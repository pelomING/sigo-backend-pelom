module.exports = (sequelize, Sequelize) => {
    const EstadoPago = sequelize.define("reporte_estado_pago", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
          codigo_estado: {
            type: Sequelize.STRING,
            allowNull: false,
          },
          encabezado: {
            type: Sequelize.JSON,
            allowNull: false
          },
          fecha_hora: {
            type: Sequelize.STRING
          }
    },
    {
        schema: "sae",
    });
  
    return EstadoPago;
  };