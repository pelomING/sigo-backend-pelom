const db = require("../../models");
const Recargo = db.recargo;
const TipoRecargo = db.tipoRecargo;
const EncabezadoEstadoPago = db.encabezadoEstadoPago;
const EncabezadoReporteDiario = db.encabezadoReporteDiario;
const EstadoPagoGestion = db.estadoPagoGestion;
const EstadoPagoHistorial = db.estadoPagoHistorial;
const Obra = db.obra;


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
              res.status(500).send(err.message);
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
        const sql = `SELECT 
                        r.id, 
                        nombre, 
                        row_to_json(tr) as tipo_recargo, 
                        porcentaje 
                    FROM obras.recargos r 
                    JOIN obras.tipo_recargo tr 
                    ON r.id_tipo_recargo = tr.id`;

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
    const ids_reporte = req.query.ids_reporte;
    const id_estado_pago = req.query.id_estado_pago;
    const campos = [
        'id_obra'
      ];
      for (const element of campos) {
        if (!req.query[element]) {
          res.status(400).send(
            "No puede estar nulo el campo " + element
          );
          return;
        }
      };

      const salida = await DeterminaEncabezadoEstadoPago(id_obra, ids_reporte, id_estado_pago);
      if (salida.error) {
        res.status(500).send(salida.detalle);
      } else {
        res.status(200).send(salida.detalle);
      }

      

      /*
     const condicion_reporte = ids_reporte?`AND erd.id in (${ids_reporte})`:"";
     const sql = `SELECT 
                  o.id as id_obra, 
                  o.codigo_obra as codigo_obra, 
                  o.nombre_obra as nombre_obra, 
                  row_to_json(d) as cliente, 
                  fecha_llegada::text as fecha_asignacion, 
                  row_to_json(tt) as tipo_trabajo, 
                  row_to_json(s) as segmento, 
                  initcap(gestor_cliente)::varchar as solicitado_por, 
                  repo.sdi as sdi, 
                  row_to_json(ofi) as supervisor_pelom, 
                  row_to_json(cc) as coordinador, 
                  row_to_json(c) as comuna, 
                  ubicacion as direccion, 
                  repo.flexiapp as flexiapp, 
                  fecha_termino::text as fecha_ejecucion, 
                  initcap(o.jefe_delegacion)::varchar as jefe_delegacion, 
                  json_build_object('id', repo.id_jefe, 'nombre', repo.jefe_faena) as jefe_faena, 
                  repo.num_documento as numero_documento, 
                  (SELECT centrality FROM obras.encabezado_reporte_diario erd 
                    WHERE centrality is not null 
                    ${condicion_reporte}
                    ORDER BY fecha_reporte DESC LIMIT 1) as centrality,
                  rec.nombre as recargo_nombre, 
                  rec.porcentaje as recargo_porcentaje,
                  case when tob.no_exige_oc then 1::integer else 0::integer end no_exige_oc, 
                  (SELECT CASE WHEN cod_borrado IS NULL THEN cod_nuevo ELSE cod_borrado END as codigo_pelom
                    FROM
                    (SELECT 
                    (SELECT DISTINCT ON (id_obra) codigo_pelom 
                    FROM obras.encabezado_estado_pago_borrado
                    WHERE codigo_pelom NOT IN
                    (SELECT codigo_pelom FROM obras.encabezado_estado_pago)
                    AND id_obra = ${id_obra}
                    ORDER BY id_obra, fecha_borrado ASC) as cod_borrado,
                    (SELECT 'EDP-' || (case when max(id) is null then 0 else max(id) end + 10000001)::text || 
                                      '-' || substring(current_timestamp::text,1,4) 
                                        FROM (select id from obras.encabezado_estado_pago 
                                  UNION select (datos->>'id')::bigint as id 
                                FROM obras.encabezado_estado_pago_borrado) as eep) as cod_nuevo) as a) as codigo_pelom, 
                  (SELECT precio 
                    FROM obras.valor_uc 
                    WHERE oficina = o.oficina 
                    ORDER BY oficina, fecha desc 
                    LIMIT 1) as valor_uc,
                    (SELECT DISTINCT ON (id) numero_oc
                      FROM obras.encabezado_reporte_diario erd WHERE id_obra = ${id_obra}
                      ${condicion_reporte}
                      ORDER BY id DESC limit 1) as numero_oc,
                      (SELECT DISTINCT ON (id) referencia
                      FROM obras.encabezado_reporte_diario erd WHERE id_obra = ${id_obra}
                      ${condicion_reporte}
                      ORDER BY id DESC limit 1) as referencia
                FROM obras.obras o 
                      LEFT JOIN obras.delegaciones d 
                            ON o.delegacion = d.id 
                      LEFT JOIN obras.tipo_trabajo tt 
                            ON o.tipo_trabajo = tt.id 
                      LEFT JOIN obras.segmento s 
                            ON o.segmento = s.id 
                      LEFT JOIN 
                          (SELECT id, initcap(nombre)::varchar as nombre, id_empresa, 
                          replace(to_char(left(rut, length(rut) - 2)::integer, 'FM99,999,999') 
					                || right(rut, 2),',','.') as rut FROM
                          obras.coordinadores_contratista) cc
                            ON o.coordinador_contratista = cc.id 
                      LEFT JOIN _comun.comunas c 
                            ON o.comuna = c.codigo
                      LEFT JOIN obras.tipo_obra tob
                            ON o.tipo_obra = tob.id 
                      LEFT JOIN (SELECT os.id, o.nombre as oficina, initcap(so.nombre) as supervisor,
                              so.rut as rut 
                                  FROM obras.oficina_supervisor os 
                                  JOIN _comun.oficinas o ON os.oficina = o.id 
                                  JOIN obras.supervisores_contratista so ON os.supervisor = so.id) ofi 
                            ON o.oficina = ofi.id 
                      LEFT JOIN (SELECT id_obra, initcap(jf.nombre) as jefe_faena, jf.id as id_jefe, sdi, num_documento, 
                                flexiapp[1] 
                                FROM obras.encabezado_reporte_diario erd join obras.jefes_faena jf 
                                ON erd.jefe_faena = jf.id	
                                WHERE id_obra = ${id_obra} 
                                ${condicion_reporte}
                                ORDER BY fecha_reporte desc LIMIT 1) as repo 
                            ON o.id = repo.id_obra 
                      LEFT JOIN obras.recargos rec 
                            ON o.recargo_distancia = rec.id 
                      WHERE o.id = ${id_obra}`;
          
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
                    centrality: element.centrality?String(element.centrality):null,
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
                    numero_oc: element.numero_oc?String(element.numero_oc):null,
                    referencia: element.referencia?String(element.referencia):null,
                    no_exige_oc: element.no_exige_oc?Number(element.no_exige_oc):null
 
                  }
                  salida.push(detalle_salida);
            };
          }
          if (salida===undefined){
            res.status(500).send("Error en la consulta (servidor backend)");
          }else{
            res.status(200).send(salida);
          }*/
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
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };

          const ids_reporte = req.query.ids_reporte?req.query.ids_reporte:null;
          const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
          if (array_id_reporte) {
            for (const e of array_id_reporte){
              if (Number.isNaN(e)){
                res.status(400).send("Hay un problema con el formato de ids_reporte");
                return
              }
            }
          };
          //Va a consultar a la funcion listadoActividadesByIdObra definida mas abajo
          const consulta = await listadoActividadesByIdObra(id_obra, ids_reporte);
          if (consulta.error === false) {
            res.status(200).send(consulta.detalle);
          } else {
            res.status(500).send(consulta.detalle);
          }
      } catch (error) {
        console.log('error 5', error)
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
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };
          const ids_reporte = req.query.ids_reporte?req.query.ids_reporte:null;
          const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
          if (array_id_reporte) {
            for (const e of array_id_reporte){
              if (Number.isNaN(e)){
                res.status(400).send("Hay un problema con el formato de ids_reporte");
                return
              }
            }
          };
          
          //Va a consultar a la funcion listadoActividadesByIdObra definida mas abajo
          const consulta = await listadoActividadesAdicionalesByIdObra(id_obra, ids_reporte);
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
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };
          const ids_reporte = req.query.ids_reporte?req.query.ids_reporte:null;
          const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
          if (array_id_reporte) {
            for (const e of array_id_reporte){
              if (Number.isNaN(e)){
                res.status(400).send("Hay un problema con el formato de ids_reporte");
                return
              }
            }
          };
          //Va a consultar a la funcion listadoActividadesByIdObra definida mas abajo
          const consulta = await listadoActividadesHoraExtraByIdObra(id_obra, ids_reporte);
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
/* Obtiene la explicación de los recargos en hora extra
    GET /api/obras/backoffice/estadopago/v1/getallrecargoextra
*/
exports.getAllRecargoExtra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Obtiene la explicación de los recargos en hora extra' */
  try {
    const id_obra = req.query.id_obra;
        const campos = [
            'id_obra'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };
          const ids_reporte = req.query.ids_reporte?req.query.ids_reporte:null;
          const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
          if (array_id_reporte) {
            for (const e of array_id_reporte){
              if (Number.isNaN(e)){
                res.status(400).send("Hay un problema con el formato de ids_reporte");
                return
              }
            }
          };

          const consulta = await recargosHorasExtra( id_obra, ids_reporte );
          if (consulta.error === false) {
            res.status(200).send(consulta.detalle);
          } else {
            res.status(500).send(consulta.detalle);
          }
        } catch (error) {
          console.log('error en getAllRecargoExtra: ', error);
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
          res.status(400).send(
            "No puede estar nulo el campo " + element
          );
          return;
        }
      };

    const ids_reporte = req.query.ids_reporte?req.query.ids_reporte:null;
    const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
    if (array_id_reporte) {
      for (const e of array_id_reporte){
        if (Number.isNaN(e)){
          res.status(400).send("Hay un problema con el formato de ids_reporte");
          return
        }
      }
    };

    const actividadesNormales = await listadoActividadesByIdObra(id_obra, ids_reporte);
    let totalActividadesNormales = !actividadesNormales.error?actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;
   
    const actividadesAdicionales = await listadoActividadesAdicionalesByIdObra(id_obra, ids_reporte);
    let totalActividadesAdicionales = !actividadesAdicionales.error?actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    const actividadesHoraExtra = await listadoActividadesHoraExtraByIdObra(id_obra, ids_reporte);
    let totalActividadesHoraExtra = !actividadesHoraExtra.error?actividadesHoraExtra.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    //const detalle_avances = await listadoAvancesEstadoPagoIdObra(id_obra);
    //let totalAvances = !detalle_avances.error?detalle_avances.detalle.reduce(((total, num) => total + num.monto), 0):undefined;
    
    let totalAvances = 0;

    if (totalActividadesNormales===undefined || totalActividadesAdicionales===undefined || totalActividadesHoraExtra===undefined || totalAvances===undefined) {
      res.status(500).send("Error en la consulta (servidor backend)");
      return;
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
    console.log(error);
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
          res.status(400).send(
            "No puede estar nulo el campo " + element
          );
          return;
        }
      };
      //Va a consultar a la funcion listadoAvancesEstadoPagoIdObra definida mas abajo
      //Deshabilitar los avance 2024/05/06 y enviar un array vacío
      /*
      const consulta = await listadoAvancesEstadoPagoIdObra(id_obra);
      if (consulta.error === false) {
        res.status(200).send(consulta.detalle);
      } else {
        res.status(500).send(consulta.detalle);
      }
      */

      res.status(200).send([]);

    
  } catch (error) {
    res.status(500).send(error);
  }
}

