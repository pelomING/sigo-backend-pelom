const { authJwt } = require("../middleware");
const backofficeGeneralController = require("../controllers/obras/backoffice.general.controller");
const backofficeObrasController = require("../controllers/obras/backoffice.obras.controller");
const backofficeBomController = require("../controllers/obras/backoffice.bom.controller");
const backofficeTerrenoController = require("../controllers/obras/backoffice.terreno.controller");
const backofficeRepodiarioController = require("../controllers/obras/backoffice.repodiario.controller");
const backofficeEstadopagoController = require("../controllers/obras/backoffice.estadopago.controller");

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
    app.get("/api/obras/backoffice/general/v1/alltipoobras", [authJwt.verifyToken], backofficeGeneralController.findAllTipoObra);


    app.get("/api/obras/backoffice/general/v1/alltipoperacion", [authJwt.verifyToken], backofficeGeneralController.findAllTipoOperacion);


    app.get("/api/obras/backoffice/general/v1/alltipoactividad", [authJwt.verifyToken], backofficeGeneralController.findAllTipoActividad);


    app.get("/api/obras/backoffice/general/v1/allmaestroactividad", [authJwt.verifyToken], backofficeGeneralController.findAllMaestroActividad);


    app.get("/api/obras/backoffice/general/v1/maestroactividadporid", [authJwt.verifyToken], backofficeGeneralController.findOneMaestroActividad);


    app.get("/api/obras/backoffice/general/v1/maestroactividadporactividad", [authJwt.verifyToken], backofficeGeneralController.findAllMaestroActividadActividad);


    app.get("/api/obras/backoffice/general/v1/allzonales", [authJwt.verifyToken], backofficeGeneralController.findAllZonal);


    app.get("/api/obras/backoffice/general/v1/alldelegaciones", [authJwt.verifyToken], backofficeGeneralController.findAllDelegacion);


    app.get("/api/obras/backoffice/general/v1/alltipotrabajos", [authJwt.verifyToken], backofficeGeneralController.findAllTipoTrabajo);


    app.get("/api/obras/backoffice/general/v1/allempresacontratistas", [authJwt.verifyToken], backofficeGeneralController.findAllEmpresaContratista);


    app.get("/api/obras/backoffice/general/v1/allcoordinadorcontratistas", [authJwt.verifyToken], backofficeGeneralController.findAllCoordinadorContratista);


    app.get("/api/obras/backoffice/general/v1/allcomunas", [authJwt.verifyToken], backofficeGeneralController.findAllComuna);


    app.get("/api/obras/backoffice/general/v1/allestados", [authJwt.verifyToken], backofficeGeneralController.findAllEstadoObra);


    app.get("/api/obras/backoffice/general/v1/allestadovisitas", [authJwt.verifyToken], backofficeGeneralController.findAllEstadoVisita);


    app.get("/api/obras/backoffice/general/v1/allsegmentos", [authJwt.verifyToken], backofficeGeneralController.findAllSegmento);


    app.get("/api/obras/backoffice/general/v1/alloficinasupervisor", [authJwt.verifyToken], backofficeGeneralController.findAllOficinas);

    app.get("/api/obras/backoffice/general/v1/allrecargospordistancia", [authJwt.verifyToken], backofficeGeneralController.findAllRecargosDistancia);

    

}
/*/*********************************************************************************** */
/******* OBRAS ******************************************************************** */    

