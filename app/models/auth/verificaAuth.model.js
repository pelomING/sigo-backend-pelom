module.exports = (sequelize, Sequelize) => {
    const VerificaAuth = sequelize.define("verifica_auth", {
      id: {
        type: Sequelize.BIGINT,
        primaryKey: true
      },
      user_id: {
        type: Sequelize.INTEGER,
        allowNull: false
      },
      codigo: {
        type: Sequelize.STRING,
        allowNull: false
      },
      crear: {
        type: Sequelize.BOOLEAN,
        allowNull: false
      },
      leer: {
        type: Sequelize.BOOLEAN,
        allowNull: false
      },
      actualizar: {
        type: Sequelize.BOOLEAN,
        allowNull: false
      },
      borrar: {
        type: Sequelize.BOOLEAN,
        allowNull: false
      },
      comentario: {
        type: Sequelize.STRING
      }
    },
    {
      schema: "_auth",
    });
  
    return VerificaAuth;
  };