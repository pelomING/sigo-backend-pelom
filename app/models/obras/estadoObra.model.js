module.exports = (sequelize, Sequelize) => {
    const EstadoObra = sequelize.define("estado_obra", {
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
        color: {
            type: Sequelize.STRING,
            allowNull: false
        }
        },
        {
            schema: "obras",
        });
    return EstadoObra;
  };