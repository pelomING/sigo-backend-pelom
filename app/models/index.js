// const config = require("../config/db.config.local.js");

let dbconfig = {};
if (process.env.NODE_ENV === "production") {
  dbconfig = require("../config/db.config.prod.js");
}else if(process.env.NODE_ENV === "development"){
  dbconfig = require("../config/db.config.dev.js");
}else if(process.env.NODE_ENV === "local"){
  dbconfig = require("../config/db.config.local.js");
}else{
  dbconfig = require("../config/db.config.local.js");
}

const Sequelize = require("sequelize");
const sequelize = new Sequelize(
  dbconfig.DB,
  dbconfig.USER,
  dbconfig.PASSWORD,
  {
    host: dbconfig.HOST,
    dialect: dbconfig.dialect,
    define : dbconfig.define,
    port: dbconfig.PORT,
    pool: {
      max: dbconfig.pool.max,
      min: dbconfig.pool.min,
      acquire: dbconfig.pool.acquire,
      idle: dbconfig.pool.idle
    }
  }
);

console.log(dbconfig.HOST);

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
db.estados = require("./estados.model.js")(sequelize, Sequelize);
db.eventos = require("./eventos.model.js")(sequelize, Sequelize);




module.exports = db;