const mantendorController = require("../controllers/mantenedor.controller");

    
module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
  
    app.post("/api/mantenedor/v1/creaestado", mantendorController.createEstado);

    app.get("/api/mantenedor/v1/estados", mantendorController.estados);

  };