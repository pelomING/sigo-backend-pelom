const jwt = require("jsonwebtoken");
const config = require("../config/auth.config.js");
const db = require("../models");
const User = db.user;

let verifyToken = (req, res, next) => {
  let token = req.session.token;

  if (!token) {
    return res.status(403).send({
      error: true,
      message: "No está autenticado",
    });
  }

  jwt.verify(token,
             config.secret,
             (err, decoded) => {
              if (err) {
                return res.status(401).send({
                  error: true,
                  message: "No autorizado!",
                });
              }
              req.userId = decoded.id;
              next();
             });
};

let isAdmin = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.userId);
    const roles = await user.getRoles();

    for (const element of roles) {
      if (element.name === "admin") {
        return next();
      }
    }

    return res.status(403).send({
      error: true,
      message: "Debe ser Administrador",
    });
  } catch (error) {
    return res.status(500).send({
      error: true,
      message: "No es posible validar el rol",
    });
  }
};


let isSistema = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.userId);
    const roles = await user.getRoles();

    for (const element of roles) {
      if (element.name === "sistema") {
        return next();
      }
    }

    return res.status(403).send({
      error: true,
      message: "Debe ser usuario de Sistema",
    });
  } catch (error) {
    return res.status(500).send({
      error: true,
      message: "No es posible validar el rol",
    });
  }
};

let isTecnico = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.userId);
    const roles = await user.getRoles();

    for (const element of roles) {
      if (element.name === "tecnico") {
        return next();
      }
    }

    return res.status(403).send({
      error: true,
      message: "Debe ser Tecnico",
    });
  } catch (error) {
    return res.status(500).send({
      error: true,
      message: "No es posible determinar el rol",
    });
  }
};

let isSupervisor = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.userId);
    const roles = await user.getRoles();

    for (const element of roles) {
      if (element.name === "supervisor") {
        return next();
      }
    }

    return res.status(403).send({
      error: true,
      message: "Debe ser Supervisor",
    });
  } catch (error) {
    return res.status(500).send({
      error: true,
      message: "No es posible determinar el rol",
    });
  }
};


let isSupervisorOrAdmin = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.userId);
    const roles = await user.getRoles();

    for (const element of roles) {
      if (element.name === "supervisor") {
        return next();
      }

      if (element.name === "admin" || element.name === "adminsae") {
        return next();
      }
    }

    return res.status(403).send({
      message: "Debe ser Supervisor o Administrador!",
    });
  } catch (error) {
    return res.status(500).send({
      message: "No es posible determinar el rol",
    });
  }
};


let isSupervisorOrAdminOrSistema = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.userId);
    const roles = await user.getRoles();

    for (const element of roles) {
      if (element.name === "supervisor") {
        return next();
      }

      if (element.name === "admin") {
        return next();
      }

      if (element.name === "sistema") {
        return next();
      }
    }

    return res.status(403).send({
      message: "Debe ser Supervisor o Administrador o Sistema!",
    });
  } catch (error) {
    return res.status(500).send({
      message: "No es posible determinar el rol",
    });
  }
};


const authJwt = {
  verifyToken,
  isAdmin,
  isTecnico,
  isSistema,
  isSupervisor,
  isSupervisorOrAdmin,
  isSupervisorOrAdminOrSistema
};
module.exports = authJwt;