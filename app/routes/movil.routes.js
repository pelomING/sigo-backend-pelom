const { authJwt } = require("../middleware");
const movilController = require("../controllers/movil.controller");

module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
  
    app.get("/api/movil/v1/paquete", movilController.paquete);

    app.get("/api/movil/v1/zonaPaqueteBaseSql", [authJwt.verifyToken, authJwt.isTecnico], movilController.zonaPaqueteBaseSql);

    app.get("/api/movil/v1/usuariosApp", [authJwt.verifyToken, authJwt.isSistema], movilController.usuariosApp);

    app.get("/api/movil/v1/turnos", [authJwt.verifyToken, authJwt.isSistema], movilController.turnos);

    app.get("/api/movil/v1/eventostipo", [authJwt.verifyToken, authJwt.isSistema], movilController.eventostipo);

    app.get("/api/movil/v1/ayudantes", [authJwt.verifyToken, authJwt.isSistema], movilController.ayudantes);

    app.get("/api/movil/v1/camionetas", [authJwt.verifyToken, authJwt.isSistema], movilController.camionetas);

    app.post("/api/movil/v1/creaevento", [authJwt.verifyToken, authJwt.isSistema], movilController.createEvento);

    app.post("/api/movil/v1/creajornada", [authJwt.verifyToken, authJwt.isSistema], movilController.creaJornada);


  };