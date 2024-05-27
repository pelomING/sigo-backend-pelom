const { authJwt } = require("../middleware");
const uploadJs = require("../middleware/upload");
const backofficeGeneralController = require("../controllers/obras/backoffice.general.controller");
const backofficeObrasController = require("../controllers/obras/backoffice.obras.controller");
const backofficeBomController = require("../controllers/obras/backoffice.bom.controller");
const backofficeTerrenoController = require("../controllers/obras/backoffice.terreno.controller");
const backofficeRepodiarioController = require("../controllers/obras/backoffice.repodiario.controller");
const backofficeEstadopagoController = require("../controllers/obras/backoffice.estadopago.controller");
const backofficeUsoController = require("../controllers/obras/backoffice.usosistema.controller");

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

    
    app.get("/api/obras/backoffice/general/v1/resumengeneral", [authJwt.verifyToken], backofficeGeneralController.getResumenGeneral);

    app.get("/api/obras/backoffice/general/v1/allusuarios", [authJwt.verifyToken], backofficeGeneralController.findAllUsuariosFunciones);

    app.get("/api/obras/backoffice/general/v1/allmaestromaterial", [authJwt.verifyToken], backofficeGeneralController.findAllMaestroMateriales);

    

}
/*/*********************************************************************************** */
/******* OBRAS ******************************************************************** */    

{/*** OBRAS ***  */
    app.get("/api/obras/backoffice/v1/allobras", [authJwt.verifyToken], backofficeObrasController.findAllObra);


    app.post("/api/obras/backoffice/v1/creaobra", [authJwt.verifyToken, authJwt.createObrasBackofficeObras], backofficeObrasController.createObra);


    app.put("/api/obras/backoffice/v1/actualizaobra/:id", [authJwt.verifyToken, authJwt.updateObrasBackofficeObras], backofficeObrasController.updateObra);


    app.delete("/api/obras/backoffice/v1/eliminaobra/:id", [authJwt.verifyToken, authJwt.deleteObrasBackofficeObras], backofficeObrasController.deleteObra);

    app.post("/api/obras/backoffice/v1/paralizaobra", [authJwt.verifyToken, authJwt.createObrasBackofficeObras], backofficeObrasController.paralizaObra);

    app.post("/api/obras/backoffice/v1/cierraobra", [authJwt.verifyToken, authJwt.createObrasBackofficeObras], backofficeObrasController.cierreObra);


    app.get("/api/obras/backoffice/v1/obras/:id", [authJwt.verifyToken, authJwt.readObrasBackofficeObras], backofficeObrasController.findObraById);


    app.get("/api/obras/backoffice/v1/obras", [authJwt.verifyToken, authJwt.readObrasBackofficeObras], backofficeObrasController.findObraByCodigo);

    /* Obtiene el código de obra en caso de que sea de tipo emergencia*/
    app.get("/api/obras/backoffice/v1/codigodeobraemergencia", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeObrasController.getCodigoObraEmergencia);

    /* Obtiene el resumen informartivo de obras*/
    app.get("/api/obras/backoffice/v1/resumenobras", [authJwt.verifyToken, authJwt.readObrasBackofficeObras], backofficeObrasController.getResumenObras);


}
/*/*********************************************************************************** */
/******* BOM ******************************************************************** */    

{ /*** BOM ** */
    //app.get("/api/obras/backoffice/v1/allbom", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.findAllBom);
    //app.get("/api/obras/backoffice/v1/bomporparametros", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.findBomByParametros);

    app.get("/api/obras/backoffice/v1/allobrasparabom", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getAllObrasParaBom);
    app.get("/api/obras/backoffice/v1/solicitudesmaterialporobra", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getPedidosPorObra);
    app.get("/api/obras/backoffice/v1/obtiene_numero_solicitud", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getNumeroPedido);
    app.post("/api/obras/backoffice/v1/creasolicitudmaterial", [authJwt.verifyToken, authJwt.createObrasBackofficeBom], backofficeBomController.createPedidoMaterial);
    app.get("/api/obras/backoffice/v1/materialesporsolicitud", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getMaterialPorPedido);
    app.get("/api/obras/backoffice/v1/totalmaterialsolicitadoporobra", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getTotalMaterialSolicitadoPorObra);
    app.get("/api/obras/backoffice/v1/totalmaterialreservadoporobra", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getTotalMaterialReservadoPorObra);

    app.put("/api/obras/backoffice/v1/actualizasolicitud", [authJwt.verifyToken, authJwt.updateObrasBackofficeBom], backofficeBomController.generaOcancelaSolicitud);
    app.get("/api/obras/backoffice/v1/reservasporobra", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getReservasPorObra);
    app.post("/api/obras/backoffice/v2/creabom", [authJwt.verifyToken, authJwt.createObrasBackofficeBom], backofficeBomController.createBomMasivo_v2);
    app.post("/api/obras/backoffice/v1/reserva_upload", [authJwt.verifyToken, authJwt.createObrasBackofficeBom, uploadJs.upload.single('file')], backofficeBomController.createBomFromExcel);
    app.get("/api/obras/backoffice/v1/materialesporreserva", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getMaterialPorReserva);
    app.get("/api/obras/backoffice/v1/bom_inicial_por_obra", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getBomZero);
    app.get("/api/obras/backoffice/v1/bom_actual_por_obra", [authJwt.verifyToken, authJwt.readObrasBackofficeBom], backofficeBomController.getBomFinal);

    app.post("/api/obras/backoffice/v1/crealistafaena", [authJwt.verifyToken, authJwt.createObrasBackofficeBom], backofficeBomController.createListaFaena);

    //app.post("/api/obras/backoffice/v1/creabom", [authJwt.verifyToken, authJwt.createObrasBackofficeBom], backofficeBomController.createBomMasivo);
    //app.post("/api/obras/backoffice/v1/creabomindividual", [authJwt.verifyToken, authJwt.createObrasBackofficeBom], backofficeBomController.createBomIndividual);
    //app.delete("/api/obras/backoffice/v1/eliminabomporreserva/:reserva", [authJwt.verifyToken, authJwt.deleteObrasBackofficeBom], backofficeBomController.deleteBomByReserva);
    //app.delete("/api/obras/backoffice/v1/eliminamaterialbom/:reserva/:cod_sap", [authJwt.verifyToken, authJwt.deleteObrasBackofficeBom], backofficeBomController.deleteBomByMaterial);
}

