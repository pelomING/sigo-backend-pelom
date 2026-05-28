module.exports = (sequelize, Sequelize) => {
    const PedidoMaterialMandante = sequelize.define("mat_solicitudes_detalle", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        pedido: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        codigo_sap_material: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        cantidad_requerida_old: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        cantidad_requerida_new: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        tipo_movimiento: {
            type: Sequelize.STRING,
            allowNull: false
        },
        fecha_movimiento: {
            type: Sequelize.STRING,
            allowNull: false
        },
        rut_usuario: {
            type: Sequelize.STRING,
            allowNull: false
        }
    },
    {
        schema: "obras",
    });
    return PedidoMaterialMandante;
  };