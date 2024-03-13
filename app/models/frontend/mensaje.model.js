module.exports = (sequelize, Sequelize) => {
    const Mensaje = sequelize.define("mensaje", {
      id: {
        type: Sequelize.INTEGER,
        field: 'id',
        primaryKey: true
      },
      mensaje: {
        type: Sequelize.STRING,
        field: 'mensaje'
      }
    },
    {
      schema: "_frontend",
    });
  
    return Mensaje;
  };