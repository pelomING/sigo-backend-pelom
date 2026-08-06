const backofficeObrasController = require("../controllers/obras/backoffice.obras.controller");
const backofficeMaterialController = require("../controllers/obras/backoffice.material.controller");

//viene de server.js y se ejecuta cada 10 minuto por defecto
exports.resumenObras = async () => {

    //console.log("Cron resumen obras");
    await backofficeObrasController.genera_resumen(true);
}

exports.lectura_daia = async () => {
    await backofficeMaterialController.lee_daia();
}