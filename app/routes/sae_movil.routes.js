const { authJwt } = require("../middleware");
const movilController = require("../controllers/sae/movil.controller");
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
 * /api/movil/v1/paquete:
 *   get:
 *     summary: Retrieve a list of JSONPlaceholder users
 *     description: Retrieve a list of users from JSONPlaceholder. Can be used to populate a list of fake users when prototyping or testing an API.
*/

    /* Consulta los paquetes*/
    app.get("/api/movil/v1/paquete", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.paquete);

    /* Devuelve zona-paquete-base*/
    app.get("/api/movil/v1/zonaPaqueteBaseSql", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.zonaPaqueteBaseSql);

    /* Devuelve los usuarios de la app móvil*/
    app.get("/api/movil/v1/usuariosApp", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.usuariosApp);

    /* Devuelve los turnos de la app móvil*/
    app.get("/api/movil/v1/turnos", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.turnos);

    /* Devuelve los tipos de eventos de la app móvil*/
    app.get("/api/movil/v1/eventostipo", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.eventostipo);

    //por petición de Patricio en ayudantes se entregan todos los usuarios del sistema
    app.get("/api/movil/v1/ayudantes", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.usuariosApp);

    /* Devuelve los camionetas de la app móvil*/
    app.get("/api/movil/v1/camionetas", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.camionetas);

    /*Devuelve las oficinas */
    app.get("/api/movil/v1/oficinas", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.bases);

    /* Devuelve las comunas */
    app.get("/api/movil/v1/comunas", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.comunas);

    /* Devuelve los tipo de turno */
    app.get("/api/movil/v1/tipoturno", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.tipoTurno);

    /* Devuelve las brigadas */
    app.get("/api/movil/v1/saebrigadas", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.saeBrigadas);

    // deshabilitada por ahora para la api
    //app.post("/api/movil/v1/creaevento", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.createEvento);

    // deshabilitada por ahora para la api
    //app.post("/api/movil/v1/creajornada", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.creaJornada);

    //actualiza un evento por ID de evento
    app.put("/api/movil/v1/actualizaEvento/:id", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.updateEvento);

    //actualiza una jornada por ID
    app.put("/api/movil/v1/actualizaJornada/:id", [authJwt.verifyToken, authJwt.isSistemaOrAdminSae], movilController.updateJornada);




  };