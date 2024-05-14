const { verifySignUp } = require("../middleware");
const { authJwt } = require("../middleware");
const controller = require("../controllers/auth/auth.controller");
const usuariosController = require("../controllers/auth/usuarios.controller");
const ajustesController = require("../controllers/auth/ajustes.controller");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "Origin, Content-Type, Accept"
    );
    next();
  });


  // SIGN UP
  app.post("/api/auth/signup", [verifySignUp.checkDuplicateUsernameOrEmail,verifySignUp.checkRolesExisted], controller.signup);
  //********************************************************* */


  // SIGN IN
  app.post("/api/auth/signin", controller.signin);
  //********************************************************** */


  // SIGN OUT
  app.post("/api/auth/signout", controller.signout);

  //crea una nueva persona, ejemplo: { "rut": "23.567.789-1", "apellido_1": "Gonzalez", "apellido_2": "Muñoz", "nombres": "Marcela", "base": 1, "cliente": 1, "id_funcion": 1 }
  app.post("/api/usuarios/v1/creapersona", [authJwt.verifyToken, authJwt.isSistema], usuariosController.createPersona);

  //crea un nuevo usuario
  app.post("/api/usuarios/v1/creausuario", [authJwt.verifyToken, authJwt.isSistema], usuariosController.createUser);

  // cambio de password, debe ingresar la password actual y la nueva
  app.post("/api/ajustes/v1/cambiapassword", [authJwt.verifyToken], ajustesController.cambioPassword);

  //Resetea password para un usuario
  app.post("/api/ajustes/v1/resetpassword", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], usuariosController.resetPassword);

};