module.exports = (sequelize, Sequelize) => {
    const EstadoVisita = sequelize.define("estado_visita", {
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
            schema: "obras",
        });
    return EstadoVisita;
  };