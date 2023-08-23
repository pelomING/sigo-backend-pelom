module.exports = (sequelize, Sequelize) => {
    const Personas = sequelize.define("personas", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
          },
        rut: {
            type: Sequelize.STRING,
            allowNull: false
        },
        apellido_1: {
            type: Sequelize.STRING,
            allowNull: false
        },
        apellido_2: {
            type: Sequelize.STRING,
            allowNull: true
        },
        nombres: {
            type: Sequelize.STRING,
            allowNull: false
        },
        base: {
            type: Sequelize.INTEGER,
          },
        cliente: {
            type: Sequelize.INTEGER,
        },
        id_funcion: {
            type: Sequelize.INTEGER,
          },
        activo: {
            type: Sequelize.BOOLEAN,
        }
    });
  
    return Personas;
  };