/*********************************************************************************** */
/* Crea un estado de pago
    POST /api/obras/backoffice/estadopago/v1/creaestadopago
*/
exports.creaEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Crea un estado de pago' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos para el crear estado de pago',
            required: false,
            schema: {
                "id_obra": 39,
                "cliente": {
                  "id": 2,
                  "nombre": "CGE Distribución Curicó"
                },
                "fecha_asignacion": "2024-02-21",
                "tipo_trabajo": {
                  "id": 1,
                  "descripcion": "CONSTRUCCIÓN"
                },
                "segmento": {
                  "id": 3,
                  "nombre": "INVERSIÓN",
                  "descripcion": ""
                },
                "solicitado_por": "Luis Pino",
                "supervisor_pelom": {
                  "id": 1,
                  "oficina": "Curicó",
                  "supervisor": "Eduardo Soto"
                },
                "coordinador": {
                  "id": 4,
                  "nombre": "ALEXIS NICOLAS TAPIA GONZALEZ",
                  "id_empresa": 1,
                  "rut": "18983279-6"
                },
                "comuna": {
                  "codigo": "07301",
                  "nombre": "Curicó",
                  "provincia": "073"
                },
                "direccion": "Sector la herradura",
                "fecha_ejecucion": "2024-02-28",
                "jefe_delegacion": "Jorge Castro",
                "jefe_faena": {
                  "id": 4,
                  "nombre": "AYRTON ALEXANDER YEVENES HINOJOSA"
                },
                "codigo_pelom": "EDP-10000051-2024",
                "valor_uc": 10302,
                "ids_reporte": "1,2,3,4,5"
                
            }
        }
      */
  try {
    const campos = [
      'id_obra', 'cliente', 'fecha_asignacion', 'tipo_trabajo',
      'segmento', 'solicitado_por', 'supervisor_pelom', 'coordinador', 'comuna',
      'direccion', 'fecha_ejecucion', 'jefe_delegacion', 'jefe_faena',
      'codigo_pelom', 'valor_uc', 'numero_oc'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send(
          "No puede estar nulo el campo " + element
        );
        return;
      }
    };
    

    const id_obra = req.body.id_obra;
    const ids_reporte = req.body.ids_reporte?req.body.ids_reporte:null;
    const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
    if (array_id_reporte) {
      for (const e of array_id_reporte){
        if (Number.isNaN(e)){
          res.status(400).send("Hay un problema con el formato de ids_reporte");
          return
        }
      }
    };

    //Consultar nombre de la obra y OC
    const obraInfo = await Obra.findOne({
          where: { id: id_obra },
          attributes: ['nombre_obra', 'numero_oc']
    });
    const nombreObra = obraInfo.nombre_obra?obraInfo.nombre_obra:undefined;
    const numeroOc = req.body.numero_oc //obraInfo.numero_oc?obraInfo.numero_oc:undefined;

    const c = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"});
    const fecha_estado_pago = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2)
    const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);


    //const detalle_avances = await listadoAvancesEstadoPagoIdObra(id_obra);
    //let totalAvances = !detalle_avances.error?detalle_avances.detalle.reduce(((total, num) => total + num.monto), 0):undefined;
    const detalle_avances = []
    let totalAvances = 0;

    const actividadesNormales = await listadoActividadesByIdObra(id_obra, ids_reporte);
    let totalActividadesNormales = !actividadesNormales.error?actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;
       
    const actividadesAdicionales = await listadoActividadesAdicionalesByIdObra(id_obra, ids_reporte);
    let totalActividadesAdicionales = !actividadesAdicionales.error?actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    const actividadesHoraExtra = await listadoActividadesHoraExtraByIdObra(id_obra, ids_reporte);
    let totalActividadesHoraExtra = !actividadesHoraExtra.error?actividadesHoraExtra.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    let recargosExtra = await recargosHorasExtra(id_obra, ids_reporte);

    //Chequear si que el total del estado paga sea mayor a cero, si no es así se debe devolver un error
    if (totalActividadesNormales+totalActividadesAdicionales+totalActividadesHoraExtra-totalAvances <= 0) {
      res.status(500).send("No es posible crear un estado de pago con un total menor o igual a 0");
      return;
    }

    let sql = "select nextval('obras.encabezado_estado_pago_id_seq'::regclass) as valor";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let encabezado_estado_pago_id = 0;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          encabezado_estado_pago_id = data[0].valor;
        }).catch(err => {
          res.status(500).send(err.message );
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
      id_obra: id_obra,
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
      recargos_extra: !recargosExtra.error?recargosExtra.detalle:undefined,
      numero_oc: req.body.numero_oc,
      referencia: req.body.referencia?String(req.body.referencia):undefined,
      centrality: req.body.centrality?String(req.body.centrality):undefined,

    }
    console.log('datos -> ', datos)
    if (!datos.flexiapp) {
      res.status(400).send("No puede estar vacio el campo flexiapp. Por favor ingrese al menos un flexiapp en algún reporte diario");
      return
    }
    /*
      Se debe ingresar los datos de la creación de un estado de pago en la tabla estado_pago_gestion
      y también en la de estado_pago_historial
      Si tiene OC se ingresa con estado emitido con OC si no tiene, se ingresa con estado emitido pendiente OC
    */

    let id_usuario = req.userId;
    let user_name;
    sql = "select username from _auth.users where id = " + id_usuario;
    await sequelize.query(sql, {
      type: QueryTypes.SELECT
    }).then(data => {
      user_name = data[0].username;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

   const estadoPagoGestion = {
      codigo_pelom: req.body.codigo_pelom,
      detalle: nombreObra,
      numero_oc: numeroOc,
      estado: numeroOc?2:1, //Si tiene OC pasa a estado emitido con OC (1), si no tiene, pasa a estado pendiente OC (2)
      fecha_entrega_oc: numeroOc?fecha_estado_pago:undefined
   }

   const estadoPagoHistorial = {
      codigo_pelom: req.body.codigo_pelom,
      fecha_hora: fechahoy,
      usuario_rut: user_name,
      estado_edp: numeroOc?2:1,
      datos: datos,
      observacion: "Se crea el estado de pago de la obra <" + nombreObra + ">"
   }

   const Op = db.Sequelize.Op;
   const where = array_id_reporte?{ id_estado_pago: null, id_obra: id_obra, id: { [Op.in]: array_id_reporte } }:{ id_estado_pago: null, id_obra: id_obra};

        let salida = {};
        const t = await sequelize.transaction();

        try {

          salida = {"error": false, "message": "obra ingresada"};
          await EncabezadoEstadoPago.create(datos, { transaction: t });

          await EncabezadoReporteDiario.update(
            {id_estado_pago: encabezado_estado_pago_id}, 
            {where: where, transaction: t});

          await EstadoPagoGestion.create(estadoPagoGestion, { transaction: t });

          await EstadoPagoHistorial.create(estadoPagoHistorial, { transaction: t });
          
          await t.commit();
        } catch (error) {
          salida = { error: true, message: error }
          await t.rollback();
        }
        if (salida.error) {
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }
  }catch(error){
    console.log(error);
    res.status(500).send(error);
  }
}
/*********************************************************************************** */
/* Crea estado de pago version 2
    POST /api/obras/backoffice/estadopago/v2/creaestadopago
*/
exports.creaEstadoPago_v2 = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Crea un estado de pago Versión 2' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos para el crear estado de pago',
            required: false,
            schema: {
                "id_obra": 39,
                "es_preliminar": 1,
                "cliente": {
                  "id": 2,
                  "nombre": "CGE Distribución Curicó"
                },
                "fecha_asignacion": "2024-02-21",
                "tipo_trabajo": {
                  "id": 1,
                  "descripcion": "CONSTRUCCIÓN"
                },
                "segmento": {
                  "id": 3,
                  "nombre": "INVERSIÓN",
                  "descripcion": ""
                },
                "solicitado_por": "Luis Pino",
                "supervisor_pelom": {
                  "id": 1,
                  "oficina": "Curicó",
                  "supervisor": "Eduardo Soto"
                },
                "coordinador": {
                  "id": 4,
                  "nombre": "ALEXIS NICOLAS TAPIA GONZALEZ",
                  "id_empresa": 1,
                  "rut": "18983279-6"
                },
                "comuna": {
                  "codigo": "07301",
                  "nombre": "Curicó",
                  "provincia": "073"
                },
                "direccion": "Sector la herradura",
                "fecha_ejecucion": "2024-02-28",
                "jefe_delegacion": "Jorge Castro",
                "jefe_faena": {
                  "id": 4,
                  "nombre": "AYRTON ALEXANDER YEVENES HINOJOSA"
                },
                "codigo_pelom": "EDP-10000051-2024",
                "valor_uc": 10302,
                "ids_reporte": "1,2,3,4,5"
                
            }
        }
      */
  try {
    const campos = [
      'id_obra', 'cliente', 'fecha_asignacion', 'tipo_trabajo',
      'segmento', 'solicitado_por', 'supervisor_pelom', 'coordinador', 'comuna',
      'direccion', 'fecha_ejecucion', 'jefe_delegacion', 'jefe_faena',
      'codigo_pelom', 'valor_uc', 'numero_oc'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send(
          "No puede estar nulo el campo " + element
        );
        return;
      }
    };
    

    const esPreliminar = req.body.es_preliminar;
    const id_obra = req.body.id_obra;
    const ids_reporte = req.body.ids_reporte?req.body.ids_reporte:null;
    const array_id_reporte = ids_reporte?ids_reporte.split(",").map((e) => Number(e)):undefined;
    if (array_id_reporte) {
      for (const e of array_id_reporte){
        if (Number.isNaN(e)){
          res.status(400).send("Hay un problema con el formato de ids_reporte");
          return
        }
      }
    };

    //Consultar nombre de la obra y OC
    const obraInfo = await Obra.findOne({
          where: { id: id_obra },
          attributes: ['nombre_obra', 'numero_oc']
    });
    const nombreObra = obraInfo.nombre_obra?obraInfo.nombre_obra:undefined;
    const numeroOc = req.body.numero_oc //obraInfo.numero_oc?obraInfo.numero_oc:undefined;

    const c = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"});
    const fecha_estado_pago = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2)
    const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);


    //const detalle_avances = await listadoAvancesEstadoPagoIdObra(id_obra);
    //let totalAvances = !detalle_avances.error?detalle_avances.detalle.reduce(((total, num) => total + num.monto), 0):undefined;
    const detalle_avances = []
    let totalAvances = 0;

    const actividadesNormales = !esPreliminar?await listadoActividadesByIdObra(id_obra, ids_reporte):{error: false, detalle: []};
    let totalActividadesNormales = !actividadesNormales.error?actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;
       
    const actividadesAdicionales = !esPreliminar?await listadoActividadesAdicionalesByIdObra(id_obra, ids_reporte):{error: false, detalle: []};
    let totalActividadesAdicionales = !actividadesAdicionales.error?actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    const actividadesHoraExtra = !esPreliminar?await listadoActividadesHoraExtraByIdObra(id_obra, ids_reporte):{error: false, detalle: []};
    let totalActividadesHoraExtra = !actividadesHoraExtra.error?actividadesHoraExtra.detalle.reduce(((total, num) => total + num.total_pesos), 0):undefined;

    let recargosExtra = !esPreliminar?await recargosHorasExtra(id_obra, ids_reporte):{error: false, detalle: []};

    //Chequear si que el total del estado paga sea mayor a cero, si no es así se debe devolver un error
    if (totalActividadesNormales+totalActividadesAdicionales+totalActividadesHoraExtra-totalAvances <= 0 && !esPreliminar) {
      res.status(500).send("No es posible crear un estado de pago con un total menor o igual a 0");
      return;
    }

    let sql = "select nextval('obras.encabezado_estado_pago_id_seq'::regclass) as valor";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let encabezado_estado_pago_id = 0;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          encabezado_estado_pago_id = data[0].valor;
        }).catch(err => {
          res.status(500).send(err.message );
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
      id_obra: id_obra,
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
      estado: !esPreliminar?1:0,     //0: pendiente, 1: cerrado, 2: facturado
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
      recargos_extra: !recargosExtra.error?recargosExtra.detalle:undefined,
      numero_oc: req.body.numero_oc,
      referencia: req.body.referencia?String(req.body.referencia):undefined,
      centrality: req.body.centrality?String(req.body.centrality):undefined,

    }
    console.log('datos -> ', datos)
    if (!datos.flexiapp) {
      res.status(400).send("No puede estar vacio el campo flexiapp. Por favor ingrese al menos un flexiapp en algún reporte diario");
      return
    }
    /*
      Se debe ingresar los datos de la creación de un estado de pago en la tabla estado_pago_gestion
      y también en la de estado_pago_historial
      Si tiene OC se ingresa con estado emitido con OC si no tiene, se ingresa con estado emitido pendiente OC
    */

    let id_usuario = req.userId;
    let user_name;
    sql = "select username from _auth.users where id = " + id_usuario;
    await sequelize.query(sql, {
      type: QueryTypes.SELECT
    }).then(data => {
      user_name = data[0].username;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

   const estadoPagoGestion = !esPreliminar?{
      codigo_pelom: req.body.codigo_pelom,
      detalle: nombreObra,
      numero_oc: numeroOc,
      estado: numeroOc?2:1, //Si tiene OC pasa a estado emitido con OC (1), si no tiene, pasa a estado pendiente OC (2)
      fecha_entrega_oc: numeroOc?fecha_estado_pago:undefined
   }:undefined;

   const estadoPagoHistorial = !esPreliminar?{
      codigo_pelom: req.body.codigo_pelom,
      fecha_hora: fechahoy,
      usuario_rut: user_name,
      estado_edp: numeroOc?2:1,
      datos: datos,
      observacion: "Se crea el estado de pago de la obra <" + nombreObra + ">"
   }:undefined;

   const Op = db.Sequelize.Op;
   const where = array_id_reporte?{ id_estado_pago: null, id_obra: id_obra, id: { [Op.in]: array_id_reporte } }:{ id_estado_pago: null, id_obra: id_obra};

        let salida = {};
        const t = await sequelize.transaction();

        try {

          salida = {"error": false, "message": "obra ingresada"};
          await EncabezadoEstadoPago.create(datos, { transaction: t });

          await EncabezadoReporteDiario.update(
            {id_estado_pago: encabezado_estado_pago_id}, 
            {where: where, transaction: t});

            estadoPagoGestion?await EstadoPagoGestion.create(estadoPagoGestion, { transaction: t }):null;

            estadoPagoHistorial?await EstadoPagoHistorial.create(estadoPagoHistorial, { transaction: t }):null;
          
          await t.commit();
        } catch (error) {
          salida = { error: true, message: error }
          await t.rollback();
        }
        if (salida.error) {
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }
  }catch(error){
    console.log(error);
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
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };
        const sql = `SELECT 
                        eep.id, 
                        eep.id_obra, 
                        eep.fecha_estado_pago, 
                        row_to_json(d) as cliente, 
                        eep.fecha_asignacion, 
                        row_to_json(tt) as tipo_trabajo, 
                        row_to_json(s) as segmento, 
                        eep.solicitado_por, 
                        row_to_json(c) as comuna, 
                        eep.direccion, 
                        eep.fecha_ejecucion, 
                        eep.jefe_delegacion, 
                        eep.codigo_pelom, 
                        row_to_json(sc) as supervisor, 
                        row_to_json(jf) as jefe_faena, 
                        eep.estado, eep.ot, eep.sdi, 
                        row_to_json(cc) as coordinador, 
                        eep.recargo_nombre, 
                        eep.recargo_porcentaje, 
                        eep.flexiapp, 
                        o.codigo_obra, 
                        o.nombre_obra, 
                        eep.valor_uc,
                        eep.numero_oc,
                        eep.referencia,
                        eep.centrality 
                    FROM 
                        obras.encabezado_estado_pago eep 
                    LEFT JOIN obras.delegaciones d 
                        ON eep.cliente = d.id 
                    LEFT JOIN obras.tipo_trabajo tt 
                        ON eep.tipo_trabajo = tt.id 
                    LEFT JOIN obras.segmento s 
                        ON eep.segmento = s.id 
                    LEFT JOIN _comun.comunas c 
                        ON eep.comuna = c.codigo 
                    LEFT JOIN obras.supervisores_contratista sc 
                        ON eep.supervisor = sc.id 
                    LEFT JOIN obras.jefes_faena jf 
                        ON eep.jefe_faena = jf.id 
                    LEFT JOIN obras.coordinadores_contratista cc 
                        ON eep.coordinador = cc.id 
                    JOIN obras.obras o 
                        ON eep.id_obra = o.id 
                    WHERE 
                        id_obra = ${id_obra} ;`;

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
                        valor_uc: element.valor_uc?Number(element.valor_uc):null,
                        numero_oc: element.numero_oc?String(element.numero_oc):null,
                        referencia: element.referencia?String(element.referencia):null,
                        centrality: element.centrality?String(element.centrality):null,
                        estado: element.estado?Number(element.estado):null

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
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };

          //Buscar el estado del estado de pago, si el estado es 0 es pendiente, si es 1 es procesado
          const estado_edp = await EncabezadoEstadoPago.findOne({
            where: { id: id_estado_pago },
            attributes: ['estado']
          });
          if (!estado_edp) {
            res.status(400).send("No se encontro el estado del estado de pago");
            return;
          }else if (estado_edp.dataValues.estado === 0) {
            console.log("El estado del estado de pago es pendiente");
          }else if (estado_edp.dataValues.estado === 1) {
            console.log("El estado del estado de pago es procesado");
          } else {
            res.status(400).send("Valor del estado desconocido");
            return;
          }

          if (estado_edp.dataValues.estado === 1) {


              const { QueryTypes } = require('sequelize');
              const sequelize = db.sequelize;
              const sql = `SELECT 
                                eep.id, 
                                eep.fecha_estado_pago, 
                                eep.id_obra, 
                                o.codigo_obra, 
                                o.nombre_obra, 
                                row_to_json(d) as cliente, 
                                eep.fecha_asignacion::text, 
                                row_to_json(tt) as tipo_trabajo, 
                                row_to_json(s) as segmento, 
                                initcap(eep.solicitado_por::varchar)::varchar as solicitado_por, 
                                eep.sdi::text, 
                                row_to_json(ofi) as supervisor_pelom, 
                                row_to_json(cc) as coordinador, 
                                row_to_json(c) as comuna, 
                                eep.direccion, 
                                eep.flexiapp, 
                                eep.fecha_ejecucion::text, 
                                initcap(eep.jefe_delegacion)::varchar as jefe_delegacion, 
                                row_to_json(jf) as jefe_faena, 
                                eep.ot as numero_documento, 
                                eep.recargo_nombre, 
                                eep.recargo_porcentaje, 
                                eep.codigo_pelom, 
                                eep.valor_uc, 
                                eep.estado, 
                                eep.subtotal1, 
                                eep.subtotal2, 
                                eep.subtotal3, 
                                eep.descuento_avance, 
                                eep.detalle_avances, 
                                eep.detalle_actividades, 
                                eep.detalle_otros, 
                                eep.detalle_horaextra,
                                eep.numero_oc,
                                eep.recargos_extra,
                                eep.referencia,
                                eep.centrality 
                            FROM obras.encabezado_estado_pago eep 
                            LEFT JOIN obras.obras o 
                                ON eep.id_obra = o.id 
                            LEFT JOIN obras.delegaciones d 
                                ON o.delegacion = d.id 
                            LEFT JOIN obras.tipo_trabajo tt 
                                ON o.tipo_trabajo = tt.id 
                            LEFT JOIN obras.segmento s 
                                ON o.segmento = s.id 
                            LEFT JOIN _comun.comunas c 
                                ON o.comuna = c.codigo 
                            LEFT JOIN 
                      (SELECT id, initcap(nombre)::varchar as nombre, id_empresa, 
                      replace(to_char(left(rut, length(rut) - 2)::integer, 'FM99,999,999') 
                      || right(rut, 2),',','.') as rut FROM
                      obras.coordinadores_contratista) cc 
                                ON o.coordinador_contratista = cc.id 
                            LEFT JOIN 
                                (SELECT os.id, o.nombre as oficina, initcap(so.nombre) as supervisor,
                      so.rut as rut
                                    FROM obras.oficina_supervisor os 
                                    JOIN _comun.oficinas o 
                                      ON os.oficina = o.id 
                                    JOIN obras.supervisores_contratista so 
                                      ON os.supervisor = so.id) ofi 
                                ON o.oficina = ofi.id 
                            LEFT JOIN 
                      (SELECT id, initcap(nombre)::varchar as nombre FROM 
                      obras.jefes_faena) jf 
                                ON eep.jefe_faena = jf.id 
                            WHERE eep.id = ${id_estado_pago}`;

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
                            numero_oc: element.numero_oc?String(element.numero_oc):null,
                            referencia: element.referencia?String(element.referencia):null,
                            centrality: element.centrality?String(element.centrality):null,
                            estado: 1
                        
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
                            avances_estado_pago: element.detalle_avances,
                            recargos_extra: element.recargos_extra
                          }
                          salida.push(detalle_salida);
                    };
                  }
                  if (salida===undefined){
                    res.status(500).send("Error en la consulta (servidor backend)");
                  }else{
                    res.status(200).send(salida[0]);
                  }
          }else {
            const sql = `SELECT 
                            id_obra, 
                            codigo_pelom, 
                            (SELECT ARRAY_AGG(id) as id_reportes 
                            FROM obras.encabezado_reporte_diario 
                            WHERE id_estado_pago = ${id_estado_pago}) 
                        FROM obras.encabezado_estado_pago 
                        WHERE id = ${id_estado_pago};`;

            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const estado_edp = await sequelize.query(sql, { type: QueryTypes.SELECT });

            if (!estado_edp) {
              res.status(400).send("No se encontro el estado del estado de pago");
              return;
            }else {
              const id_obra = estado_edp[0].id_obra;
              const ids_reporte = estado_edp[0].id_reportes.reduce((total, num) => total + ", " + num);
              // Es estado pendiente, hay que consultar los valores desde nuevo encabezado
              const encabezado = await DeterminaEncabezadoEstadoPago(id_obra, ids_reporte, id_estado_pago);
              if (encabezado.error) {
                res.status(500).send(encabezado.detalle);
                return;
              } 

              const detalle_avances = []
              let descuento_avance = 0;

              const actividadesNormales = await listadoActividadesByIdObra(id_obra, ids_reporte);
              let subtotal1 = actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0);
                
              const actividadesAdicionales = await listadoActividadesAdicionalesByIdObra(id_obra, ids_reporte);
              let subtotal2 = actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0);

              const actividadesHoraExtra = await listadoActividadesHoraExtraByIdObra(id_obra, ids_reporte);
              let subtotal3 = actividadesHoraExtra.detalle.reduce(((total, num) => total + num.total_pesos), 0);

              let recargosExtra = await recargosHorasExtra(id_obra, ids_reporte);

               //Chequear si que el total del estado paga sea mayor a cero, si no es así se debe devolver un error
              if (subtotal1+subtotal2+subtotal3-descuento_avance <= 0 ) {
                res.status(500).send("No es posible crear un estado de pago con un total menor o igual a 0");
                return;
              }

                const valorNeto = Number(Number(subtotal1)+Number(subtotal2)+Number(subtotal3));
                const totalNeto = Number(valorNeto - Number(descuento_avance));
                const total = Number((totalNeto * 1.19).toFixed(0));
                const iva = Number(Number(total - totalNeto).toFixed(0));

                const totales = {

                  subtotal1: Number(subtotal1),
                  subtotal2: Number(subtotal2),
                  subtotal3: Number(subtotal3),
                  valorNeto: valorNeto,
                  descuentoAvance: Number(descuento_avance),
                  totalNeto: totalNeto,
                  total: total,
                  iva: iva
                }

                const detalle_salida = {
                  encabezado: encabezado.detalle[0],
                  totales: totales,
                  actividades_por_obra: !actividadesNormales.error?actividadesNormales.detalle:undefined,
                  actividades_adicionales: !actividadesAdicionales.error?actividadesAdicionales.detalle:undefined,
                  actividades_hora_extra: !actividadesHoraExtra.error?actividadesHoraExtra.detalle:undefined,
                  avances_estado_pago: detalle_avances,
                  recargos_extra: recargosExtra
                }

              res.status(200).send(detalle_salida);
            }
          }
      } catch (error) {
          console.log('error Historico  --> ', error)
          res.status(500).send(error);
      }
}

