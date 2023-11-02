module.exports = (sequelize, Sequelize) => {
    const Bom = sequelize.define("bom", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        reserva: {
            type: Sequelize.INTEGER,
            allowNull: false
          },
        codigo_sap_material: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        cantidad_requerida: {
            type: Sequelize.FLOAT,
            allowNull: false
        }
    },
    {
        schema: "obras",
    });
    return Bom;
  };