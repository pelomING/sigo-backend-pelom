module.exports = (sequelize, Sequelize) => {
    const Base = sequelize.define("base", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          id_paquete: {
            type: Sequelize.INTEGER
          }
    },
    {
      schema: "_comun",
    });
  
    return Base;
  };