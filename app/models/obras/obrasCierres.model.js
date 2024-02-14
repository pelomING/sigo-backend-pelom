module.exports = (sequelize, Sequelize) => {
    const ObrasCierres = sequelize.define("obras_cierres", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.INTEGER,
            allowNull: false
          },
        fecha_hora: {
            type: Sequelize.STRING,
            allowNull: false
        },
        supervisor_responsable: {
            type: Sequelize.STRING,
            allowNull: false
        },
        coordinador_responsable: {
            type: Sequelize.STRING,
            allowNull: false
        },
        gestor_cge: {
            type: Sequelize.STRING,
            allowNull: false
        },
        observaciones: {
            type: Sequelize.STRING,
            allowNull: false
        },
        usuario_rut: {
            type: Sequelize.STRING,
            allowNull: false
        }
        },
        {
            schema: "obras",
        });
    return ObrasCierres;
  };