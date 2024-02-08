const db = require("../../models");
const Recargo = db.recargo;
const TipoRecargo = db.tipoRecargo;
const EncabezadoEstadoPago = db.encabezadoEstadoPago;
const EncabezadoReporteDiario = db.encabezadoReporteDiario;

/*********************************************************************************** */
/* Obtiene todos los tipos de recargo
    GET /api/obras/backoffice/estadopago/v1/alltiporecargo
*/
exports.findAllTipoRecargo = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Devuelve todos los tipos de recargo' */
    try {
        await TipoRecargo.findAll().then(data => {
            res.status(200).send(data);
          }).catch(err => {
              res.status(500).send({ message: err.message });
          })
    } catch (error) {
        res.status(500).send(error);
    }
}

/*********************************************************************************** */
/* Obtiene todos los Recargos
    GET /api/obras/backoffice/estadopago/v1/allrecargos
*/
exports.findAllRecargo = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Devuelve todos los Recargos' */
    try {
        const sql = "SELECT r.id, nombre, row_to_json(tr) as tipo_recargo, porcentaje \
        FROM obras.recargos r join obras.tipo_recargo tr on r.id_tipo_recargo = tr.id";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const recargo = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = [];
        if (recargo) {
            
            for (const element of recargo) {
      
                  const detalle_salida = {
                    id: Number(element.id),
                    nombre: String(element.nombre),
                    tipo_recargo: element.tipo_recargo,  //json {"id":2,"descripcion":"Recargo por distancia"}
                    porcentaje: Number(element.porcentaje)
                    
                  }
                  salida.push(detalle_salida);
            };
          }
          if (salida===undefined){
            res.status(500).send("Error en la consulta (servidor backend)");
          }else{
            res.status(200).send(salida);
          }
    } catch (error) {
        res.status(500).send(error);
    }
}

