const { authJwt } = require("../middleware");
const backofficeGeneralController = require("../controllers/obras/backoffice.general.controller");
const backofficeObrasController = require("../controllers/obras/backoffice.obras.controller");
const backofficeBomController = require("../controllers/obras/backoffice.bom.controller");
const backofficeTerrenoController = require("../controllers/obras/backoffice.terreno.controller");
const backofficeRepodiarioController = require("../controllers/obras/backoffice.repodiario.controller");

module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
    
{/***** BACKOFFICE */
    /* Devuelve todos los tipo de obras */
    app.get("/api/obras/backoffice/v1/alltipoobras", [authJwt.verifyToken], backofficeGeneralController.findAllTipoObra);


    app.get("/api/obras/backoffice/v1/alltipoperacion", [authJwt.verifyToken], backofficeGeneralController.findAllTipoOperacion);


    app.get("/api/obras/backoffice/v1/alltipoactividad", [authJwt.verifyToken], backofficeGeneralController.findAllTipoActividad);


    app.get("/api/obras/backoffice/v1/allmaestroactividad", [authJwt.verifyToken], backofficeGeneralController.findAllMaestroActividad);


    app.get("/api/obras/backoffice/v1/maestroactividadporid", [authJwt.verifyToken], backofficeGeneralController.findOneMaestroActividad);


    app.get("/api/obras/backoffice/v1/maestroactividadporactividad", [authJwt.verifyToken], backofficeGeneralController.findAllMaestroActividadActividad);


    app.get("/api/obras/backoffice/v1/allzonales", [authJwt.verifyToken], backofficeGeneralController.findAllZonal);


    app.get("/api/obras/backoffice/v1/alldelegaciones", [authJwt.verifyToken], backofficeGeneralController.findAllDelegacion);


    app.get("/api/obras/backoffice/v1/alltipotrabajos", [authJwt.verifyToken], backofficeGeneralController.findAllTipoTrabajo);


    app.get("/api/obras/backoffice/v1/allempresacontratistas", [authJwt.verifyToken], backofficeGeneralController.findAllEmpresaContratista);


    app.get("/api/obras/backoffice/v1/allcoordinadorcontratistas", [authJwt.verifyToken], backofficeGeneralController.findAllCoordinadorContratista);


    app.get("/api/obras/backoffice/v1/allcomunas", [authJwt.verifyToken], backofficeGeneralController.findAllComuna);


    app.get("/api/obras/backoffice/v1/allestados", [authJwt.verifyToken], backofficeGeneralController.findAllEstadoObra);


    app.get("/api/obras/backoffice/v1/allsegmentos", [authJwt.verifyToken], backofficeGeneralController.findAllSegmento);

}
/*/*********************************************************************************** */
/******* OBRAS ******************************************************************** */    

{/*** OBRAS ***  */
    app.get("/api/obras/backoffice/v1/allobras", [authJwt.verifyToken], backofficeObrasController.findAllObra);


    app.post("/api/obras/backoffice/v1/creaobra", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeObrasController.createObra);


    app.put("/api/obras/backoffice/v1/actualizaobra/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeObrasController.updateObra);


    app.delete("/api/obras/backoffice/v1/eliminaobra/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeObrasController.deleteObra);


    app.get("/api/obras/backoffice/v1/obras/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeObrasController.findObraById);


    app.get("/api/obras/backoffice/v1/obras", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeObrasController.findObraByCodigo);

}
/*/*********************************************************************************** */
/******* BOM ******************************************************************** */    

{ /*** BOM ** */
    app.get("/api/obras/backoffice/v1/allbom", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeBomController.findAllBom);


    app.get("/api/obras/backoffice/v1/bomporparametros", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeBomController.findBomByParametros);


    app.post("/api/obras/backoffice/v1/creabom", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeBomController.createBomMasivo);


    app.post("/api/obras/backoffice/v1/creabomindividual", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeBomController.createBomIndividual);


    app.delete("/api/obras/backoffice/v1/eliminabomporreserva/:reserva", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeBomController.deleteBomByReserva);


    app.delete("/api/obras/backoffice/v1/eliminamaterialbom/:reserva/:cod_sap", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeBomController.deleteBomByMaterial);
}

{ /*** VISITA TERRENOS ** */
  app.get("/api/obras/backoffice/v1/allvisitaterreno", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.findAllVisitaTerreno);

  app.get("/api/obras/backoffice/v1/visitaterreno", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.findVisitaTerrenoByIdObra);

  app.post("/api/obras/backoffice/v1/creavisitaterreno", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.createVisitaTerreno);

  app.put("/api/obras/backoffice/v1/actualizavisitaterreno/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.updateVisitaTerreno);
}

  app.get("/api/obras/backoffice/v1/allreportesdiarios", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.findAllEncabezadoReporteDiario);

  app.post("/api/obras/backoffice/v1/creareportediario", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.createEncabezadoReporteDiario);

  app.put("/api/obras/backoffice/v1/actualizareportediario/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.updateEncabezadoReporteDiario);

  app.delete("/api/obras/backoffice/v1/eliminareportediario/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.deleteEncabezadoReporteDiario);


  app.get("/api/obras/backoffice/v1/allreportesdiariosactividad", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.findAllDetalleReporteDiarioActividad);


  app.get("/api/obras/backoffice/v1/reportesdiariosactividadporid", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.findOneDetalleReporteDiarioActividad);

  app.get("/api/obras/backoffice/v1/reportesdiariosactividadporencabezado", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.findDetalleReporteDiarioActividadPorEncabezado);

  app.post("/api/obras/backoffice/v1/creardetalleactividad", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.createOneDetalleReporteDiarioActividad);

}


