const db = require("../models");
const Estados = db.estados;
const Base = db.base;
const Cliente = db.cliente;
const TipoFuncionPersonal = db.tipoFuncionPersonal;
const Persona = db.personas;

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

exports.estados = async (req, res) => {
    try {
      const sql = "SELECT * FROM reporte.estados order by id";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const estados = await sequelize.query(sql, { type: QueryTypes.SELECT });
      res.status(200).send(estados);
    } catch (error) {
      res.status(500).send(error);
    }
  }

  exports.findAllBases = async (req, res) => {
    await Base.findAll().then(data => {
        res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
}


exports.findAllClientes = async (req, res) => {
  await Cliente.findAll().then(data => {
      res.send(data);
  }).catch(err => {
      res.status(500).send({ message: err.message });
  })
}

exports.findAllTipofuncionPersonal = async (req, res) => {
  await TipoFuncionPersonal.findAll({where: {sistema: false}}).then(data => {
      res.send(data);
  }).catch(err => {
      res.status(500).send({ message: err.message });
  })
}

exports.findAllPersonas = async (req, res) => {
  try {
    const sql = "SELECT p.id, p.rut, p.apellido_1, p.apellido_2, p.nombres, p.base, p.cliente, \
    p.id_funcion, p.activo, c.nombre as nom_cliente, pq.nombre as oficina, tfp.nombre as nom_funcion \
    FROM public.personas p JOIN public.tipo_funcion_personal tfp on p.id_funcion = tfp.id JOIN public.cliente \
    c on p.cliente = c.id JOIN public.paquete pq on p.base = pq.id WHERE not tfp.sistema ORDER BY p.id ASC;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const personas = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(personas);
  } catch (error) {
    res.status(500).send(error);
  }
}

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