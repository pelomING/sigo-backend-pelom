const db = require("../models");
const Estados = db.estados;

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