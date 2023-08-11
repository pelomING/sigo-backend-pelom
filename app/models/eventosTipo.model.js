module.exports = (sequelize, Sequelize) => {
    const EventosTipo = sequelize.define("eventos_tipo", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          codigo: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          descripcion: {
            type: Sequelize.STRING,
            allowNull: false
          }
    });
  
    return EventosTipo;
  };