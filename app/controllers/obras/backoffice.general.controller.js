const db = require("../../models");
const TipoObra = db.tipoObra;
const Zonal = db.zonal;
const Delegacion = db.delegacion;
const TipoTrabajo = db.tipoTrabajo;
const EmpresaContratista = db.empresaContratista;
const CoordinadorContratista = db.coordinadorContratista;
const Comuna = db.comuna;
const EstadoObra = db.estadoObra;
const EstadoVisita = db.estadoVisita;
const Segmento = db.segmento;
const TipoOperacion = db.tipoOperacion;
const TipoActividad = db.tipoActividad;
const MaestroActividad = db.maestroActividad;

exports.findAllTipoObra = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los tipo de Obra' */
      await TipoObra.findAll().then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })
  }
  /*********************************************************************************** */

exports.findAllTipoOperacion = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los tipo de Operación' */
      await TipoOperacion.findAll().then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })
  }
  /*********************************************************************************** */

exports.findAllTipoActividad = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los tipo de Actividad' */
      await TipoActividad.findAll().then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })
  }
  /*********************************************************************************** */

exports.findAllMaestroActividad = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todas las actividades dentro del Maestro Actividades' */
    try {
      const sql = "SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, \
      uc_retiro, uc_traslado, ma.descripcion FROM obras.maestro_actividades ma \
      join obras.tipo_actividad ta on ma.id_tipo_actividad = ta.id";
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
    } catch (error) {
      res.status(500).send(error);
    }
  }
  /*********************************************************************************** */
/*********************************************************************************** */
/* Consulta MaestroActividad por ID
;
*/
exports.findOneMaestroActividad = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve una actividad dentro del Maestro Actividades buscando por ID' */
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
      const sql = "SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, \
      uc_retiro, uc_traslado, ma.descripcion FROM obras.maestro_actividades ma \
      join obras.tipo_actividad ta on ma.id_tipo_actividad = ta.id WHERE ma.id = :id";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const maestroActividad = await sequelize.query(sql,  { replacements: { id: id }, type: QueryTypes.SELECT });
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
/*********************************************************************************** */
/* Consulta MaestroActividad haciendo like al campo actividad
;
*/
exports.findAllMaestroActividadActividad = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todas las actividades que coincidan (select like) con el campo actividad dentro del Maestro Actividades' */
    try {
      
      const campos = [
        'actividad'
      ];
      for (const element of campos) {
        if (!req.query[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };
      let actividad = req.query.actividad.trim().split(" ");  //hace el trim y despues genera un array con los elementos
      let condicion = actividad.filter((item) => item).map((item) => 'ma.actividad ILIKE \'%'+item+'%\'').reduce((acc, valor) => acc + ' AND ' +valor);
      const sql = "SELECT ma.id, actividad, row_to_json(ta) as tipo_actividad, uc_instalacion, \
      uc_retiro, uc_traslado, ma.descripcion FROM obras.maestro_actividades ma \
      join obras.tipo_actividad ta on ma.id_tipo_actividad = ta.id WHERE "+condicion;
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const maestroActividad = await sequelize.query(sql,  { type: QueryTypes.SELECT });
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

exports.findAllZonal = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todas las zonales' */
    try {
      const data = await Zonal.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllDelegacion = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todas las delegaciones' */
    try {
      const data = await Delegacion.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


 exports.findAllTipoTrabajo = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los tipo de Trabajo' */
    try {
      const data = await TipoTrabajo.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllEmpresaContratista = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todas las empresas contratistas' */
    try {
      const data = await EmpresaContratista.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllCoordinadorContratista = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los coordinadores contratistas' */
    try {
      const data = await CoordinadorContratista.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllComuna = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todas las comunas' */
    try {
      const data = await Comuna.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */

exports.findAllEstadoObra = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los estados de Obra' */
    try {
      const data = await EstadoObra.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
/*********************************************************************************** */

exports.findAllEstadoVisita = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['Obras - General']
    #swagger.description = 'Devuelve todos los estados de Visita Terreno' */
  try {
    const data = await EstadoVisita.findAll();
    res.send(data);
  } catch (err) {
    res.status(500).send({ message: err.message });
  }
}
 /*********************************************************************************** */

exports.findAllSegmento = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['Obras - General']
      #swagger.description = 'Devuelve todos los segmentos' */
    try {
      const data = await Segmento.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */