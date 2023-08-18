const db = require("../models");
const Jornada = db.jornada;

exports.readAllJornada = async (req, res) => {
    await Jornada.findAll().then(data => {
        console.log(data);
        res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
}

exports.findJornadas = async (req, res) => {
    try {
      const sql = "SELECT * FROM reporte.jornada ORDER BY id ASC ";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const camionetas = await sequelize.query(sql, { type: QueryTypes.SELECT });
      res.status(200).send(camionetas);
    } catch (error) {
      res.status(500).send(error);
    }
    
  }