// Actualiza los datos de un estado de pago gestionado para facturación
// PUT /api/obras/backoffice/estadopago/v1/updateEstadoPagoGestionado
exports.updateEstadoPagoGestionado = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Actualiza los datos de un estado de pago gestionado para facturación' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos básicos de una obra',
            required: false,
            schema: {
              fecha_presentacion: "2023-10-25",
              semana: 1,
              numero_oc: "123456",
              fecha_entrega_oc: "2023-10-25",
              fecha_subido_portal: "2023-10-25",
              folio_portal: "123456",
              fecha_hes: "2023-10-25",
              numero_hes: "123456",
              fecha_solicita_factura: "2023-10-25",
              responsable_solicitud : "responsable solicitud",
              numero_factura: "123456",
              fecha_factura: "2023-10-25",
              rango_dias: "30-60"
            }
        }
      */
  try {
    const datos_ingresados = {
      fecha_presentacion: req.body.fecha_presentacion?req.body.fecha_presentacion:undefined,
      semana: req.body.semana?req.body.semana:undefined,
      numero_oc: req.body.numero_oc?req.body.numero_oc:undefined,
      fecha_entrega_oc: req.body.fecha_entrega_oc?req.body.fecha_entrega_oc:undefined,
      fecha_subido_portal: req.body.fecha_subido_portal?req.body.fecha_subido_portal:undefined,
      folio_portal: req.body.folio_portal?req.body.folio_portal:undefined,
      fecha_hes: req.body.fecha_hes?req.body.fecha_hes:undefined,
      numero_hes: req.body.numero_hes?req.body.numero_hes:undefined,
      fecha_solicita_factura: req.body.fecha_solicita_factura?req.body.fecha_solicita_factura:undefined,
      responsable_solicitud : req.body.responsable_solicitud?req.body.responsable_solicitud:undefined,
      numero_factura: req.body.numero_factura?req.body.numero_factura:undefined,
      fecha_factura: req.body.fecha_factura?req.body.fecha_factura:undefined,
      rango_dias: req.body.rango_dias?req.body.rango_dias:undefined,
      estado: undefined
    }
    

    const id = req.params.id;
    // Buscar el estado de pago gestionado por id
    const estadoPagoGestion = await EstadoPagoGestion.findByPk(id);
    if (!estadoPagoGestion) {
      res.status(404).send('No se encontro el estado de pago gestionado para el id ' + id);
      return;
    }

    let estado_edp_nuevo;
    let revisar = true;
    if ((datos_ingresados.fecha_factura || datos_ingresados.numero_factura) && revisar) {
      // Pasar a estado factura emitida (6), primero chequear los campos necesarios esten completos
          const campos = ['fecha_presentacion', 'numero_oc', 'fecha_entrega_oc', 'fecha_subido_portal',
            'folio_portal', 'fecha_hes', 'numero_hes', 'fecha_solicita_factura', 'responsable_solicitud', 'numero_factura',
            'fecha_factura'];
            for (const element of campos) {
              if (!datos_ingresados[element] && !estadoPagoGestion[element]) {
                res.status(400).send("Debe ingresar el dato para el campo " + element );
                return;
              }
            };
            if (estadoPagoGestion.estado && estadoPagoGestion.estado <= 6) {
              estado_edp_nuevo = 6;
            }
            revisar = false;
    }
    if ((datos_ingresados.fecha_solicita_factura || datos_ingresados.responsable_solicitud) && revisar) 
    {

      // Pasar a estado factura solicitada (5), primero chequear los campos necesarios esten completos
          const campos = ['fecha_presentacion', 'numero_oc', 'fecha_entrega_oc', 'fecha_subido_portal',
            'folio_portal', 'fecha_hes', 'numero_hes', 'fecha_solicita_factura', 'responsable_solicitud'];
            for (const element of campos) {
              if (!datos_ingresados[element] && !estadoPagoGestion[element]) {
                res.status(400).send("Debe ingresar el dato para el campo " + element );
                return;
              }
            };
            if (estadoPagoGestion.estado && estadoPagoGestion.estado <= 5) {
              estado_edp_nuevo = 5;
            }
            revisar = false;
    }
    if ((datos_ingresados.fecha_hes || datos_ingresados.numero_hes) && revisar) 
    {

      // Pasar a estado hes registrada (4), primero chequear los campos necesarios esten completos
          const campos = ['fecha_presentacion', 'numero_oc', 'fecha_entrega_oc', 'fecha_subido_portal',
            'folio_portal', 'fecha_hes', 'numero_hes'];
            for (const element of campos) {
              if (!datos_ingresados[element] && !estadoPagoGestion[element]) {
                res.status(400).send("Debe ingresar el dato para el campo " + element );
                return;
              }
            };
            if (estadoPagoGestion.estado && estadoPagoGestion.estado <= 4) {
              estado_edp_nuevo = 4;
            }
            revisar = false;
    }
    if ((datos_ingresados.fecha_subido_portal || datos_ingresados.folio_portal) && revisar) 
    {

      // Pasar a estado subido a portal (3), primero chequear los campos necesarios esten completos
          const campos = ['fecha_presentacion', 'numero_oc', 'fecha_entrega_oc', 'fecha_subido_portal', 'folio_portal'];
            for (const element of campos) {
              if (!datos_ingresados[element] && !estadoPagoGestion[element]) {
                res.status(400).send("Debe ingresar el dato para el campo " + element );
                return;
              }
            };
            if (estadoPagoGestion.estado && estadoPagoGestion.estado <= 3) {
              estado_edp_nuevo = 3;
            }
            revisar = false;
    }
    if ((datos_ingresados.numero_oc || datos_ingresados.fecha_entrega_oc) && revisar) 
    {

      // Pasar a estado emitido con oc (2), primero chequear los campos necesarios esten completos
          const campos = ['fecha_presentacion', 'numero_oc', 'fecha_entrega_oc'];
            for (const element of campos) {
              if (!datos_ingresados[element] && !estadoPagoGestion[element]) {
                res.status(400).send("Debe ingresar el dato para el campo " + element );
                return;
              }
            };
            if (estadoPagoGestion.estado && estadoPagoGestion.estado <= 2) {
              estado_edp_nuevo = 2;
            }
    }
    datos_ingresados.estado = estado_edp_nuevo;

    let id_usuario = req.userId;
    let user_name;
    let sql = "select username from _auth.users where id = " + id_usuario;
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    await sequelize.query(sql, {
      type: QueryTypes.SELECT
    }).then(data => {
      user_name = data[0].username;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

    const c = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"});
    const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

    const estadoPagoHistorial = {
      codigo_pelom: estadoPagoGestion.codigo_pelom,
      fecha_hora: fechahoy,
      usuario_rut: user_name,
      estado_edp: datos_ingresados.estado,
      datos: datos_ingresados,
      observacion: "Modificación de datos de estado pago gestionado"
    }

    let salida = {};
    const t = await sequelize.transaction();
    try {

      salida = {"error": false, "message": "Estado de pago actualizado ok"};

      await EstadoPagoGestion.update(datos_ingresados, { where: { id: id }, transaction: t });

      await EstadoPagoHistorial.create(estadoPagoHistorial, { transaction: t });

      await t.commit();

    } catch (error) {
      salida = { error: true, message: error }
      await t.rollback();
    }
    if (salida.error) {
      res.status(500).send(salida.message);
    }else {
      res.status(200).send(salida);
    }
  }catch (error) {
    res.status(500).send(error);
  }
}

// Lista todos los estados de pago gestionados
// GET /api/obras/backoffice/estadopago/v1/allestadospagogestion
exports.allestadospagogestion = async (req, res) => {
   /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Lista todos los estados de pago gestionados' */
  try {
    const sql = `SELECT 
                    epg.id, 
                    epg.codigo_pelom, 
                    fecha_presentacion::text, 
                    semana, 
                    detalle, 
                    epg.numero_oc, 
                    fecha_entrega_oc::text, 
                    fecha_subido_portal::text, 
                    folio_portal, 
                    fecha_hes::text, 
                    numero_hes, 
                    fecha_solicita_factura::text, 
                    responsable_solicitud, 
                    numero_factura, 
                    fecha_factura::text, 
                    rango_dias, 
                    row_to_json(epe) as estado, 
                    eep.id_obra, 
                    o.codigo_obra, 
                    o.nombre_obra 
                FROM obras.estado_pago_gestion epg 
                JOIN obras.estado_pago_estados epe 
                    ON epg.estado = epe.id 
                JOIN obras.encabezado_estado_pago eep 
                    ON epg.codigo_pelom = eep.codigo_pelom 
                JOIN obras.obras o on eep.id_obra = o.id`;

    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const estadosPagoGes = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (estadosPagoGes) {
        
        for (const element of estadosPagoGes) {
  
              const detalle_salida = {
                id: Number(element.id),
                codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
                fecha_presentacion: element.fecha_presentacion?String(element.fecha_presentacion):null,
                semana: element.semana?Number(element.semana):null,
                detalle: element.detalle?String(element.detalle):null,
                numero_oc: element.numero_oc?String(element.numero_oc):null,
                fecha_entrega_oc: element.fecha_entrega_oc?String(element.fecha_entrega_oc):null,
                fecha_subido_portal: element.fecha_subido_portal?String(element.fecha_subido_portal):null,
                folio_portal: element.folio_portal?String(element.folio_portal):null,
                fecha_hes: element.fecha_hes?String(element.fecha_hes):null,
                numero_hes: element.numero_hes?String(element.numero_hes):null,
                fecha_solicita_factura: element.fecha_solicita_factura?String(element.fecha_solicita_factura):null,
                responsable_solicitud: element.responsable_solicitud?String(element.responsable_solicitud):null,
                numero_factura: element.numero_factura?String(element.numero_factura):null,
                fecha_factura: element.fecha_factura?String(element.fecha_factura):null,
                rango_dias: element.rango_dias?String(element.rango_dias):null,
                estado: element.estado,
                id_obra: element.id_obra?Number(element.id_obra):null,
                codigo_obra: element.codigo_obra?String(element.codigo_obra):null,
                nombre_obra: element.nombre_obra?String(element.nombre_obra):null
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

// Elimina un estado de pago
// DELETE /api/obras/backoffice/estadopago/v1/borraestadopago
exports.borraEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
      #swagger.description = 'Elimina un estado de pago' */

  try {
    const id_estado_pago = req.params.id;

    let codigo_pelom;
    let sql = `SELECT codigo_pelom	FROM obras.encabezado_estado_pago WHERE id = ${id_estado_pago};`
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    await sequelize.query(sql, {
      type: QueryTypes.SELECT
    }).then(data => {
      codigo_pelom = data[0].codigo_pelom;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

    let id_usuario = req.userId;
    let user_name;
    sql = "select username from _auth.users where id = " + id_usuario;
    await sequelize.query(sql, {
      type: QueryTypes.SELECT
    }).then(data => {
      user_name = data[0].username;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

    const sql_borra = `INSERT INTO obras.encabezado_estado_pago_borrado (id_obra, codigo_pelom, usuario_rut, datos) 
                            SELECT eep.id_obra, eep.codigo_pelom, '${user_name}'::varchar, row_to_json(eep) as datos	
                            FROM obras.encabezado_estado_pago as eep WHERE id = ${id_estado_pago};
                      DELETE FROM obras.estado_pago_historial WHERE codigo_pelom = '${codigo_pelom}';
                      DELETE FROM obras.estado_pago_gestion WHERE codigo_pelom = '${codigo_pelom}';
                      UPDATE obras.encabezado_reporte_diario SET id_estado_pago = null WHERE id_estado_pago = ${id_estado_pago};
                      DELETE FROM obras.encabezado_estado_pago WHERE id = ${id_estado_pago};`

    
    const estado = await sequelize.query(sql_borra, { type: QueryTypes.DELETE });
    res.status(200).send(estado);
  } catch (error) {
    res.status(500).send(error);
  }
} 

/*********************************************************************************** */
/* Consulta todos los encabezados reportes diarios para un id de estado de pago
;
*/
exports.findAllEncabezadoReporteDiarioByIdEstadoPago = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Estado de Pago']
     #swagger.description = 'Devuelve todos los encabezados de reporte diario para id de estado de pago'*/

   

   try {
     
      const id_estado_pago = req.query.id_estado_pago;
      if (!id_estado_pago) return res.status(500).send('Falta id de estado de pago');
     
      const sql = `
         SELECT 
             rd.id, 
             id_estado_pago, 
             eep.estado,
             eep.codigo_pelom,
             json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, 
             fecha_reporte::text, 
             row_to_json(jf) as jefe_faena, 
             rd.sdi, 
             rd.gestor_cliente, 
             row_to_json(tt) as id_area, 
             brigada_pesada, 
             observaciones, 
             entregado_por_persona, 
             fecha_entregado::text, 
             revisado_por_persona, 
             fecha_revisado::text, 
             sector, 
             hora_salida_base::text, 
             hora_llegada_terreno::text, 
             hora_salida_terreno::text, 
             hora_llegada_base::text, 
             alimentador, 
             --row_to_json(c) as comuna, 
             num_documento, 
             rd.flexiapp, 
             row_to_json(rec) as recargo,
             rd.referencia,
             rd.numero_oc, 
             rd.centrality,
             (SELECT ARRAY_AGG(detalle) as detalle_actividad 
               FROM (SELECT row_to_json(a) as detalle 
                     FROM (SELECT 
                             dra.id, 
                             row_to_json(top) as tipo_operacion, 
                             ma.tipo_actividad, row_to_json(ma) as actividad, 
                             cantidad, 
                             json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) 
                               as encabezado_reporte, 
                             case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 
                               then uc_traslado else 0 end as unitario, 
                             case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 
                               then uc_traslado else 0 end * cantidad as total 
                           FROM 
                             obras.detalle_reporte_diario_actividad dra 
                           JOIN obras.tipo_operacion top 
                             ON dra.tipo_operacion = top.id 
                           JOIN (SELECT ma.id, 
                                   actividad, 
                                   row_to_json(ta) as tipo_actividad, 
                                   uc_instalacion, 
                                   uc_retiro, 
                                   uc_traslado, 
                                   ma.descripcion, 
                                   row_to_json(mu) as unidad 
                                 FROM obras.maestro_actividades ma 
                                 JOIN obras.tipo_actividad ta 
                                     ON ma.id_tipo_actividad = ta.id 
                                 JOIN obras.maestro_unidades mu 
                                     ON ma.id_unidad = mu.id) ma 
                               ON dra.id_actividad = ma.id 
                           JOIN obras.encabezado_reporte_diario erd 
                               ON dra.id_encabezado_rep = erd.id 
                           WHERE dra.id_encabezado_rep = rd.id
                           ) a
                     ) b
               ), 
             (SELECT ARRAY_AGG(detalle) as detalle_otros 
               FROM (SELECT row_to_json(a) as detalle 
                       FROM (SELECT 
                               drd.id, 
                               glosa, 
                               uc_unitaria, 
                               cantidad, 
                               total_uc,
                               unitario_pesos,
                               total_pesos, 
                               json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) 
                                 as encabezado_reporte 
                             FROM obras.detalle_reporte_diario_otras_actividades drd 
                             JOIN obras.encabezado_reporte_diario erd 
                                 ON drd.id_encabezado_rep = erd.id 
                             WHERE drd.id_encabezado_rep = rd.id
                             ) a
                     ) b
               ) 
           FROM obras.encabezado_reporte_diario rd 
           JOIN obras.tipo_trabajo tt 
               ON rd.id_area = tt.id 
           JOIN obras.obras o 
               ON rd.id_obra = o.id 
           --LEFT JOIN _comun.comunas c 
           --    ON rd.comuna = c.codigo 
           LEFT JOIN obras.jefes_faena jf 
               ON rd.jefe_faena = jf.id 
           LEFT JOIN obras.recargos rec 
               ON rd.recargo_hora = rec.id 
           LEFT JOIN obras.encabezado_estado_pago eep 
               ON rd.id_estado_pago = eep.id
           WHERE rd.id_estado_pago = ${id_estado_pago}
           OR (rd.id_estado_pago is null
           AND rd.id_obra = (select id_obra from obras.encabezado_estado_pago where id = ${id_estado_pago}))
           ORDER by rd.id_estado_pago, rd.fecha_reporte::date desc`;
      


       const { QueryTypes } = require('sequelize'); 
       const sequelize = db.sequelize;
       const encabezadoReporte = await sequelize.query(sql, { type: QueryTypes.SELECT });
       let salida = [];
       if (encabezadoReporte) {
         for (const element of encabezadoReporte) {
           

           const detalle_salida = {
             id: Number(element.id),
             id_estado_pago: element.id_estado_pago?Number(element.id_estado_pago):null,
             estado: element.estado?element.estado:null,
             codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
             id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
             fecha_reporte: String(element.fecha_reporte),
             jefe_faena: element.jefe_faena,
             sdi: String(element.sdi),
             supervisor: String(element.revisado_por_persona),
             ito_mandante: String(element.gestor_cliente),
             area: element.id_area, //json {"id": id, "descripcion": descripcion}
             brigada_pesada: element.brigada_pesada?{ id: 2, descripcion: 'PESADA' }:{ id: 1, descripcion: 'LIVIANA'},
             observaciones: String(element.observaciones),
             entregado_por_persona: String(element.entregado_por_persona),
             fecha_entregado: String(element.fecha_entregado),
             revisado_por_persona: String(element.revisado_por_persona),
             fecha_revisado: String(element.fecha_revisado),
             sector: String(element.sector),
             hora_salida_base: String(element.hora_salida_base),
             hora_llegada_terreno: String(element.hora_llegada_terreno),
             hora_salida_terreno: String(element.hora_salida_terreno),
             hora_llegada_base: String(element.hora_llegada_base),
             alimentador: String(element.alimentador),
             comuna: element.comuna,
             num_documento: element.num_documento?String(element.num_documento):null,
             flexiapp: element.flexiapp,
             recargo_hora: element.recargo,
             referencia: element.referencia?String(element.referencia):null,
             numero_oc: element.numero_oc?String(element.numero_oc):null,
             centrality: element.centrality?String(element.centrality):null,
             det_actividad: element.detalle_actividad,
             det_otros: element.detalle_otros


           }
               salida.push(detalle_salida);
         };
       }
       if (salida===undefined){
         res.status(500).send("Error en la consulta (servidor backend)");
       }else{
         res.status(200).send(salida);
       }
     
   }catch (error) {
    console.log('error enc_repo -> ',error);
     res.status(500).send(error);
   }
 
}

let listadoActividadesByIdObra = async (id_obra, ids_reporte) => {
  try {
    console.log('listadoActividadesByIdObra - ids_reporte -> ',ids_reporte);
    const condicion_reporte = ids_reporte?`AND erd.id in (${ids_reporte})`:"";

    const sql = `SELECT 
                    top.clase, 
                    ta.descripcion tipo, 
                    (case when e.porcentaje is null or e.porcentaje = 0 then '' else e.nombre_corto end || ma.actividad) as actividad, 
                    mu.codigo_corto as unidad, 
                    e.cantidad, 
                    case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' 
                    then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, 
                    (SELECT precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    e.porcentaje as porcentaje, 
                    e.recargo_distancia,
                    e.descripcion_hextra,
                    e.descripcion_distancia 
                FROM 
                  (SELECT drda.tipo_operacion, 
                          drda.id_actividad, 
                          sum(drda.cantidad) as cantidad, 
                          case when rec.nombre_corto is null then ''::varchar else ('(' || rec.nombre_corto || ') ')::varchar end as nombre_corto,
                          case when rec.nombre_corto is null then ''::varchar else ('(' || rec.nombre || ') ')::varchar end as descripcion_hextra,  
                          rec1.porcentaje as recargo_distancia,
                          rec1.nombre as descripcion_distancia, 
                          case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, 
                          o.oficina 
                    FROM obras.encabezado_reporte_diario erd 
                      JOIN obras.detalle_reporte_diario_actividad drda 
                            ON erd.id = drda.id_encabezado_rep 
                      LEFT JOIN obras.recargos rec 
                            ON erd.recargo_hora = rec.id 
                      JOIN obras.obras o 
                            ON erd.id_obra = o.id 
                      LEFT JOIN obras.recargos rec1 
                            ON o.recargo_distancia = rec1.id 
                    WHERE id_obra = ${id_obra} 
                    ${condicion_reporte}
                    GROUP BY 
                        drda.tipo_operacion, 
                        drda.id_actividad, 
                        rec.nombre_corto, 
                        rec.nombre,
                        rec.porcentaje, 
                        rec1.porcentaje, 
				   		          rec1.nombre,
                        o.oficina
                  ) e 
                JOIN obras.maestro_actividades ma 
                    ON e.id_actividad = ma.id 
                JOIN obras.tipo_operacion top 
                    ON e.tipo_operacion = top.id 
                JOIN obras.tipo_actividad ta 
                    ON ma.id_tipo_actividad = ta.id 
                JOIN obras.maestro_unidades mu 
                    ON ma.id_unidad = mu.id 
                WHERE 
                    e.porcentaje = 0 
                    AND ta.id <> 9`;
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (actividades) {
                
                for (const element of actividades) {

                      //const total_pesos = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));
                      //const total_recargo_aplicado = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+element.recargo_distancia/100)).toFixed(0));
                      //const recargo_calculado = Number((Number(total_recargo_aplicado) - Number(total_pesos)).toFixed(0));
                      const total_neto = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));
                      const total_pesos =  Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+element.recargo_distancia/100)).toFixed(0));

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
                        total_pesos: total_pesos,
                        total_neto: total_neto,
                        //total_recargo_aplicado: total_recargo_aplicado,
                        //recargo_calculado: recargo_calculado,
                        //descripcion_distancia: element.descripcion_distancia?String(element.descripcion_distancia):null,
                        
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
    console.log('error, listadoActividadesAdicionalesByIdObra', error);
    const retorna = {
      error: true,
      detalle: error
    }
    return retorna;
  }
  
}

let listadoActividadesAdicionalesByIdObra = async (id_obra, ids_reporte) => {
  try {

    console.log('listadoActividadesAdicionalesByIdObra - ids_reporte -> ',ids_reporte);
    const condicion_reporte = ids_reporte?`AND erd.id in (${ids_reporte})`:"";

    const sql = `SELECT 
                    top.clase, 
                    ta.descripcion tipo, 
                    (case when e.porcentaje is null or e.porcentaje = 0 
                          then '' else e.nombre_corto end || ma.actividad) as actividad, 
                    mu.codigo_corto as unidad, 
                    e.cantidad, 
                    case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' 
                          then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, 
                    (SELECT precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    e.porcentaje as porcentaje, 
                    e.recargo_distancia 
                FROM 
                    (SELECT 
                        drda.tipo_operacion, 
                        drda.id_actividad, 
                        sum(drda.cantidad) as cantidad, 
                        case when rec.nombre_corto is null then ''::varchar else ('(' || rec.nombre_corto || ') ')::varchar end as nombre_corto, 
                        rec1.porcentaje as recargo_distancia, 
                        case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, 
                        o.oficina 
                            FROM 
                                obras.encabezado_reporte_diario erd 
                            JOIN obras.detalle_reporte_diario_actividad drda 
                                ON erd.id = drda.id_encabezado_rep 
                            LEFT JOIN obras.recargos rec 
                                ON erd.recargo_hora = rec.id 
                            JOIN obras.obras o 
                                ON erd.id_obra = o.id 
                            LEFT JOIN obras.recargos rec1 
                                ON o.recargo_distancia = rec1.id 
                            WHERE id_obra = ${id_obra} 
                            ${condicion_reporte}
                            GROUP BY 
                                drda.tipo_operacion, 
                                drda.id_actividad, 
                                rec.nombre_corto, 
                                rec.porcentaje, 
                                rec1.porcentaje, 
                                o.oficina
                    ) e 
                JOIN obras.maestro_actividades ma 
                      ON e.id_actividad = ma.id 
                JOIN obras.tipo_operacion top 
                      ON e.tipo_operacion = top.id 
                JOIN obras.tipo_actividad ta 
                      ON ma.id_tipo_actividad = ta.id 
                JOIN obras.maestro_unidades mu 
                      ON ma.id_unidad = mu.id 
                WHERE e.porcentaje = 0 
                AND ta.id = 9 
            UNION 
                SELECT 
                    'I'::char as clase, 
                    'Adicionales'::varchar as tipo, 
                    (case when rec.porcentaje is null or rec.porcentaje = 0 then ''::varchar 
                        else ('(' || rec.nombre_corto || ') ')::varchar end || glosa) as actividad, 
                    'CU'::varchar, 
                    cantidad, 
                    uc_unitaria::double precision as unitario, 
                    (SELECT precio FROM obras.valor_uc where oficina = o.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, 
                    rec1.porcentaje as recargo_distancia 
                FROM 
                    obras.detalle_reporte_diario_otras_actividades drdoa 
                JOIN obras.encabezado_reporte_diario erd 
                    ON drdoa.id_encabezado_rep = erd.id
                JOIN obras.obras o 
                    ON erd.id_obra = o.id 
                LEFT JOIN obras.recargos rec 
                    ON erd.recargo_hora = rec.id 
                LEFT JOIN obras.recargos rec1 
                    ON o.recargo_distancia = rec1.id 
                WHERE erd.id_obra = ${id_obra} 
                ${condicion_reporte}
                AND (rec.porcentaje is null or rec.porcentaje = 0) 
                ORDER BY 1,2,3;`;

    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (actividades) 
    {    
        for (const element of actividades) 
        {
              const total_neto = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));
              const total_pesos =  Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+element.recargo_distancia/100)).toFixed(0));

  
              const detalle_salida = 
              {
                  clase: String(element.clase),
                  tipo: String(element.tipo),
                  actividad: String(element.actividad),
                  unidad: String(element.unidad),
                  cantidad: Number(element.cantidad),
                  unitario: Number(element.unitario).toFixed(3),
                  unitario_pesos: Number(element.unitario * element.valor_uc),
                  total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                  recargos: element.recargo_distancia?element.recargo_distancia.toString()+'%':'0%',
                  total_pesos: total_pesos,
                  total_neto: total_neto
                  
              }
              salida.push(detalle_salida);
        };
    }
    const retorna = 
    {
        error: false,
        detalle: salida
    }
    return retorna;
  } 
    catch (error) 
  {
    const retorna = 
    {
        error: true,
        detalle: error
    }
    return retorna;
  }
}

