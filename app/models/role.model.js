module.exports = (sequelize, Sequelize) => {
    const Role = sequelize.define("roles", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true
      },
      name: {
        type: Sequelize.STRING,
        allowNull: false
      },
      sistema: {
        type: Sequelize.BOOLEAN,
        allowNull: false
      }
    });
  
    return Role;
  };