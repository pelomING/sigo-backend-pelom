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
    const sql = "SELECT p.* FROM public.personas p JOIN public.tipo_funcion_personal \
    tfp on p.id_funcion = tfp.id WHERE not tfp.sistema ORDER BY p.id ASC ";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const personas = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(personas);
  } catch (error) {
    res.status(500).send(error);
  }
}

exports.createPersona = async (req, res) => {

  const campos = [
    'rut', 'apellido_1', 'nombres', 'base', 'cliente', 'id_funcion'
  ];
  for (let i = 0; i < campos.length; i++) {
    if (!req.body[campos[i]]) {
      res.status(400).send({
        message: "No puede estar nulo el campo " + campos[i]
      });
      return;
    }
  };

  const persona = {
      rut: req.body.rut,
      apellido_1: req.body.apellido_1,
      apellido_2: req.body.apellido_2,
      nombres: req.body.nombres,
      base: req.body.base,
      cliente: req.body.cliente,
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