const db = require("../../models");
const User = db.user;
const LoginHistorial = db.loginHistorial;
const bcrypt = require("bcryptjs");
const sequelize = db.sequelize;

exports.cambioPassword = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
            #swagger.description = 'Cambio de contraseña' */
    try {

        const campos = [
            'password', 'newpassword'
          ];
          for (const element of campos) {
            if (!req.body[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };

        const id_user = req.userId;
        const user = await User.findByPk(id_user);

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

          const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
          const fecha_hoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2)

          const password = bcrypt.hashSync(req.body.newpassword, 8);


          
          let salida = {};
          const t = await sequelize.transaction();
          try 
          {
              salida = {"error": false, "message": "Contraseña cambiada correctamente!"};
              await User.update({ password: password, fecha_password: fecha_hoy }, { where: { id: req.userId }, transaction: t });
              //* almacenar el log *//
              await LoginHistorial.create({
                username: user.username,
                email: user.email,
                accion: 'Cambio Password',
                fecha_hora: fecha_hoy, 
                comentario: 'Password actualizada para el usuario ' + user.username}, { transaction: t })
              await t.commit();
          }
          catch (error) {
              salida = { error: true, message: error }
              await t.rollback();
          }
          if (salida.error) {
            res.status(500).send(salida.message);
          }else {
            //Hacer el logout para que el usuario entre nuevamente con la password nueva
            req.session = null;
            res.status(200).send(salida);
          }
    }catch (error) {
        res.status(500).send({ message: error.message });
    }
}