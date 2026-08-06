module.exports = (sequelize, Sequelize) => {
    const DetalleReporteDiarioOtrasActividades = sequelize.define("detalle_reporte_diario_otras_actividades", {
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
        id_encabezado_rep: {
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
    return DetalleReporteDiarioOtrasActividades;
  };