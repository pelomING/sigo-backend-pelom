module.exports = (sequelize, Sequelize) => {
    const VisitaTerreno = sequelize.define("visitas_terreno", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        fecha_visita: {
            type: Sequelize.STRING,
            allowNull: false
        },
        direccion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        persona_mandante: {
            type: Sequelize.STRING,
            allowNull: false
        },
        cargo_mandante: {
            type: Sequelize.STRING,
            allowNull: false
        },
        persona_contratista: {
            type: Sequelize.STRING,
            allowNull: false
        },
        cargo_contratista: {
            type: Sequelize.STRING,
            allowNull: false
        },
        observacion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        estado: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        fecha_modificacion: {
            type: Sequelize.STRING,
            allowNull: false
        }
    },
    {
        schema: "obras",
    });
    return VisitaTerreno;
  };