let listadoActividadesHoraExtraByIdObra = async (id_obra, ids_reporte) => {
  try 
  {
    console.log('listadoActividadesHoraExtraByIdObra - ids_reporte -> ',ids_reporte);
    const condicion_reporte = ids_reporte?`AND erd.id in (${ids_reporte})`:"";

    const sql = `SELECT 
                    top.clase, 
                    ta.descripcion tipo, 
                    (e.nombre_corto || ma.actividad) as actividad, 
                    mu.codigo_corto as unidad, 
                    e.cantidad, 
                    case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' 
                        then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, 
                    (SELECT precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    e.porcentaje as porcentaje, 
                    e.recargo_distancia 
                FROM 
                    (SELECT 
                        drda.tipo_operacion, 
                        drda.id_actividad, 
                        sum(drda.cantidad) as cantidad, 
                        case when rec.nombre_corto is null then ''::varchar else ('(' || rec.nombre_corto || ') ')::varchar end as nombre_corto, 
                        rec1.porcentaje as recargo_distancia, 
                        case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, 
                        o.oficina 
                            FROM 
                                obras.encabezado_reporte_diario erd 
                            JOIN obras.detalle_reporte_diario_actividad drda 
                                ON erd.id = drda.id_encabezado_rep 
                            LEFT JOIN obras.recargos rec 
                                ON erd.recargo_hora = rec.id 
                            JOIN obras.obras o 
                                ON erd.id_obra = o.id 
                            LEFT JOIN obras.recargos rec1 
                                ON o.recargo_distancia = rec1.id 
                            WHERE id_obra = ${id_obra} 
                            ${condicion_reporte}
                            GROUP BY 
                                drda.tipo_operacion, 
                                drda.id_actividad, 
                                rec.nombre_corto, 
                                rec.porcentaje, 
                                rec1.porcentaje, 
                                o.oficina
                    ) e 
                JOIN obras.maestro_actividades ma 
                    ON e.id_actividad = ma.id 
                JOIN obras.tipo_operacion top 
                    ON e.tipo_operacion = top.id 
                JOIN obras.tipo_actividad ta 
                    ON ma.id_tipo_actividad = ta.id 
                JOIN obras.maestro_unidades mu 
                    ON ma.id_unidad = mu.id 
                WHERE e.porcentaje > 0 
            UNION 
                SELECT 
                    'I'::char as clase, 
                    'Adicionales'::varchar as tipo, 
                    (case when rec.nombre_corto is null then ''::varchar else ('(' || rec.nombre_corto || ') ')::varchar 
                        end || glosa) as actividad, 
                    'CU'::varchar, 
                    cantidad, 
                    uc_unitaria::double precision as unitario, 
                    (SELECT precio FROM obras.valor_uc where oficina = o.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, 
                    rec1.porcentaje as recargo_distancia 
                FROM 
                    obras.detalle_reporte_diario_otras_actividades drdoa 
                JOIN obras.encabezado_reporte_diario erd 
                    ON drdoa.id_encabezado_rep = erd.id 
                JOIN obras.obras o 
                    ON erd.id_obra = o.id 
                LEFT JOIN obras.recargos rec 
                    ON erd.recargo_hora = rec.id 
                LEFT JOIN obras.recargos rec1 
                    ON o.recargo_distancia = rec1.id 
                WHERE erd.id_obra = ${id_obra} 
                ${condicion_reporte}
                AND (rec.porcentaje is not null and rec.porcentaje > 0) 
                ORDER BY 1,2,3;`;

    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (actividades) 
    {
                
        for (const element of actividades) 
        {

            const recargo_hora = element.porcentaje?Number(element.porcentaje):0;
            const recargo_distancia = element.recargo_distancia?Number(element.recargo_distancia):0;
            const recargo_total = Number(recargo_hora+recargo_distancia);
            const total_neto = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));
            const total_pesos =  Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+recargo_total/100)).toFixed(0));


            const detalle_salida = 
            {
                clase: String(element.clase),
                tipo: String(element.tipo),
                actividad: String(element.actividad),
                unidad: String(element.unidad),
                cantidad: Number(element.cantidad),
                unitario: Number(element.unitario),
                unitario_pesos: Number(element.unitario * element.valor_uc),
                total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                recargos: recargo_total.toString()+'%',
                total_pesos: total_pesos,
                total_neto: total_neto
            }
            salida.push(detalle_salida);
        };
    }
    const retorna = 
    {
        error: false,
        detalle: salida
    }
    return retorna;
  } 
    catch (error) 
  {
    const retorna = 
    {
        error: true,
        detalle: error
    }
    return retorna;
  }
}

