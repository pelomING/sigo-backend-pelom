module.exports = (sequelize, Sequelize) => {
    const ObrasHistorialCambios = sequelize.define("obras_historial_cambios", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.INTEGER,
            allowNull: false
          },
        fecha_hora: {
            type: Sequelize.STRING,
            allowNull: false
        },
        usuario_rut: {
            type: Sequelize.STRING,
            allowNull: false
        },
        estado_obra: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        datos: {
            type: Sequelize.JSON
        }
        },
        {
            schema: "obras",
        });
    return ObrasHistorialCambios;
  };