{ /*** VISITA TERRENOS ** */
  app.get("/api/obras/backoffice/v1/allvisitaterreno", [authJwt.verifyToken, authJwt.readObrasBackofficeTerreno], backofficeTerrenoController.findAllVisitaTerreno);

  app.get("/api/obras/backoffice/v1/visitaterreno", [authJwt.verifyToken, authJwt.readObrasBackofficeTerreno], backofficeTerrenoController.findVisitaTerrenoByIdObra);

  app.post("/api/obras/backoffice/v1/creavisitaterreno", [authJwt.verifyToken, authJwt.createObrasBackofficeTerreno], backofficeTerrenoController.createVisitaTerreno);

  app.put("/api/obras/backoffice/v1/actualizavisitaterreno/:id", [authJwt.verifyToken, authJwt.updateObrasBackofficeTerreno], backofficeTerrenoController.updateVisitaTerreno);

  app.delete("/api/obras/backoffice/v1/eliminavisitaterreno/:id", [authJwt.verifyToken, authJwt.deleteObrasBackofficeTerreno], backofficeTerrenoController.deleteVisitaTerreno)
}

{/*** REPORTES DIARIOS ** */

    app.get("/api/obras/backoffice/repodiario/v1/allreportesdiarios", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllEncabezadoReporteDiario);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosporparametros", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllEncabezadoReporteDiarioByParametros);

    /*********************************************************************************** */
/* Consulta el ultimo de encabezado de reporte diario
*/
    app.get("/api/obras/backoffice/repodiario/v1/ultimoreportediario", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findUltimoEncabezadoReporteDiarioByIdObra);

    app.post("/api/obras/backoffice/repodiario/v1/creareportediario", [authJwt.verifyToken, authJwt.createObrasBackofficeRepodiario], backofficeRepodiarioController.createEncabezadoReporteDiario_V2);

    app.put("/api/obras/backoffice/repodiario/v1/actualizareportediario/:id", [authJwt.verifyToken, authJwt.updateObrasBackofficeRepodiario], backofficeRepodiarioController.updateEncabezadoReporteDiario_V2);

    app.delete("/api/obras/backoffice/repodiario/v1/eliminareportediario/:id", [authJwt.verifyToken, authJwt.deleteObrasBackofficeRepodiario], backofficeRepodiarioController.deleteEncabezadoReporteDiario);

    app.get("/api/obras/backoffice/repodiario/v1/allreportesdiariosactividad", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllDetalleReporteDiarioActividad);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosactividadporid", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findOneDetalleReporteDiarioActividad);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosactividadporparametros", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findDetalleReporteDiarioActividadPorParametros);

    app.get("/api/obras/backoffice/repodiario/v1/reportesdiariosotrosporparametros", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findDetalleReporteDiarioOtrasPorParametros);

    app.get("/api/obras/backoffice/repodiario/v1/alljefesfaena", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllJefesFaena);

    app.get("/api/obras/backoffice/repodiario/v1/alltipooperacion", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllTipoOperacion);

    app.get("/api/obras/backoffice/repodiario/v1/alltipoactividad", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllTipoActividad);

    app.get("/api/obras/backoffice/repodiario/v1/allmaestroactividad", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllMaestroActividad);

    app.get("/api/obras/backoffice/repodiario/v1/allareas", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllTipoTrabajo);

    app.get("/api/obras/backoffice/repodiario/v1/allrecargoshora", [authJwt.verifyToken, authJwt.readObrasBackofficeRepodiario], backofficeRepodiarioController.findAllRecargosHoraExtra);

}


