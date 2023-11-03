module.exports = (sequelize, Sequelize) => {
    const LoginHistorial = sequelize.define("login_historial", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        username: {
            type: Sequelize.STRING,
            unique: true,
            allowNull: false
        },
        email: {
            type: Sequelize.STRING,
            unique: true,
            allowNull: false
        },
        accion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        fecha_hora: {
            type: Sequelize.STRING,
            allowNull: false
        }
    },
    {
      schema: "_auth",
    });
  
    return LoginHistorial;
  };