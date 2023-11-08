const db = require("../../models");
const Estados = db.estados;
const Base = db.base;
const Cliente = db.cliente;
const TipoFuncionPersonal = db.tipoFuncionPersonal;
const Persona = db.personas;
const Oficinas = db.consulta_oficinas;



/*********************************************************************************** */
/* Crea un Estado
  app.post("/api/mantenedor/v1/creaestado", mantendorController.createEstado)
*/
exports.createEstado = (req, res) => {
  /*  #swagger.tags = ['SAE - Mantenedores']
      #swagger.description = 'Crea un estado para sae' */

    if (!req.body["nombre"]) {
        res.status(400).send({
          message: "No puede estar vacío"
        });
        return;
    }

    const estado = {
        nombre: req.body.nombre
    };

    Estados.create(estado)
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({ message: err.message });
        })

}
/*********************************************************************************** */


/*********************************************************************************** */
/* Consulta los Estados
  app.get("/api/mantenedor/v1/estados", mantendorController.estados)
*/
exports.estados = async (req, res) => {
  /*  #swagger.tags = ['SAE - Mantenedores']
      #swagger.description = 'Devuelve todos los estados que puede tomar un reporte' */
    try {
      const sql = "SELECT * FROM sae.reporte_estados order by id";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const estados = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];

        if (estados) {
          for (const element of estados) {

            if (typeof element.id === 'number' && 
              typeof element.nombre === 'string' 
            ) {
              const detalle_salida = {
                //Campos
                id: Number(element.id),
                nombre: String(element.nombre)
                //**************************** */
              }
              salida.push(detalle_salida);
            }else {
              salida=undefined;
              break;
            }
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
/* Consulta todas las bases ( u oficinas dentro de Pelom)
  app.get("/api/mantenedor/v1/findallbases", mantendorController.findAllBases)
*/
  exports.findAllBases = async (req, res) => {
    /*  #swagger.tags = ['SAE - Mantenedores']
      #swagger.description = 'Devuelve todas las bases del sae' */
    await Base.findAll().then(data => {
        res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
  }
/*********************************************************************************** */


/*********************************************************************************** */
/* Consulta los clientes de Pelóm, ejemplo CGE
  app.get("/api/mantenedor/v1/findallclientes", mantendorController.findAllClientes)
*/
exports.findAllClientes = async (req, res) => {
  /*  #swagger.tags = ['SAE - Mantenedores']
      #swagger.description = 'Devuelve todos los clientes sae' */
  await Cliente.findAll().then(data => {
      res.send(data);
  }).catch(err => {
      res.status(500).send({ message: err.message });
  })
}
/*********************************************************************************** */


/*********************************************************************************** */
/* Consulta los tipos de funcion del personal
  app.get("/api/mantenedor/v1/findalltipofuncionpersonal", mantendorController.findAllTipofuncionPersonal)
*/
exports.findAllTipofuncionPersonal = async (req, res) => {
  /*  #swagger.tags = ['SAE - Mantenedores']
      #swagger.description = 'Devuelve todos los tipo de funcion del personal sae' */
  await TipoFuncionPersonal.findAll({where: {sistema: false}}).then(data => {
      res.send(data);
  }).catch(err => {
      res.status(500).send({ message: err.message });
  })
}
/*********************************************************************************** */


/*********************************************************************************** */
/* Consulta las oficinas
  app.get("/api/mantenedor/v1/oficinas", mantendorController.oficinas)
*/
exports.oficinas = async (req, res) => {
  /*  #swagger.tags = ['SAE - Mantenedores']
      #swagger.description = 'Devuelve todas las oficinas del sae' */
  try {
    const sql = "select p.id, p.nombre, p.id_zonal from _comun.paquete p join (SELECT distinct sc.paquete \
      FROM _comun.servicio_comuna sc inner join _comun.servicios s on sc.servicio = s.codigo \
      where s.activo and s.sae and sc.activo) as pa on p.id = pa.paquete order by nombre;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const base = await sequelize.query(sql, { type: QueryTypes.SELECT });

    //Chequear los campos que vienen de la consulta
    let salida = [];
    if (base) {
      for (const element of base) {
        if (typeof element.id === 'number' && 
        typeof element.id_zonal === 'number' && 
        typeof element.nombre === 'string') {
          const detalle_salida = {
            id: Number(element.id),
            nombre: String(element.nombre),
            id_zonal: Number(element.id_zonal)
          }
          salida.push(detalle_salida);
        }else {
          salida=undefined;
          break;
        }
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
