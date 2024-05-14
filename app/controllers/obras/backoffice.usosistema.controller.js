const db = require("../../models");
const z = require('zod');
const ZodError = z.ZodError;
/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 USO DEL SISTEMA                                */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/
const customErrorMap = (issue, ctx) => {
    if (issue.code === z.ZodIssueCode.invalid_type) {
      if (issue.received === "undefined") {
        return { message: "Es requerido" };
      }
      if (issue.received === "null") {
        return { message: "No puede ser nulo" };
      }
      if (issue.expected === "string") {
        return { message: "Debe ser una cadena de texto" };
      }
      if (issue.expected === "number") {
        return { message: "Debe ser un numero" };
      }
      if (issue.expected === "date") {
        return { message: "Debe ser una fecha" };
      }
    }
    if (issue.code === z.ZodIssueCode.invalid_string) {
      if (issue.validation === "email") {
        return { message: "El formato no es correcto, debe ser un email" };
      }
      return { message: "El formato no es correcto" };
    }
    if (issue.code === z.ZodIssueCode.too_small) {
      return { message: `debe ser mayor que ${issue.minimum}` };
    }
    if (issue.code === z.ZodIssueCode.custom) {
      return { message: `menor-que-${(issue.params || {}).minimum}` };
    }
    return { message: ctx.defaultError };
  };
  
  z.setErrorMap(customErrorMap);


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
				 	a.nombre_obra,
                    a.fecha_reporte AS fecha_ultimo,
                    a.dias AS dias_sin_rep
                   FROM ( SELECT DISTINCT ON (erd.id_obra) erd.id_obra,
                            o.codigo_obra,
						 	o.nombre_obra,
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

//Lista de los reportes diarios en los últimos días
// GET /api/obras/backoffice/usosistema/v1/reportesdiarios_pordia
exports.getReportesDiariosPorDia = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
          #swagger.description = 'Devuelve el listado de reportes diarios por día' */
    
        try {
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
    
            //consulta una vista en la base de datos
            let sql = `
            SELECT ( SELECT array_agg(row_to_json(z.*)) AS maule_norte
            FROM ( SELECT row_number() OVER (ORDER BY serie.fecha) AS id,
                     serie.fecha,
                     ( SELECT
                                 CASE
                                     WHEN a.dia = 0 THEN 'Domingo'::text
                                     WHEN a.dia = 1 THEN 'Lunes'::text
                                     WHEN a.dia = 2 THEN 'Martes'::text
                                     WHEN a.dia = 3 THEN 'Miércoles'::text
                                     WHEN a.dia = 4 THEN 'Jueves'::text
                                     WHEN a.dia = 5 THEN 'Viernes'::text
                                     WHEN a.dia = 6 THEN 'Sábado'::text
                                     ELSE NULL::text
                                 END AS nombre_dia
                            FROM ( SELECT EXTRACT(dow FROM serie.fecha)::integer AS dia) a) AS dia,
                         CASE
                             WHEN reportes.cantidad IS NULL THEN 0::bigint
                             ELSE reportes.cantidad
                         END AS cantidad,
                          CASE
                             WHEN EXTRACT(dow FROM serie.fecha) = 0::numeric THEN 'bg-pink-500'::character varying
                             ELSE 'bg-cyan-500'::character varying
                         END AS "bg-color",
                         CASE
                             WHEN EXTRACT(dow FROM serie.fecha) = 0::numeric THEN 'text-pink-500'::character varying
                             ELSE 'text-cyan-500'::character varying
                         END AS "text-color"
                    FROM ( SELECT (now()::timestamp without time zone AT TIME ZONE 'america/santiago'::text)::date - a.num AS fecha
                            FROM ( SELECT generate_series(0::bigint, b.valor)::integer AS num
                                    FROM ( SELECT
   CASE
    WHEN a_1.valor IS NULL THEN 7::bigint
    ELSE a_1.valor
   END AS valor
    FROM ( SELECT sum(parametros_config.valor::integer) AS valor
      FROM _comun.parametros_config
     WHERE parametros_config.clave::text = 'dias_reporte_ingresadas'::text) a_1) b) a) serie
                      LEFT JOIN ( SELECT erd.fecha_ingreso::date,
                             count(erd.fecha_ingreso::date) AS cantidad
                            FROM obras.encabezado_reporte_diario erd
                              JOIN obras.obras o ON erd.id_obra = o.id
                           WHERE o.zona = 1
                           GROUP BY erd.fecha_ingreso::date
                           ORDER BY erd.fecha_ingreso::date) reportes ON reportes.fecha_ingreso = serie.fecha) z) AS maule_norte,
     ( SELECT array_agg(row_to_json(z.*)) AS maule_norte
            FROM ( SELECT row_number() OVER (ORDER BY serie.fecha) AS id,
                     serie.fecha,
                     ( SELECT
                                 CASE
                                     WHEN a.dia = 0 THEN 'Domingo'::text
                                     WHEN a.dia = 1 THEN 'Lunes'::text
                                     WHEN a.dia = 2 THEN 'Martes'::text
                                     WHEN a.dia = 3 THEN 'Miércoles'::text
                                     WHEN a.dia = 4 THEN 'Jueves'::text
                                     WHEN a.dia = 5 THEN 'Viernes'::text
                                     WHEN a.dia = 6 THEN 'Sábado'::text
                                     ELSE NULL::text
                                 END AS nombre_dia
                            FROM ( SELECT EXTRACT(dow FROM serie.fecha)::integer AS dia) a) AS dia,
                         CASE
                             WHEN reportes.cantidad IS NULL THEN 0::bigint
                             ELSE reportes.cantidad
                         END AS cantidad,
                          CASE
                             WHEN EXTRACT(dow FROM serie.fecha) = 0::numeric THEN 'bg-pink-500'::character varying
                             ELSE 'bg-cyan-500'::character varying
                         END AS "bg-color",
                         CASE
                             WHEN EXTRACT(dow FROM serie.fecha) = 0::numeric THEN 'text-pink-500'::character varying
                             ELSE 'text-cyan-500'::character varying
                         END AS "text-color"
                    FROM ( SELECT (now()::timestamp without time zone AT TIME ZONE 'america/santiago'::text)::date - a.num AS fecha
                            FROM ( SELECT generate_series(0::bigint, b.valor)::integer AS num
                                    FROM ( SELECT
   CASE
    WHEN a_1.valor IS NULL THEN 7::bigint
    ELSE a_1.valor
   END AS valor
    FROM ( SELECT sum(parametros_config.valor::integer) AS valor
      FROM _comun.parametros_config
     WHERE parametros_config.clave::text = 'dias_reporte_ingresadas'::text) a_1) b) a) serie
                      LEFT JOIN ( SELECT erd.fecha_ingreso::date,
                             count(erd.fecha_ingreso::date) AS cantidad
                            FROM obras.encabezado_reporte_diario erd
                              JOIN obras.obras o ON erd.id_obra = o.id
                           WHERE o.zona = 2
                           GROUP BY erd.fecha_ingreso::date
                           ORDER BY erd.fecha_ingreso::date) reportes ON reportes.fecha_ingreso = serie.fecha) z) AS maule_sur,
     ( SELECT array_agg(row_to_json(z.*)) AS maule_norte
            FROM ( SELECT row_number() OVER (ORDER BY serie.fecha) AS id,
                     serie.fecha,
                     ( SELECT
                                 CASE
                                     WHEN a.dia = 0 THEN 'Domingo'::text
                                     WHEN a.dia = 1 THEN 'Lunes'::text
                                     WHEN a.dia = 2 THEN 'Martes'::text
                                     WHEN a.dia = 3 THEN 'Miércoles'::text
                                     WHEN a.dia = 4 THEN 'Jueves'::text
                                     WHEN a.dia = 5 THEN 'Viernes'::text
                                     WHEN a.dia = 6 THEN 'Sábado'::text
                                     ELSE NULL::text
                                 END AS nombre_dia
                            FROM ( SELECT EXTRACT(dow FROM serie.fecha)::integer AS dia) a) AS dia,
                         CASE
                             WHEN reportes.cantidad IS NULL THEN 0::bigint
                             ELSE reportes.cantidad
                         END AS cantidad,
                          CASE
                             WHEN EXTRACT(dow FROM serie.fecha) = 0::numeric THEN 'bg-pink-500'::character varying
                             ELSE 'bg-cyan-500'::character varying
                         END AS "bg-color",
                         CASE
                             WHEN EXTRACT(dow FROM serie.fecha) = 0::numeric THEN 'text-pink-500'::character varying
                             ELSE 'text-cyan-500'::character varying
                         END AS "text-color"
                    FROM ( SELECT (now()::timestamp without time zone AT TIME ZONE 'america/santiago'::text)::date - a.num AS fecha
                            FROM ( SELECT generate_series(0::bigint, b.valor)::integer AS num
                                    FROM ( SELECT
   CASE
    WHEN a_1.valor IS NULL THEN 7::bigint
    ELSE a_1.valor
   END AS valor
    FROM ( SELECT sum(parametros_config.valor::integer) AS valor
      FROM _comun.parametros_config
     WHERE parametros_config.clave::text = 'dias_reporte_ingresadas'::text) a_1) b) a) serie
                      LEFT JOIN ( SELECT erd.fecha_ingreso::date,
                             count(erd.fecha_ingreso::date) AS cantidad
                            FROM obras.encabezado_reporte_diario erd
                              JOIN obras.obras o ON erd.id_obra = o.id
                           WHERE o.zona = ANY (ARRAY[1, 2])
                           GROUP BY erd.fecha_ingreso::date
                           ORDER BY erd.fecha_ingreso::date) reportes ON reportes.fecha_ingreso = serie.fecha) z) AS total;`;

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

//Lista de los cambios realizados al programa
// GET /api/obras/backoffice/usosistema/v1/changelog
exports.getChangeLog = async (req, res) => {
    //metodo GET
  /*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
    #swagger.description = 'Devuelve todos los cambios realizados al programa (Change Log)' */
  try {
    //metodo GET
    
    const IDataCambiosSchema = z.object({
        tipo_cambio: z.coerce.string(),
        descripcion: z.coerce.string(),
        version_front: z.coerce.string(),
        version_back: z.coerce.string()
    });

    const IDataOutputSchema = z.object({
      fecha: z.coerce.string(),
      datos: z.array(IDataCambiosSchema)
    });
    const IArrayDataOutputSchema = z.array(IDataOutputSchema);
      
    
    const sql = `SELECT fecha, ARRAY_AGG(datos) as datos FROM (select to_char(fecha::date, 'DD/MM/YYYY') as fecha, 
                    json_build_object('tipo_cambio', tipo_cambio, 'descripcion', 
                    descripcion, 'version_front', version_front, 'version_back', version_back) as datos 
                    FROM _frontend.changelog ORDER BY fecha::date DESC, tipo_cambio, id) as a GROUP BY fecha order by fecha DESC`;
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const changelog = await sequelize.query(sql, { type: QueryTypes.SELECT });
    const salida = IArrayDataOutputSchema.parse(changelog);
    res.status(200).send(salida);

  } catch (error) {
      if (error instanceof ZodError) {
        console.log(error.issues);
        const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
        res.status(400).send(mensaje);  //bad request
        return;
      }
      console.log(error);
      res.status(500).send(error);
  }
}