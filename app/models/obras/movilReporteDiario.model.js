module.exports = (sequelize, Sequelize) => {
    const MovilReporteDiario = sequelize.define("reporte_diario", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        usuario_rut: {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'usuario_rut'
        },
        fecha_insert : {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'fecha_insert'
        },
        fecha_update : {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'fecha_update'
        },
        estado: {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'estado'
        },
        datos: {
            type: Sequelize.JSON,
            field: 'datos'
        }
        },
        {
            schema: "movil",
        });
    return MovilReporteDiario;
  };