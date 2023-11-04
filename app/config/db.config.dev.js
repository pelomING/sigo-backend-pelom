module.exports = {
    HOST: "containers-us-west-195.railway.app",
    USER: "postgres",
    PORT: 7921,
    PASSWORD: "oHSOIS08dgl0m9L1WGSR",
    DB: "pelom-db",
    url: "postgres://postgres:oHSOIS08dgl0m9L1WGSR@containers-us-west-195.railway.app:7921/pelom-db",
    dialect: "postgres",
    define: {
      id: false,  // disable default id
      freezeTableName: true,  // deshabilita el agregar una 's' al final del nombre de tabla
      createdAt: false, // disable createdAt
      updatedAt: false  // disable updatedAt
    },
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  };