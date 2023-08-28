const { authJwt } = require("../middleware");
const movilController = require("../controllers/movil.controller");
// const router = require("express").Router();

module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
  
    /**
     * @swagger
     * paths:
     *   /api/movil/v1/paquete:
     *      get:
     *        summary: Lista de los paquetes del sistema SAE
     *        content:
     *          application/json:
     *        responses:
     *          200:
     *            description: Paquetes
     *          400:
     *            description: Error
     */
    app.get("/api/movil/v1/paquete", movilController.paquete);

    app.get("/api/movil/v1/zonaPaqueteBaseSql", [authJwt.verifyToken, authJwt.isTecnico], movilController.zonaPaqueteBaseSql);

    app.get("/api/movil/v1/usuariosApp", [authJwt.verifyToken, authJwt.isSistema], movilController.usuariosApp);

    app.get("/api/movil/v1/turnos", [authJwt.verifyToken, authJwt.isSistema], movilController.turnos);

    app.get("/api/movil/v1/eventostipo", [authJwt.verifyToken, authJwt.isSistema], movilController.eventostipo);

    //por petición de Patricio en ayudantes se entregan todos los usuarios del sistema
    app.get("/api/movil/v1/ayudantes", [authJwt.verifyToken, authJwt.isSistema], movilController.usuariosApp);

    app.get("/api/movil/v1/camionetas", [authJwt.verifyToken, authJwt.isSistema], movilController.camionetas);

    app.get("/api/movil/v1/oficinas", [authJwt.verifyToken, authJwt.isSistema], movilController.bases);

    app.get("/api/movil/v1/comunas", [authJwt.verifyToken, authJwt.isSistema], movilController.comunas);

    app.post("/api/movil/v1/creaevento", [authJwt.verifyToken, authJwt.isSistema], movilController.createEvento);

    app.post("/api/movil/v1/creajornada", [authJwt.verifyToken, authJwt.isSistema], movilController.creaJornada);


  };