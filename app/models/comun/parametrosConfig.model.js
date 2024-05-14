module.exports = (sequelize, Sequelize) => {
    const ParametrosConfig = sequelize.define("parametros_config", {
        id: {
            type: Sequelize.INTEGER,
            autoincrement: true,
            primaryKey: true,
            field: 'id'
        },
        clave: {
            type: Sequelize.STRING,
            allowNull: false,
            field: 'clave'
        },
        valor: {
            type: Sequelize.INTEGER,
            field: 'valor'
        },
        comentario: {
            type: Sequelize.STRING,
            field: 'comentario'
        }
    },
    {
      schema: "_comun",
    });
  
    return ParametrosConfig;
  };