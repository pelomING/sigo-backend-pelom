module.exports = (sequelize, Sequelize) => {
    const DetalleReporteDiarioActividad = sequelize.define("detalle_reporte_diario_actividad", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        tipo_operacion: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        id_actividad: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        cantidad: {
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
    return DetalleReporteDiarioActividad;
  };