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
  await TipoFuncionPersonal.findAll({where: {sistema: false}}).then(data => {
      res.send(data);
  }).catch(err => {
      res.status(500).send({ message: err.message });
  })
}
/*********************************************************************************** */


/*********************************************************************************** */
/* Consulta las personas
  app.get("/api/mantenedor/v1/findallpersonas", mantendorController.findAllPersonas)
*/
exports.findAllPersonas = async (req, res) => {
  try {
    const sql = "SELECT p.id, p.rut, p.apellido_1, p.apellido_2, p.nombres, p.base, p.cliente, \
    p.id_funcion, p.activo, c.nombre as nom_cliente, pq.nombre as oficina, tfp.nombre as nom_funcion \
    FROM _auth.personas p JOIN _comun.tipo_funcion_personal tfp on p.id_funcion = tfp.id JOIN _comun.cliente \
    c on p.cliente = c.id JOIN _comun.base b on p.base = b.id JOIN _comun.paquete pq on pq.id = b.id_paquete WHERE not tfp.sistema ORDER BY p.id ASC;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const personas = await sequelize.query(sql, { type: QueryTypes.SELECT });

    //Chequear los campos que vienen de la consulta
    let salida = [];
    if (personas) {
      for (const element of personas) {
        if (typeof element.id === 'number' && 
              typeof element.rut === 'string' && 
              typeof element.apellido_1 === 'string' &&
              (typeof element.apellido_2 === 'string' || typeof element.apellido_2 === 'object') && //acepta nulos
              typeof element.nombres === 'string' &&
              typeof element.base === 'number' &&
              typeof element.cliente === 'number' &&
              typeof element.id_funcion === 'number' &&
              typeof element.activo === 'boolean' &&
              typeof element.nom_cliente === 'string' &&
              typeof element.oficina === 'string' &&
              typeof element.nom_funcion === 'string'
        ) {
                    const detalle_salida = {
                      id: Number(element.id),
                      rut: String(element.rut),
                      apellido_1: String(element.apellido_1),
                      apellido_2: String(element.apellido_2),
                      nombres: String(element.nombres),
                      base: Number(element.base),
                      cliente: Number(element.cliente),
                      id_funcion: Number(element.id_funcion),
                      activo: Boolean(element.activo),
                      nom_cliente: String(element.nom_cliente),
                      oficina: String(element.oficina),
                      nom_funcion: String(element.nom_funcion),
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
/* Consulta las oficinas
  app.get("/api/mantenedor/v1/oficinas", mantendorController.oficinas)
*/
exports.oficinas = async (req, res) => {
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


/*********************************************************************************** */
/* Crea una persona
  app.post("/api/mantenedor/v1/creapersona", mantendorController.createPersona);
*/
exports.createPersona = async (req, res) => {

  let salir = false;
  const campos = [
    'rut', 'apellido_1', 'nombres', 'base', 'id_funcion'
  ];
  for (const element of campos) {
    if (!req.body[element]) {
      res.status(400).send({
        message: "No puede estar nulo el campo " + element
      });
      return;
    }
  };

  //Verifica que el rut no se encuentre
  await Persona.findAll({where: {rut: req.body.rut}}).then(data => {
    //el rut ya existe
    if (data.length > 0) {
      salir = true;
      res.status(403).send({ message: 'El Rut ya se encuentra ingresado en la base' });
    }
  }).catch(err => {
      salir = true;
      res.status(500).send({ message: err.message });
  })

  if (salir) {
    return;
  }

  const persona = {
      rut: req.body.rut,
      apellido_1: req.body.apellido_1,
      apellido_2: req.body.apellido_2,
      nombres: req.body.nombres,
      base: req.body.base,
      cliente: req.body.cliente?req.body.cliente:1,
      id_funcion: req.body.id_funcion,
      activo: true
  };

  await Persona.create(persona)
      .then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })

}
/*********************************************************************************** */