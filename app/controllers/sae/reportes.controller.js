const db = require("../../models");
const Jornada = db.jornada;
const EstadoResultado = db.estadoResultado;
const DetalleEstadoResultado = db.detalleEstadoResultado;

exports.readAllJornada = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve todas las jornadas' */
    await Jornada.findAll().then(data => {
        res.send(data);
    }).catch(err => {
        res.status(500).send({ message: err.message });
    })
}
/*********************************************************************************** */


/*********************************************************************************** */
/* Devuelve todos las jornadas
  app.get("/api/reportes/v1/alljornada", reportesController.findAllJornadas)
*/
exports.findAllJornadas = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve todas las jornadas' */
    try {
      const sql = "SELECT rj.id, rut_maestro, rut_ayudante, (substr(t.inicio::text,1,5) || ' - ' || substr(t.fin::text,1,5)) as turno, \
      patente, id_paquete as paquete, km_inicial, km_final, fecha_hora_ini::text, fecha_hora_fin::text, estado,  null as brigada, \
      null as tipo_turno, case when rj.coordenadas is not null then rj.coordenadas->>'latitude' else null end as latitude, case when \
      rj.coordenadas is not null then rj.coordenadas->>'longitude' else null end as longitude FROM sae.reporte_jornada rj \
      JOIN _comun.turnos t on rj.codigo_turno = t.id WHERE brigada is null UNION SELECT rj.id, rut_maestro, rut_ayudante, \
      br.turno as turno, patente, id_paquete as paquete, km_inicial, km_final, fecha_hora_ini::text, fecha_hora_fin::text, \
      estado,  br.brigada as brigada, case when tipo_turno is not null then (select nombre from _comun.tipo_turno where \
        id = rj.tipo_turno) else null end as tipo_turno, case when rj.coordenadas is not null then rj.coordenadas->>'latitude' \
        else null end as latitude, case when rj.coordenadas is not null then rj.coordenadas->>'longitude' else null end as \
        longitude FROM sae.reporte_jornada rj join (SELECT br.id, b.nombre as base, p.nombre as paquete, (substr(t.inicio::text,1,5) \
        || ' - ' || substr(t.fin::text,1,5)) as turno, (substr(t.inicio::text,1,5) || '-' || substr(t.fin::text,1,5)) \
        || ' (' || b.nombre || ')' as brigada FROM _comun.brigadas  br join _comun.base b on br.id_base = b.id join \
        _comun.paquete p on b.id_paquete = p.id join _comun.turnos t on br.id_turno = t.id) as br on rj.brigada = br.id \
        WHERE rj.brigada is not null ORDER BY id DESC;";
        console.log(sql);
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const jornadas = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (jornadas) {
        console.log('jornadas ok');
        for (const element of jornadas) {
          console.log('elemento ok', element.id);
          if (
            typeof element.id === 'number' && 
            typeof element.rut_maestro === 'string' &&
            typeof element.rut_ayudante === 'string' &&
            typeof element.turno === 'string' &&
            typeof element.patente === 'string' &&
            typeof element.paquete === 'number' &&
            (typeof element.km_inicial === 'number' || typeof element.km_inicial === 'string') &&
            (typeof element.km_final === 'number' || typeof element.km_final === 'string') &&
            (typeof element.fecha_hora_ini === 'string' || typeof element.fecha_hora_ini === 'object') &&
            (typeof element.fecha_hora_fin === 'string' || typeof element.fecha_hora_fin === 'object') &&
            typeof element.estado === 'number' &&
            (typeof element.brigada === 'string' || typeof element.brigada === 'object') &&
            (typeof element.tipo_turno === 'string' || typeof element.tipo_turno === 'object') &&
            (typeof element.latitude === 'string' || typeof element.latitude === 'object') &&
            (typeof element.longitude === 'string' || typeof element.longitude === 'object'))  {
              console.log('if ok', element.id);

              const detalle_salida = {

                id: Number(element.id),
                rut_maestro: String(element.rut_maestro),
                rut_ayudante: String(element.rut_ayudante),
                turno: String(element.turno),
                patente: String(element.patente),
                paquete: Number(element.paquete),
                km_inicial: String(element.km_inicial),
                km_final: String(element.km_final),
                fecha_hora_ini: String(element.fecha_hora_ini),
                fecha_hora_fin: String(element.fecha_hora_fin),
                estado: Number(element.estado),
                brigada: String(element.brigada),
                tipo_turno: String(element.tipo_turno),
                coordenadas: {
                  latitude: String(element.latitude),
                  longitude: String(element.longitude)
                }

              }
              salida.push(detalle_salida);

          }else {
              console.log('else ok', element.id);
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
/* Devuelve detalle de eventos
  app.get("/api/reportes/v1/alleventos", reportesController.findAllEventos)
*/
  exports.findAllEventos = async (req, res) => {
    //metodo GET
    /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve todos los eventos' */
    try {
      const sql = "SELECT e.id, e.numero_ot, et.descripcion as tipo_evento, e.rut_maestro, e.rut_ayudante, (substr(t.inicio::text,1,5) \
      || ' - ' || substr(t.fin::text,1,5)) as turno, p.nombre as paquete, e.requerimiento, e.direccion, e.fecha_hora::text, \
      e.estado, null as hora_inicio, null as hora_termino, null as brigada, null as tipo_turno, null as comuna, case when \
      e.coordenadas is not null  then e.coordenadas->>'latitude' else null end as latitude, case when e.coordenadas is not null \
      then e.coordenadas->>'longitude' else null end as longitude FROM sae.reporte_eventos e join _comun.eventos_tipo et on \
      e.tipo_evento = et.codigo join _comun.turnos t on e.codigo_turno = t.id join _comun.paquete p on e.id_paquete = p.id \
      WHERE brigada is null UNION SELECT e.id, e.numero_ot, et.descripcion as tipo_evento, e.rut_maestro, e.rut_ayudante, \
      br.turno as turno, br.paquete as paquete, e.requerimiento, e.direccion, e.fecha_hora::text, e.estado, hora_inicio, \
      hora_termino, br.brigada as brigada, case when tipo_turno is not null then (select nombre from _comun.tipo_turno where \
        id = e.tipo_turno) else null end as tipo_turno, case when e.comuna is not null then (select nombre from _comun.comunas \
          where codigo = e.comuna ) else null end as comuna, case when e.coordenadas is not null then e.coordenadas->>'latitude' \
          else null end as latitude, case when e.coordenadas is not null then e.coordenadas->>'longitude' else null end as \
          longitude FROM sae.reporte_eventos e join _comun.eventos_tipo et on e.tipo_evento = et.codigo join \
          (SELECT br.id, b.nombre as base, p.nombre as paquete, (substr(t.inicio::text,1,5) || ' - ' || substr(t.fin::text,1,5)) \
          as turno, (substr(t.inicio::text,1,5) || '-' || substr(t.fin::text,1,5)) || ' (' || b.nombre || ')' as brigada \
          FROM _comun.brigadas  br join _comun.base b on br.id_base = b.id join _comun.paquete p on b.id_paquete = p.id \
          join _comun.turnos t on br.id_turno = t.id) as br on e.brigada = br.id WHERE e.brigada is not null order by id desc;";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const eventos = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (eventos) {
        for (const element of eventos) {
          if (
            typeof element.id === 'number' && 
            typeof element.numero_ot === 'string' &&
            typeof element.tipo_evento === 'string' &&
            typeof element.rut_maestro === 'string' &&
            typeof element.rut_ayudante === 'string' &&
            typeof element.turno === 'string' &&
            typeof element.paquete === 'string' &&
            typeof element.requerimiento === 'string' &&
            typeof element.direccion === 'string' &&
            (typeof element.fecha_hora === 'object' || typeof element.fecha_hora === 'string') &&
            typeof element.estado === 'number' &&
            (typeof element.hora_inicio === 'string' || typeof element.hora_inicio === 'object') &&
            (typeof element.hora_termino === 'string' || typeof element.hora_termino === 'object') &&
            (typeof element.brigada === 'string' || typeof element.brigada === 'object') &&
            (typeof element.tipo_turno === 'string' || typeof element.tipo_turno === 'object') &&
            (typeof element.comuna === 'string' || typeof element.comuna === 'object') &&
            (typeof element.latitude === 'string' || typeof element.latitude === 'object') &&
            (typeof element.longitude === 'string' || typeof element.longitude === 'object')) {

              const detalle_salida = {

                id: Number(element.id),
                numero_ot: String(element.numero_ot),
                tipo_evento: String(element.tipo_evento),
                rut_maestro: String(element.rut_maestro),
                rut_ayudante: String(element.rut_ayudante),
                turno: String(element.turno),
                paquete: String(element.paquete),
                requerimiento: String(element.requerimiento),
                direccion: String(element.direccion),
                fecha_hora: String(element.fecha_hora),
                estado: Number(element.estado),
                hora_inicio: String(element.hora_inicio),
                hora_termino: String(element.hora_termino),
                brigada: String(element.brigada),
                tipo_turno: String(element.tipo_turno),
                comuna: String(element.comuna),
                coordenadas: {
                  latitude: String(element.latitude),
                  longitude: String(element.longitude)
                }

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
/* Crea un estado resultado
  app.post("/api/reportes/v1/creaestadoresultado", reportesController.creaEstadoResultado)
*/
  exports.creaEstadoResultado = async (req, res) => {
    //metodo POST
    /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Crea un estado resultado' */
    try {
      const campos = [
        'id_usuario', 
        'zona', 
        'paquete', 
        'mes', 
        'fecha_inicio', 
        'fecha_final', 
        'nombre_doc', 
        'url_doc', 
        'fecha_creacion', 
        'fecha_modificacion', 
        'estado', 
        'eventos_relacionados',
        'id_cliente'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send({
            message: "No puede estar nulo el campo " + element
          });
          return;
        }
      };

      const detalles = req.body.eventos_relacionados;
      
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
        estado: req.body.estado,
        id_cliente: req.body.id_cliente
      }).then(async data => {
            let hayError = false;
            let mensajeError = '';
            for (const detalle of detalles) {
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
/*********************************************************************************** */


/*********************************************************************************** */
/* Devuelve el reporte de estado con los eventos asociados
  app.get("/api/reportes/v1/allestadosresultado", reportesController.findAllEstadosResultado)
*/
  exports.findAllEstadosResultado = async (req, res) => {
    //metodo POST
    /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve todos los estados de resultado' */
    try {
      const sql = "SELECT er.id, id_usuario, u.username as nombre_usuario, zona, z.nombre as nombre_zona, paquete, \
      p.nombre as nombre_paquete, mes, m.nombre as nombre_mes, fecha_inicio::text, fecha_final::text, nombre_doc, url_doc, \
      fecha_creacion::text, fecha_modificacion::text, estado, (SELECT array_agg(id_evento) as eventos FROM sae.reporte_detalle_estado_resultado  \
      where id_estado_resultado = er.id) as eventos_relacionados	FROM sae.reporte_estado_resultado er INNER JOIN _auth.users u \
      on er.id_usuario = u.id	INNER JOIN _comun.zonal z on z.id = er.zona	INNER JOIN _comun.paquete p on p.id = er.paquete	\
      INNER JOIN _comun.meses m on m.id = er.mes;";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const estadosResultado = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (estadosResultado) {
        for (const element of estadosResultado) {

          if (
            typeof element.id === 'number' && 
            typeof element.id_usuario === 'number' &&
            typeof element.nombre_usuario === 'string' &&
            typeof element.zona === 'number' &&
            typeof element.nombre_zona === 'string' &&
            typeof element.paquete === 'number' &&
            typeof element.nombre_paquete === 'string' &&
            typeof element.mes === 'number' &&
            typeof element.nombre_mes === 'string' &&
            (typeof element.fecha_inicio === 'object' || typeof element.fecha_inicio === 'string') &&
            (typeof element.fecha_final === 'object' || typeof element.fecha_final === 'string') &&
            typeof element.nombre_doc === 'string' &&
            typeof element.url_doc === 'string' &&
            (typeof element.fecha_creacion === 'object' || typeof element.fecha_creacion === 'string') &&
            (typeof element.fecha_modificacion === 'object' || typeof element.fecha_modificacion === 'string') &&
            typeof element.estado === 'number' &&
            typeof element.eventos_relacionados === 'object' ) { //Este campo es de tipo array integer[]

              const detalle_salida = {

                id: Number(element.id),
                id_usuario: Number(element.id_usuario),
                nombre_usuario: String(element.nombre_usuario),
                zona: Number(element.zona),
                nombre_zona: String(element.nombre_zona),
                paquete: Number(element.paquete),
                nombre_paquete: String(element.nombre_paquete),
                mes: Number(element.mes),
                nombre_mes: String(element.nombre_mes),
                fecha_inicio: String(element.fecha_inicio),
                fecha_final: String(element.fecha_final),
                nombre_doc: String(element.nombre_doc),
                url_doc: String(element.url_doc),
                fecha_creacion: String(element.fecha_creacion),
                fecha_modificacion: String(element.fecha_modificacion),
                estado: Number(element.estado),
                eventos_relacionados: element.eventos_relacionados

              }
              salida.push(detalle_salida);

          }else {
              salida = undefined;
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
/* Devuelve resumen de eventos
  app.get("/api/reportes/v1/resumeneventos", reportesController.resumenEventos)
*/
exports.resumenEventos = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve el resumen de eventos por paquete y rango de fechas' */
  try {
    const campos = [
      'id_paquete', 'fecha_inicial', 'fecha_final'
    ];
    for (const element of campos) {
      if (!req.query[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
    const sql = "SELECT e.id_paquete, e.tipo_evento, et.id as id_tipo_evento, et.descripcion as glosa_evento, \
    pb.valor as precio, count(e.id) as cantidad, (pb.valor*count(e.id)) as monto from sae.reporte_eventos e \
    inner join _comun.eventos_tipo et on et.codigo = e.tipo_evento inner join (SELECT distinct on \
      (id_cliente, id_paquete, id_evento_tipo) id_cliente, id_paquete, id_evento_tipo, valor FROM \
      sae.precios_base ORDER BY id_cliente, id_paquete, id_evento_tipo ASC ) as pb on et.id = \
      pb.id_evento_tipo and e.id_paquete = pb.id_paquete and pb.id_cliente = 1 where estado = 1 and \
      e.id_paquete = :id_paquete and (fecha_hora between date :fec_ini and date :fec_fin) group by \
      e.id_paquete, e.tipo_evento, et.id, et.descripcion, pb.valor;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const eventos = await sequelize.query(sql, { replacements: { id_paquete: req.query.id_paquete, fec_ini: req.query.fecha_inicial, fec_fin: req.query.fecha_final }, type: QueryTypes.SELECT });
    let salida = [];
    if (eventos) {
      for (const element of eventos) {
        if (
          typeof element.id_paquete === 'number' && 
          typeof element.tipo_evento === 'string' &&
          typeof element.id_tipo_evento === 'number' &&
          typeof element.glosa_evento === 'string' &&
          (typeof element.precio === 'number' || typeof element.precio === 'string') &&
          (typeof element.cantidad === 'number' || typeof element.cantidad === 'string') &&
          (typeof element.monto === 'number' || typeof element.monto === 'string')) {

            const detalle_salida = {

              id_paquete: Number(element.id_paquete),
              tipo_evento: String(element.tipo_evento),
              id_tipo_evento: Number(element.id_tipo_evento),
              glosa_evento: String(element.glosa_evento),
              precio: Number(element.precio),
              cantidad: Number(element.cantidad),
              monto: Number(element.monto)

            }
            salida.push(detalle_salida);

        }else {
            salida===undefined;
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
/* Devuelve resumen de turnos
  app.get("/api/reportes/v1/resumenturnos", reportesController.resumenTurnos)
*/
exports.resumenTurnos = async (req, res) => {
  // metodo GET
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve el resumen de turnos por paquete y rango de fechas' */
  try {
    const campos = [
      'id_paquete', 'fecha_inicial', 'fecha_final'
    ];
    for (const element of campos) {
      if (!req.query[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
    
    const sql = "select r.*, (r.cantidad_brigada*r.precio*r.uso_semanal)::integer as monto from \
    (SELECT id_paquete, id_turno, (substring(t.inicio::text,1,5) || ' - ' || substring(t.fin::text,1,5)) as permanencia_semanal, \
    cantidad_brigada, valor as precio, ((date :fec_fin - (date :fec_ini - 1))::numeric/7)::numeric(6,4) \
    as uso_semanal 	FROM sae.cargo_fijo cf inner join _comun.turnos t on t.id = cf.id_turno where id_cliente = 1 and id_paquete = :id_paquete) r;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const eventos = await sequelize.query(sql, { replacements: { id_paquete: req.query.id_paquete, fec_ini: req.query.fecha_inicial, fec_fin: req.query.fecha_final }, type: QueryTypes.SELECT });
    let salida = [];
    if (eventos) {
      for (const element of eventos) {
        if (
          typeof element.id_paquete === 'number' && 
          typeof element.id_turno === 'number' &&
          typeof element.permanencia_semanal === 'string' &&
          typeof element.cantidad_brigada === 'number' &&
          (typeof element.precio === 'number' || typeof element.precio === 'string') &&
          (typeof element.uso_semanal === 'number' || typeof element.uso_semanal === 'string') &&
          typeof element.monto === 'number') {

            const detalle_salida = {

              id_paquete: Number(element.id_paquete),
              id_turno: Number(element.id_turno),
              permanencia_semanal: String(element.permanencia_semanal),
              cantidad_brigada: Number(element.cantidad_brigada),
              precio: Number(element.precio),
              uso_semanal: Number(element.uso_semanal),
              monto: Number(element.monto)

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
/* Devuelve resumen de todos los eventos, no considera paquete
  app.get("/api/reportes/v1/resumenalleventos", reportesController.resumenAllEventos)
*/
exports.resumenAllEventos = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve el resumen de eventos por paquete y rango de fechas' */
  try {
    const campos = [
      'fecha_inicial', 'fecha_final'
    ];
    for (const element of campos) {
      if (!req.query[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
    const sql = "SELECT e.id_paquete, e.tipo_evento, et.id as id_tipo_evento, et.descripcion as glosa_evento, \
    pb.valor as precio, count(e.id) as cantidad, (pb.valor*count(e.id)) as monto from sae.reporte_eventos e \
    inner join _comun.eventos_tipo et on et.codigo = e.tipo_evento inner join (SELECT distinct on \
      (id_cliente, id_paquete, id_evento_tipo) id_cliente, id_paquete, id_evento_tipo, valor FROM \
      sae.precios_base ORDER BY id_cliente, id_paquete, id_evento_tipo ASC ) as pb on et.id = \
      pb.id_evento_tipo and e.id_paquete = pb.id_paquete and pb.id_cliente = 1 where estado = 1 and \
      (fecha_hora between date :fec_ini and date :fec_fin) group by \
      e.id_paquete, e.tipo_evento, et.id, et.descripcion, pb.valor;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const eventos = await sequelize.query(sql, { replacements: { fec_ini: req.query.fecha_inicial, fec_fin: req.query.fecha_final }, type: QueryTypes.SELECT });
    let salida = [];
    if (eventos) {
      for (const element of eventos) {
        if (
          typeof element.id_paquete === 'number' && 
          typeof element.tipo_evento === 'string' &&
          typeof element.id_tipo_evento === 'number' &&
          typeof element.glosa_evento === 'string' &&
          (typeof element.precio === 'number' || typeof element.precio === 'string') &&
          (typeof element.cantidad === 'number' || typeof element.cantidad === 'string') &&
          (typeof element.monto === 'number' || typeof element.monto === 'string')) {

            const detalle_salida = {

              id_paquete: Number(element.id_paquete),
              tipo_evento: String(element.tipo_evento),
              id_tipo_evento: Number(element.id_tipo_evento),
              glosa_evento: String(element.glosa_evento),
              precio: Number(element.precio),
              cantidad: Number(element.cantidad),
              monto: Number(element.monto)

            }
            salida.push(detalle_salida);

        }else {
            salida===undefined;
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
/* Devuelve resumen de todos los turnos
  app.get("/api/reportes/v1/resumenallturnos", reportesController.resumenTurnos)
*/
exports.resumenAllTurnos = async (req, res) => {
  // metodo GET
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Devuelve el resumen de turnos por paquete y rango de fechas' */
  try {
    const campos = [
      'fecha_inicial', 'fecha_final'
    ];
    for (const element of campos) {
      if (!req.query[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
    
    const sql = "select r.*, (r.cantidad_brigada*r.precio*r.uso_semanal)::integer as monto from \
    (SELECT id_paquete, id_turno, (substring(t.inicio::text,1,5) || ' - ' || substring(t.fin::text,1,5)) as permanencia_semanal, \
    cantidad_brigada, valor as precio, ((date :fec_fin - (date :fec_ini - 1))::numeric/7)::numeric(6,4) \
    as uso_semanal 	FROM sae.cargo_fijo cf inner join _comun.turnos t on t.id = cf.id_turno where id_cliente = 1) r;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const eventos = await sequelize.query(sql, { replacements: { fec_ini: req.query.fecha_inicial, fec_fin: req.query.fecha_final }, type: QueryTypes.SELECT });
    let salida = [];
    if (eventos) {
      for (const element of eventos) {
        if (
          typeof element.id_paquete === 'number' && 
          typeof element.id_turno === 'number' &&
          typeof element.permanencia_semanal === 'string' &&
          typeof element.cantidad_brigada === 'number' &&
          (typeof element.precio === 'number' || typeof element.precio === 'string') &&
          (typeof element.uso_semanal === 'number' || typeof element.uso_semanal === 'string') &&
          typeof element.monto === 'number') {

            const detalle_salida = {

              id_paquete: Number(element.id_paquete),
              id_turno: Number(element.id_turno),
              permanencia_semanal: String(element.permanencia_semanal),
              cantidad_brigada: Number(element.cantidad_brigada),
              precio: Number(element.precio),
              uso_semanal: Number(element.uso_semanal),
              monto: Number(element.monto)

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
/* Ingresa las observaciones para un estado de pago
  app.post("/api/reportes/v1/creaobservaciones", reportesController.creaObservaciones)
*/
exports.creaObservaciones = async (req, res) => {
  // metodo POST
  /*  #swagger.tags = ['SAE - Backoffice - Reportes']
      #swagger.description = 'Ingresa las observaciones para un estado de pago' */
  try {
    const campos = [
      'id_usuario', 'id_estado_pago', 'observaciones'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
}catch (error) {
  res.status(500).send(error);
}
}
