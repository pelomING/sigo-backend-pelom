module.exports = (sequelize, Sequelize) => {
    const EstadoResultado = sequelize.define("reporte_estado_resultado", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
          id_usuario: {
            type: Sequelize.INTEGER,
            allowNull: false,
          },
          zona: {
            type: Sequelize.INTEGER,
            allowNull: false
          },
          paquete: {
            type: Sequelize.INTEGER,
            allowNull: false
          },
          mes: {
            type: Sequelize.INTEGER,
            allowNull: false
          },
          fecha_inicio: {
            type: Sequelize.STRING,
            allowNull: false
          },
          fecha_final: {
            type: Sequelize.STRING,
            allowNull: false
          },
          nombre_doc: {
            type: Sequelize.STRING
          },
          url_doc: {
            type: Sequelize.STRING
          },
          fecha_creacion: {
            type: Sequelize.STRING
          },
          fecha_modificacion: {
            type: Sequelize.STRING
          },
          estado: {
            type: Sequelize.INTEGER
          }
    },
    {
        schema: "sae",
    });
  
    return EstadoResultado;
  };