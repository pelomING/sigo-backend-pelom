module.exports = (sequelize, Sequelize) => {
    const Observaciones = sequelize.define("reporte_observaciones", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        detalle: {
            type: Sequelize.STRING
        },
        fecha_hora: {
            type: Sequelize.STRING
        },
        id_estado_resultado: {
            type: Sequelize.INTEGER
        },
        estado: {
            type: Sequelize.INTEGER
          }
    },
    {
        schema: "sae",
    });
    return Observaciones;
  };