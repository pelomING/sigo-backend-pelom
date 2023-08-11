const db = require("../models");
const Paquete = db.paquete;

exports.paquete = async (req, res) => {
  try {
    const paquete = await Paquete.findAll();
    res.status(200).send(paquete);
  } catch (error) {
    res.status(500).send(error);
  }
}

exports.zonaPaqueteBaseSql = async (req, res) => {
  try {
    const sql = "select b.id, z.nombre as zona, p.nombre as paquete, b.nombre as base from zonal z join \
    paquete p on z.id = p.id_zonal join base b on p.id = b.id_paquete order by z.id, p.id, b.id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const zonaPaqueteBase = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(zonaPaqueteBase);
  }catch (error) {
    console.log("error en zonaPaqueteBaseSql", error);
    res.status(500).send(error);
  }
}

exports.usuariosApp = async (req, res) => {
  try {

    const sql = "select u.id, p.rut, (p.nombres || ' ' || p.apellido_1 || case when p.apellido_2 is null then \
    '' else ' ' || trim(p.apellido_2) end) as nombre, u.password, tfp.nombre as funcion, r.name as rol, b.nombre as base \
    from users u join personas p on u.username = p.rut join tipo_funcion_personal tfp on p.id_funcion = tfp.id \
    join user_roles ur on ur.\"userId\" = u.id join roles r on r.id = ur.\"roleId\" join base b on p.base = b.id \
    where p.activo and not r.sistema order by p.rut"
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const usuariosApp = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(usuariosApp);
  } catch (error) {
    res.status(500).send(error);
  }
}

exports.ayudantes = async (req, res) => {
  try {

    const sql = "select u.id, p.rut, (p.nombres || ' ' || p.apellido_1 || case when p.apellido_2 is null then \
    '' else ' ' || trim(p.apellido_2) end) as nombre, u.password, tfp.nombre as funcion, r.name as rol, b.nombre as base \
    from users u join personas p on u.username = p.rut join tipo_funcion_personal tfp on p.id_funcion = tfp.id \
    join user_roles ur on ur.\"userId\" = u.id join roles r on r.id = ur.\"roleId\" join base b on p.base = b.id \
    where p.activo and not r.sistema and tfp.ayudante order by p.rut"
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const ayudantes = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(ayudantes);
  } catch (error) {
    res.status(500).send(error);
  }
}

exports.turnos = async (req, res) => {
  try {
    const sql = "SELECT id, substring(inicio::text,1,5) || ' - ' || substring(fin::text,1,5) as turno, observacion FROM public.turnos order by id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const turnos = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(turnos);
  } catch (error) {
    res.status(500).send(error);
  }
}

exports.eventostipo = async (req, res) => {
  try {
    const sql = "SELECT id, codigo, descripcion FROM public.eventos_tipo ORDER BY id ASC;";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const eventostipo = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(eventostipo);
  } catch (error) {
    res.status(500).send(error);
  }
}

exports.camionetas = async (req, res) => {
  try {
    const sql = "SELECT c.id, c.patente, c.marca, c.modelo, b.nombre as base, c.activa FROM camionetas c join base b on c.id_base = b.id ORDER BY id ASC ";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const camionetas = await sequelize.query(sql, { type: QueryTypes.SELECT });
    res.status(200).send(camionetas);
  } catch (error) {
    res.status(500).send(error);
  }
  
}