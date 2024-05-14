const backofficeObrasController = require("../controllers/obras/backoffice.obras.controller");

//viene de server.js y se ejecuta cada 10 minuto por defecto
exports.resumenObras = () => {

    //console.log("Cron resumen obras");
    backofficeObrasController.genera_resumen(true);
}