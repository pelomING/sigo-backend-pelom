module.exports = (sequelize, Sequelize) => {
    const TipoActividad = sequelize.define("tipo_actividad", {
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
    return TipoActividad;
  };