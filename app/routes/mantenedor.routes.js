const mantendorController = require("../controllers/mantenedor.controller");
const movilController = require("../controllers/movil.controller");

    
module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
  
    app.post("/api/mantenedor/v1/creaestado", mantendorController.createEstado);

    app.post("/api/mantenedor/v1/creapersona", mantendorController.createPersona);

    app.get("/api/mantenedor/v1/estados", mantendorController.estados);

    app.get("/api/mantenedor/v1/findallbases", mantendorController.findAllBases);

    app.get("/api/mantenedor/v1/findallclientes", mantendorController.findAllClientes);

    app.get("/api/mantenedor/v1/findalltipofuncionpersonal", mantendorController.findAllTipofuncionPersonal);

    app.get("/api/mantenedor/v1/findallpersonas", mantendorController.findAllPersonas);

    app.get("/api/mantenedor/v1/oficinas", movilController.bases);

  };