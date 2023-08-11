module.exports = (sequelize, Sequelize) => {
    const Paquete = sequelize.define("paquete", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false
          },
          id_zonal: {
            type: Sequelize.INTEGER
          }
    });
  
    return Paquete;
  };