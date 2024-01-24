module.exports = (sequelize, Sequelize) => {
    const EncabezadoEstadoPago = sequelize.define("encabezado_estado_pago", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.BIGINT,    
            allowNull: false
          },
        fecha_estado_pago: {
            type: Sequelize.STRING,
            allowNull: false
        },
        cliente: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        fecha_asignacion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        tipo_trabajo: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        segmento: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        solicitado_por: {
            type: Sequelize.STRING,
            allowNull: false
        },
        ot_sdi: {
            type: Sequelize.STRING,
            allowNull: false
        },
        comuna: {
            type: Sequelize.STRING,
            allowNull: false
        },
        direccion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        flexiapp: {
            type: Sequelize.STRING,
            allowNull: false
        },
        fecha_ejecucion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        jefe_delegacion: {
            type: Sequelize.STRING,
            allowNull: false
        },
        codigo_pelom: {
            type: Sequelize.STRING,
            allowNull: false
        },
        supervisor: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        jefe_faena: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        estado: {
            type: Sequelize.INTEGER,
            allowNull: false
        }
    },
        {
            schema: "obras",
        });
    return EncabezadoEstadoPago;
  };