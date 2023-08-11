module.exports = (sequelize, Sequelize) => {
    const PreciosBase = sequelize.define("precios_base", {
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
        id_evento_tipo: {
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
    });
  
    return PreciosBase;
  };