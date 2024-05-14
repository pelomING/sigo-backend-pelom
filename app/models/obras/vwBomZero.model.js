module.exports = (sequelize, Sequelize) => {
    const VwBomZero = sequelize.define("view_bom_zero", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        cod_reserva: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        codigo_sap_material: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        cantidad_requerida: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        fecha_ingreso: {
            type: Sequelize.STRING,
            allowNull: false
        },
        rut_usuario: {
            type: Sequelize.STRING,
            allowNull: false
        },
        persona: {
            type: Sequelize.STRING,
            allowNull: false
        }
    },
    {
        schema: "obras",
    });
    return VwBomZero;
  };