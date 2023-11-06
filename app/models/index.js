// const config = require("../config/db.config.local.js");
const {ConnectionString} = require('connection-string');

let dbconfig = {};
/*
if (process.env.NODE_ENV === "production") {
  dbconfig = require("../config/db.config.prod.js");
}else if(process.env.NODE_ENV === "development"){
  dbconfig = require("../config/db.config.dev.js");
}else if(process.env.NODE_ENV === "local"){
  dbconfig = require("../config/db.config.local.js");
}else{
  dbconfig = require("../config/db.config.local.js");
}
*/
dbconfig = require("../config/db.config.js");

console.log('process.env.DATABASE_URL', process.env.DATABASE_URL);
console.log('process.env.DATABASE_NAME', process.env.DATABASE_NAME)

const database_url = process.env.DATABASE_URL;
const write_uri = new ConnectionString(database_url);

if (database_url){
  console.log('user:', write_uri.user)
  console.log('password:', write_uri.password)
  console.log('host:', write_uri.hostname)
  console.log('port:', write_uri.port)
  console.log('db:', write_uri.path[0])

  dbconfig.DB = process.env.DATABASE_NAME;
  dbconfig.USER = write_uri.user;
  dbconfig.PASSWORD = write_uri.password;
  dbconfig.HOST = write_uri.hostname;
  dbconfig.PORT = write_uri.port;
}

//const connDB = write_uri.path[0];
//dbconfig.DB = connDB;
//console.log('connDB', connDB);

const Sequelize = require("sequelize");
const sequelize = new Sequelize(
  dbconfig.DB,
  dbconfig.USER,
  dbconfig.PASSWORD,
  {
    url: dbconfig.url,
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


console.log('write_uri', write_uri);

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

/****** MODELOS */
/*****  AUTH */
db.personas = require("./auth/personas.model.js")(sequelize, Sequelize);
db.user = require("./auth/user.model.js")(sequelize, Sequelize);
db.role = require("./auth/role.model.js")(sequelize, Sequelize);
db.loginHistorial = require("./auth/loginHistorial.model.js")(sequelize, Sequelize);
db.verificaAuth = require("./auth/verificaAuth.model.js")(sequelize, Sequelize);

db.role.belongsToMany(db.user, {
  through: "user_roles"
});
db.user.belongsToMany(db.role, {
  through: "user_roles"
});

db.ROLES = ["user", "admin", "moderator", "tecnico", "supervisor", "sistema"];



/*****  COMUN */
db.base = require("./comun/base.model.js")(sequelize, Sequelize);
db.cliente = require("./comun/cliente.model.js")(sequelize, Sequelize);
db.comuna = require("./comun/comuna.model.js")(sequelize, Sequelize);
db.eventosTipo = require("./comun/eventosTipo.model.js")(sequelize, Sequelize);
db.paquete = require("./comun/paquete.model.js")(sequelize, Sequelize);
db.tipoFuncionPersonal = require("./comun/tipoFuncionPersonal.model.js")(sequelize, Sequelize);
db.turnos = require("./comun/turnos.model.js")(sequelize, Sequelize);
db.zonal = require("./comun/zonal.model.js")(sequelize, Sequelize);

/*****  OBRAS */
db.bom = require("./obras/bom.model.js")(sequelize, Sequelize);
db.coordinadorContratista = require("./obras/coordinadorContratista.model.js")(sequelize, Sequelize);
db.delegacion = require("./obras/delegacion.model.js")(sequelize, Sequelize);
db.detalleReporteDiarioActividad = require("./obras/detalleReporteDiarioActividad.model.js")(sequelize, Sequelize);
db.empresaContratista = require("./obras/empresaContratista.model.js")(sequelize, Sequelize);
db.encabezadoReporteDiario = require("./obras/encabezadoReporteDiario.model.js")(sequelize, Sequelize);
db.estadoObra = require("./obras/estadoObra.model.js")(sequelize, Sequelize);
db.estadoVisita = require("./obras/estadoVisita.model.js")(sequelize, Sequelize);
db.maestroActividad = require("./obras/maestroActividad.model.js")(sequelize, Sequelize);
db.obra = require("./obras/obra.model.js")(sequelize, Sequelize);
db.segmento = require("./obras/segmento.model.js")(sequelize, Sequelize);
db.tipoActividad = require("./obras/tipoActividad.model.js")(sequelize, Sequelize);
db.tipoObra = require("./obras/tipoObra.model.js")(sequelize, Sequelize);
db.tipoOperacion = require("./obras/tipoOperacion.model.js")(sequelize, Sequelize);
db.tipoTrabajo = require("./obras/tipoTrabajo.model.js")(sequelize, Sequelize);
db.visitaTerreno = require("./obras/visitaTerreno.model.js")(sequelize, Sequelize);


/*****  SAE */
db.cargoFijo = require("./sae/cargoFijo.model.js")(sequelize, Sequelize);
db.detalleEstadoResultado = require("./sae/detalleEstadoResultado.model.js")(sequelize, Sequelize);
db.estadoResultado = require("./sae/estadoResultado.model.js")(sequelize, Sequelize);
db.estados = require("./sae/estados.model.js")(sequelize, Sequelize);
db.eventos = require("./sae/eventos.model.js")(sequelize, Sequelize);
db.jornada = require("./sae/jornada.model.js")(sequelize, Sequelize);
db.preciosBase = require("./sae/preciosBase.model.js")(sequelize, Sequelize);

module.exports = db;