const { verifySignUp } = require("../middleware");
const controller = require("../controllers/auth/auth.controller");

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
};