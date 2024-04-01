const backofficeObrasController = require("../controllers/obras/backoffice.obras.controller");

exports.resumenObras = () => {

    console.log("Cron resumen obras");
    backofficeObrasController.genera_resumen(true);
}