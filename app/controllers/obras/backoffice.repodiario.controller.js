const db = require("../../models");
const EncabezadoReporteDiario = db.encabezadoReporteDiario;
const DetalleReporteDiarioActividad = db.detalleReporteDiarioActividad;
const DetalleRporteDiarioOtrasActividades = db.detalleReporteDiarioOtrasActividades; 
const tipoOperacion = db.tipoOperacion;
const maestroActividad = db.maestroActividad;
const encabezado_reporte_diario = db.encabezadoReporteDiario;
const JefesFaena = db.jefesFaena;
const TipoActividad = db.tipoActividad;

/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 REPORTE DIARIO                                  */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/


/*********************************************************************************** */
/* Consulta todos los encabezados reportes diarios
;
*/
exports.findAllEncabezadoReporteDiario = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los ancabezados de reporte diario' */
    try {
        const sql = "SELECT rd.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, fecha_reporte::text, \
        case when jf.id is not null then json_build_object('id', jf.id, 'nombre', jf.nombre) else null end as jefe_faena, sdi, \
        rd.gestor_cliente, row_to_json(tt) as id_area, brigada_pesada, observaciones, entregado_por_persona, fecha_entregado::text, \
        revisado_por_persona, fecha_revisado::text, sector, hora_salida_base::text, hora_llegada_terreno::text, \
        hora_salida_terreno::text, hora_llegada_base::text, alimentador, row_to_json(c) as comuna, num_documento, flexiapp \
        FROM obras.encabezado_reporte_diario rd join obras.tipo_trabajo tt on rd.id_area = tt.id join obras.obras o on \
        rd.id_obra = o.id join _comun.comunas c on rd.comuna = c.codigo	left join obras.jefes_faena jf on rd.jefe_faena = jf.id";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const encabezadoReporte = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = [];
        if (encabezadoReporte) {
          for (const element of encabezadoReporte) {
    
                const detalle_salida = {
                  id: Number(element.id),
                  id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
                  fecha_reporte: String(element.fecha_reporte),
                  jefe_faena: element.jefe_faena, //json {"id": id, "nombre": nombre jefe}
                  sdi: String(element.sdi),
                  gestor_cliente: String(element.gestor_cliente),
                  id_area: element.id_area, //json {"id": id, "descripcion": descripcion}
                  brigada_pesada: Boolean(element.brigada_pesada),
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
                  alimentador: String(req.body.alimentador),
                  comuna: String(req.body.comuna),
                  num_documento: String(req.body.num_documento),
                  flexiapp: String(req.body.flexiapp)
                  
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
/* Consulta todos los encabezados reportes diarios por parámetros
;
*/
exports.findAllEncabezadoReporteDiarioByParametros = async (req, res) => {
   /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los ancabezados de reporte diario por parametro: id de reporte, id_obra, fecha_reporte
      , debe indicarse al menos uno' */
  const parametros = {
    id: req.query.id,
    id_obra: req.query.id_obra,
    fecha_reporte: req.query.fecha_reporte
  }
  const keys = Object.keys(parametros)
  let sql_array = [];
  let param = {};
  for (element of keys) {
    if (parametros[element]){
      if (element === "id") {
        sql_array.push("rd.id = :" + element);
        param[element] = Number(parametros[element]);
      }
      if (element === "id_obra") {
        sql_array.push("o.id = :" + element);
        param[element] = Number(parametros[element]);
      }
      if (element === "fecha_reporte") {
        sql_array.push("rd.fecha_reporte = :" + element);
        param[element] = String(parametros[element]);
      }
    }
  }

  if (sql_array.length === 0) {
    res.status(500).send("Debe incluir algun parametro para consultar");
  }else {
    try {
      let b = sql_array.reduce((total, num) => total + " AND " + num);
      if (b){
        const sql = "SELECT rd.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, \
        fecha_reporte::text, jefe_faena, sdi, rd.gestor_cliente, row_to_json(tt) as id_area, brigada_pesada, \
        observaciones, entregado_por_persona, fecha_entregado::text, revisado_por_persona, fecha_revisado::text, \
        sector, hora_salida_base::text, hora_llegada_terreno::text, hora_salida_terreno::text, hora_llegada_base::text, \
        alimentador, row_to_json(c) as comuna, num_documento, flexiapp FROM obras.encabezado_reporte_diario rd join obras.tipo_trabajo \
        tt on rd.id_area = tt.id join obras.obras o on rd.id_obra = o.id join _comun.comunas c on rd.comuna = c.codigo WHERE "+b;
        console.log("sql: "+sql);
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const encabezadoReporte = await sequelize.query(sql, { replacements: param, type: QueryTypes.SELECT });
        let salida = [];
        if (encabezadoReporte) {
          for (const element of encabezadoReporte) {

            const detalle_salida = {
              id: Number(element.id),
              id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
              fecha_reporte: String(element.fecha_reporte),
              jefe_faena: String(element.jefe_faena),
              sdi: String(element.sdi),
              gestor_cliente: String(element.gestor_cliente),
              id_area: element.id_area, //json {"id": id, "descripcion": descripcion}
              brigada_pesada: Boolean(element.brigada_pesada),
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
              alimentador: String(req.body.alimentador),
              comuna: String(req.body.comuna),
              num_documento: String(req.body.num_documento),
              flexiapp: String(req.body.flexiapp)
            }
                salida.push(detalle_salida);
          };
        }
        if (salida===undefined){
          res.status(500).send("Error en la consulta (servidor backend)");
        }else{
          res.status(200).send(salida);
        }
      }else {
        res.status(500).send("Error en la consulta (servidor backend)");
      }
    }catch (error) {
      res.status(500).send(error);
    }
  }
}
/*********************************************************************************** */
/* Crea un reporte diario
;
*/
exports.createEncabezadoReporteDiario = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Crea un encabezado de reporte diario'
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos encabezado reporte diario',
            required: true,
            schema: {
                id_obra: 1,
                fecha_reporte: "2023-10-25",
                jefe_faena: 1,
                sdi: "sdi",
                gestor_cliente: "nombre gestor cliente",
                id_area: 1,
                brigada_pesada: false,
                observaciones: "observaciones",
                entregado_por_persona: "nombre persona",
                fecha_entregado: "2023-10-25",
                revisado_por_persona: "nombre persona que revisa",
                fecha_revisado: "2023-10-25",
                sector: "direccion sector",
                hora_salida_base: "2023-10-25 07:30:00",
                hora_llegada_terreno: "2023-10-25 08:00",
                hora_salida_terreno: "2023-10-25 18:30",
                hora_llegada_base: "2023-10-25 19:30",
                alimentador: "alimentador",
                comuna: "10305",
                num_documento: "10001000600",
                flexiapp: ["CGE-123343-55", "CGE-123343-56"],
                det_actividad: [
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 1,
                      "cantidad": 1
                    },
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 2,
                      "cantidad": 3
                    }
                ],
                det_otros: [
                      {
                        "glosa": "descripcion de la tarea 1", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1
                      },
                      {
                        "glosa": "descripcion de la tarea 2", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1
                      }
                ]
            }
        } */
  try{
      let salir = false;
      const campos = [
        'id_obra', 'fecha_reporte', 'jefe_faena', 'sdi', 'gestor_cliente', 'id_area', 
        'observaciones', 'entregado_por_persona', 'fecha_entregado', 
        'revisado_por_persona', 'fecha_revisado', 'sector', 'hora_salida_base', 
        'hora_llegada_terreno', 'hora_salida_terreno', 'hora_llegada_base'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };

      //Verifica que la fecha de reporte no este asignada a una obra
      await EncabezadoReporteDiario.findAll({where: {id_obra: req.body.id_obra, fecha_reporte: req.body.fecha_reporte}}).then(data => {
          //el rut ya existe
          if (data.length > 0) {
            salir = true;
            res.status(403).send({ message: 'El Codigo de Obra ya se encuentra ingresado en la base' });
          }
        }).catch(err => {
            salir = true;
            res.status(500).send({ message: err.message });
        })
      
        if (salir) {
          return;
        }
        //const flexiapp = req.body.flexiapp;
        let flexiapp = "{";
        for (const b of req.body.flexiapp){
          if (flexiapp.length==1) {
            flexiapp = flexiapp + b
          }else {
            flexiapp = flexiapp + ", " + b
          }
        }
        flexiapp = flexiapp + "}"
        // procesa detalle de actividad
        for (const element of req.body.det_actividad) {
          if (!element.clase || !element.actividad || !element.cantidad) {
            res.status(400).send({
              message: "No puede estar nulo el campo " + element
            });
            return;
          }
        };

        // Busca el ID de encabezado disponible
        const sql = "select nextval('obras.encabezado_reporte_diario_id_seq'::regclass) as valor";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let encabezado_reporte_diario_id = 0;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          console.log('data', data);
          encabezado_reporte_diario_id = data[0].valor;
        }).catch(err => {
          res.status(500).send({ message: err.message });
        })
        console.log('id', encabezado_reporte_diario_id);

        const encabezado_reporte_diario = {
            id: encabezado_reporte_diario_id,
            id_obra: Number(req.body.id_obra),
            fecha_reporte: String(req.body.fecha_reporte),
            jefe_faena: Number(req.body.jefe_faena),
            sdi: String(req.body.sdi),
            gestor_cliente: String(req.body.gestor_cliente),
            id_area: Number(req.body.id_area),
            brigada_pesada: Boolean(req.body.brigada_pesada),
            observaciones: String(req.body.observaciones),
            entregado_por_persona: String(req.body.entregado_por_persona),
            fecha_entregado: String(req.body.fecha_entregado),
            revisado_por_persona: String(req.body.revisado_por_persona),
            fecha_revisado: String(req.body.fecha_revisado),
            sector: String(req.body.sector),
            hora_salida_base: String(req.body.hora_salida_base),
            hora_llegada_terreno: String(req.body.hora_llegada_terreno),
            hora_salida_terreno: String(req.body.hora_salida_terreno),
            hora_llegada_base: String(req.body.hora_llegada_base),
            alimentador: String(req.body.alimentador),
            comuna: String(req.body.comuna),
            num_documento: String(req.body.num_documento),
            flexiapp: String(flexiapp)
        }
        /*
        sql_insert_encabezado = `INSERT INTO obras.encabezado_reporte_diario(id, id_obra, fecha_reporte, sdi, gestor_cliente, \
          id_area, brigada_pesada, observaciones, entregado_por_persona, fecha_entregado, revisado_por_persona, fecha_revisado, \
          sector, hora_salida_base, hora_llegada_terreno, hora_salida_terreno, hora_llegada_base, alimentador, comuna, \
          num_documento, jefe_faena, flexiapp) VALUES (${encabezado_reporte_diario.id}, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);`
*/
        await EncabezadoReporteDiario.create(encabezado_reporte_diario)
          .then(data => {
              res.send(data);
          }).catch(err => {
              res.status(500).send({ message: err.message });
          })
  }catch (error) {
    res.status(500).send(error);
  }

}
/*********************************************************************************** */
/* Crea un reporte diario Versión 2
;
*/
exports.createEncabezadoReporteDiario_V2 = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Crea un encabezado de reporte diario'
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos encabezado reporte diario',
            required: true,
            schema: {
                id_obra: 1,
                fecha_reporte: "2023-10-25",
                jefe_faena: 1,
                sdi: "sdi",
                gestor_cliente: "nombre gestor cliente",
                id_area: 1,
                brigada_pesada: false,
                observaciones: "observaciones",
                entregado_por_persona: "nombre persona",
                fecha_entregado: "2023-10-25",
                revisado_por_persona: "nombre persona que revisa",
                fecha_revisado: "2023-10-25",
                sector: "direccion sector",
                hora_salida_base: "2023-10-25 07:30:00",
                hora_llegada_terreno: "2023-10-25 08:00",
                hora_salida_terreno: "2023-10-25 18:30",
                hora_llegada_base: "2023-10-25 19:30",
                alimentador: "alimentador",
                comuna: "10305",
                num_documento: "10001000600",
                flexiapp: ["CGE-123343-55", "CGE-123343-56"],
                det_actividad: [
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 1,
                      "cantidad": 1
                    },
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 2,
                      "cantidad": 3
                    }
                ],
                det_otros: [
                      {
                        "glosa": "descripcion de la tarea 1", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1
                      },
                      {
                        "glosa": "descripcion de la tarea 2", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1
                      }
                ]
            }
        } */
  try{
      let salir = false;
      const campos = [
        'id_obra', 'fecha_reporte', 'jefe_faena', 'sdi', 'gestor_cliente', 'id_area', 
        'observaciones', 'entregado_por_persona', 'fecha_entregado', 
        'revisado_por_persona', 'fecha_revisado', 'sector', 'hora_salida_base', 
        'hora_llegada_terreno', 'hora_salida_terreno', 'hora_llegada_base'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };

      //Verifica que la fecha de reporte no este asignada a una obra
      await EncabezadoReporteDiario.findAll({where: {id_obra: req.body.id_obra, fecha_reporte: req.body.fecha_reporte}}).then(data => {
          //el rut ya existe
          if (data.length > 0) {
            salir = true;
            res.status(403).send({ message: 'El Codigo de Obra ya se encuentra ingresado en la base' });
          }
        }).catch(err => {
            salir = true;
            res.status(500).send({ message: err.message });
        })
      
        if (salir) {
          return;
        }
        //const flexiapp = req.body.flexiapp;
        let flexiapp = "{";
        for (const b of req.body.flexiapp){
          if (flexiapp.length==1) {
            flexiapp = flexiapp + b
          }else {
            flexiapp = flexiapp + ", " + b
          }
        }
        flexiapp = flexiapp + "}"
        // procesa detalle de actividad
        for (const element of req.body.det_actividad) {
          if (!element.clase || !element.actividad || !element.cantidad) {
            res.status(400).send({
              message: "No puede estar nulo el campo " + element
            });
            return;
          }
        };

        // Busca el ID de encabezado disponible
        const sql = "select nextval('obras.encabezado_reporte_diario_id_seq'::regclass) as valor";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let encabezado_reporte_diario_id = 0;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          console.log('data', data);
          encabezado_reporte_diario_id = data[0].valor;
        }).catch(err => {
          res.status(500).send({ message: err.message });
        })
        console.log('id', encabezado_reporte_diario_id);

        const encabezado_reporte_diario = {
            id: encabezado_reporte_diario_id,
            id_obra: Number(req.body.id_obra),
            fecha_reporte: String(req.body.fecha_reporte),
            jefe_faena: Number(req.body.jefe_faena),
            sdi: String(req.body.sdi),
            gestor_cliente: String(req.body.gestor_cliente),
            id_area: Number(req.body.id_area),
            brigada_pesada: Boolean(req.body.brigada_pesada),
            observaciones: String(req.body.observaciones),
            entregado_por_persona: String(req.body.entregado_por_persona),
            fecha_entregado: String(req.body.fecha_entregado),
            revisado_por_persona: String(req.body.revisado_por_persona),
            fecha_revisado: String(req.body.fecha_revisado),
            sector: String(req.body.sector),
            hora_salida_base: String(req.body.hora_salida_base),
            hora_llegada_terreno: String(req.body.hora_llegada_terreno),
            hora_salida_terreno: String(req.body.hora_salida_terreno),
            hora_llegada_base: String(req.body.hora_llegada_base),
            alimentador: String(req.body.alimentador),
            comuna: String(req.body.comuna),
            num_documento: String(req.body.num_documento),
            flexiapp: String(flexiapp)
        }

        const result = await sequelize.transaction(async () => {
          // both of these queries will run in the transaction
          const encabezadoReporteDiario = await EncabezadoReporteDiario.create(encabezado_reporte_diario);
      
          for (const element of req.body.det_actividad) {
            const det_actividad = {
              id_encabezado_rep: Number(encabezado_reporte_diario_id),
              tipo_operacion: Number(element.clase),
              id_actividad: Number(element.actividad),
              cantidad: Number(element.cantidad)
            }
            await DetalleReporteDiarioActividad.create(det_actividad);
          }

          for (const element of req.body.det_otros) {
            const det_otros = {
              id_encabezado_rep: Number(encabezado_reporte_diario_id),
              glosa: String(element.glosa),
              uc_unitaria: Number(element.uc_unitaria),
              total_uc: Number(element.uc_total),
              cantidad: Number(element.cantidad)
            }
            await DetalleRporteDiarioOtrasActividades.create(det_otros);
          }
          res.status(200).send(encabezadoReporteDiario);
        });

        

  }catch (error) {
    res.status(500).send(error);
  }

}
/*********************************************************************************** */
/* Actualiza un reporte diario
;
*/
exports.updateEncabezadoReporteDiario = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Actualiza un encabezado de reporte diario por ID' */
  try{
    const id = req.params.id;
    await EncabezadoReporteDiario.update(req.body, {
      where: { id: id }
    }).then(data => {
      if (data[0] === 1) {
        res.send({ message: "Obra actualizada" });
      } else {
        res.send({ message: `No existe una obra con el id ${id}` });
      }
    }).catch(err => {
      res.status(500).send({ message: err.message });
    })
  }catch (error) {
    res.status(500).send(error);
  }
}
/*********************************************************************************** */
/* Borra un reporte diario
;
*/
exports.deleteEncabezadoReporteDiario = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Borra un encabezado de reporte diario por ID' */
  try{
    const id = req.params.id;
    EncabezadoReporteDiario.destroy({
        where: { id: id }
      }).then(data => {
        console.log('data', data);
        if (data > 0) {
          res.send({ message: `Reporte eliminado`});
        } else {
          res.send({ message: `No existe el reporte con id ${id}` });
        }
      }).catch(err => {
        res.status(500).send({ message: err.message });
      })
  }catch (error) {
    res.status(500).send(error);
  }

}
/*********************************************************************************** */
/* Consulta detalles de reportes diarios actividad
;
*/
exports.findAllDetalleReporteDiarioActividad = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los registros de detalle de reportes diarios' */
    try {
      const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, ma.tipo_actividad, row_to_json(ma) as actividad, cantidad, \
      json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) as encabezado_reporte, \
      case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 then uc_traslado else 0 end as unitario, \
      case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 then uc_traslado else 0 end * \
      cantidad as total FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top on \
      dra.tipo_operacion = top.id join (SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, uc_retiro, \
      uc_traslado, ma.descripcion, row_to_json(mu) as unidad FROM obras.maestro_actividades ma join obras.tipo_actividad \
      ta on ma.id_tipo_actividad = ta.id join obras.maestro_unidades mu on ma.id_unidad = mu.id) ma on dra.id_actividad = \
      ma.id join obras.encabezado_reporte_diario erd on dra.id_encabezado_rep = erd.id";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const detalleReporteDiarioActividad = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida;
      if (detalleReporteDiarioActividad) {
        salida = [];
        for (const element of detalleReporteDiarioActividad) {
  
              const detalle_salida = {
                id: Number(element.id),
                tipo_operacion: element.tipo_operacion,
                tipo_actividad: element.tipo_actividad,
                actividad: element.actividad,
                cantidad: Number(element.cantidad),
                id_encabezado_rep: element.encabezado_reporte,
                unitario: Number(element.unitario),
                total: Number(element.total),                
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
/* Consulta detalles de reportes diarios actividad por ID
;
*/
exports.findOneDetalleReporteDiarioActividad = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve un registro de detalle de reportes diarios por ID' */
  try {
      
    const campos = [
      'id'
    ];
    for (const element of campos) {
      if (!req.query[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
    const id = req.query.id;
    /*
    const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, row_to_json(ma) as tipo_actividad, cantidad, \
    json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) as encabezado_reporte \
    FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top on dra.tipo_operacion = top.id \
    join obras.maestro_actividades ma on dra.id_actividad = ma.id join obras.encabezado_reporte_diario erd \
    on dra.id_encabezado_rep = erd.id WHERE dra.id = :id";*/

    const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, ma.tipo_actividad, row_to_json(ma) as actividad, cantidad, \
    json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) as encabezado_reporte, \
    case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 then uc_traslado else 0 end as unitario, \
    case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 then uc_traslado else 0 end * \
    cantidad as total FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top on \
    dra.tipo_operacion = top.id join (SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, uc_retiro, \
    uc_traslado, ma.descripcion, row_to_json(mu) as unidad FROM obras.maestro_actividades ma join obras.tipo_actividad \
    ta on ma.id_tipo_actividad = ta.id join obras.maestro_unidades mu on ma.id_unidad = mu.id) ma on dra.id_actividad = \
    ma.id join obras.encabezado_reporte_diario erd on dra.id_encabezado_rep = erd.id WHERE dra.id = :id";

    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const detalleReporteDiarioActividad = await sequelize.query(sql,  { replacements: { id: id }, type: QueryTypes.SELECT });
    let salida;
    if (detalleReporteDiarioActividad) {
      salida = [];
      for (const element of detalleReporteDiarioActividad) {

            const detalle_salida = {
              id: Number(element.id),
              tipo_operacion: element.tipo_operacion,
              tipo_actividad: element.tipo_actividad,
              actividad: element.actividad,
              cantidad: Number(element.cantidad),
              id_encabezado_rep: element.encabezado_reporte,
              unitario: Number(element.unitario),
              total: Number(element.total),
            }
            salida.push(detalle_salida);
      };
    }
    if (salida===undefined){
      res.status(500).send("Error en la consulta (servidor backend)");
    }else{
      res.status(200).send(salida);
    }
  } catch (err) {
    res.status(500).send({ message: err.message });
  }
}
/*********************************************************************************** */
/* Consulta detalles de reportes diarios actividad por obra
;
*/
/*********************************************************************************** */
exports.findDetalleReporteDiarioActividadPorParametros = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve un registro de detalle de reportes diarios por parámetros: id_obra, id_encabezado_rep,
      debe tener al menos un parámetro' */
  const parametros = {
    id_obra: req.query.id_obra,
    id_encabezado_rep: req.query.id_encabezado_rep
  }
  const keys = Object.keys(parametros)
  let sql_array = [];
  let param = {};
  for (element of keys) {
    if (parametros[element]){

      if (element === "id_obra") {
        sql_array.push("erd.id_obra = :" + element);
        param[element] = Number(parametros[element]);
      }
      if (element === "id_encabezado_rep") {
        sql_array.push("dra.id_encabezado_rep = :" + element);
        param[element] = Number(parametros[element]);
      }
    }
  }

  if (sql_array.length === 0) {
    res.status(500).send("Debe incluir algun parametro para consultar");
  }else {
    try {
      let b = sql_array.reduce((total, num) => total + " AND " + num);
      if (b){
        /*
        const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, row_to_json(ma) as tipo_actividad, cantidad, \
        json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) as encabezado_reporte \
        FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top on dra.tipo_operacion = top.id \
        join obras.maestro_actividades ma on dra.id_actividad = ma.id join obras.encabezado_reporte_diario erd \
        on dra.id_encabezado_rep = erd.id WHERE "+b;*/

        const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, ma.tipo_actividad, row_to_json(ma) as actividad, cantidad, \
        json_build_object('id', erd.id, 'id_obra', erd.id_obra, 'fecha_reporte', erd.fecha_reporte) as encabezado_reporte, \
        case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 then uc_traslado else 0 end as unitario, \
        case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 then uc_traslado else 0 end * \
        cantidad as total FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top on \
        dra.tipo_operacion = top.id join (SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, uc_retiro, \
        uc_traslado, ma.descripcion, row_to_json(mu) as unidad FROM obras.maestro_actividades ma join obras.tipo_actividad \
        ta on ma.id_tipo_actividad = ta.id join obras.maestro_unidades mu on ma.id_unidad = mu.id) ma on dra.id_actividad = \
        ma.id join obras.encabezado_reporte_diario erd on dra.id_encabezado_rep = erd.id WHERE "+b;

        console.log("sql: "+sql);
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const detalleReporteDiarioActividad = await sequelize.query(sql, { replacements: param, type: QueryTypes.SELECT });
        let salida = [];
        if (detalleReporteDiarioActividad) {
          for (const element of detalleReporteDiarioActividad) {

            const detalle_salida = {
              id: Number(element.id),
              tipo_operacion: element.tipo_operacion,
              tipo_actividad: element.tipo_actividad,
              actividad: element.actividad,
              cantidad: Number(element.cantidad),
              id_encabezado_rep: element.encabezado_reporte,
              unitario: Number(element.unitario),
              total: Number(element.total),
            }
                salida.push(detalle_salida);
          };
        }
        if (salida===undefined){
          res.status(500).send("Error en la consulta (servidor backend)");
        }else{
          res.status(200).send(salida);
        }
      }else {
        res.status(500).send("Error en la consulta (servidor backend)");
      }
    }catch (error) {
      res.status(500).send(error);
    }
  }
}
/* Crea un detalle de reporte diario
;
*/
exports.createOneDetalleReporteDiarioActividad = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Crea un detalle de reporte diario' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos para el detalle de reporte diario',
            required: true,
            schema: {
                tipo_operacion: 1,
                id_actividad: 537,
                cantidad: 2.3,
                id_encabezado_rep: 3
            }
        }*/
  try {
    const campos = [
      'tipo_operacion',
      'id_actividad',
      'cantidad',
      'id_encabezado_rep'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };

    // Consultar si existe la actividad en el maestro de actividades
    const actividadExists = await maestroActividad.findOne({
      where: {
        id: req.body.id_actividad
      }
    });

    // Consultar si existe el tipo de opracion en la tabla tipo_operacion
    const tipoOperacionExists = await tipoOperacion.findOne({
      where: {
        id: req.body.tipo_operacion
      }
    });

    // Consultar si existe el encabezado de reporte diario en la tabla encabezado_reporte_diario
    const encabezado_reporte_diarioExists = await encabezado_reporte_diario.findOne({
      where: {
        id: req.body.id_encabezado_rep
      }
    });
    if (!actividadExists) {
      // La actividad no existe en la tabla maestro_actividad
      res.status(400).send({message: "No existe la actividad con Id " + req.body.id_actividad});
      return;
    }

    if (!tipoOperacionExists) {
      // El tipo de operación no existe en la tabla tipo_operacion
      res.status(400).send({message: "No el tipo de operación con Id " + req.body.tipo_operacion});
      return;
    }

    if (!encabezado_reporte_diarioExists) {
      // El encabezado de reporte diario no existe
      res.status(400).send({message: "No existe un encabezado reporte diario con Id " + req.body.id_encabezado_rep});
      return;
    }

    const detalleReporteDiarioActividad = {
      tipo_operacion: Number(req.body.tipo_operacion),
      id_actividad: Number(req.body.id_actividad),
      cantidad: Number(req.body.cantidad),
      id_encabezado_rep: Number(req.body.id_encabezado_rep)
    }
    await DetalleReporteDiarioActividad.create(detalleReporteDiarioActividad)
          .then(data => {
              res.send(data);
          }).catch(err => {
              res.status(500).send({ message: err.message });
          })
  }catch (error) {
    res.status(500).send(error);
  }

}

/*********************************************************************************** */
/* Obtiene todos los jefes de faena
*/
exports.findAllJefesFaena = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los jefes de faena' */
  try {
    await JefesFaena.findAll().then(data => {
      res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
  }catch (error) {
    res.status(500).send(error);
  }
}

/*********************************************************************************** */
/* Obtiene todos los tipo de operación
*/
exports.findAllTipoOperacion = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los tipo de operación' */
  try {
    await tipoOperacion.findAll().then(data => {
      res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
  }catch (error) {
    res.status(500).send(error);
  }
}

/*********************************************************************************** */
/* Obtiene todos los tipo de actividad
*/
exports.findAllTipoActividad = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los tipo de actividad' */
  try {
    await TipoActividad.findAll().then(data => {
      res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
  }catch (error) {
    res.status(500).send(error);
  }
}

/*********************************************************************************** */
/* Obtiene todos las actividades del maestro actividades
*/
exports.findAllMaestroActividad = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
    #swagger.description = 'Devuelve todas las actividades dentro del Maestro Actividades' */
  try {
    //metodo GET
    const id_tipo_actividad = req.query.id_tipo_actividad;
    let where = '';
    if (id_tipo_actividad) {
      where = `WHERE ta.id = ${id_tipo_actividad}`
    }

    const sql = "SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, uc_retiro, \
    uc_traslado, ma.descripcion, row_to_json(mu) as unidad FROM obras.maestro_actividades ma join \
    obras.tipo_actividad ta on ma.id_tipo_actividad = ta.id	join obras.maestro_unidades mu on ma.id_unidad = mu.id " + where;
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const maestroActividad = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida;
    if (maestroActividad) {
      salida = [];
      for (const element of maestroActividad) {

            const detalle_salida = {
              id: Number(element.id),
              actividad: String(element.actividad),
              tipo_actividad: element.tipo_actividad,  //json {"id": 1, "descripcion": "Instalación"}
              uc_instalacion: Number(element.uc_instalacion),
              uc_retiro:  Number(element.uc_retiro),
              uc_traslado:  Number(element.uc_traslado),
              descripcion: String(element.descripcion),
              unidad: element.unidad
              
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