let listadoAvancesEstadoPagoIdObra = async (id_obra) => {
  try 
  {
      const sql = `SELECT 
                      codigo_pelom, 
                      fecha_estado_pago::text, 
                      (subtotal1 + subtotal2 + subtotal3 - descuento_avance) as monto 
                  FROM obras.encabezado_estado_pago 
                  WHERE id_obra = ${id_obra} 
                  ORDER BY 
                      fecha_estado_pago DESC, 
                      id desc`;

      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const avances = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];

      if (avances) 
      {  
          for (const element of avances) 
          {

              const detalle_salida = 
              {
                  codigo_pelom: String(element.codigo_pelom),
                  fecha_avance: String(element.fecha_estado_pago),
                  monto: Number(element.monto)                                
              }
              salida.push(detalle_salida);
          };
      }
      const retorna = 
      {
          error: false,
          detalle: salida
      }
      return retorna;

  } 
    catch (error) 
  {
      const retorna = 
      {
          error: true,
          detalle: error
      }
      return retorna;
  }
}

let recargosHorasExtra = async (id_obra, ids_reporte) => {
  try {

    const condicion_reporte = ids_reporte?`AND erd.id in (${ids_reporte})`:"";
    const sql = `SELECT 
                  
                  rec.nombre_corto,
                  rec.nombre,
                  rec1.porcentaje as recargo_distancia, 
                  case when rec.porcentaje is null then 0 else rec.porcentaje end as porcentaje, 
                  o.oficina 
                      FROM 
                          obras.encabezado_reporte_diario erd 
                      JOIN obras.detalle_reporte_diario_actividad drda 
                          ON erd.id = drda.id_encabezado_rep 
                      LEFT JOIN obras.recargos rec 
                          ON erd.recargo_hora = rec.id 
                      JOIN obras.obras o 
                          ON erd.id_obra = o.id 
                      LEFT JOIN obras.recargos rec1 
                          ON o.recargo_distancia = rec1.id 
                      WHERE rec.porcentaje is not null and rec.porcentaje > 0 AND
              id_obra = ${id_obra} 
                      ${condicion_reporte}
                      GROUP BY 
                          rec.nombre_corto,
              rec.nombre,
                          rec.porcentaje, 
                          rec1.porcentaje, 
                          o.oficina`;

      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const recargoExtra = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (recargoExtra) 
      {  
          for (const element of recargoExtra) 
          {

              const detalle_salida = 
              {
                tipo_extra: String(element.nombre_corto),
                descripcion: String(element.nombre),
                recargo_distancia: Number(element.recargo_distancia),
                recargo_extra: Number(element.porcentaje),
                recargo_total: Number((Number(element.recargo_distancia) + Number(element.porcentaje)).toFixed(2))
                               
              }
              salida.push(detalle_salida);
          };
      }
      const retorna = 
      {
          error: false,
          detalle: salida
      }
      return retorna;
  } catch (error) {
      const retorna = 
      {
          error: true,
          detalle: error
      }
      return retorna;

  }

}

