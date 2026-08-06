module.exports = (sequelize, Sequelize) => {
    const SolicitudMaterialEncabezado = sequelize.define("solicitud_material_encabezado", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_tipo_doc: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        codigo_documento: {
            type: Sequelize.STRING,
            allowNull: false
          }, 
        fecha_solicitud: {
            type: Sequelize.STRING,
            allowNull: false
        },   
        rut_usuario: {
            type: Sequelize.STRING,
            allowNull: false
        },
        estado: {
            type: Sequelize.STRING,
            allowNull: false
          }  
    },
    {
        schema: "material",
    });
    return SolicitudMaterialEncabezado;
  };