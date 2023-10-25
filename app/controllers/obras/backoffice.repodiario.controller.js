const db = require("../../models");
const EncabezadoReporteDiario = db.encabezadoReporteDiario;
const DetalleReporteDiarioActividad = db.detalleReporteDiarioActividad;

/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 REPORTE DIARIO                                  */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/


/*********************************************************************************** */
/* Consulta todos los reportes diarios
;
*/
exports.findAllEncabezadoReporteDiario = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los ancabezados de reporte diario' */
    try {
        const sql = "SELECT rd.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, \
        fecha_reporte::text, jefe_faena, sdi, rd.gestor_cliente, row_to_json(tt) as id_area, brigada_pesada, \
        observaciones, entregado_por_persona, fecha_entregado::text, revisado_por_persona, fecha_revisado::text, \
        sector, hora_salida_base::text, hora_llegada_terreno::text, hora_salida_terreno::text, hora_llegada_base::text \
        FROM obras.encabezado_reporte_diario rd join obras.tipo_trabajo tt on rd.id_area = tt.id join \
        obras.obras o on rd.id_obra = o.id";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const obras = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = [];
        if (obras) {
          for (const element of obras) {
    
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
                  hora_llegada_base: String(element.hora_llegada_base)
                  
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
/* Crea un reporte diario
;
*/
exports.createEncabezadoReporteDiario = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Crea un encabezado de reporte diario' */
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

        const encabezado_reporte_diario = {
            id_obra: req.body.id_obra,
            fecha_reporte: req.body.fecha_reporte,
            jefe_faena: req.body.jefe_faena,
            sdi: req.body.sdi,
            gestor_cliente: req.body.gestor_cliente,
            id_area: req.body.id_area,
            brigada_pesada: req.body.brigada_pesada,
            observaciones: req.body.observaciones,
            entregado_por_persona: req.body.entregado_por_persona,
            fecha_entregado: req.body.fecha_entregado,
            revisado_por_persona: req.body.revisado_por_persona,
            fecha_revisado: req.body.fecha_revisado,
            sector: req.body.sector,
            hora_salida_base: req.body.hora_salida_base,
            hora_llegada_terreno: req.body.hora_llegada_terreno,
            hora_salida_terreno: req.body.hora_salida_terreno,
            hora_llegada_base: req.body.hora_llegada_base
        }

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
      const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, row_to_json(ta) as tipo_actividad, cantidad, \
      id_encabezado_rep FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top \
      on dra.tipo_operacion = top.id join obras.tipo_actividad ta on dra.id_actividad = ta.id";
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
                cantidad: Number(element.cantidad),
                id_encabezado_rep: Number(element.id_encabezado_rep)
                
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
    const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, row_to_json(ta) as tipo_actividad, cantidad, \
    id_encabezado_rep FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top \
    on dra.tipo_operacion = top.id join obras.tipo_actividad ta on dra.id_actividad = ta.id WHERE dra.id = :id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const detalleReporteDiarioActividad = await sequelize.query(sql,  { replacements: { id: id }, type: QueryTypes.SELECT });
    let salida;
    if (detalleReporteDiarioActividad) {
      salida = [];
      for (const element of detalleReporteDiarioActividad) {

            const detalle_salida = {
              id: Number(element.id),
              

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
/* Consulta detalles de reportes diarios actividad por id_encabezado_rep
;
*/
exports.findDetalleReporteDiarioActividadPorEncabezado = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Reporte diario']
      #swagger.description = 'Devuelve todos los registros de detalle de reportes diarios para un encabezado' */
  try {
      
    const campos = [
      'encabezado_reporte'
    ];
    for (const element of campos) {
      if (!req.query[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
    const encabezado_reporte = req.query.encabezado_reporte;
    const sql = "SELECT dra.id, row_to_json(top) as tipo_operacion, row_to_json(ta) as tipo_actividad, cantidad, \
    id_encabezado_rep FROM obras.detalle_reporte_diario_actividad dra join obras.tipo_operacion top \
    on dra.tipo_operacion = top.id join obras.tipo_actividad ta on dra.id_actividad = ta.id WHERE id_encabezado_rep = :encabezado_reporte";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const detalleReporteDiarioActividad = await sequelize.query(sql,  { replacements: { encabezado_reporte: encabezado_reporte }, type: QueryTypes.SELECT });
    let salida;
    if (detalleReporteDiarioActividad) {
      salida = [];
      for (const element of detalleReporteDiarioActividad) {

            const detalle_salida = {
              id: Number(element.id),
              actividad: String(element.actividad),
              tipo_actividad: element.tipo_actividad,  //json {"id": 1, "descripcion": "Instalación"}
              uc_instalacion: Number(element.uc_instalacion),
              uc_retiro:  Number(element.uc_retiro),
              uc_traslado:  Number(element.uc_traslado),
              descripcion: String(element.descripcion)

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

