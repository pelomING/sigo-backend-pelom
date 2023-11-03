const db = require("../../models");
const config = require("../../config/auth.config");
const User = db.user;
const Role = db.role;
const LoginHistorial = db.loginHistorial;

const Op = db.Sequelize.Op;

const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

exports.signup = async (req, res) => {
  // Save User to Database
  /*  #swagger.tags = ['Autenticación']
      #swagger.description = 'Registro de un usuariuo nuevo' */
  try {
    const user = await User.create({
      username: req.body.username,
      email: req.body.email,
      password: bcrypt.hashSync(req.body.password, 8),
    });
    if (req.body.roles) {
      const roles = await Role.findAll({
        where: {
          name: {
            [Op.or]: req.body.roles,
          },
        },
      });
      const result = user.setRoles(roles);
      if (result) res.send({ message: "User registered successfully!" });
    } else {
      // user has role = 1
      const result = user.setRoles([1]);
      if (result) res.send({ message: "User registered successfully!" });
    }
  } catch (error) {
    res.status(500).send({ message: error.message });
    
  }
};

exports.signin = async (req, res) => {
  /*  #swagger.tags = ['Autenticación']
      #swagger.description = 'Login de usuario' */
  try {
    const c = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"});
    const fechoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12)
  

    const user = await User.findOne({
      where: {
        username: req.body.username,
      },
    });

    if (!user) {
      return res.status(404).send({ message: "User Not found." });
    }

    const passwordIsValid = bcrypt.compareSync(
      req.body.password,
      user.password
    );

    if (!passwordIsValid) {
      return res.status(401).send({
        message: "Invalid Password!",
      });
    }

    const token = jwt.sign({ id: user.id },
                           config.secret,
                           {
                            algorithm: 'HS256',
                            allowInsecureKeySizes: true,
                            expiresIn: 86400, // 24 hours
                           });

    let authorities = [];
    const roles = await user.getRoles();
    for (const element of roles) {
      authorities.push("ROLE_" + element.name.toUpperCase());
    }

    req.session.token = token;

    //* almacenar el log *//
    const loginHistorial = await LoginHistorial.create({
      username: user.username,
      email: user.email,
      accion: 'Login',
      fecha_hora: fechoy
    }).then(data => {
      console.log('ok');
    }).catch(err => {
      console.log('err', err);
    })

    return res.status(200).send({
      id: user.id,
      username: user.username,
      email: user.email,
      roles: authorities,
      accessToken: token
    });
  } catch (error) {
    if (error.message === "connect ECONNREFUSED ::1:5432") {
      return res.status(400).send({
        message: "No hay conexión a la base de datos",
      });
    } else {
      return res.status(500).send({ message: error.message });
    }
  }
};

exports.signout = async (req, res) => {
  /*  #swagger.tags = ['Autenticación']
      #swagger.description = 'Logout de usuario' */
  try {
    //console.log("req.session", req);
    req.session = null;
    return res.status(200).send({
      message: "You've been signed out!"
    });
  } catch (err) {
    this.next(err);
  }
};