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

exports.findAllJornadas = async (req, res) => {
    try {
      const sql = "SELECT id, rut_maestro, rut_ayudante, codigo_turno, patente, base, km_inicial, km_final, fecha_hora_ini::text, \
      fecha_hora_fin::text, estado	FROM reporte.jornada ORDER BY id ASC;";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const jornadas = await sequelize.query(sql, { type: QueryTypes.SELECT });
      res.status(200).send(jornadas);
    } catch (error) {
      res.status(500).send(error);
    }
    
  }

  exports.findAllEventos = async (req, res) => {
    try {
      const sql = "SELECT e.id, e.numero_ot, et.descripcion as tipo_evento, e.rut_maestro, e.rut_ayudante, \
      (substr(t.inicio::text,1,5) || ' - ' || substr(t.fin::text,1,5)) as turno, b.nombre as base, \
      e.requerimiento, e.direccion, e.fecha_hora::text, e.estado FROM reporte.eventos e join \
      public.eventos_tipo et on e.tipo_evento = et.codigo join public.turnos t on e.codigo_turno = t.id join \
      public.base b on e.id_base = b.id order by e.id asc";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const eventos = await sequelize.query(sql, { type: QueryTypes.SELECT });
      res.status(200).send(eventos);
    } catch (error) {
      res.status(500).send(error);
    }
    
  }