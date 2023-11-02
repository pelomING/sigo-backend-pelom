module.exports = (sequelize, Sequelize) => {
    const MaestroActividad = sequelize.define("maestro_actividades", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        actividad: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
        },
        id_tipo_actividad: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        uc_instalacion: {
            type: Sequelize.DECIMAL,
            allowNull: false
        },
        uc_retiro: {
            type: Sequelize.DECIMAL,
            allowNull: false
        },
        uc_traslado: {
            type: Sequelize.DECIMAL,
            allowNull: false
        },
        descripcion: {
            type: Sequelize.STRING
        }
        },
        {
            schema: "obras",
        });
    return MaestroActividad;
  };