const { authJwt } = require("../middleware");
const mantendorController = require("../controllers/comun/mantenedor.controller");

    
module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
  
    //crea un nuevo estado, se debe pasar el nombre del estado, ejemplo: { nombre: "estado" }
    app.post("/api/mantenedor/v1/creaestado", [authJwt.verifyToken, authJwt.isSistema], mantendorController.createEstado);

    //crea una nueva persona, ejemplo: { "rut": "23.567.789-1", "apellido_1": "Gonzalez", "apellido_2": "Muñoz", "nombres": "Marcela", "base": 1, "cliente": 1, "id_funcion": 1 }
    app.post("/api/mantenedor/v1/creapersona", [authJwt.verifyToken, authJwt.isSistema], mantendorController.createPersona);

    app.get("/api/mantenedor/v1/estados", [authJwt.verifyToken], mantendorController.estados);

    app.get("/api/mantenedor/v1/findallbases", [authJwt.verifyToken], mantendorController.findAllBases);

    app.get("/api/mantenedor/v1/findallclientes", [authJwt.verifyToken], mantendorController.findAllClientes);

    app.get("/api/mantenedor/v1/findalltipofuncionpersonal", [authJwt.verifyToken], mantendorController.findAllTipofuncionPersonal);

    app.get("/api/mantenedor/v1/findallpersonas", [authJwt.verifyToken], mantendorController.findAllPersonas);

    app.get("/api/mantenedor/v1/oficinas", [authJwt.verifyToken], mantendorController.oficinas);

  }; 