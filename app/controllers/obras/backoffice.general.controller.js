const db = require("../../models");
const TipoObra = db.tipoObra;
const Zonal = db.zonal;
const Delegacion = db.delegacion;
const TipoTrabajo = db.tipoTrabajo;
const EmpresaContratista = db.empresaContratista;
const CoordinadorContratista = db.coordinadorContratista;
const Comuna = db.comuna;
const EstadoObra = db.estadoObra;
const Segmento = db.segmento;

exports.findAllTipoObra = async (req, res) => {
    //metodo GET
      await TipoObra.findAll().then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })
  }
  /*********************************************************************************** */

exports.findAllZonal = async (req, res) => {
    //metodo GET
    try {
      const data = await Zonal.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllDelegacion = async (req, res) => {
    //metodo GET
    try {
      const data = await Delegacion.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


 exports.findAllTipoTrabajo = async (req, res) => {
    //metodo GET
    try {
      const data = await TipoTrabajo.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllEmpresaContratista = async (req, res) => {
    //metodo GET
    try {
      const data = await EmpresaContratista.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllCoordinadorContratista = async (req, res) => {
    //metodo GET
    try {
      const data = await CoordinadorContratista.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllComuna = async (req, res) => {
    //metodo GET
    try {
      const data = await Comuna.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */

exports.findAllEstadoObra = async (req, res) => {
    //metodo GET
    try {
      const data = await EstadoObra.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */

exports.findAllSegmento = async (req, res) => {
    //metodo GET
    try {
      const data = await Segmento.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */
