const db = require("../../models");
const Paquete = db.paquete;
const Eventos = db.eventos;
const Jornada = db.jornada;
//const Base = db.base;


/*********************************************************************************** */
/* Consulta los paquetes
  app.get("/api/movil/v1/paquete", movilController.paquete)
*/
exports.paquete = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todos los paquetes en sae' */
  try {
    const paquete = await Paquete.findAll();
    res.status(200).send(paquete);
  } catch (error) {
    res.status(500).send(error);
  }
}
/*********************************************************************************** */


/*********************************************************************************** */
/* Devuelve zona-paquete-base
  app.get("/api/movil/v1/zonaPaqueteBaseSql", [authJwt.verifyToken, authJwt.isTecnico], movilController.zonaPaqueteBaseSql);
*/
exports.zonaPaqueteBaseSql = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todos la relación zona-paquete-base en sae' */
  try {
    const sql = "select b.id, z.nombre as zona, p.nombre as paquete, b.nombre as base from _comun.zonal z join \
    _comun.paquete p on z.id = p.id_zonal join _comun.base b on p.id = b.id_paquete order by z.id, p.id, b.id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const zonaPaqueteBase = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (zonaPaqueteBase) {
      for (const element of zonaPaqueteBase) {
        if (
          typeof element.id === 'number' && 
          typeof element.zona === 'string' &&
          typeof element.paquete === 'string' &&
          typeof element.base === 'string') {

            const detalle_salida = {

              id: Number(element.id),
              zona: String(element.zona),
              paquete: String(element.paquete),
              base: String(element.base)

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
  }catch (error) {
    res.status(500).send(error);
  }
}
/*********************************************************************************** */


/*********************************************************************************** */
/* Devuelve los usuarios de la app móvil
  app.get("/api/movil/v1/usuariosApp", [authJwt.verifyToken, authJwt.isSistema], movilController.usuariosApp)
*/
exports.usuariosApp = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todos usuarios de la app móvil sae' */
  try {

    const sql = "select u.id, p.rut, (p.nombres || ' ' || p.apellido_1 || case when p.apellido_2 is null then \
    '' else ' ' || trim(p.apellido_2) end) as nombre, u.password, tfp.nombre as funcion, r.name as rol, b.nombre as base \
    from _auth.users u join _auth.personas p on u.username = p.rut join _comun.tipo_funcion_personal tfp on p.id_funcion = tfp.id \
    join _auth.user_roles ur on ur.\"userId\" = u.id join _auth.roles r on r.id = ur.\"roleId\" join _comun.base b on p.base = b.id \
    where p.activo and not r.sistema and (tfp.maestro or tfp.ayudante) order by p.rut"
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const usuariosApp = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (usuariosApp) {
      for (const element of usuariosApp) {
        if (
          typeof element.id === 'number' && 
          typeof element.rut === 'string' &&
          typeof element.nombre === 'string' &&
          typeof element.password === 'string' &&
          typeof element.funcion === 'string' &&
          typeof element.rol === 'string' &&
          typeof element.base === 'string') {

            const detalle_salida = {
              id: Number(element.id),
              rut: String(element.rut),
              nombre: String(element.nombre),
              password: String(element.password),
              funcion: String(element.funcion),
              rol: String(element.rol),
              base: String(element.base)
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
/* Devuelve los ayudantes
  app.get("/api/movil/v1/ayudantes", [authJwt.verifyToken, authJwt.isSistema], movilController.usuariosApp);
*/
exports.ayudantes = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todos los ayudantes de la app móvil sae' */
  try {

    const sql = "select u.id, p.rut, (p.nombres || ' ' || p.apellido_1 || case when p.apellido_2 is null then \
    '' else ' ' || trim(p.apellido_2) end) as nombre, u.password, tfp.nombre as funcion, r.name as rol, b.nombre as base \
    from _auth.users u join _auth.personas p on u.username = p.rut join _comun.tipo_funcion_personal tfp on p.id_funcion = tfp.id \
    join _auth.user_roles ur on ur.\"userId\" = u.id join _auth.roles r on r.id = ur.\"roleId\" join _comun.base b on p.base = b.id \
    where p.activo and not r.sistema and tfp.ayudante order by p.rut"
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const ayudantes = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (ayudantes) {
      for (const element of ayudantes) {
        if (
          typeof element.id === 'number' && 
          typeof element.rut === 'string' &&
          typeof element.nombre === 'string' &&
          typeof element.password === 'string' &&
          typeof element.funcion === 'string' &&
          typeof element.rol === 'string' &&
          typeof element.base === 'string') {

            const detalle_salida = {
              id: Number(element.id),
              rut: String(element.rut),
              nombre: String(element.nombre),
              password: String(element.password),
              funcion: String(element.funcion),
              rol: String(element.rol),
              base: String(element.base)
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
/* Devuelve los turnos
  app.get("/api/movil/v1/turnos", [authJwt.verifyToken, authJwt.isSistema], movilController.turnos);
*/
exports.turnos = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todos los turnos de la app móvil sae' */
  try {
    const sql = "SELECT id, substring(inicio::text,1,5) || ' - ' || substring(fin::text,1,5) as turno, observacion FROM _comun.turnos order by id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const turnos = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (turnos) {
      for (const element of turnos) {
        if (
          typeof element.id === 'number' && 
          typeof element.turno === 'string' &&
          typeof element.observacion === 'string' || typeof element.observacion === 'object') {

            const detalle_salida = {
              id: Number(element.id),
              turno: String(element.turno),
              observacion: Number(element.observacion)
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
/* Devuelve los tipos de eventos
  app.get("/api/movil/v1/eventostipo", [authJwt.verifyToken, authJwt.isSistema], movilController.eventostipo)
*/
exports.eventostipo = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todos los tipos de eventos' */
  try {
    const sql = "SELECT id, codigo, descripcion FROM _comun.eventos_tipo ORDER BY id ASC;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const eventostipo = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (eventostipo) {
      for (const element of eventostipo) {
        if (
          typeof element.id === 'number' && 
          typeof element.codigo === 'string' &&
          typeof element.descripcion === 'string') {

            const detalle_salida = {
              id: Number(element.id),
              codigo: String(element.codigo),
              descripcion: Number(element.descripcion)
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
/* Devuelve los camionetas
  app.get("/api/movil/v1/camionetas", [authJwt.verifyToken, authJwt.isSistema], movilController.camionetas)
*/
exports.camionetas = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todas las camionetas' */
  try {
    const sql = "SELECT c.id, c.patente, c.marca, c.modelo, b.nombre as base, c.activa FROM _comun.camionetas c join _comun.base b on c.id_base = b.id WHERE activa ORDER BY id ASC ";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const camionetas = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (camionetas) {
      for (const element of camionetas) {
        if (
          typeof element.id === 'number' && 
          typeof element.patente === 'string' &&
          typeof element.marca === 'string' &&
          (typeof element.modelo === 'string' ||  typeof element.modelo === 'object') &&  //acepta nulos
          (typeof element.base === 'string' ||  typeof element.base === 'object') &&  //acepta nulos
          typeof element.activa === 'boolean') {

            const detalle_salida = {

              id: Number(element.id),
              patente: String(element.patente),
              marca: String(element.marca),
              modelo: String(element.modelo),
              base: String(element.base),
              activa: Boolean(element.activa)

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
/*Crea un nuevo evento
  app.post("/api/movil/v1/creaevento", [authJwt.verifyToken, authJwt.isSistema], movilController.createEvento);
*/
exports.createEvento = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Crea un nuevo evento' */

  const campos = [
    'numero_ot', 'tipo_evento', 'rut_maestro', 'rut_ayudante', 'codigo_turno', 'id_base', 'requerimiento', 'direccion', 'fecha_hora'
  ];
  for (const element of campos) {
    if (!req.body[element]) {
      res.status(400).send({
        message: "No puede estar nulo el campo " + element
      });
      return;
    }
  };

  const evento = {
      numero_ot: req.body.numero_ot,
      tipo_evento: req.body.tipo_evento,
      rut_maestro: req.body.rut_maestro,
      rut_ayudante: req.body.rut_ayudante,
      codigo_turno: req.body.codigo_turno,
      id_base: req.body.id_base,
      requerimiento: req.body.requerimiento,
      direccion: req.body.direccion,
      fecha_hora: req.body.fecha_hora,
      estado: 1
  };

  await Eventos.create(evento)
      .then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })

}
/*********************************************************************************** */


/*********************************************************************************** */
/*Crea un nueva jornada
  app.post("/api/movil/v1/creajornada", [authJwt.verifyToken, authJwt.isSistema], movilController.creaJornada)
*/
exports.creaJornada = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Crea una nueva jornada' */
  try {

    const campos = [
      'rut_maestro', 'rut_ayudante', 'codigo_turno', 'patente', 'base', 'km_inicial', 'km_final', 'fecha_hora_ini', 'fecha_hora_fin'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };

    const jornada = await Jornada.create({
      rut_maestro: req.body.rut_maestro,
      rut_ayudante: req.body.rut_ayudante,
      codigo_turno: req.body.codigo_turno,
      patente: req.body.patente,
      base: req.body.base,
      km_inicial: req.body.km_inicial,
      km_final: req.body.km_final,
      fecha_hora_ini: req.body.fecha_hora_ini,
      fecha_hora_fin: req.body.fecha_hora_fin,
      estado: 1
    });
    res.status(200).send(jornada);
  } catch (error) {
    res.status(500).send(error);
  }
  
}
/*********************************************************************************** */

/*********************************************************************************** */
/*Actualiza un evento
  app.post("/api/movil/v1/updateevento", [authJwt.verifyToken, authJwt.isSistema], movilController.updateEvento);
*/
exports.updateEvento = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Actualiza un evento' */
  try {
    const id = req.params.id;

    const evento = {
      numero_ot: req.body.numero_ot,
      tipo_evento: req.body.tipo_evento,
      rut_maestro: req.body.rut_maestro,
      rut_ayudante: req.body.rut_ayudante,
      codigo_turno: req.body.codigo_turno,
      id_base: req.body.id_base,
      requerimiento: req.body.requerimiento,
      direccion: req.body.direccion,
      fecha_hora: req.body.fecha_hora
    };

    await Eventos.update(evento, { where: { id: id } })
          .then(data => {
              if (data == 1) {
                  res.send({ message: "Evento actualizado" });
              }else {
                  res.status(500).send({ message: "No se pudo actualizar el evento" });
              }
          }).catch(err => {
              res.status(500).send({ message: err.message + " Evento no actualizado" });
          })

  }catch (error) {
      res.status(500).send(error);
    }
}

/*********************************************************************************** */
/*Devuelve las oficinas
  app.get("/api/movil/v1/oficinas", [authJwt.verifyToken, authJwt.isSistema], movilController.bases)
*/
exports.bases = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todas las bases sae' */
  try {
    const sql = "select p.id, p.nombre, p.id_zonal from _comun.paquete p join (SELECT distinct sc.paquete \
      FROM _comun.servicio_comuna sc inner join _comun.servicios s on sc.servicio = s.codigo \
      where s.activo and s.sae and sc.activo) as pa on p.id = pa.paquete order by nombre;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const base = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (base) {
      for (const element of base) {
        if (
          typeof element.id === 'number' && 
          typeof element.nombre === 'string' && 
          typeof element.id_zonal === 'number') {

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
/* Devuelve las comunas
  app.get("/api/movil/v1/comunas", [authJwt.verifyToken, authJwt.isSistema], movilController.comunas)
*/
exports.comunas = async (req, res) => {
  /*  #swagger.tags = ['SAE - Móvil']
      #swagger.description = 'Devuelve todas las comunas' */
  try {
    const sql = "SELECT  sc.comuna as codigo, c.nombre, sc.paquete as oficina \
    FROM _comun.servicio_comuna sc join _comun.servicios s on sc.servicio = s.codigo join \
    _comun.comunas c on sc.comuna = c.codigo	where s.sae and s.activo and sc.activo order by c.nombre;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const comuna = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (comuna) {
      for (const element of comuna) {
        if (
          typeof element.codigo === 'string' && 
          typeof element.nombre === 'string' && 
          typeof element.oficina === 'number') {

            const detalle_salida = {
              codigo: String(element.codigo),
              nombre: String(element.nombre),
              oficina: Number(element.oficina)
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