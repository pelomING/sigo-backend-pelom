module.exports = (sequelize, Sequelize) => {
    const EmpresaContratista = sequelize.define("empresas_contratista", {
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
        rut: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          }
        },
        {
            schema: "obras",
        });
    return EmpresaContratista;
  };