module.exports = (sequelize, Sequelize) => {
    const Camonietas = sequelize.define("camonietas", {
          patente: { 
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          marca: {
            type: Sequelize.STRING,
            allowNull: false
          },
          modelo: {
            type: Sequelize.STRING,
          },
          id_base: {
            type: Sequelize.INTEGER
          },
          activo: {
            type: Sequelize.BOOLEAN
          },
          observacio: {
            type: Sequelize.STRING
          }
    },
    {
      schema: "_comun",
    });
  
    return Camonietas;
  };