module.exports = (sequelize, Sequelize) => {
    const OficinaSupervisor = sequelize.define("oficina_supervisor", {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        oficina: {
            type: Sequelize.INTEGER,
            allowNull: false,
          },
        supervisor: {
            type: Sequelize.INTEGER,
            allowNull: false,
        }
        },
        {
            schema: "obras",
        });
    return OficinaSupervisor;
  };