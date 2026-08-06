module.exports = (sequelize, Sequelize) => {
    const DetalleCotizacionOtrasActividades = sequelize.define("detalle_cotizacion_otras_actividades", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        glosa: {
            type: Sequelize.TEXT,
            allowNull: false
        },
        uc_unitaria: {
            type: Sequelize.INTEGER
            
        },
        cantidad: {
            type: Sequelize.DECIMAL,
            allowNull: false
        },
        total_uc: {
            type: Sequelize.DECIMAL
            
        },
        id_encabezado_cotizacion: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        unitario_pesos: {
            type: Sequelize.BIGINT
        },
        total_pesos: {
            type: Sequelize.BIGINT
        }
        },
        {
            schema: "obras",
        });
    return DetalleCotizacionOtrasActividades;
  };