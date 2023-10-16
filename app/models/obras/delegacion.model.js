module.exports = (sequelize, Sequelize) => {
    const Delegacion = sequelize.define("delegaciones", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        nombre: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          }
        },
        {
            schema: "obras",
        });
    return Delegacion;
  };