module.exports = (sequelize, Sequelize) => {
    const CobroAdicional = sequelize.define("reporte_cobro_adicional", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        detalle: {
            type: Sequelize.STRING
        },
        cantidad: {
            type: Sequelize.INTEGER
        },
        valor: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        id_estado_resultado: {
            type: Sequelize.INTEGER
        },
        estado: {
            type: Sequelize.INTEGER
          },
        fecha_hora: {
            type: Sequelize.STRING
        }
        },
    {
        schema: "sae",
    });
    return CobroAdicional;
  };