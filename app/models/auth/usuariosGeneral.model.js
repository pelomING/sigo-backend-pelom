module.exports = (sequelize, Sequelize) => {
    const UsuariosGeneral = sequelize.define("usuarios_general", {
    
      rut: {
        type: Sequelize.STRING,
        primaryKey: true
      },
      persona: {
        type: Sequelize.STRING,
      },
      rol: {
        type: Sequelize.STRING,
      },
      email: {
        type: Sequelize.STRING
      },
      activo: {
        type: Sequelize.BOOLEAN
      },
      base: {
        type: Sequelize.STRING
      },
      funcion: {
        type: Sequelize.STRING
      },
      password: {
        type: Sequelize.STRING,
      },
      fecha_password: {
        type: Sequelize.DATE
      }
    },
    {
      schema: "_auth",
    });
  
    return UsuariosGeneral;
  };