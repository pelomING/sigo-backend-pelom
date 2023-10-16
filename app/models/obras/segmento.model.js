module.exports = (sequelize, Sequelize) => {
    const Segmento = sequelize.define("segmento", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        nombre: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
        descripcion: {
            type: Sequelize.STRING
          }
        },
        {
            schema: "obras",
        });
    return Segmento;
  };