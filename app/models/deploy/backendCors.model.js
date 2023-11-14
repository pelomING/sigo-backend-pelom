module.exports = (sequelize, Sequelize) => {
    const BackendCors = sequelize.define("backend_cors", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true
          },
          origen: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
          comentario: {
            type: Sequelize.STRING
          }
    },
    {
      schema: "_deploy",
    });
  
    return BackendCors;
  };