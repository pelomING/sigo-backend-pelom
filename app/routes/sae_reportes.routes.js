const { authJwt } = require("../middleware");
const reportesController = require("../controllers/sae/reportes.controller");

module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
    

    /* Devuelve todos las jornadas */
    app.get("/api/reportes/v1/alljornada", [authJwt.verifyToken], reportesController.findAllJornadas);


    /* Devuelve detalle de eventos */
    app.get("/api/reportes/v1/alleventos", [authJwt.verifyToken], reportesController.findAllEventos);


    /* Devuelve el reporte de estado con los eventos asociados */
    app.get("/api/reportes/v1/allestadosresultado", [authJwt.verifyToken], reportesController.findAllEstadosResultado);


    /* Crea un estado resultado 
    ejemplo: { "id_usuario": 7, "zona": 1, "paquete": 1, "mes": 9, "fecha_inicio": "2023-09-01", "fecha_final": "2023-09-30", 
    "nombre_doc": "nombre de documento", "url_doc": "url de documento", "fecha_creacion": "2023-09-30", "fecha_modificacion": "2023-09-30", 
    "estado": 1, "eventos_relacionados": [1,2,3,4,5], "id_cliente":1 }*/
    app.post("/api/reportes/v1/creaestadoresultado", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], reportesController.creaEstadoResultado);


    /* Devuelve resumen de eventos 
    ejemplo: /api/reportes/v1/resumeneventos?id_paquete=1&fecha_inicial=2023-08-01&fecha_final=2023-09-30*/
    app.get("/api/reportes/v1/resumeneventos", [authJwt.verifyToken], reportesController.resumenEventos);


    /* Devuelve resumen de turnos 
    ejemplpo: /api/reportes/v1/resumenturnos?id_paquete=1&fecha_inicial=2023-08-01&fecha_final=2023-09-30*/
    app.get("/api/reportes/v1/resumenturnos", [authJwt.verifyToken], reportesController.resumenTurnos);


}
