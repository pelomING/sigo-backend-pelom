const db = require("../../models");
const Obra = db.obra;

/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 TABLA OBRAS                                     */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/


/*********************************************************************************** */
/* Consulta todas las Obras
;
*/
exports.findAllObra = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Devuelve todas las obras de la tabla de obras' */
    try {
      const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, \
      o.gestor_cliente, numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, \
      fecha_termino::text, row_to_json(tt) as tipo_trabajo, persona_envia_info, cargo_persona_envia_info, \
      row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, row_to_json(c) as comuna, \
      ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada, \
      case when erd.cuenta is null then 0 else erd.cuenta end as cantidad_reportes, o.jefe_delegacion, \
      (select count(id) as cantidad_estados_pago FROM obras.encabezado_estado_pago WHERE id_obra = o.id) as cantidad_estados_pago, \
      row_to_json(ofi) as oficina, row_to_json(rec) as recargo_distancia FROM obras.obras o left join _comun.zonal z \
      on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join obras.tipo_trabajo tt on \
      o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left join \
      obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on \
      o.comuna = c.codigo left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on \
      o.tipo_obra = tob.id left join obras.segmento s on o.segmento = s.id left join (select id_obra, count(id) \
      as cuenta from obras.encabezado_reporte_diario group by id_obra) as erd on o.id = erd.id_obra left join \
      (SELECT os.id, o.nombre as oficina, so.nombre as supervisor	FROM obras.oficina_supervisor os join _comun.oficinas \
        o on os.oficina = o.id join obras.supervisores_contratista so on os.supervisor = so.id) ofi on o.oficina = \
        ofi.id left join (SELECT id, nombre, porcentaje FROM obras.recargos where id_tipo_recargo = 2) rec \
        on o.recargo_distancia = rec.id WHERE not o.eliminada";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const obras = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (obras) {
        for (const element of obras) {
  
              const detalle_salida = {
                id: Number(element.id),
                codigo_obra: String(element.codigo_obra),
                numero_ot: String(element.numero_ot),
                nombre_obra: String(element.nombre_obra),
                zona: element.zona, //json
                delegacion: element.delegacion, //json
                gestor_cliente: String(element.gestor_cliente),
                numero_aviso: Number(element.numero_aviso),
                numero_oc: String(element.numero_oc),
                monto: Number(element.monto),
                cantidad_uc: Number(element.cantidad_uc),
                fecha_llegada: String(element.fecha_llegada),
                fecha_inicio: String(element.fecha_inicio),
                fecha_termino: String(element.fecha_termino),
                tipo_trabajo: element.tipo_trabajo, //json
                persona_envia_info: String(element.persona_envia_info),
                cargo_persona_envia_info: String(element.cargo_persona_envia_info),
                empresa_contratista: element.empresa_contratista, //json
                coordinador_contratista: element.coordinador_contratista, //json
                comuna: element.comuna, //json
                ubicacion: String(element.ubicacion),
                estado: element.estado, //json
                tipo_obra: element.tipo_obra, //json
                segmento: element.segmento, //json
                eliminada: element.eliminada,
                cantidad_reportes: Number(element.cantidad_reportes),
                jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
                cantidad_estados_pago: Number(element.cantidad_estados_pago),
                oficina: element.oficina, //json
                recargo_distancia: element.recargo_distancia, //json
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
/* Crea una obra
;
*/
exports.createObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Crea una nueva obra' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos básicos de una obra',
            required: true,
            schema: {
              codigo_obra: "CGE-123456",
                nombre_obra: "nombre de la obra",
                numero_ot: "123456",
                zona: 1,
                delegacion: 1,
                gestor_cliente: "nombre gestor cliente (cge)",
                numero_aviso: 123456,
                numero_oc: "123456",
                monto: 1000,
                cantidad_uc: 100,
                fecha_llegada: "2023-10-25",
                fecha_inicio: "2023-10-25",
                fecha_termino: "2023-10-25",
                tipo_trabajo: 1,
                persona_envia_info: "nombre persona envia info",
                cargo_persona_envia_info: "cargo persona envia info",
                empresa_contratista: 1,
                coordinador_contratista: 1,
                comuna: "07234",
                ubicacion: "dirección donde se trabajará en la obra",
                estado: 1,
                tipo_obra: 1,
                segmento: 1,
                jefe_delegacion: "nombre jefe delegacion",
                oficina: {'id':1,'oficina':'Curicó','supervisor':'Eduardo Soto'},
                recargo_distancia: {'id':7,'nombre':'Menos de 30km','porcentaje':0}
            }
        }
      */
  try {
      let salir = false;
      const campos = [
        'codigo_obra', 'nombre_obra'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send( "No puede estar nulo el campo " + element
          );
          return;
        }
      };
    
      //Verifica que el codigo obra no se encuentre
      await Obra.findAll({where: {codigo_obra: req.body.codigo_obra}}).then(data => {
        //el rut ya existe
        if (data.length > 0) {
          salir = true;
          res.status(400).send('El Codigo de Obra ya se encuentra ingresado en la base' );
        }
      }).catch(err => {
          salir = true;
          res.status(500).send( err.message );
      })
    
      if (salir) {
        return;
      }

      const obra = {

          codigo_obra: req.body.codigo_obra,
          nombre_obra: req.body.nombre_obra,
          numero_ot: req.body.numero_ot,
          zona: req.body.zona,
          delegacion: req.body.delegacion,
          gestor_cliente: req.body.gestor_cliente,
          numero_aviso: req.body.numero_aviso,
          numero_oc: req.body.numero_oc,
          monto: req.body.monto,
          cantidad_uc: req.body.cantidad_uc,
          fecha_llegada: req.body.fecha_llegada,
          fecha_inicio: req.body.fecha_inicio,
          fecha_termino: req.body.fecha_termino,
          tipo_trabajo: req.body.tipo_trabajo,
          persona_envia_info: req.body.persona_envia_info,
          cargo_persona_envia_info: req.body.cargo_persona_envia_info,
          empresa_contratista: req.body.empresa_contratista,
          coordinador_contratista: req.body.coordinador_contratista,
          comuna: req.body.comuna,
          ubicacion: req.body.ubicacion,
          estado: req.body.estado?req.body.estado:1,
          tipo_obra: req.body.tipo_obra,
          segmento: req.body.segmento,
          eliminada: false,
          jefe_delegacion: req.body.jefe_delegacion,
          oficina: req.body.oficina?req.body.oficina.id:null,
          recargo_distancia: req.body.recargo_distancia?req.body.recargo_distancia.id:null

      }

      await Obra.create(obra)
          .then(data => {
              res.status(200).send(data);
          }).catch(err => {
              res.status(500).send( err.message );
          })
    }catch (error) {
      res.status(500).send(error);
    }
  }
  /*********************************************************************************** */