/*********************************************************************************** */
/* Genera un nuevo encabezado para estado de pago
    GET /api/obras/backoffice/estadopago/v1/nuevoencabezado
*/
exports.generaNuevoEncabezadoEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Genera un nuevo encabezado para estado de pago' */
  try {
    const id_obra = req.query.id_obra;
    const campos = [
        'id_obra'
      ];
      for (const element of campos) {
        if (!req.query[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };
      /*
    const sql = "select o.id as id_obra, o.codigo_obra as codigo_obra, o.nombre_obra as nombre_obra, row_to_json(d) \
    as cliente, fecha_llegada::text as fecha_asignacion, row_to_json(tt) as tipo_trabajo, row_to_json(s) as segmento, \
    gestor_cliente as solicitado_por, string_to_array(numero_ot || ',' || (select string_agg(sdi, ',') as sdi from \
    (SELECT distinct on (sdi, id_obra) id_obra, sdi	FROM obras.encabezado_reporte_diario WHERE sdi is not null and \
    id_obra = 1	order by sdi, id_obra) a group by id_obra), ',') as ot_sdi, row_to_json(cc) as supervisor_pelom, \
    row_to_json(c) as comuna, ubicacion as direccion, (SELECT string_to_array(string_agg(array_to_string(\
      flexiapp, ','::text), ','), ',') as datos	FROM obras.encabezado_reporte_diario WHERE id_obra = o.id and \
      flexiapp is not null group by id_obra) as flexiapp, fecha_termino as fecha_ejecucion, null as jefe_delegacion, \
      (SELECT row_to_json(jf) as jefe_faena FROM obras.encabezado_reporte_diario erd join obras.jefes_faena jf \
      on erd.jefe_faena = jf.id	where id_obra = 1 order by fecha_reporte desc  limit 1) as jefe_faena, null as \
      codigo_pelom from obras.obras o left join obras.delegaciones d on o.delegacion = d.id left join \
      obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join obras.segmento s on o.segmento = s.id left \
      join obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c \
      on o.comuna = c.codigo WHERE o.id = " + id_obra;
      */
     const sql = "select o.id as id_obra, o.codigo_obra as codigo_obra, o.nombre_obra as nombre_obra, row_to_json(d) \
     as cliente, fecha_llegada::text as fecha_asignacion, row_to_json(tt) as tipo_trabajo, row_to_json(s) as segmento, \
     gestor_cliente as solicitado_por, repo.sdi as sdi, row_to_json(ofi) as supervisor_pelom, row_to_json(cc) as \
     coordinador, row_to_json(c) as comuna, ubicacion as direccion, repo.flexiapp as flexiapp, fecha_termino::text as \
     fecha_ejecucion, o.jefe_delegacion as jefe_delegacion, json_build_object('id', repo.id_jefe, 'nombre', \
     repo.jefe_faena) as jefe_faena, repo.num_documento as numero_documento, rec.nombre as recargo_nombre, \
     rec.porcentaje as recargo_porcentaje, (SELECT 'EDP-' || (case when max(id) is null then 0 else max(id) end + 10000001)::text || \
     '-' || substring(current_timestamp::text,1,4) FROM obras.encabezado_estado_pago) as codigo_pelom, \
     (SELECT precio FROM obras.valor_uc where oficina = o.oficina order by oficina, fecha desc limit 1) as valor_uc \
     from obras.obras o left join obras.delegaciones d on o.delegacion = d.id left join obras.tipo_trabajo tt on \
     o.tipo_trabajo = tt.id left join obras.segmento s on o.segmento = s.id left join obras.coordinadores_contratista \
     cc on     o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo left join \
     (SELECT os.id, o.nombre as oficina, so.nombre as supervisor FROM obras.oficina_supervisor os join \
      _comun.oficinas o on os.oficina = o.id join obras.supervisores_contratista so on os.supervisor = so.id) \
      ofi on o.oficina = ofi.id left join (SELECT id_obra, jf.nombre as jefe_faena, jf.id as id_jefe, sdi, \
        num_documento, flexiapp[1]  FROM obras.encabezado_reporte_diario erd join obras.jefes_faena jf on \
        erd.jefe_faena = jf.id	where id_obra = " + id_obra + " order by fecha_reporte desc limit 1) as repo on o.id = \
        repo.id_obra left join obras.recargos rec on o.recargo_distancia = rec.id WHERE o.id = " + id_obra;
          
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const nuevoEncabezado = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = [];
        if (nuevoEncabezado) {
            
            for (const element of nuevoEncabezado) {
      
                  const detalle_salida = {
                    id_obra: Number(element.id_obra),
                    cliente: element.cliente,
                    fecha_asignacion: element.fecha_asignacion?String(element.fecha_asignacion):null,
                    tipo_trabajo: element.tipo_trabajo,
                    segmento: element.segmento,
                    solicitado_por: element.solicitado_por?String(element.solicitado_por):null,
                    ot: element.numero_documento?String(element.numero_documento):null,
                    sdi: element.sdi?String(element.sdi):null,
                    supervisor_pelom: element.supervisor_pelom,
                    coordinador: element.coordinador,
                    comuna: element.comuna,
                    direccion: element.direccion?String(element.direccion):null,
                    flexiapp: element.flexiapp?String(element.flexiapp):null,
                    fecha_ejecucion: element.fecha_ejecucion?String(element.fecha_ejecucion):null,
                    jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
                    jefe_faena: element.jefe_faena,
                    codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
                    codigo_obra: element.codigo_obra?String(element.codigo_obra):null,
                    nombre_obra: element.nombre_obra?String(element.nombre_obra):null,
                    recargo_nombre: element.recargo_nombre?String(element.recargo_nombre):null,
                    recargo_porcentaje: element.recargo_porcentaje?Number(element.recargo_porcentaje):null,
                    valor_uc: element.valor_uc?Number(element.valor_uc):null
 
                  }
                  salida.push(detalle_salida);
            };
          }
          if (salida===undefined){
            res.status(500).send("Error en la consulta (servidor backend)");
          }else{
            res.status(200).send(salida);
          }
  } catch (error) {
    res.status(500).send(error);
  }
}

/*********************************************************************************** */
/* Obtiene todas las actividades no adicionales para un estado de pago
    GET /api/obras/backoffice/estadopago/v1/allactividades
*/

exports.getAllActividadesByIdObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene todas las actividades no adicionales para un estado de pago' */
      try {
        const id_obra = req.query.id_obra;
        const campos = [
            'id_obra'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };

          //Va a consultar a la funcion listadoActividadesByIdObra definida mas abajo
          const consulta = await listadoActividadesByIdObra(id_obra);
          if (consulta.error === false) {
            res.status(200).send(consulta.detalle);
          } else {
            res.status(500).send(consulta.detalle);
          }
      } catch (error) {
        res.status(500).send(error);
      }
}

