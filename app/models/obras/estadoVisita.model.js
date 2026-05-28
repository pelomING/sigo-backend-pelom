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
          },
        estado_obra_resultante: {
            type: Sequelize.INTEGER,
            allowNull: false,
        }
        },
        {
            schema: "obras",
        });
    return EstadoVisita;
  };