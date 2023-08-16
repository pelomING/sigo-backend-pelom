module.exports = (sequelize, Sequelize) => {
    const Turnos = sequelize.define("turnos", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          inicio: {
            type: Sequelize.STRING,
            allowNull: false
          },
          fin: {
            type: Sequelize.STRING,
            allowNull: false
          },
          observacion: {
            type: Sequelize.STRING
          }
    });
  
    return Turnos;
  };
  