const db = require("../models");
const Jornada = db.jornada;
const EstadoResultado = db.estadoResultado;
const DetalleEstadoResultado = db.detalleEstadoResultado;

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


  exports.creaEstadoResultado = async (req, res) => {
    try {
      const campos = [
        'id_usuario', 'zona', 'paquete', 'mes', 'fecha_inicio', 'fecha_final', 'nombre_doc', 'url_doc', 'fecha_creacion', 'fecha_modificacion', 'estado', 'detalle'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };

      console.log(req.body.detalle);
      const detalles = req.body.detalle;
      
      const estadoResultado = await EstadoResultado.create({
        id_usuario: req.body.id_usuario,
        zona: req.body.zona,
        paquete: req.body.paquete,
        mes: req.body.mes,
        fecha_inicio: req.body.fecha_inicio,
        fecha_final: req.body.fecha_final,
        nombre_doc: req.body.nombre_doc,
        url_doc: req.body.url_doc,
        fecha_creacion: req.body.fecha_creacion,
        fecha_modificacion: req.body.fecha_modificacion,
        estado: req.body.estado
      }).then(async data => {
            let hayError = false;
            let mensajeError = '';
            for (const detalle of detalles) {
              console.log(detalle);
              await DetalleEstadoResultado.create({
                id_estado_resultado: data.id,
                id_evento: detalle
              }).then(data => {
                //res.send(data);
              }).catch(err => {
                hayError = true;
                mensajeError = err.message;
                //res.status(500).send({ message: err.message });
                return;
              });
            }
            if (!hayError) {
              res.send(data);
            }else {
              res.status(500).send({ message: mensajeError });
            }
      }).catch(err => {
        res.status(500).send({ message: err.message });
      });
      
    } catch (error) {
      res.status(500).send(error);
    }
  }


  exports.findAllEstadosResultado = async (req, res) => {
    try {
      const sql = "SELECT er.id, id_usuario, u.username as nombre_usuario, zona, z.nombre as nombre_zona, paquete, p.nombre as nombre_paquete, mes, m.nombre as nombre_mes, fecha_inicio, fecha_final, nombre_doc, url_doc, fecha_creacion, fecha_modificacion, estado	FROM reporte.estado_resultado er INNER JOIN public.users u on er.id_usuario = u.id	INNER JOIN public.zonal z on z.id = er.zona	INNER JOIN public.paquete p on p.id = er.paquete	INNER JOIN public.meses m on m.id = er.mes;";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const estadosResultado = await sequelize.query(sql, { type: QueryTypes.SELECT });
      res.status(200).send(estadosResultado);
    } catch (error) {
      res.status(500).send(error);
    }
  }


  exports.creaDetalleEstadoResultado = async (req, res) => {
    
    try {
      const campos = [
        'id_estado_resultado', 'id_evento'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };

      const detalleEstadoResultado = await DetalleEstadoResultado.create({
        id_estado_resultado: req.body.id_estado_resultado,
        id_evento: req.body.id_evento
      }).then(data => {
        res.send(data);
      }).catch(err => {
        res.status(500).send({ message: err.message });
      });
      
    } catch (error) {
      res.status(500).send(error);
    }
  }