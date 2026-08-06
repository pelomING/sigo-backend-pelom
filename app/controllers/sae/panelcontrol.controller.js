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
    
        let sql = "SELECT array_agg(row_to_json(z.*)) AS cantidad_eventos_zonal FROM ( SELECT * FROM sae.cantidad_tipo_eventos_por_zonal_meses ) z WHERE z.anio_actual = EXTRACT(YEAR FROM CURRENT_DATE);";
        
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



/*********************************************************************************** */
/* Devuelve la cantidad de eventos por zonal maule norte  y sur organizado por mes 
*/
exports.getCantidadEventosSaePorZonalOrganizadoPorMes = async (req, res) => {
  /*  #swagger.tags = ['SAE - Backoffice - Panel de Control']
    #swagger.description = 'Devuelve la cantidad de eventos por zonal maule norte  y sur organizado por mes' */
    try {

      
      const respuesta = {
        json: []
      }
          
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
  
      let sql = `
      SELECT
          array_agg(row_to_json(z.*)) AS registro_tabla
      FROM (
          SELECT
              a.mes_actual,
              a.nombre_mes,
              a.id_zonal,
              a.nombre_zonal,
              (SELECT cantidad_eventos FROM sae.cantidad_tipo_eventos_por_zonal_meses WHERE anio_actual = EXTRACT(YEAR FROM CURRENT_DATE) 
                AND id_tipo_evento = 1 AND mes_actual = a.mes_actual AND id_zonal = a.id_zonal) cantidad_DOMIC,
              (SELECT cantidad_eventos FROM sae.cantidad_tipo_eventos_por_zonal_meses WHERE anio_actual = EXTRACT(YEAR FROM CURRENT_DATE) 
                AND id_tipo_evento = 2 AND mes_actual = a.mes_actual AND id_zonal = a.id_zonal) cantidad_SSEEB,
              (SELECT cantidad_eventos FROM sae.cantidad_tipo_eventos_por_zonal_meses WHERE anio_actual = EXTRACT(YEAR FROM CURRENT_DATE) 
                AND id_tipo_evento = 3 AND mes_actual = a.mes_actual AND id_zonal = a.id_zonal) cantidad_LINMT,
              (SELECT cantidad_eventos FROM sae.cantidad_tipo_eventos_por_zonal_meses WHERE anio_actual = EXTRACT(YEAR FROM CURRENT_DATE) 
                AND id_tipo_evento = 4 AND mes_actual = a.mes_actual AND id_zonal = a.id_zonal) cantidad_REPAR
          FROM
              sae.cantidad_tipo_eventos_por_zonal_meses AS a
          WHERE
              anio_actual = EXTRACT(YEAR FROM CURRENT_DATE) 
          GROUP BY
              1,2,3,4 
          ORDER BY
              3,1
      ) z`;
  
      
      const result = await sequelize.query(sql, { type: QueryTypes.SELECT });

      
      if (result) {

          respuesta.json = result[0].registro_tabla;

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


