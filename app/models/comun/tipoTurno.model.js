module.exports = (sequelize, Sequelize) => {
    const TipoTurno = sequelize.define("tipo_turno", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
        nombre: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
        }
    },
    {
      schema: "_comun",
    });
  
    return TipoTurno;
  };