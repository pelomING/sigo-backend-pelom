module.exports = (sequelize, Sequelize) => {
    const EncabezadoReporteDiario = sequelize.define("encabezado_reporte_diario", {
        id: {
            type: Sequelize.BIGINT,
            autoIncrement: true,
            primaryKey: true
        },
        id_obra: {
            type: Sequelize.BIGINT,    
            allowNull: false
          },
        fecha_reporte: {
            type: Sequelize.STRING,
        },
        jefe_faena: {
            type: Sequelize.STRING
        },
        sdi: {
            type: Sequelize.STRING
        },
        gestor_cliente: {
            type: Sequelize.STRING
        },
        id_area: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        brigada_pesada: {
            type: Sequelize.BOOLEAN
        },
        observaciones: {
            type: Sequelize.STRING
        },
        entregado_por_persona: {
            type: Sequelize.STRING
        },
        fecha_entregado: {
            type: Sequelize.STRING
        },
        revisado_por_persona: {
            type: Sequelize.STRING
        },
        fecha_revisado: {
            type: Sequelize.STRING
        },
        sector: {
            type: Sequelize.STRING
        },
        hora_salida_base: {
            type: Sequelize.STRING
        },
        hora_llegada_terreno: {
            type: Sequelize.STRING
        },
        hora_salida_terreno: {
            type: Sequelize.STRING
        },
        hora_llegada_base: {
            type: Sequelize.STRING
        },
        alimentador: {
            type: Sequelize.STRING
        },
        comuna: {
            type: Sequelize.STRING
        },
        num_documento: {
            type: Sequelize.STRING
        },
        flexiapp: {
            type: Sequelize.STRING
        }
    },
        {
            schema: "obras",
        });
    return EncabezadoReporteDiario;
  };