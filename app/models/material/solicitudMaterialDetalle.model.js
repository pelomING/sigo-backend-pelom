module.exports = (sequelize, Sequelize) => {
    const SolicitudMaterialDetalle = sequelize.define("solicitud_material_detalle", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_solicitud: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        codigo_sap_material: {
            type: Sequelize.BIGINT,
            allowNull: false
          }, 
        cantidad: {
            type: Sequelize.FLOAT,
            allowNull: false
        },   
        id_obra_propietario: {
            type: Sequelize.INTEGER,
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
    return SolicitudMaterialDetalle;
  };