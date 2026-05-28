module.exports = (sequelize, Sequelize) => {
    const ConexionDaia = sequelize.define("conexion_daia", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        accion: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        fecha_hora: {
            type: Sequelize.STRING,
            allowNull: false
          },
        datos: {
            type: Sequelize.JSON,
            allowNull: false
        },
        estado: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        observacion: {
            type: Sequelize.STRING,
          }
    },
    {
        schema: "material",
    });
    return ConexionDaia;
  };