///****************************************** Estado de Pago      */

    // Obtiene todos los tipos de recargo
    app.get("/api/obras/backoffice/estadopago/v1/alltiporecargo", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.findAllTipoRecargo);

    // Obtiene todos los Recargos
    app.get("/api/obras/backoffice/estadopago/v1/allrecargos", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.findAllRecargo);

    // Genera un nuevo encabezado para estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/nuevoencabezado", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.generaNuevoEncabezadoEstadoPago);

    // Obtiene todas las actividades no adicionales para un estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/allactividadesporobra", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.getAllActividadesByIdObra);

    // Obtiene todas las actividades adicionales para un estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/allactividadesadicionales", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.getAllActividadesAdicionalesByIdObra);

    // Obtiene todas las actividades adicionales y normales que tengan hora extra para un estado de pago
    app.get("/api/obras/backoffice/estadopago/v1/allactividadesconhoraextra", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.getAllActividadesHoraExtraByIdObra);

    /* Obtiene la explicación de los recargos en hora extra
    GET /api/obras/backoffice/estadopago/v1/getallrecargoextra*/
    app.get("/api/obras/backoffice/estadopago/v1/getallrecargoextra", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.getAllRecargoExtra);

    // Obtiene la tabla de los avances de estado de pago
    //GET /api/obras/backoffice/estadopago/v1/avancesestadopago
    app.get("/api/obras/backoffice/estadopago/v1/avancesestadopago", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.avancesEstadoPago);


    // Obtiene Los totales y subtotales de acuerdo a lo que viene de los detalles de actividades
    //GET /api/obras/backoffice/estadopago/v1/totalesestadopago
    app.get("/api/obras/backoffice/estadopago/v1/totalesestadopago", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.totalesEstadoPago);

    // Graba un estado de pago
    app.post("/api/obras/backoffice/estadopago/v1/creaestadopago", [authJwt.verifyToken, authJwt.createObrasBackofficeEstadoPago], backofficeEstadopagoController.creaEstadoPago);

    // Lista los estados de pago por id_obra  GET /api/obras/backoffice/estadopago/v1/listaestadospago
    app.get("/api/obras/backoffice/estadopago/v1/listaestadospago", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.getAllEstadosPagoByIdObra);

    // Obtiene todos los datos para completar un informe de estado de pago historico por id del estado de pago
    //GET /api/obras/backoffice/estadopago/v1/historicoestadopagoporid
    app.get("/api/obras/backoffice/estadopago/v1/historicoestadopagoporid", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.getHistoricoEstadosPagoByIdEstadoPago);

    // Actualiza los datos de un estado de pago gestionado para facturación
    // PUT /api/obras/backoffice/estadopago/v1/updateEstadoPagoGestionado
    app.put("/api/obras/backoffice/estadopago/v1/updateEstadoPagoGestionado/:id", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.updateEstadoPagoGestionado);

    // Lista todos los estados de pago gestionados
    // GET /api/obras/backoffice/estadopago/v1/allestadospagogestion
    app.get("/api/obras/backoffice/estadopago/v1/allestadospagogestion", [authJwt.verifyToken, authJwt.readObrasBackofficeEstadoPago], backofficeEstadopagoController.allestadospagogestion);

    // Elimina un estado de pago
    // DELETE /api/obras/backoffice/estadopago/v1/borraestadopago
    app.delete("/api/obras/backoffice/estadopago/v1/borraestadopago/:id", [authJwt.verifyToken, authJwt.deleteObrasBackofficeEstadoPago], backofficeEstadopagoController.borraEstadoPago);


///****************************************** Uso del Sistema ***********************      */

    // Lista un resumen de los login hechos en el sistema dentro de un período
    // GET /api/obras/backoffice/usosistema/v1/alllogin
    app.get("/api/obras/backoffice/usosistema/v1/alllogin", [authJwt.verifyToken], backofficeUsoController.getAllLoginSistema);


    // Lista un resumen del ingreso de obras en el sistema en los dias recientes
    // GET /api/obras/backoffice/usosistema/v1/resumenobrasrecientes
    app.get("/api/obras/backoffice/usosistema/v1/resumenobrasrecientes", [authJwt.verifyToken], backofficeUsoController.getObrasIngresadasResumen);

    // Lista cantidad de obras sin reporte recietes
    // GET /api/obras/backoffice/usosistema/v1/resumenobrasinreportes
    app.get("/api/obras/backoffice/usosistema/v1/resumenobrasinreportes", [authJwt.verifyToken], backofficeUsoController.getObrasSinRepDiario);

    //Lista de los reportes diarios en los últimos días
    // GET /api/obras/backoffice/usosistema/v1/reportesdiarios_pordia
    app.get("/api/obras/backoffice/usosistema/v1/reportesdiarios_pordia", [authJwt.verifyToken], backofficeUsoController.getReportesDiariosPorDia);

    //Lista de los cambios realizados al programa
    // GET /api/obras/backoffice/usosistema/v1/changelog
    app.get("/api/obras/backoffice/usosistema/v1/changelog", [authJwt.verifyToken], backofficeUsoController.getChangeLog);

}