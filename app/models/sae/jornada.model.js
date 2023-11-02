module.exports = (sequelize, Sequelize) => {
    const Jornada = sequelize.define("reporte_jornada", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
        rut_maestro: {
            type: Sequelize.STRING,
            allowNull: false
        },
        rut_ayudante: {
            type: Sequelize.STRING,
            allowNull: false
        },
        codigo_turno: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        patente: {
            type: Sequelize.STRING,
            allowNull: false
        },
        id_paquete: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        km_inicial: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        km_final: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        fecha_hora_ini: {
            type : Sequelize.STRING,
        },
        fecha_hora_fin: {
            type : Sequelize.STRING
        },
        estado: {
            type: Sequelize.INTEGER
        }
    },
    {
        schema: "sae",
    });
  
    return Jornada;
  };