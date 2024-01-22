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
            type: Sequelize.INTEGER,
            allowNull: false
        },
        cantidad: {
            type: Sequelize.DECIMAL,
            allowNull: false
        },
        total_uc: {
            type: Sequelize.DECIMAL,
            allowNull: false
        },
        id_encabezado_rep: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        },
        {
            schema: "obras",
        });
    return DetalleReporteDiarioOtrasActividades;
  };