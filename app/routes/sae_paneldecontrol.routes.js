const { authJwt } = require("../middleware");
const paneldeControlController = require("../controllers/sae/panelcontrol.controller");

module.exports = function(app) {

    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });

    app.get("/api/paneldecontrol/v1/getcantidadeventossaeporzonal", [authJwt.verifyToken], paneldeControlController.getCantidadEventosSaePorZonal);


    app.get("/api/paneldecontrol/v1/getcanteventsaeorganizadomes", [authJwt.verifyToken], paneldeControlController.getCantidadEventosSaePorZonalOrganizadoPorMes);
    

}
