module.exports = (sequelize, Sequelize) => {
    const EncabezadoCotizacion = sequelize.define("encabezado_cotizacion", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.BIGINT,    
            allowNull: false
          },
        fecha_cotizacion: {
            type: Sequelize.STRING,
        },
        cliente: {
            type: Sequelize.INTEGER
        },
        fecha_asignacion: {
            type: Sequelize.STRING,
        },
        tipo_trabajo: {
            type: Sequelize.INTEGER
        },
        segmento: {
            type: Sequelize.INTEGER
        },
        solicitado_por: {
            type: Sequelize.STRING,
        },
        comuna: {
            type: Sequelize.STRING
        },
        direccion: {
            type: Sequelize.STRING,
        },
        fecha_ejecucion: {
            type: Sequelize.STRING,
        },
        jefe_delegacion: {
            type: Sequelize.STRING,
        },
        codigo_pelom: {
            type: Sequelize.STRING,
        },
        jefe_faena: {
            type: Sequelize.INTEGER
        },
        estado: {
            type: Sequelize.INTEGER
        },
        supervisor: {
            type: Sequelize.INTEGER
        },
        valor_uc: {
            type: Sequelize.INTEGER
        }
    },
        {
            schema: "obras",
        });
    return EncabezadoCotizacion;
  };