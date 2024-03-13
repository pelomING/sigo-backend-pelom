module.exports = (sequelize, Sequelize) => {
    const RolesHomepage = sequelize.define("roles_homepage", {
      id: {
        type: Sequelize.INTEGER,
        field: 'id',
        primaryKey: true
      },
      roleId: {
        type: Sequelize.INTEGER,
        field: 'role_id',
        allowNull: false
      },
      homepage: {
        type: Sequelize.STRING,
        field: 'homepage',
        allowNull: false
      },
      comentario: {
        type: Sequelize.STRING,
        field: 'comentario'
      }
    },
    {
      schema: "_frontend",
    });
  
    return RolesHomepage;
  };