/*********************************************************************************** */
/* Actualiza una obra
;
*/
exports.updateObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Actualiza una obra' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos básicos de una obra',
            required: true,
            schema: {
              codigo_obra: "CGE-123456",
                nombre_obra: "nombre de la obra",
                numero_ot: "123456",
                zona: 1,
                delegacion: 1,
                gestor_cliente: "nombre gestor cliente (cge)",
                numero_aviso: 123456,
                numero_oc: "123456",
                monto: 1000,
                cantidad_uc: 100,
                fecha_llegada: "2023-10-25",
                fecha_inicio: "2023-10-25",
                fecha_termino: "2023-10-25",
                tipo_trabajo: 1,
                persona_envia_info: "nombre persona envia info",
                cargo_persona_envia_info: "cargo persona envia info",
                empresa_contratista: 1,
                coordinador_contratista: 1,
                comuna: "07234",
                ubicacion: "dirección donde se trabajará en la obra",
                estado: 1,
                tipo_obra: 1,
                segmento: 1,
                jefe_delegacion: "nombre jefe delegacion",
                oficina: {'id':1,'oficina':'Curicó','supervisor':'Eduardo Soto'},
                recargo_distancia: {'id':7,'nombre':'Menos de 30km','porcentaje':0}
            }
        }
      */
  
  try{
    const id = req.params.id;
    const obra = {

      codigo_obra: req.body.codigo_obra?req.body.codigo_obra:undefined,
      nombre_obra: req.body.nombre_obra?req.body.nombre_obra:undefined,
      numero_ot: req.body.numero_ot?req.body.numero_ot:undefined,
      zona: req.body.zona?req.body.zona:undefined,
      delegacion: req.body.delegacion?req.body.delegacion:undefined,
      gestor_cliente: req.body.gestor_cliente?req.body.gestor_cliente:undefined,
      numero_aviso: req.body.numero_aviso?req.body.numero_aviso:undefined,
      numero_oc: req.body.numero_oc?req.body.numero_oc:undefined,
      monto: req.body.monto?req.body.monto:undefined,
      cantidad_uc: req.body.cantidad_uc?req.body.cantidad_uc:undefined,
      fecha_llegada: req.body.fecha_llegada?req.body.fecha_llegada:undefined,
      fecha_inicio: req.body.fecha_inicio?req.body.fecha_inicio:undefined,
      fecha_termino: req.body.fecha_termino?req.body.fecha_termino:undefined,
      tipo_trabajo: req.body.tipo_trabajo?req.body.tipo_trabajo:undefined,
      persona_envia_info: req.body.persona_envia_info?req.body.persona_envia_info:undefined,
      cargo_persona_envia_info: req.body.cargo_persona_envia_info?req.body.cargo_persona_envia_info:undefined,
      empresa_contratista: req.body.empresa_contratista?req.body.empresa_contratista:undefined,
      coordinador_contratista: req.body.coordinador_contratista?req.body.coordinador_contratista:undefined,
      comuna: req.body.comuna?req.body.comuna:undefined,
      ubicacion: req.body.ubicacion?req.body.ubicacion:undefined,
      estado: req.body.estado?req.body.estado:undefined,
      tipo_obra: req.body.tipo_obra?req.body.tipo_obra:undefined,
      segmento: req.body.segmento?req.body.segmento:undefined,
      jefe_delegacion: req.body.jefe_delegacion?req.body.jefe_delegacion:undefined,
      oficina: req.body.oficina?req.body.oficina.id:undefined,
      recargo_distancia: req.body.recargo_distancia?req.body.recargo_distancia.id:undefined

  }

    await Obra.update(obra, {
      where: { id: id }
    }).then(data => {
      if (data[0] === 1) {
        res.status(200).send( { message:"Obra actualizada"} );
      } else {
        res.status(400).send( `No existe una obra con el id ${id}` );
      }
    }).catch(err => {
      res.status(500).send( err.message );
    })
  }catch (error) {
    res.status(500).send(error);
  }
}
  /*********************************************************************************** */


