module.exports = (sequelize, Sequelize) => {
    const Cliente = sequelize.define("cliente", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          nombre: {
            type: Sequelize.STRING,
            allowNull: false
          }
    });
  
    return Cliente;
  };