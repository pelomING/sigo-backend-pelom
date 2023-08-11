module.exports = {
    HOST: "localhost",
    USER: "postgres",
    PASSWORD: "hm1308!@..",
    DB: "sae",
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