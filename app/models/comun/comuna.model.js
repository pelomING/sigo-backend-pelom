module.exports = (sequelize, Sequelize) => {
    const Comuna = sequelize.define("comunas", {
        codigo: {
            type: Sequelize.STRING,
            primaryKey: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          provincia: {
            type: Sequelize.STRING,
            allowNull: false,
          }
    },
    {
      schema: "_comun",
    });
  
    return Comuna;
  };