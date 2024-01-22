module.exports = (sequelize, Sequelize) => {
    const Recargos = sequelize.define("recargos", {
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
            id_tipo_recargo: {
                type: Sequelize.INTEGER,
                allowNull: false
            },
            porcentaje: {
                type: Sequelize.FLOAT,
                allowNull: false
            }
        },
        {
            schema: "obras",
        });
    return Recargos;
  };