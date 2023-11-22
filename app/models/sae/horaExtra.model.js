module.exports = (sequelize, Sequelize) => {
    const HoraExtra = sequelize.define("reporte_hora_extra", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        brigada: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        cantidad: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        comentario: {
            type: Sequelize.STRING
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
    return HoraExtra;
  };