{/*** OBRAS ***  */
    app.get("/api/obras/backoffice/v1/allobras", [authJwt.verifyToken], backofficeObrasController.findAllObra);


    app.post("/api/obras/backoffice/v1/creaobra", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeObrasController.createObra);


    app.put("/api/obras/backoffice/v1/actualizaobra/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeObrasController.updateObra);


    app.delete("/api/obras/backoffice/v1/eliminaobra/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeObrasController.deleteObra);


    app.get("/api/obras/backoffice/v1/obras/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeObrasController.findObraById);


    app.get("/api/obras/backoffice/v1/obras", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeObrasController.findObraByCodigo);

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
  app.get("/api/obras/backoffice/v1/allvisitaterreno", [authJwt.verifyToken, authJwt.readObrasBackofficeTerreno], backofficeTerrenoController.findAllVisitaTerreno);

  app.get("/api/obras/backoffice/v1/visitaterreno", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.findVisitaTerrenoByIdObra);

  app.post("/api/obras/backoffice/v1/creavisitaterreno", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.createVisitaTerreno);

  app.put("/api/obras/backoffice/v1/actualizavisitaterreno/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeTerrenoController.updateVisitaTerreno);
}

{/*** REPORTES DIARIOS ** */

    app.get("/api/obras/backoffice/repodiario/v1/allreportesdiarios", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllEncabezadoReporteDiario);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosporparametros", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllEncabezadoReporteDiarioByParametros);

    app.post("/api/obras/backoffice/repodiario/v1/creareportediario", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.createEncabezadoReporteDiario_V2);

    app.put("/api/obras/backoffice/repodiario/v1/actualizareportediario/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.updateEncabezadoReporteDiario_V2);

    app.delete("/api/obras/backoffice/repodiario/v1/eliminareportediario/:id", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.deleteEncabezadoReporteDiario);

    app.get("/api/obras/backoffice/repodiario/v1/allreportesdiariosactividad", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllDetalleReporteDiarioActividad);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosactividadporid", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findOneDetalleReporteDiarioActividad);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosactividadporparametros", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findDetalleReporteDiarioActividadPorParametros);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosotrosporparametros", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findDetalleReporteDiarioOtrasPorParametros);

    //app.post("/api/obras/backoffice/repodiario/v1/creardetalleactividad", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], backofficeRepodiarioController.createOneDetalleReporteDiarioActividad);

    app.get("/api/obras/backoffice/repodiario/v1/alljefesfaena", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllJefesFaena);

    app.get("/api/obras/backoffice/repodiario/v1/alltipooperacion", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllTipoOperacion);

    app.get("/api/obras/backoffice/repodiario/v1/alltipoactividad", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllTipoActividad);

    app.get("/api/obras/backoffice/repodiario/v1/allmaestroactividad", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllMaestroActividad);

    app.get("/api/obras/backoffice/repodiario/v1/allareas", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllTipoTrabajo);

    app.get("/api/obras/backoffice/repodiario/v1/allrecargoshora", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeRepodiarioController.findAllRecargosHoraExtra);

}


///****************************************** Estado de Pago      */

    // Obtiene todos los tipos de recargo
    app.get("/api/obras/backoffice/estadopago/v1/alltiporecargo", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.findAllTipoRecargo);

    // Obtiene todos los Recargos
    app.get("/api/obras/backoffice/estadopago/v1/allrecargos", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.findAllRecargo);

    // Genera un nuevo encabezado para estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/nuevoencabezado", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.generaNuevoEncabezadoEstadoPago);

    // Obtiene todas las actividades no adicionales para un estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/allactividadesporobra", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.getAllActividadesByIdObra);

    // Obtiene todas las actividades adicionales para un estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/allactividadesadicionales", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.getAllActividadesAdicionalesByIdObra);

    // Obtiene todas las actividades adicionales y normales que tengan hora extra para un estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/allactividadesconhoraextra", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.getAllActividadesHoraExtraByIdObra);

    // Obtiene la tabla de los avances de estado de pago
    //GET /api/obras/backoffice/estadopago/v1/avancesestadopago
    app.get("/api/obras/backoffice/estadopago/v1/avancesestadopago", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.avancesEstadoPago);


    // Obtiene Los totales y subtotales de acuerdo a lo que viene de los detalles de actividades
    //GET /api/obras/backoffice/estadopago/v1/totalesestadopago
    app.get("/api/obras/backoffice/estadopago/v1/totalesestadopago", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.totalesEstadoPago);

    // Graba un estado de pago
    app.post("/api/obras/backoffice/estadopago/v1/creaestadopago", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.creaEstadoPago);

    // Lista los estados de pago por id_obra  GET /api/obras/backoffice/estadopago/v1/listaestadospago
    app.get("/api/obras/backoffice/estadopago/v1/listaestadospago", [authJwt.verifyToken, authJwt.isSupervisorOrAdminObrasOrSistema], backofficeEstadopagoController.getAllEstadosPagoByIdObra);


}