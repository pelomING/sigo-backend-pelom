const config = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(
  config.DB,
  config.USER,
  config.PASSWORD,
  {
    host: config.HOST,
    dialect: config.dialect,
    define : config.define,
    pool: {
      max: config.pool.max,
      min: config.pool.min,
      acquire: config.pool.acquire,
      idle: config.pool.idle
    }
  }
);0

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.user = require("../models/user.model.js")(sequelize, Sequelize);
db.role = require("../models/role.model.js")(sequelize, Sequelize);

db.role.belongsToMany(db.user, {
  through: "user_roles"
});
db.user.belongsToMany(db.role, {
  through: "user_roles"
});

db.ROLES = ["user", "admin", "moderator", "tecnico", "supervisor", "sistema"];

db.base = require("./base.model.js")(sequelize, Sequelize);
db.cargoFijo = require("./cargoFijo.model.js")(sequelize, Sequelize);
db.cliente = require("./cliente.model.js")(sequelize, Sequelize);
db.eventosTipo = require("./eventosTipo.model.js")(sequelize, Sequelize);
db.paquete = require("./paquete.model.js")(sequelize, Sequelize);
db.personas = require("./personas.model.js")(sequelize, Sequelize);
db.preciosBase = require("./preciosBase.model.js")(sequelize, Sequelize);
db.tipoFuncionPersonal = require("./tipoFuncionPersonal.model.js")(sequelize, Sequelize);
db.turnos = require("./turnos.model.js")(sequelize, Sequelize);
db.zonal = require("./zonal.model.js")(sequelize, Sequelize);




module.exports = db;