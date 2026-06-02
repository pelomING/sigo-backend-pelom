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
        coordinador: {
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
        },
        ot: {
            type: Sequelize.STRING
        },
        sdi: {
            type: Sequelize.STRING
        },
        recargo_nombre: {
            type: Sequelize.STRING
        },
        recargo_porcentaje: {
            type: Sequelize.FLOAT
        },
        valor_uc: {
            type: Sequelize.FLOAT
        },
        subtotal1 : {
            type: Sequelize.BIGINT
        },
        subtotal2: {
            type: Sequelize.BIGINT
        },
        subtotal3: {
            type: Sequelize.BIGINT
        },
        descuento_avance: {
            type: Sequelize.BIGINT
        },
        detalle_avances: {
            type: Sequelize.ARRAY(Sequelize.JSON)
        },
        detalle_actividades : {
            type: Sequelize.ARRAY(Sequelize.JSON)
        },
        detalle_otros : {
            type: Sequelize.ARRAY(Sequelize.JSON)
        },
        detalle_horaextra : {
            type: Sequelize.ARRAY(Sequelize.JSON)
        },
        numero_oc : {
            type: Sequelize.STRING
        },
        recargos_extra : {
            type: Sequelize.ARRAY(Sequelize.JSON)
        },
        referencia : {
            type: Sequelize.STRING
        },
        centrality: {
            type: Sequelize.STRING
        }
    },
        {
            schema: "obras",
        });
    return EncabezadoEstadoPago;
  };