module.exports = (sequelize, Sequelize) => {
    const LogMovimiento = sequelize.define("log_movimientos", {
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
        fecha_hora : {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'fecha_hora'
        },
        modulo: {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'modulo'
        },
        accion: {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'accion'
        },
        comentario: {
            type: Sequelize.STRING,
            field: 'comentario'
        },
        datos: {
            type: Sequelize.JSON,
            field: 'datos'
        }
        },
        {
            schema: "obras",
        });
    return LogMovimiento;
  };