/*********************************************************************************** */
/* Obtiene todas las actividades adicionales para un estado de pago
    GET /api/obras/backoffice/estadopago/v1/allactividadesadicionales
*/
exports.getAllActividadesAdicionalesByIdObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene todas las actividades adicionales para un estado de pago' */
      try {
        const id_obra = req.query.id_obra;
        const campos = [
            'id_obra'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };
          //Va a consultar a la funcion listadoActividadesByIdObra definida mas abajo
          const consulta = await listadoActividadesAdicionalesByIdObra(id_obra);
          if (consulta.error === false) {
            res.status(200).send(consulta.detalle);
          } else {
            res.status(500).send(consulta.detalle);
          }
      } catch (error) {
        res.status(500).send(error);
      }

}
/*********************************************************************************** */
/* Obtiene todas las actividades adicionales y normales que tengan hora extra para un estado de pago
    GET /api/obras/backoffice/estadopago/v1/allactividadesconhoraextra
*/
exports.getAllActividadesHoraExtraByIdObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene todas las actividades adicionales y normales que tengan hora extra para un estado de pago' */
      try {
        const id_obra = req.query.id_obra;
        const campos = [
            'id_obra'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };
          //Va a consultar a la funcion listadoActividadesByIdObra definida mas abajo
          const consulta = await listadoActividadesHoraExtraByIdObra(id_obra);
          if (consulta.error === false) {
            res.status(200).send(consulta.detalle);
          } else {
            res.status(500).send(consulta.detalle);
          }
        
      } catch (error) {
        res.status(500).send(error);
      }

}
/*********************************************************************************** */
/* Obtiene Los totales y subtotales de acuerdo a lo que viene de los detalles de actividades
    GET /api/obras/backoffice/estadopago/v1/totalesestadopago
*/
exports.totalesEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene los totales y subtotales de acuerdo a lo que viene de los detalles de actividades' */
  try {
    const id_obra = req.query.id_obra;
    const campos = ['id_obra'];
      for (const element of campos) {
        if (!req.query[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };

    const actividadesNormales = await listadoActividadesByIdObra(id_obra);
    let totalActividadesNormales = !actividadesNormales.error?actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;
   
    const actividadesAdicionales = await listadoActividadesAdicionalesByIdObra(id_obra);
    let totalActividadesAdicionales = !actividadesAdicionales.error?actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    const actividadesHoraExtra = await listadoActividadesHoraExtraByIdObra(id_obra);
    let totalActividadesHoraExtra = !actividadesHoraExtra.error?actividadesHoraExtra.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    const detalle_avances = await listadoAvancesEstadoPagoIdObra(id_obra);
    let totalAvances = !detalle_avances.error?detalle_avances.detalle.reduce(((total, num) => total + num.monto), 0):undefined;


    if (totalActividadesNormales===undefined || totalActividadesAdicionales===undefined || totalActividadesHoraExtra===undefined || totalAvances===undefined) {
      res.status(500).send("Error en la consulta (servidor backend)");
    }
    const subtotal1 = Number(totalActividadesNormales);
    const subtotal2 = Number(totalActividadesAdicionales);
    const subtotal3 = Number(totalActividadesHoraExtra);
    const valorNeto = Number(subtotal1+subtotal2+subtotal3);
    const descuentoAvance = Number(totalAvances);
    const totalNeto = Number(valorNeto - descuentoAvance);
    const total = Number((totalNeto * 1.19).toFixed(0));
    const iva = Number(Number(total - totalNeto).toFixed(0));


    const result = {
      subtotal1: subtotal1,
      subtotal2: subtotal2,
      subtotal3: subtotal3,
      valorNeto: valorNeto,
      descuentoAvance: descuentoAvance,
      totalNeto: totalNeto,
      total: total,
      iva: iva
    };

    res.status(200).send(result);
  } catch (error) {
    res.status(500).send(error);
  }
}
/*********************************************************************************** */
/* Obtiene la tabla de los avances de estado de pago
    GET /api/obras/backoffice/estadopago/v1/avancesestadopago
*/
exports.avancesEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene la tabla de los avances de estado de pago' */
  try {
    const id_obra = req.query.id_obra;
    const campos = ['id_obra'];
      for (const element of campos) {
        if (!req.query[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };
      //Va a consultar a la funcion listadoAvancesEstadoPagoIdObra definida mas abajo
      const consulta = await listadoAvancesEstadoPagoIdObra(id_obra);
      if (consulta.error === false) {
        res.status(200).send(consulta.detalle);
      } else {
        res.status(500).send(consulta.detalle);
      }
    
  } catch (error) {
    res.status(500).send(error);
  }
}

/*********************************************************************************** */
/* ista los estados de pago por id_obra
    POST /api/obras/backoffice/estadopago/v1/creaestadopago
*/
exports.creaEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Lista los estados de pago por id_obra' */
  try {
    const campos = [
      'id_obra', 'cliente', 'fecha_asignacion', 'tipo_trabajo',
      'segmento', 'solicitado_por', 'supervisor_pelom', 'coordinador', 'comuna',
      'direccion', 'flexiapp', 'fecha_ejecucion', 'jefe_delegacion', 'jefe_faena',
      'codigo_pelom', 'valor_uc'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };

    const id_obra = req.body.id_obra;

    const c = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"});
    const fecha_estado_pago = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2)


    const detalle_avances = await listadoAvancesEstadoPagoIdObra(id_obra);
    let totalAvances = !detalle_avances.error?detalle_avances.detalle.reduce(((total, num) => total + num.monto), 0):undefined;

    const actividadesNormales = await listadoActividadesByIdObra(id_obra);
    let totalActividadesNormales = !actividadesNormales.error?actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;
   
    const actividadesAdicionales = await listadoActividadesAdicionalesByIdObra(id_obra);
    let totalActividadesAdicionales = !actividadesAdicionales.error?actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    const actividadesHoraExtra = await listadoActividadesHoraExtraByIdObra(id_obra);
    let totalActividadesHoraExtra = !actividadesHoraExtra.error?actividadesHoraExtra.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    //Chequear si que el total del estado paga sea mayor a cero, si no es así se debe devolver un error
    if (totalActividadesNormales+totalActividadesAdicionales+totalActividadesHoraExtra-totalAvances <= 0) {
      res.status(500).send("No es posible crear un estado de pago con un total menor o igual a 0");
      return;
    }

    const sql = "select nextval('obras.encabezado_estado_pago_id_seq'::regclass) as valor";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let encabezado_estado_pago_id = 0;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          encabezado_estado_pago_id = data[0].valor;
        }).catch(err => {
          res.status(500).send({ message: err.message });
        })

        /*
        let flexiapp = "{";
        for (const b of req.body.flexiapp){
          if (flexiapp.length==1) {
            flexiapp = flexiapp + b
          }else {
            flexiapp = flexiapp + ", " + b
          }
        }
        flexiapp = flexiapp + "}"

        let ot_sdi = "{";
        for (const b of req.body.ot_sdi){
          if (ot_sdi.length==1) {
            ot_sdi = ot_sdi + b
          }else {
            ot_sdi = ot_sdi + ", " + b
          }
        }
        ot_sdi = ot_sdi + "}"
        */
        

    const datos = {
      id: encabezado_estado_pago_id,
      id_obra: req.body.id_obra,
      fecha_estado_pago: fecha_estado_pago,
      cliente: req.body.cliente.id,
      fecha_asignacion: req.body.fecha_asignacion,
      tipo_trabajo: req.body.tipo_trabajo.id,
      segmento: req.body.segmento.id,
      solicitado_por: req.body.solicitado_por,
      supervisor: req.body.supervisor_pelom.id,
      coordinador: req.body.coordinador.id,
      comuna: req.body.comuna.codigo,
      direccion: req.body.direccion,
      flexiapp: req.body.flexiapp,
      fecha_ejecucion: req.body.fecha_ejecucion,
      jefe_delegacion: req.body.jefe_delegacion,
      jefe_faena: req.body.jefe_faena.id,
      estado: 1,     //0: pendiente, 1: cerrado, 2: facturado
      codigo_pelom: req.body.codigo_pelom,
      ot: req.body.ot,
      sdi: req.body.sdi,
      recargo_nombre: req.body.recargo_nombre,
      recargo_porcentaje: req.body.recargo_porcentaje,
      valor_uc: req.body.valor_uc,
      subtotal1: totalActividadesNormales,
      subtotal2: totalActividadesAdicionales,
      subtotal3: totalActividadesHoraExtra,
      descuento_avance: totalAvances,
      detalle_avances: !detalle_avances.error?detalle_avances.detalle:undefined,
      detalle_actividades: !actividadesNormales.error?actividadesNormales.detalle:undefined,
      detalle_otros: !actividadesAdicionales.error?actividadesAdicionales.detalle:undefined,
      detalle_horaextra: !actividadesHoraExtra.error?actividadesHoraExtra.detalle:undefined,

    }
    
    const result = await sequelize.transaction(async () => {

      let salida = {};
      await EncabezadoEstadoPago.create(datos)
          .then(async data => {
            salida = { error: false, message: data }
            await EncabezadoReporteDiario.update({id_estado_pago: encabezado_estado_pago_id}, {
              where: {
                id_estado_pago: null,
                id_obra: req.body.id_obra
              }
            })
          }).catch(err => {
            salida = { error: true, message: err }
          })
      return salida;
    });
    if (result.error) {
      res.status(500).send(result.message);
    }else {
      res.status(200).send(result.message);
    }
  } catch (error) {
    res.status(500).send(error);
  }
}
/*********************************************************************************** */
/* Lista los estados de pago por id_obra
    GET /api/obras/backoffice/estadopago/v1/listaestadospago
*/
exports.getAllEstadosPagoByIdObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Lista los estados de pago por id_obra' */
      try {
        const id_obra = req.query.id_obra;
        const campos = [
            'id_obra'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };
        const sql = "SELECT eep.id, eep.id_obra, eep.fecha_estado_pago, row_to_json(d) as cliente, \
        eep.fecha_asignacion, row_to_json(tt) as tipo_trabajo, row_to_json(s) as segmento, eep.solicitado_por, \
        row_to_json(c) as comuna, eep.direccion, eep.fecha_ejecucion, eep.jefe_delegacion, eep.codigo_pelom, \
        row_to_json(sc) as supervisor, row_to_json(jf) as jefe_faena, eep.estado, eep.ot, eep.sdi, \
        row_to_json(cc) as coordinador, eep.recargo_nombre, eep.recargo_porcentaje, eep.flexiapp, o.codigo_obra, o.nombre_obra, \
        eep.valor_uc FROM obras.encabezado_estado_pago eep LEFT JOIN obras.delegaciones d on eep.cliente = d.id LEFT JOIN \
        obras.tipo_trabajo tt on eep.tipo_trabajo = tt.id LEFT JOIN obras.segmento s on eep.segmento = s.id \
        LEFT JOIN _comun.comunas c on eep.comuna = c.codigo LEFT JOIN obras.supervisores_contratista sc on \
        eep.supervisor = sc.id LEFT JOIN obras.jefes_faena jf on eep.jefe_faena = jf.id LEFT JOIN \
        obras.coordinadores_contratista cc on eep.coordinador = cc.id JOIN obras.obras o on eep.id_obra = o.id WHERE id_obra = " + id_obra + ";";
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const lstEstadosPagos = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (lstEstadosPagos) {
                
                for (const element of lstEstadosPagos) {
          
                      const detalle_salida = {
                        id: Number(element.id),
                        id_obra: Number(element.id_obra),
                        cliente: element.cliente,
                        fecha_asignacion: element.fecha_asignacion?String(element.fecha_asignacion):null,
                        tipo_trabajo: element.tipo_trabajo,
                        segmento: element.segmento,
                        solicitado_por: element.solicitado_por?String(element.solicitado_por):null,
                        ot: element.ot?String(element.ot):null,
                        sdi: element.sdi?String(element.sdi):null,
                        supervisor_pelom: element.supervisor_pelom,
                        coordinador: element.coordinador,
                        comuna: element.comuna,
                        direccion: element.direccion?String(element.direccion):null,
                        flexiapp: element.flexiapp?String(element.flexiapp):null,
                        fecha_ejecucion: element.fecha_ejecucion?String(element.fecha_ejecucion):null,
                        jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
                        jefe_faena: element.jefe_faena,
                        codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
                        codigo_obra: element.codigo_obra?String(element.codigo_obra):null,
                        nombre_obra: element.nombre_obra?String(element.nombre_obra):null,
                        recargo_nombre: element.recargo_nombre?String(element.recargo_nombre):null,
                        recargo_porcentaje: element.recargo_porcentaje?Number(element.recargo_porcentaje):null,
                        valor_uc: element.valor_uc?Number(element.valor_uc):null

                      }
                      salida.push(detalle_salida);
                };
              }
              if (salida===undefined){
                res.status(500).send("Error en la consulta (servidor backend)");
              }else{
                res.status(200).send(salida);
              }
      } catch (error) {
        res.status(500).send(error);
      }
}
/*********************************************************************************** */
/* Obtiene todos los datos para completar un informe de estado de pago historico por id del estado de pago
    GET /api/obras/backoffice/estadopago/v1/historicoestadopagoporid
*/
exports.getHistoricoEstadosPagoByIdEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene todos los datos para completar un informe de estado de pago historico por id del estado de pago' */
      try {
        const id_estado_pago = req.query.id_estado_pago;
        const campos = [
            'id_estado_pago'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };

          const { QueryTypes } = require('sequelize');
          const sequelize = db.sequelize;
          const sql = "SELECT eep.id, eep.fecha_estado_pago, eep.id_obra, o.codigo_obra, o.nombre_obra, \
          row_to_json(d) as cliente, eep.fecha_asignacion::text, row_to_json(tt) as tipo_trabajo, row_to_json(s) as \
          segmento, eep.solicitado_por::varchar,  eep.sdi::text, row_to_json(ofi) as supervisor_pelom, row_to_json(cc) \
          as coordinador, row_to_json(c) as comuna, eep.direccion, eep.flexiapp, eep.fecha_ejecucion::text, \
          eep.jefe_delegacion::varchar, row_to_json(jf) as jefe_faena, eep.ot as numero_documento, eep.recargo_nombre, \
          eep.recargo_porcentaje, eep.codigo_pelom, eep.valor_uc, eep.estado, eep.subtotal1, eep.subtotal2, eep.subtotal3, \
          eep.descuento_avance, eep.detalle_avances, eep.detalle_actividades, eep.detalle_otros, eep.detalle_horaextra \
          FROM obras.encabezado_estado_pago eep LEFT JOIN obras.obras o on eep.id_obra = o.id LEFT JOIN obras.delegaciones \
          d on o.delegacion = d.id LEFT JOIN obras.tipo_trabajo tt on o.tipo_trabajo = tt.id LEFT JOIN obras.segmento s \
          on o.segmento = s.id LEFT JOIN _comun.comunas c on o.comuna = c.codigo LEFT JOIN obras.coordinadores_contratista \
          cc on o.coordinador_contratista = cc.id LEFT JOIN (SELECT os.id, o.nombre as oficina, so.nombre as supervisor \
            FROM obras.oficina_supervisor os join _comun.oficinas o on os.oficina = o.id join obras.supervisores_contratista \
            so on os.supervisor = so.id) ofi on o.oficina = ofi.id LEFT JOIN obras.jefes_faena jf on \
            eep.jefe_faena = jf.id WHERE eep.id = " + id_estado_pago;
            const historiaEstadoPago = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (historiaEstadoPago) {
                
                for (const element of historiaEstadoPago) {
                  const valorNeto = Number(Number(element.subtotal1)+Number(element.subtotal2)+Number(element.subtotal3));
                  const totalNeto = Number(valorNeto - Number(element.descuento_avance));
                  const total = Number((totalNeto * 1.19).toFixed(0));
                  const iva = Number(Number(total - totalNeto).toFixed(0));

                  const encabezado = {
                    id_obra: Number(element.id_obra),
                        cliente: element.cliente,
                        fecha_asignacion: element.fecha_asignacion?String(element.fecha_asignacion):null,
                        tipo_trabajo: element.tipo_trabajo,
                        segmento: element.segmento,
                        solicitado_por: element.solicitado_por?String(element.solicitado_por):null,
                        ot: element.numero_documento?String(element.numero_documento):null,
                        sdi: element.sdi?String(element.sdi):null,
                        supervisor_pelom: element.supervisor_pelom,
                        coordinador: element.coordinador,
                        comuna: element.comuna,
                        direccion: element.direccion?String(element.direccion):null,
                        flexiapp: element.flexiapp?String(element.flexiapp):null,
                        fecha_ejecucion: element.fecha_ejecucion?String(element.fecha_ejecucion):null,
                        jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
                        jefe_faena: element.jefe_faena,
                        codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
                        codigo_obra: element.codigo_obra?String(element.codigo_obra):null,
                        nombre_obra: element.nombre_obra?String(element.nombre_obra):null,
                        recargo_nombre: element.recargo_nombre?String(element.recargo_nombre):null,
                        recargo_porcentaje: element.recargo_porcentaje?Number(element.recargo_porcentaje):null,
                        valor_uc: element.valor_uc?Number(element.valor_uc):null,
                    
                  }
                  const totales = {

                        subtotal1: Number(element.subtotal1),
                        subtotal2: Number(element.subtotal2),
                        subtotal3: Number(element.subtotal3),
                        valorNeto: valorNeto,
                        descuentoAvance: Number(element.descuento_avance),
                        totalNeto: totalNeto,
                        total: total,
                        iva: iva
                  }
          
                      const detalle_salida = {
                        encabezado: encabezado,
                        totales: totales,
                        actividades_por_obra: element.detalle_actividades,
                        actividades_adicionales: element.detalle_otros,
                        actividades_hora_extra: element.detalle_horaextra,
                        avances_estado_pago: element.detalle_avances
                      }
                      salida.push(detalle_salida);
                };
              }
              if (salida===undefined){
                res.status(500).send("Error en la consulta (servidor backend)");
              }else{
                res.status(200).send(salida[0]);
              }

      } catch (error) {
          res.status(500).send(error);
      }
}
let listadoActividadesByIdObra = async (id_obra) => {
  try {
    const sql = "select top.clase, ta.descripcion tipo, (case when e.porcentaje is null or e.porcentaje = 0 then '' else e.nombre_corto end || ma.actividad) as actividad, \
        mu.codigo_corto as unidad, e.cantidad, case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' \
        then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, \
        (SELECT precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, \
        e.porcentaje as porcentaje, e.recargo_distancia from (SELECT drda.tipo_operacion, drda.id_actividad, \
          sum(drda.cantidad) as cantidad, case when rec.nombre_corto is null then ''::varchar \
          else ('(' || rec.nombre_corto || ') ')::varchar end as nombre_corto, rec1.porcentaje as recargo_distancia, \
          case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, o.oficina FROM \
          obras.encabezado_reporte_diario erd join obras.detalle_reporte_diario_actividad drda on erd.id = \
          drda.id_encabezado_rep left join obras.recargos rec on erd.recargo_hora = rec.id join obras.obras o on \
          erd.id_obra = o.id left join obras.recargos rec1 on o.recargo_distancia = rec1.id \
          WHERE id_obra = " + id_obra + " group by drda.tipo_operacion, drda.id_actividad, rec.nombre_corto, rec.porcentaje, \
          rec1.porcentaje, o.oficina) e join obras.maestro_actividades ma on e.id_actividad = ma.id \
          join obras.tipo_operacion top on e.tipo_operacion = top.id join obras.tipo_actividad ta on \
          ma.id_tipo_actividad = ta.id join obras.maestro_unidades mu on ma.id_unidad = mu.id WHERE \
          e.porcentaje = 0 AND ta.id <> 9";
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (actividades) {
                
                for (const element of actividades) {
          
                      const detalle_salida = {
                        clase: String(element.clase),
                        tipo: String(element.tipo),
                        actividad: String(element.actividad), 
                        unidad: String(element.unidad),
                        cantidad: Number(element.cantidad),
                        unitario: Number(element.unitario),
                        unitario_pesos: Number(element.unitario * element.valor_uc),
                        total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                        recargos: element.recargo_distancia?element.recargo_distancia.toString()+'%':'0%',
                        total_pesos: Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+element.recargo_distancia/100)).toFixed(0))
                        
                      }
                      salida.push(detalle_salida);
                };
              }
              const retorna = {
                error: false,
                detalle: salida
              }
              return retorna;
  }catch (error) {
    const retorna = {
      error: true,
      detalle: error
    }
    return retorna;
  }
  
}

