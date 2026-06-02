module.exports = (sequelize, Sequelize) => {
    const MaestroMateriales = sequelize.define("maestro_materiales", {
        codigo_sap: {
            type: Sequelize.BIGINT,
            allowNull: false,
            primaryKey: true
        },
        texto_breve: {
            type: Sequelize.STRING,
            allowNull: false
        },
        descripcion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        id_unidad: {
            type: Sequelize.INTEGER,
            allowNull: false
        }
        },
    {
        schema: "obras",
    });
    return MaestroMateriales;
  };