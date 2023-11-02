module.exports = (sequelize, Sequelize) => {
    const CoordinadorContratista = sequelize.define("coordinadores_contratista", {
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
            allowNull: false,
            unique: true
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
    return CoordinadorContratista;
  };