let listadoActividadesAdicionalesByIdObra = async (id_obra) => {
  try {
    const sql = "select top.clase, ta.descripcion tipo, (case when e.porcentaje is null or e.porcentaje = 0 then '' else e.nombre_corto end || ma.actividad) as actividad, \
        mu.codigo_corto as unidad, e.cantidad, case when top.clase = 'I' then ma.uc_instalacion \
        when top.clase = 'R' then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision \
        end as unitario, (SELECT precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) \
        as valor_uc, e.porcentaje as porcentaje, e.recargo_distancia from (SELECT drda.tipo_operacion, \
          drda.id_actividad, sum(drda.cantidad) as cantidad, case when rec.nombre_corto is null then ''::varchar else \
          ('(' || rec.nombre_corto || ') ')::varchar end as nombre_corto, rec1.porcentaje as recargo_distancia, \
          case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, o.oficina FROM \
          obras.encabezado_reporte_diario erd join obras.detalle_reporte_diario_actividad \
          drda on erd.id = drda.id_encabezado_rep left join obras.recargos rec on erd.recargo_hora = rec.id \
          join obras.obras o on erd.id_obra = o.id left join obras.recargos rec1 on o.recargo_distancia = rec1.id \
          WHERE id_obra = " + id_obra + " group by drda.tipo_operacion, drda.id_actividad, rec.nombre_corto, rec.porcentaje, \
          rec1.porcentaje, o.oficina) e join obras.maestro_actividades ma on e.id_actividad = ma.id join \
          obras.tipo_operacion top on e.tipo_operacion = top.id join obras.tipo_actividad ta on \
          ma.id_tipo_actividad = ta.id join obras.maestro_unidades mu on ma.id_unidad = mu.id WHERE \
          e.porcentaje = 0 AND ta.id = 9 \
          UNION \
          select 'I'::char as clase, 'Adicionales'::varchar as tipo, (case when rec.porcentaje is null or rec.porcentaje = 0 \
            then ''::varchar else ('(' || rec.nombre_corto || ') ')::varchar end || glosa) as actividad, 'CU'::varchar, cantidad, \
            uc_unitaria::double precision as unitario, (SELECT precio FROM obras.valor_uc where oficina = o.oficina \
              order by oficina, fecha desc limit 1) as valor_uc, case when rec.porcentaje is null then 0 else \
              rec.porcentaje end as porcentaje, rec1.porcentaje as recargo_distancia from \
              obras.detalle_reporte_diario_otras_actividades drdoa join obras.encabezado_reporte_diario erd on \
              drdoa.id_encabezado_rep = erd.id join obras.obras o on erd.id_obra = o.id left join obras.recargos rec \
              on erd.recargo_hora = rec.id left join obras.recargos rec1 on o.recargo_distancia = rec1.id \
              WHERE erd.id_obra = " + id_obra + " and (rec.porcentaje is null or rec.porcentaje = 0) order by 1,2,3;";
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (actividades) {
                
                for (const element of actividades) {
          
                      const detalle_salida = {
                        clase: String(element.clase),
                        tipo: String(element.tipo),
                        actividad: String(element.actividad),
                        unidad: String(element.unidad),
                        cantidad: Number(element.cantidad),
                        unitario: Number(element.unitario),
                        unitario_pesos: Number(element.unitario * element.valor_uc),
                        total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                        recargos: element.recargo_distancia?element.recargo_distancia.toString()+'%':'0%',
                        total_pesos: Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+element.recargo_distancia/100)).toFixed(0))
                        
                      }
                      salida.push(detalle_salida);
                };
              }
              const retorna = {
                error: false,
                detalle: salida
              }
              return retorna;
    
  } catch (error) {
    const retorna = {
      error: true,
      detalle: error
    }
    return retorna;
  }
}

