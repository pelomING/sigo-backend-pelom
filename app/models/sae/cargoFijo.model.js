module.exports = (sequelize, Sequelize) => {
    const CargoFijo = sequelize.define("cargo_fijo", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
        },
        id_cliente: {
            type: Sequelize.INTEGER
        },
        id_base: {
            type: Sequelize.INTEGER
        },
        id_turno: {
            type: Sequelize.INTEGER
        },
        valor: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        observacion: {
            type: Sequelize.STRING
          }
        },
        {
            schema: "sae",
        });
    return CargoFijo;
  };