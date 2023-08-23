const reportesController = require("../controllers/reportes.controller");

module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });

    app.get("/api/reportes/v1/alljornada", reportesController.findAllJornadas);

    app.get("/api/reportes/v1/alleventos", reportesController.findAllEventos);


}
