module.exports = (sequelize, Sequelize) => {
    const TipoFuncionPersonal = sequelize.define("tipo_funcion_personal", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false
          },
          sistema: {
            type: Sequelize.BOOLEAN,
            allowNull: false
          },
          maestro: {
            type: Sequelize.BOOLEAN,
            allowNull: false
          },
          ayudante: {
            type: Sequelize.BOOLEAN,
            allowNull: false
          }
    });
  
    return TipoFuncionPersonal;
  };