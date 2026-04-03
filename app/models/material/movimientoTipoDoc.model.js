module.exports = (sequelize, Sequelize) => {
    const MovimientoTipoDoc = sequelize.define("movimiento_tipo_doc", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_movimiento: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        id_tipo_doc: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        valor: {
            type: Sequelize.STRING,
            allowNull: false
          }  
    },
    {
        schema: "material",
    });
    return MovimientoTipoDoc;
  };