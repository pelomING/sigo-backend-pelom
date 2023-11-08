const { verifySignUp } = require("../middleware");
const { authJwt } = require("../middleware");
const controller = require("../controllers/auth/auth.controller");
const usuariosController = require("../controllers/auth/usuarios.controller");
const autogestionController = require("../controllers/auth/autogestion.controller");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "Origin, Content-Type, Accept"
    );
    next();
  });


  // SIGN UP
  app.post(
    "/api/auth/signup",
    [
      verifySignUp.checkDuplicateUsernameOrEmail,
      verifySignUp.checkRolesExisted
    ],
    controller.signup
  );
  //********************************************************* */


  // SIGN IN
  app.post("/api/auth/signin", controller.signin);
  //********************************************************** */


  // SIGN OUT
  app.post("/api/auth/signout", controller.signout);

  //crea una nueva persona, ejemplo: { "rut": "23.567.789-1", "apellido_1": "Gonzalez", "apellido_2": "Muñoz", "nombres": "Marcela", "base": 1, "cliente": 1, "id_funcion": 1 }
  app.post("/api/usuarios/v1/creapersona", [authJwt.verifyToken, authJwt.isSistema], usuariosController.createPersona);

  app.get("/api/usuarios/v1/findallpersonas", [authJwt.verifyToken], usuariosController.findAllPersonas);

  // cambio de password, debe ingresar la password actual y la nueva
  app.post("/api/autogestion/v1/cambiapassword", [authJwt.verifyToken], autogestionController.cambioPassword);

};