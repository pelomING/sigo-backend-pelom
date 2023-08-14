module.exports = (sequelize, Sequelize) => {
    const Estados = sequelize.define("estados", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          }
    },
    {
        schema: "reporte",
    });
  
    return Estados;
  };