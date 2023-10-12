module.exports = (sequelize, Sequelize) => {
    const DetalleEstadoResultado = sequelize.define("reporte_detalle_estado_resultado", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
          id_estado_resultado: {
            type: Sequelize.INTEGER,
            allowNull: false,
          },
          id_evento: {
            type: Sequelize.INTEGER,
            allowNull: false
          }
    },
    {
        schema: "sae",
    });
  
    return DetalleEstadoResultado;
  };