module.exports = (sequelize, Sequelize) => {
    const DetalleCotizacionActividad = sequelize.define("detalle_cotizacion_actividad", {
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
        id_encabezado_cotizacion: {
            type: Sequelize.BIGINT,
            allowNull: false
        },
        },
        {
            schema: "obras",
        });
    return DetalleCotizacionActividad;
  };