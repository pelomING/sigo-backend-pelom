module.exports = (sequelize, Sequelize) => {
    const TipoTrabajo = sequelize.define("tipo_trabajo", {
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
    return TipoTrabajo;
  };