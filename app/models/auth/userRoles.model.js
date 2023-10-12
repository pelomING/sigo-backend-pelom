module.exports = (sequelize, Sequelize) => {
    const UserRoles = sequelize.define("user_roles", {
      id: {
        type: DataTypes.INTEGER,
        field: 'id',
        primaryKey: true
      },
      roleId: {
        type: Sequelize.INTEGER,
        field: 'roleId',
        allowNull: false
      },
      userId: {
        type: Sequelize.INTEGER,
        field: 'userId',
        allowNull: false
      }
    },
    {
      schema: "_auth",
    });
  
    return UserRoles;
  };