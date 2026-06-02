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

  //crea un full usuario
  app.post("/api/usuarios/v1/creafullusuario", [authJwt.verifyToken, authJwt.isSistema], usuariosController.createFullUser);

  //Lista los usaruarios generales
  //app.get("/api/usuarios/v1/lista_usuarios", [authJwt.verifyToken, authJwt.isSistema], usuariosController.findAllUsuariosGeneral);
  app.get("/api/usuarios/v1/lista_usuarios", [authJwt.verifyToken, authJwt.isSistema], usuariosController.findAllUsuariosGeneral);

  app.get("/api/usuarios/v2/lista_usuarios", [authJwt.verifyToken, authJwt.isSistema], usuariosController.findAllUsuariosGeneral_V2);

  app.get("/api/usuarios/v1/lista_roles", [authJwt.verifyToken, authJwt.isSistema], usuariosController.findAllRoles);


  app.put("/api/usuarios/v1/updatefullusuario/:rut", [authJwt.verifyToken, authJwt.isSistema], usuariosController.updateFullUser);
  
  app.post("/api/usuarios/v1/desactivausuario", [authJwt.verifyToken, authJwt.isSistema], usuariosController.desactivaUser);

  app.post("/api/usuarios/v1/activausuario", [authJwt.verifyToken, authJwt.isSistema], usuariosController.activaUser);

  // cambio de password, debe ingresar la password actual y la nueva
  app.post("/api/ajustes/v1/cambiapassword", [authJwt.verifyToken], ajustesController.cambioPassword);

  //Resetea password para un usuario
  //app.post("/api/ajustes/v1/resetpassword", [authJwt.verifyToken, authJwt.isSupervisorOrAdminOrSistema], usuariosController.resetPassword);
  app.post("/api/ajustes/v1/resetpassword", usuariosController.resetPassword);

  

};