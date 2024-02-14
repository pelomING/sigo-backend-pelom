module.exports = (sequelize, Sequelize) => {
    const ObrasParalizacion = sequelize.define("obras_paralizacion", {
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
        responsable: {
            type: Sequelize.STRING,
            allowNull: false
        },
        motivo: {
            type: Sequelize.STRING,
            allowNull: false
        },
        observacion: {
            type: Sequelize.STRING
        },
        usuario_rut: {
            type: Sequelize.STRING,
            allowNull: false
        }
        },
        {
            schema: "obras",
        });
    return ObrasParalizacion;
  };