module.exports = (sequelize, Sequelize) => {
    const MovimientosBodega = sequelize.define("movimientos_bodega", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        codigo_sap_material: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        cantidad: {
            type: Sequelize.FLOAT,
            allowNull: false
          },
        tipo_movimiento: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        guia_despacho: {
            type: Sequelize.STRING,
            allowNull: false
          },
        fecha_movimiento: {
            type: Sequelize.STRING,
            allowNull: false
          },
        rut_usuario: {
            type: Sequelize.STRING
          }       
    },
    {
        schema: "material",
    });
    return MovimientosBodega;
  };