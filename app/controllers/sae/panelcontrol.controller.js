const db = require("../../models");



/*********************************************************************************** */
/* Devuelve la cantidad de eventos por zonal maule norte  y sur
*/
exports.getCantidadEventosSaePorZonal = async (req, res) => {
    /*  #swagger.tags = ['SAE - Backoffice - Panel de Control']
      #swagger.description = 'Devuelve la cantidad de eventos por zonal maule norte  y sur' */
      try {

        
        const respuesta = {
          json: []
        }
            
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
    
        let sql = "SELECT array_agg(row_to_json(z.*)) AS cantidad_eventos_zonal FROM ( SELECT * FROM sae.cantidad_tipo_eventos_por_zonal_meses ) z WHERE z.anio_actual = 2024;";
        
        const result = await sequelize.query(sql, { type: QueryTypes.SELECT });

        
        if (result) {

            respuesta.json = result[0].cantidad_eventos_zonal;

        }else{

          res.status(500).send("Error en la consulta (servidor backend)");
          return;

        }
    
        res.status(200).send(respuesta);
    
      } catch (error) {

        console.log("error",error);

        res.status(500).send(error);

      }
  }
