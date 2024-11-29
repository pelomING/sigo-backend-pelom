module.exports = (sequelize, Sequelize) => {
    const UsuariosFunciones = sequelize.define("usuarios_funciones", {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true
        },
      username: {
        type: Sequelize.STRING,
      },
      password: {
        type: Sequelize.STRING,
      },
      email: {
        type: Sequelize.STRING
      },
      funcion: {
        type: Sequelize.STRING
      },
      nombres: {
        type: Sequelize.STRING
      },
      fecha_password: {
        type: Sequelize.DATE
      },
      cod_mensaje: {
        type: Sequelize.INTEGER
      }
    },
    {
      schema: "_auth",
    });
  
    return UsuariosFunciones;
  };