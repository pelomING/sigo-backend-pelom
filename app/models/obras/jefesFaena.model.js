module.exports = (sequelize, Sequelize) => {
    const JefesFaena = sequelize.define("jefes_faena", {
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
    return JefesFaena;
  };