/*********************************************************************************** */
/* Eliminar una obra
;
*/
exports.deleteObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Borra una obra, pasando el campo eliminado a true' */
  try{
    const id = req.params.id;
    const borrar = {"eliminada": true};

    await Obra.update(borrar, {
      where: { id: id }
    }).then(data => {
      if (data[0] === 1) {
        res.status(200).send( "Obra eliminada" );
      }
    }).catch(err => {
      res.status(500).send(err.message );
    })
  }catch (error) {
    res.status(500).send(error);
  }

}
  /*********************************************************************************** */


/*********************************************************************************** */
/* Encuentra una obra por id
;
*/
exports.findObraById = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Devuelve una obra por ID' */
  const id = req.params.id;

  try {
    /*
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, gestor_cliente, \
    numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, fecha_termino::text, row_to_json(tt) as tipo_trabajo, \
    persona_envia_info, cargo_persona_envia_info, row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, \
    row_to_json(c) as comuna, ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada \
    FROM obras.obras o left join _comun.zonal z on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join \
    obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left \
    join obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo \
    left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento \
    s on o.segmento = s.id WHERE o.id = :id";
    */
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, \
      o.gestor_cliente, numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, \
      fecha_termino::text, row_to_json(tt) as tipo_trabajo, persona_envia_info, cargo_persona_envia_info, \
      row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, row_to_json(c) as comuna, \
      ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada, \
      case when erd.cuenta is null then 0 else erd.cuenta end as cantidad_reportes, o.jefe_delegacion, \
      (select count(id) as cantidad_estados_pago FROM obras.encabezado_estado_pago WHERE id_obra = 6) as cantidad_estados_pago, \
      row_to_json(ofi) as oficina, row_to_json(rec) as recargo_distancia FROM obras.obras o left join _comun.zonal z \
      on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join obras.tipo_trabajo tt on \
      o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left join \
      obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on \
      o.comuna = c.codigo left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on \
      o.tipo_obra = tob.id left join obras.segmento s on o.segmento = s.id left join (select id_obra, count(id) \
      as cuenta from obras.encabezado_reporte_diario group by id_obra) as erd on o.id = erd.id_obra left join \
      (SELECT os.id, o.nombre as oficina, so.nombre as supervisor	FROM obras.oficina_supervisor os join _comun.oficinas \
        o on os.oficina = o.id join obras.supervisores_contratista so on os.supervisor = so.id) ofi on o.oficina = \
        ofi.id left join (SELECT id, nombre, porcentaje FROM obras.recargos where id_tipo_recargo = 2) rec \
        on o.recargo_distancia = rec.id WHERE o.id = :id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const obras = await sequelize.query(sql, { replacements: { id: id }, type: QueryTypes.SELECT });
    let salida = [];
    if (obras) {
      for (const element of obras) {

            const detalle_salida = {
              id: Number(element.id),
              codigo_obra: String(element.codigo_obra),
              numero_ot: String(element.numero_ot),
              nombre_obra: String(element.nombre_obra),
              zona: element.zona, //json
              delegacion: element.delegacion, //json
              gestor_cliente: String(element.gestor_cliente),
              numero_aviso: Number(element.numero_aviso),
              numero_oc: String(element.numero_oc),
              monto: Number(element.monto),
              cantidad_uc: Number(element.cantidad_uc),
              fecha_llegada: String(element.fecha_llegada),
              fecha_inicio: String(element.fecha_inicio),
              fecha_termino: String(element.fecha_termino),
              tipo_trabajo: element.tipo_trabajo, //json
              persona_envia_info: String(element.persona_envia_info),
              cargo_persona_envia_info: String(element.cargo_persona_envia_info),
              empresa_contratista: element.empresa_contratista, //json
              coordinador_contratista: element.coordinador_contratista, //json
              comuna: element.comuna, //json
              ubicacion: String(element.ubicacion),
              estado: element.estado, //json
              tipo_obra: element.tipo_obra, //json
              segmento: element.segmento, //json
              eliminada: element.eliminada,
              cantidad_reportes: Number(element.cantidad_reportes),
              jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
              cantidad_estados_pago: Number(element.cantidad_estados_pago),
              oficina: element.oficina, //json
              recargo_distancia: element.recargo_distancia, //json
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


/*********************************************************************************** */
/* Encuentra una obra por Codigo Obra
;
*/
exports.findObraByCodigo = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Devuelve una obra por código de obra' */
  const codigo_obra = req.query.codigo_obra;

  try {
    /*
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, gestor_cliente, \
    numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, fecha_termino::text, row_to_json(tt) as tipo_trabajo, \
    persona_envia_info, cargo_persona_envia_info, row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, \
    row_to_json(c) as comuna, ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada \
    FROM obras.obras o left join _comun.zonal z on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join \
    obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left \
    join obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo \
    left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento \
    s on o.segmento = s.id WHERE o.codigo_obra = :codigo_obra";*/
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, \
      o.gestor_cliente, numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, \
      fecha_termino::text, row_to_json(tt) as tipo_trabajo, persona_envia_info, cargo_persona_envia_info, \
      row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, row_to_json(c) as comuna, \
      ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada, \
      case when erd.cuenta is null then 0 else erd.cuenta end as cantidad_reportes, o.jefe_delegacion, \
      (select count(id) as cantidad_estados_pago FROM obras.encabezado_estado_pago WHERE id_obra = 6) as cantidad_estados_pago, \
      row_to_json(ofi) as oficina, row_to_json(rec) as recargo_distancia FROM obras.obras o left join _comun.zonal z \
      on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join obras.tipo_trabajo tt on \
      o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left join \
      obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on \
      o.comuna = c.codigo left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on \
      o.tipo_obra = tob.id left join obras.segmento s on o.segmento = s.id left join (select id_obra, count(id) \
      as cuenta from obras.encabezado_reporte_diario group by id_obra) as erd on o.id = erd.id_obra left join \
      (SELECT os.id, o.nombre as oficina, so.nombre as supervisor	FROM obras.oficina_supervisor os join _comun.oficinas \
        o on os.oficina = o.id join obras.supervisores_contratista so on os.supervisor = so.id) ofi on o.oficina = \
        ofi.id left join (SELECT id, nombre, porcentaje FROM obras.recargos where id_tipo_recargo = 2) rec \
        on o.recargo_distancia = rec.id WHERE o.codigo_obra = :codigo_obra";
    
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const obras = await sequelize.query(sql, { replacements: { codigo_obra: codigo_obra }, type: QueryTypes.SELECT });
    let salida = [];
    if (obras) {
      for (const element of obras) {

            const detalle_salida = {
              id: Number(element.id),
              codigo_obra: String(element.codigo_obra),
              numero_ot: String(element.numero_ot),
              nombre_obra: String(element.nombre_obra),
              zona: element.zona, //json
              delegacion: element.delegacion, //json
              gestor_cliente: String(element.gestor_cliente),
              numero_aviso: Number(element.numero_aviso),
              numero_oc: String(element.numero_oc),
              monto: Number(element.monto),
              cantidad_uc: Number(element.cantidad_uc),
              fecha_llegada: String(element.fecha_llegada),
              fecha_inicio: String(element.fecha_inicio),
              fecha_termino: String(element.fecha_termino),
              tipo_trabajo: element.tipo_trabajo, //json
              persona_envia_info: String(element.persona_envia_info),
              cargo_persona_envia_info: String(element.cargo_persona_envia_info),
              empresa_contratista: element.empresa_contratista, //json
              coordinador_contratista: element.coordinador_contratista, //json
              comuna: element.comuna, //json
              ubicacion: String(element.ubicacion),
              estado: element.estado, //json
              tipo_obra: element.tipo_obra, //json
              segmento: element.segmento, //json
              eliminada: element.eliminada,
              cantidad_reportes: Number(element.cantidad_reportes),
              jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
              cantidad_estados_pago: Number(element.cantidad_estados_pago),
              oficina: element.oficina, //json
              recargo_distancia: element.recargo_distancia, //json
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

/*********************************************************************************** */
/* Obtiene el código de obra en caso de que sea de tipo emergencia
    GET /api/obras/backoffice/estadopago/v1/codigodeobraemergencia
*/
exports.getCodigoObraEmergencia = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Obtiene el código de obra en caso de que sea de tipo emergencia' */
  try {
    //tipo_obra igual 7 es emergencia
      const sql = "select case when maximo is null then 'E-0000000001'::text else \
      ('E-' || to_char(maximo+1, 'FM0999999999'))::text end as valor from \
      (select max(id) as maximo from obras.obras WHERE tipo_obra = 7) as a";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const codigoEmergencia = await sequelize.query(sql, { type: QueryTypes.SELECT });
      if (codigoEmergencia) {
        res.status(200).send(codigoEmergencia);
      }else{
        res.status(500).send("Error en la consulta (servidor backend)");
      }
  } catch (error) {
    res.status(500).send(error);
  }
}