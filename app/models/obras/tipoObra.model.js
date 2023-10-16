module.exports = (sequelize, Sequelize) => {
    const TipoObra = sequelize.define("tipo_obra", {
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
    return TipoObra;
  };