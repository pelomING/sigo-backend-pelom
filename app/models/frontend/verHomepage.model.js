module.exports = (sequelize, Sequelize) => {
    const VerHomepage = sequelize.define("ver_homepage", {
      id: {
        type: Sequelize.INTEGER,
        field: 'id',
        primaryKey: true
      },
      mensajeId: {
        type: Sequelize.INTEGER,
        field: 'mensaje_id',
        allowNull: false
      },
      rolId: {
        type: Sequelize.INTEGER,
        field: 'rol_id',
        allowNull: false
      },
      mensaje: {
        type: Sequelize.JSON,
        field: 'mensaje',
        allowNull: false
      },
      rol: {
        type: Sequelize.STRING,
        field: 'rol'
      },
      homepage: {
        type: Sequelize.JSON,
        field: 'homepage'
      }
    },
    {
      schema: "_frontend",
    });
  
    return VerHomepage;
  };