const db = require("../../models");
const User = db.user;

exports.cambioPassword = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
            #swagger.description = 'Cambio de contraseña' */
    try {

        const campos = [
            'username', 'password', 'newpassword'
          ];
          for (const element of campos) {
            if (!req.body[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };

        const user = await User.findOne({
            where: {
                username: req.body.username,
            },
        });

        if (!user) {
            return res.status(404).send({ message: "Usuario no existe." });
          }
      
          const passwordIsValid = bcrypt.compareSync(
            req.body.password,
            user.password
          );
      
          if (!passwordIsValid) {
            return res.status(401).send({
              message: "Password Incorrecta!",
            });
          };

          if (req.body.newpassword === req.body.password) {
            return res.status(401).send({
              message: "La nueva contraseña no puede ser igual a la actual!",
            });
          };

          const password = bcrypt.hashSync(req.body.newpassword, 8);

          const result = await User.update(
            { password: password },
          );

          if (result) {
            res.send({ message: "Contraseña cambiada correctamente!" });
          }else {
            res.status(500).send({ message: error.message });
          }

    }catch (error) {
        res.status(500).send({ message: error.message });
    }
}