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
        },
        id_obra_asignada: {
            type: Sequelize.BIGINT,
            field: 'id_obra_asignada'
        },
        id_reporte_procesado: {
            type: Sequelize.BIGINT,
            field: 'id_reporte_procesado'
        },
        usuario_rut_update: {
            type: Sequelize.STRING,
            field: 'usuario_rut_update'
        }
    },
        {
            schema: "movil",
        });
    return MovilReporteDiario;
  };