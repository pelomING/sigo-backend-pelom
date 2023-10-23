module.exports = (sequelize, Sequelize) => {
    const TipoOperacion = sequelize.define("tipo_operacion", {
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
    return TipoOperacion;
  };