let DeterminaEncabezadoEstadoPago = async (id_obra, ids_reporte, id_estado_pago) => {

  try {
    if (!id_obra) return { error: true, detalle: 'No puede estar vacio el id_obra' };

    const condicion_reporte = ids_reporte?`AND erd.id in (${ids_reporte})`:"";

    const codigo_pelom = id_estado_pago?await EncabezadoEstadoPago.findOne({
      where: { id: id_estado_pago },
      attributes: ['codigo_pelom']
    }):undefined;

    console.log('codigo_pelom -> ', codigo_pelom);
    let condicion_codigo_pelom;
    if (codigo_pelom) {
      condicion_codigo_pelom = `'${codigo_pelom.dataValues.codigo_pelom}'::text as codigo_pelom`;
    } else {
      condicion_codigo_pelom = `(SELECT CASE WHEN cod_borrado IS NULL THEN cod_nuevo ELSE cod_borrado END as codigo_pelom
        FROM
        (SELECT 
        (SELECT DISTINCT ON (id_obra) codigo_pelom 
        FROM obras.encabezado_estado_pago_borrado
        WHERE codigo_pelom NOT IN
        (SELECT codigo_pelom FROM obras.encabezado_estado_pago)
        AND id_obra = ${id_obra}
        ORDER BY id_obra, fecha_borrado ASC) as cod_borrado,
        (SELECT 'EDP-' || (case when max(id) is null then 0 else max(id) end + 10000001)::text || 
                          '-' || substring(current_timestamp::text,1,4) 
                            FROM (select id from obras.encabezado_estado_pago 
                      UNION select (datos->>'id')::bigint as id 
                    FROM obras.encabezado_estado_pago_borrado) as eep) as cod_nuevo) as a) as codigo_pelom`;
    }
    
     const sql = `SELECT 
                  o.id as id_obra, 
                  o.codigo_obra as codigo_obra, 
                  o.nombre_obra as nombre_obra, 
                  row_to_json(d) as cliente, 
                  fecha_llegada::text as fecha_asignacion, 
                  row_to_json(tt) as tipo_trabajo, 
                  row_to_json(s) as segmento, 
                  initcap(gestor_cliente)::varchar as solicitado_por, 
                  repo.sdi as sdi, 
                  row_to_json(ofi) as supervisor_pelom, 
                  row_to_json(cc) as coordinador, 
                  row_to_json(c) as comuna, 
                  ubicacion as direccion, 
                  repo.flexiapp as flexiapp, 
                  fecha_termino::text as fecha_ejecucion, 
                  initcap(o.jefe_delegacion)::varchar as jefe_delegacion, 
                  json_build_object('id', repo.id_jefe, 'nombre', repo.jefe_faena) as jefe_faena, 
                  repo.num_documento as numero_documento, 
                  (SELECT centrality FROM obras.encabezado_reporte_diario erd 
                    WHERE centrality is not null 
                    ${condicion_reporte}
                    ORDER BY fecha_reporte DESC LIMIT 1) as centrality,
                  rec.nombre as recargo_nombre, 
                  rec.porcentaje as recargo_porcentaje,
                  case when tob.no_exige_oc then 1::integer else 0::integer end no_exige_oc,${condicion_codigo_pelom}, 
                  (SELECT precio 
                    FROM obras.valor_uc 
                    WHERE oficina = o.oficina 
                    ORDER BY oficina, fecha desc 
                    LIMIT 1) as valor_uc,
                    (SELECT DISTINCT ON (id) numero_oc
                      FROM obras.encabezado_reporte_diario erd WHERE id_obra = ${id_obra}
                      ${condicion_reporte}
                      ORDER BY id DESC limit 1) as numero_oc,
                      (SELECT DISTINCT ON (id) referencia
                      FROM obras.encabezado_reporte_diario erd WHERE id_obra = ${id_obra}
                      ${condicion_reporte}
                      ORDER BY id DESC limit 1) as referencia
                FROM obras.obras o 
                      LEFT JOIN obras.delegaciones d 
                            ON o.delegacion = d.id 
                      LEFT JOIN obras.tipo_trabajo tt 
                            ON o.tipo_trabajo = tt.id 
                      LEFT JOIN obras.segmento s 
                            ON o.segmento = s.id 
                      LEFT JOIN 
                          (SELECT id, initcap(nombre)::varchar as nombre, id_empresa, 
                          replace(to_char(left(rut, length(rut) - 2)::integer, 'FM99,999,999') 
					                || right(rut, 2),',','.') as rut FROM
                          obras.coordinadores_contratista) cc
                            ON o.coordinador_contratista = cc.id 
                      LEFT JOIN _comun.comunas c 
                            ON o.comuna = c.codigo
                      LEFT JOIN obras.tipo_obra tob
                            ON o.tipo_obra = tob.id 
                      LEFT JOIN (SELECT os.id, o.nombre as oficina, initcap(so.nombre) as supervisor,
                              so.rut as rut 
                                  FROM obras.oficina_supervisor os 
                                  JOIN _comun.oficinas o ON os.oficina = o.id 
                                  JOIN obras.supervisores_contratista so ON os.supervisor = so.id) ofi 
                            ON o.oficina = ofi.id 
                      LEFT JOIN (SELECT id_obra, initcap(jf.nombre) as jefe_faena, jf.id as id_jefe, sdi, num_documento, 
                                flexiapp[1] 
                                FROM obras.encabezado_reporte_diario erd join obras.jefes_faena jf 
                                ON erd.jefe_faena = jf.id	
                                WHERE id_obra = ${id_obra} 
                                ${condicion_reporte}
                                ORDER BY fecha_reporte desc LIMIT 1) as repo 
                            ON o.id = repo.id_obra 
                      LEFT JOIN obras.recargos rec 
                            ON o.recargo_distancia = rec.id 
                      WHERE o.id = ${id_obra}`;
          
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
                    valor_uc: element.valor_uc?Number(element.valor_uc):null,
                    numero_oc: element.numero_oc?String(element.numero_oc):null,
                    referencia: element.referencia?String(element.referencia):null,
                    centrality: element.centrality?String(element.centrality):null,
                    no_exige_oc: element.no_exige_oc?Number(element.no_exige_oc):null,
                    estado: 0
 
                  }
                  salida.push(detalle_salida);
            };
          }
          if (salida===undefined){
            //res.status(500).send("Error en la consulta (servidor backend)");
            const retorna = 
              {
                  error: true,
                  detalle: "Error en la consulta (servidor backend)"
              }
              return retorna;
          }else{
            //res.status(200).send(salida);
            const retorna = 
              {
                  error: false,
                  detalle: salida
              }
              return retorna;
          }

  }catch {
    const retorna = 
      {
          error: true,
          detalle: error
      }
      return retorna;

  }


}
