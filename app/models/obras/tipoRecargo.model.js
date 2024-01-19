module.exports = (sequelize, Sequelize) => {
    const TipoRecargo = sequelize.define("tipo_recargo", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        descripcion: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          }
        },
        {
            schema: "obras",
        });
    return TipoRecargo;
  };