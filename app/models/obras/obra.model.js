module.exports = (sequelize, Sequelize) => {
    const Obra = sequelize.define("obras", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        codigo_obra: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
          },
        numero_ot: {
            type: Sequelize.STRING,
            unique: true
        },
        nombre_obra: {
            type: Sequelize.STRING
        },
        zona: {
            type: Sequelize.INTEGER
        },
        delegacion: {
            type: Sequelize.INTEGER
        },
        gestor_cliente: {
            type: Sequelize.STRING
        },
        numero_aviso: {
            type: Sequelize.INTEGER
        },
        numero_oc: {
            type: Sequelize.STRING
        },
        monto: {
            type: Sequelize.FLOAT
        },
        cantidad_uc: {
            type: Sequelize.FLOAT
        },
        fecha_llegada: {
            type: Sequelize.STRING
        },
        fecha_inicio: {
            type: Sequelize.STRING
        },
        fecha_termino: {
            type: Sequelize.STRING
        },
        tipo_trabajo: {
            type: Sequelize.INTEGER
        },
        persona_envia_info: {
            type: Sequelize.STRING
        },
        cargo_persona_envia_info: {
            type: Sequelize.STRING
        },
        empresa_contratista: {
            type: Sequelize.INTEGER
        },
        coordinador_contratista: {
            type: Sequelize.INTEGER
        },
        comuna: {
            type: Sequelize.STRING
        },
        ubicacion: {
            type: Sequelize.STRING
        },
        estado: {
            type: Sequelize.INTEGER
        },
        tipo_obra: {
            type: Sequelize.INTEGER
        },
        segmento: {
            type: Sequelize.INTEGER
        },
        eliminada: {
            type: Sequelize.BOOLEAN
        },
        jefe_delegacion: {
            type: Sequelize.STRING
        },
        oficina: {
            type: Sequelize.INTEGER
        },
        recargo_distancia: {
            type: Sequelize.INTEGER
        }
        },
        {
            schema: "obras",
        });
    return Obra;
  };