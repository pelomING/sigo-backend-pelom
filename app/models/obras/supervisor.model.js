module.exports = (sequelize, Sequelize) => {
    const Supervisor = sequelize.define("supervisores_contratista", {
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
        id_empresa: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
          rut: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          }
        },
        {
            schema: "obras",
        });
    return Supervisor;
  };