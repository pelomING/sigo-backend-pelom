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
          },
          bg_color: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          txt_color: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          no_exige_oc: {
            type: Sequelize.BOOLEAN
          }
        },
        {
            schema: "obras",
        });
    return TipoObra;
  };