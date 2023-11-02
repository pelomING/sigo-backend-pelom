module.exports = (sequelize, Sequelize) => {
    const Zonal = sequelize.define("zonal", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false
          }
    },
    {
      schema: "_comun",
    });
  
    return Zonal;
  };