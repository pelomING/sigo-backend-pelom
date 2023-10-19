const { authJwt } = require("../middleware");
const backofficeController = require("../controllers/obras/backoffice.controller");

module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
    

    /* Devuelve todos los tipo de obras */
    app.get("/api/obras/backoffice/v1/alltipoobras", [authJwt.verifyToken], backofficeController.findAllTipoObra);


    app.get("/api/obras/backoffice/v1/allzonales", [authJwt.verifyToken], backofficeController.findAllZonal);


    app.get("/api/obras/backoffice/v1/alldelegaciones", [authJwt.verifyToken], backofficeController.findAllDelegacion);


    app.get("/api/obras/backoffice/v1/alltipotrabajos", [authJwt.verifyToken], backofficeController.findAllTipoTrabajo);


    app.get("/api/obras/backoffice/v1/allempresacontratistas", [authJwt.verifyToken], backofficeController.findAllEmpresaContratista);


    app.get("/api/obras/backoffice/v1/allcoordinadorcontratistas", [authJwt.verifyToken], backofficeController.findAllCoordinadorContratista);


    app.get("/api/obras/backoffice/v1/allcomunas", [authJwt.verifyToken], backofficeController.findAllComuna);


    app.get("/api/obras/backoffice/v1/allestados", [authJwt.verifyToken], backofficeController.findAllEstadoObra);


    app.get("/api/obras/backoffice/v1/allsegmentos", [authJwt.verifyToken], backofficeController.findAllSegmento);


    app.get("/api/obras/backoffice/v1/allobras", [authJwt.verifyToken], backofficeController.findAllObra);


    app.post("/api/obras/backoffice/v1/creaobra", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.createObra);


    app.put("/api/obras/backoffice/v1/actualizaobra/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.updateObra);


    app.delete("/api/obras/backoffice/v1/eliminaobra/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.deleteObra);


    app.get("/api/obras/backoffice/v1/obras/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.findObraById);


    app.get("/api/obras/backoffice/v1/obras", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.findObraByCodigo);


    app.get("/api/obras/backoffice/v1/allbom", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.findAllBom);


    app.get("/api/obras/backoffice/v1/bomporparametros", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.findBomByParametros);


    app.post("/api/obras/backoffice/v1/creabom", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.createBomMasivo);


    app.delete("/api/obras/backoffice/v1/eliminabombyreserva/:reserva", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.deleteBomByReserva);


    app.delete("/api/obras/backoffice/v1/eliminamaterialbom/:reserva/:cod_sap", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeController.deleteBomByMaterial);


}
