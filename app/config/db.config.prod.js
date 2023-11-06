module.exports = {
    HOST: "containers-us-west-123.railway.app",
    USER: "postgres",
    PORT: 5655,
    PASSWORD: "sPamwlPOKx6gKhvfEgTR",
    DB: "pelom-db",
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