let listadoActividadesHoraExtraByIdObra = async (id_obra) => {
  try {
    const sql = "select top.clase, ta.descripcion tipo, (e.nombre_corto || ma.actividad) as actividad, \
        mu.codigo_corto as unidad, e.cantidad, case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' \
        then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, \
        (SELECT precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, \
        e.porcentaje as porcentaje, e.recargo_distancia from (SELECT drda.tipo_operacion, drda.id_actividad, \
          sum(drda.cantidad) as cantidad, case when rec.nombre_corto is null then ''::varchar else \
          ('(' || rec.nombre_corto || ') ')::varchar end as nombre_corto, rec1.porcentaje as recargo_distancia, \
          case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, o.oficina FROM \
          obras.encabezado_reporte_diario erd join obras.detalle_reporte_diario_actividad drda on \
          erd.id = drda.id_encabezado_rep left join obras.recargos rec on erd.recargo_hora = rec.id join obras.obras o \
          on erd.id_obra = o.id left join obras.recargos rec1 on o.recargo_distancia = rec1.id \
          WHERE id_obra = " + id_obra + " group by drda.tipo_operacion, drda.id_actividad, rec.nombre_corto, rec.porcentaje, rec1.porcentaje, o.oficina) \
          e join obras.maestro_actividades ma on e.id_actividad = ma.id join obras.tipo_operacion top on \
          e.tipo_operacion = top.id join obras.tipo_actividad ta on ma.id_tipo_actividad = ta.id join obras.maestro_unidades \
          mu on ma.id_unidad = mu.id WHERE e.porcentaje > 0 \
          UNION \
          select 'I'::char as clase, 'Adicionales'::varchar as tipo, (case when rec.nombre_corto is null \
            then ''::varchar else ('(' || rec.nombre_corto || ') ')::varchar end || glosa) as actividad, 'CU'::varchar, cantidad, \
            uc_unitaria::double precision as unitario, (SELECT precio FROM obras.valor_uc where oficina = o.oficina order \
              by oficina, fecha desc limit 1) as valor_uc, case when rec.porcentaje is null then 0 else rec.porcentaje end \
              as porcentaje, rec1.porcentaje as recargo_distancia from obras.detalle_reporte_diario_otras_actividades \
              drdoa join obras.encabezado_reporte_diario erd on drdoa.id_encabezado_rep = erd.id join obras.obras o \
              on erd.id_obra = o.id left join obras.recargos rec on erd.recargo_hora = rec.id left join obras.recargos \
              rec1 on o.recargo_distancia = rec1.id WHERE erd.id_obra = " + id_obra + " and (rec.porcentaje is not null and rec.porcentaje > 0) \
              order by 1,2,3;";
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (actividades) {
                
                for (const element of actividades) {

                      const recargo_hora = element.porcentaje?Number(element.porcentaje):0;
                      const recargo_distancia = element.recargo_distancia?Number(element.recargo_distancia):0;
                      const recargo_total = Number(recargo_hora+recargo_distancia);

                      const detalle_salida = {
                        clase: String(element.clase),
                        tipo: String(element.tipo),
                        actividad: String(element.actividad),
                        unidad: String(element.unidad),
                        cantidad: Number(element.cantidad),
                        unitario: Number(element.unitario),
                        unitario_pesos: Number(element.unitario * element.valor_uc),
                        total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                        recargos: recargo_total.toString()+'%',
                        total_pesos: Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+recargo_total/100)).toFixed(0))
                        
                      }
                      salida.push(detalle_salida);
                };
              }
              const retorna = {
                error: false,
                detalle: salida
              }
              return retorna;

  } catch (error) {
    const retorna = {
      error: true,
      detalle: error
    }
    return retorna;
  }
  
}

let listadoAvancesEstadoPagoIdObra = async (id_obra) => {
  try {
      const sql = "SELECT codigo_pelom, fecha_estado_pago::text, (subtotal1 + subtotal2 + subtotal3 - descuento_avance) \
      as monto FROM obras.encabezado_estado_pago WHERE id_obra = " + id_obra + " order by fecha_estado_pago desc, id desc";
            console.log('sql', sql);
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const avances = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (avances) {
                
                for (const element of avances) {

                      const detalle_salida = {
                        codigo_pelom: String(element.codigo_pelom),
                        fecha_avance: String(element.fecha_estado_pago),
                        monto: Number(element.monto)
                                                
                      }
                      salida.push(detalle_salida);
                };
              }
              const retorna = {
                error: false,
                detalle: salida
              }
              return retorna;

  } catch (error) {
    const retorna = {
      error: true,
      detalle: error
    }
    return retorna;
  }
  
}
