const db = require("../../models");
/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 USO DEL SISTEMA                                */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/

// Lista un resumen de los login hechos en el sistema dentro de un período
// GET /api/obras/backoffice/usosistema/v1/alllogin
exports.getAllLoginSistema = async (req, res) => {
/*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
      #swagger.description = 'Lista un resumen de los login hechos en el sistema dentro de un período' */

      /*
    const maule_norte = [
        {id: 1, fecha: '2024-03-20', dia: "Miércoles", cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', dia: "Martes", cantidad: 3, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', dia: "Lunes", cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', dia: "Domingo", cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', dia: "Sábado", cantidad: 9, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', dia: "Viernes", cantidad: 3, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', dia: "Jueves", cantidad: 8, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ];

    const maule_sur = [
        {id: 1, fecha: '2024-03-20', dia: "Miércoles", cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', dia: "Martes", cantidad: 10, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', dia: "Lunes", cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', dia: "Domingo", cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', dia: "Sábado", cantidad: 6, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', dia: "Viernes", cantidad: 4, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', dia: "Jueves", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ];

    const total = [
        {id: 1, fecha: '2024-03-20', dia: "Miércoles", cantidad: 10, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', dia: "Martes", cantidad: 13, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', dia: "Lunes", cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', dia: "Domingo", cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', dia: "Sábado", cantidad: 15, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', dia: "Viernes", cantidad: 7, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', dia: "Jueves", cantidad: 9, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ];
    */

    try {
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;

        //consulta una vista en la base de datos
        let sql = `SELECT * FROM _auth.resumen_login_sistema`;
        const resumen = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = {};

        if (resumen) {
                salida = {
                    maule_norte: resumen[0].maule_norte,
                    maule_sur: resumen[0].maule_sur,
                    total: resumen[0].total
                }
        }
        if (salida===undefined){
            res.status(500).send("Error en la consulta (servidor backend)");
        }else{
            res.status(200).send(salida);
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Error en la consulta (servidor backend)");
    }
}

// Lista un resumen del ingreso de obras en el sistema en los dias recientes
// GET /api/obras/backoffice/usosistema/v1/resumenobrasrecientes
exports.getObrasIngresadasResumen = async (req, res) => {
/*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
      #swagger.description = 'Lista un resumen del ingreso de obras en el sistema en los dias recientes' */
      /*
    const maule_norte = [
        {id: 1, fecha: '2024-03-20', dia: "Miércoles", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', dia: "Martes", cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', dia: "Lunes", cantidad: 3, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', dia: "Domingo", cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', dia: "Sábado", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', dia: "Viernes", cantidad: 2, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', dia: "Jueves", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ];
    const maule_sur = [
        {id: 1, fecha: '2024-03-20', dia: "Miércoles", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', dia: "Martes", cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', dia: "Lunes", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', dia: "Domingo", cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', dia: "Sábado", cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', dia: "Viernes", cantidad: 3, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', dia: "Jueves", cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ];
    const total = [
        {id: 1, fecha: '2024-03-20', dia: "Miércoles", cantidad: 2, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', dia: "Martes", cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', dia: "Lunes", cantidad: 4, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', dia: "Domingo", cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', dia: "Sábado", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', dia: "Viernes", cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', dia: "Jueves", cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ];*/

    try {
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;

        //consulta una vista en la base de datos
        let sql = `SELECT * FROM _auth.resumen_obras_ingresadas`;
        const resumen = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = {};

        if (resumen) {
                salida = {
                    maule_norte: resumen[0].maule_norte,
                    maule_sur: resumen[0].maule_sur,
                    total: resumen[0].total
                }
        }
        if (salida===undefined){
            res.status(500).send("Error en la consulta (servidor backend)");
        }else{
            res.status(200).send(salida);
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Error en la consulta (servidor backend)");
    }
}

// Lista cantidad de obras sin reporte recietes
// GET /api/obras/backoffice/usosistema/v1/resumenobrasinreportes
exports.getObrasSinRepDiario = async (req, res) => {
/*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
      #swagger.description = 'Lista cantidad de obras sin reporte recietes' */

      /*
    const periodo = {
        desde: '2024-03-13',
        hasta: '2024-03-20'
    };

    const cantidad = 5;

    const detalle = [
        {id: 1, codigo_obra: 'CGED-1234000', fecha_ultimo: '2024-03-20', dias_sin_rep: 2},
        {id: 2, codigo_obra: 'CGED-1113344', fecha_ultimo: '2024-03-01', dias_sin_rep: 17},
        {id: 3, codigo_obra: 'CGED-0098643', fecha_ultimo: '2024-03-15', dias_sin_rep: 5},
        {id: 4, codigo_obra: 'CGED-4362235', fecha_ultimo: '2024-03-18', dias_sin_rep: 2},
        {id: 5, codigo_obra: 'CGED-6841249', fecha_ultimo: '2024-03-12', dias_sin_rep: 8}
    ];

    const salida = {
        periodo: periodo,
        cantidad: cantidad,
        detalle: detalle
    };
*/
    try {
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;

        let sql = `
        SELECT ( SELECT row_to_json(c.*) AS periodo
           FROM ( SELECT (now()::timestamp without time zone AT TIME ZONE 'america/santiago'::text)::date - b.valor AS desde,
                    (now()::timestamp without time zone AT TIME ZONE 'america/santiago'::text)::date AS hasta
                   FROM ( SELECT
                                CASE
                                    WHEN a.valor IS NULL THEN 7
                                    ELSE a.valor
                                END AS valor
                           FROM ( SELECT sum(parametros_config.valor::integer)::integer AS valor
                                   FROM _comun.parametros_config
                                  WHERE parametros_config.clave::text = 'dias_reporte_sinrepdiario'::text) a) b) c) AS periodo,
        ( SELECT array_agg(row_to_json(z.*)) AS detalle
           FROM ( SELECT a.id_obra AS id,
                    a.codigo_obra,
                    a.fecha_reporte AS fecha_ultimo,
                    a.dias AS dias_sin_rep
                   FROM ( SELECT DISTINCT ON (erd.id_obra) erd.id_obra,
                            o.codigo_obra,
                            erd.fecha_reporte,
                            now()::date - erd.fecha_reporte AS dias
                           FROM obras.obras o
                             JOIN obras.encabezado_reporte_diario erd ON o.id = erd.id_obra
                          WHERE NOT o.eliminada AND (o.estado <> ALL (ARRAY[6, 7, 8]))
                          ORDER BY erd.id_obra, erd.fecha_reporte DESC) a
                  WHERE a.dias > (( SELECT
                                CASE
                                    WHEN a_1.valor IS NULL THEN 7
                                    ELSE a_1.valor
                                END AS valor
                           FROM ( SELECT sum(parametros_config.valor::integer)::integer AS valor
                                   FROM _comun.parametros_config
                                  WHERE parametros_config.clave::text = 'dias_reporte_sinrepdiario'::text) a_1))
                  ORDER BY a.fecha_reporte DESC) z) AS detalle;`;

        
        const resumen = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = {};

        if (resumen) {
                salida = {
                    periodo: resumen[0].periodo,
                    detalle: resumen[0].detalle,
                    cantidad: resumen[0].detalle.length
                }
        }
        if (salida===undefined){
            res.status(500).send("Error en la consulta (servidor backend)");
        }else{
            res.status(200).send(salida);
        }
    } catch (error) {
        res.status(500).send(error);
    }

}