const db = require("../../models");
const z = require('zod');
const EncabezadoCotizacion = db.encabezadoCotizacion;
const DetalleCotizacionActividad = db.detalleCotizacionActividad;
const DetalleCotizacionOtrasActividades = db.detalleCotizacionOtrasActividades;


const ZodError = z.ZodError;


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

/*********************************************************************************** */
/* Consulta todos los encabezados reportes diarios por parámetros
;
*/
exports.findAllEncabezadoCotizacionByParametros = async (req, res) => {
   /*  #swagger.tags = ['Obras - Backoffice - Cotizaciones']
      #swagger.description = 'Devuelve todos los encabezados de cotizacion por parametro
      , debe indicarse al menos uno' */
  const parametros = {
    id: req.query.id,
    id_obra: req.query.id_obra,
    fecha_cotizacion: req.query.fecha_cotizacion,
    mostrar_todos: req.query.mostrar_todos
  }
  //console.log(parametros);  
  const keys = Object.keys(parametros)
  let sql_array = [];
  let param = {};
  const campos_detalle = `,
	(SELECT ARRAY_AGG(detalle) as detalle_actividad 
                FROM (SELECT row_to_json(a) as detalle 
                      FROM (SELECT 
                              dco.id, 
                              row_to_json(top) as tipo_operacion, 
                              ma.tipo_actividad, row_to_json(ma) as actividad, 
                              cantidad, 
                              json_build_object('id', eco.id, 'id_obra', eco.id_obra, 'fecha_reporte', eco.fecha_cotizacion) 
                                as encabezado_cotizacion, 
                              case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 
                                then uc_traslado else 0 end as unitario, 
                              case when top.id = 1 then uc_instalacion when top.id = 2 then uc_retiro when top.id = 3 
                                then uc_traslado else 0 end * cantidad as total 
                            FROM 
                              obras.detalle_cotizacion_actividad dco 
                            JOIN obras.tipo_operacion top 
                              ON dco.tipo_operacion = top.id 
                            JOIN (SELECT ma.id, 
                                    actividad, 
                                    row_to_json(ta) as tipo_actividad, 
                                    uc_instalacion, 
                                    uc_retiro, 
                                    uc_traslado, 
                                    ma.descripcion, 
                                    row_to_json(mu) as unidad 
                                  FROM obras.maestro_actividades ma 
                                  JOIN obras.tipo_actividad ta 
                                      ON ma.id_tipo_actividad = ta.id 
                                  JOIN obras.maestro_unidades mu 
                                      ON ma.id_unidad = mu.id) ma 
                                ON dco.id_actividad = ma.id 
                            JOIN obras.encabezado_cotizacion eco 
                                ON dco.id_encabezado_cotizacion = eco.id 
                            WHERE dco.id_encabezado_cotizacion = ec.id
                            ) a
                      ) b
                ), 
              (SELECT ARRAY_AGG(detalle) as detalle_otros 
                FROM (SELECT row_to_json(a) as detalle 
                        FROM (SELECT 
                                eco.id, 
                                glosa, 
                                uc_unitaria, 
                                cantidad, 
                                total_uc,
                                unitario_pesos,
                                total_pesos, 
                                json_build_object('id', eco.id, 'id_obra', eco.id_obra, 'fecha_reporte', eco.fecha_cotizacion) 
                                  as encabezado_reporte 
                              FROM obras.detalle_cotizacion_otras_actividades dcot 
                              JOIN obras.encabezado_cotizacion eco 
                                  ON dcot.id_encabezado_cotizacion = eco.id 
                              WHERE dcot.id_encabezado_cotizacion = ec.id
                              ) a
                      ) b
                ) `;
  //console.log('campos_detalle', campos_detalle);
  let campos_adicionales = '';
  for (element of keys) {
    if (parametros[element]){
      if (element === "id") {
        sql_array.push("ec.id = :" + element);
        param[element] = Number(parametros[element]);
        campos_adicionales = campos_detalle;
      }
      if (element === "id_obra") {
        sql_array.push("o.id = :" + element);
        param[element] = Number(parametros[element]);
        campos_adicionales = campos_detalle;
      }
      if (element === "fecha_cotizacion") {
        sql_array.push("ec.fecha_cotizacion = :" + element);
        param[element] = String(parametros[element]);
      }
    }
  }
  //console.log('campos_adicionales', campos_adicionales);

  //console.log('sql_array', sql_array);
  if (sql_array.length === 0) {
    res.status(500).send("Debe incluir algun parametro para consultar");
  }else {
    try {
      //const condicion_muestra = parametros.mostrar_todos==="true"?"":" AND rd.id_estado_pago is null";
      ////console.log('condicion_muestra', condicion_muestra);
      let b = sql_array.reduce((total, num) => total + " AND " + num);
      if (b){
      
       const sql = `
          SELECT ec.id , json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, 
	fecha_cotizacion, row_to_json(d) as cliente, fecha_asignacion, row_to_json(tt) as tipo_trabajo
	, row_to_json(s) as segmento, solicitado_por, row_to_json(c) as comuna, direccion, fecha_ejecucion
	, ec.jefe_delegacion, codigo_pelom, row_to_json(jf) as jefe_faena, row_to_json(eco) as estado
	, json_build_object('id', sc.id, 'nombre', sc.nombre) as supervisor, valor_uc
    ${campos_adicionales}
	FROM obras.encabezado_cotizacion ec 
	JOIN obras.tipo_trabajo tt 
                ON ec.tipo_trabajo = tt.id 
            JOIN obras.obras o 
                ON ec.id_obra = o.id 
            LEFT JOIN obras.jefes_faena jf 
                ON ec.jefe_faena = jf.id 
			LEFT JOIN obras.delegaciones d
				ON ec.cliente = d.id
			LEFT JOIN obras.segmento s
				ON ec.segmento = s.id
			LEFT JOIN _comun.comunas c
				ON ec.comuna = c.codigo
			LEFT JOIN obras.estado_cotizacion eco 
				ON ec.estado = eco.id
			LEFT JOIN obras.supervisores_contratista sc
				ON ec.supervisor = sc.id
            WHERE (${b})`;
       

        //const sql = sql_all_reportes_diarios + ` WHERE ${b}`;

        const { QueryTypes } = require('sequelize'); 
        const sequelize = db.sequelize;
        const encabezadoCotizacion = await sequelize.query(sql, { replacements: param, type: QueryTypes.SELECT });
        let salida = [];
        if (encabezadoCotizacion) {
          for (const element of encabezadoCotizacion) {
            

            const detalle_salida = {
              id: Number(element.id),
              id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
              fecha_cotizacion: String(element.fecha_cotizacion),
              cliente: element.cliente, //json {"id": id, "nombre": nombre}
              fecha_asignacion: String(element.fecha_asignacion),
              tipo_trabajo: element.tipo_trabajo, //json {"id": id, "descripcion": descripcion}
              segmento: element.segmento, //json {"id": id, "nombre": nombre}
              solicitado_por: String(element.solicitado_por),
              comuna: element.comuna, //json {"id": id, "descripcion": descripcion}
              direccion: String(element.direccion),
              fecha_ejecucion: String(element.fecha_ejecucion),
              jefe_delegacion: String(element.jefe_delegacion),
              codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
              jefe_faena: element.jefe_faena,
              estado: element.estado?element.estado:null,
              supervisor: element.supervisor,
              valor_uc: String(element.valor_uc),
              detalle_actividad: element.detalle_actividad,
              detalle_otros: element.detalle_otros

            }
                salida.push(detalle_salida);
          };
        }
        if (salida===undefined){
          res.status(500).send("Error en la consulta (servidor backend)");
        }else{
          res.status(200).send(salida);
        }
      }else {
        res.status(500).send("Error en la consulta (servidor backend)");
      }
    }catch (error) {
      res.status(500).send(error);
    }
  }
}


/*********************************************************************************** */
/* Crea una cotización
;
*/
exports.createEncabezadoCotizacion = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Cotizaciones']
      #swagger.description = 'Crea un encabezado de cotización'
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos encabezado reporte diario',
            required: true,
            schema: {
                id_obra: 1,
                codigo_cotizacion: "123456",
                solicitado_por: "Nombre apellido",
                direccion: "direccion",
                fecha_ejecucion: "2026-10-25",
                jefe_faena: 1,
                supervisor: 1,
                detalle_actividad: [
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 1,
                      "cantidad": 1
                    },
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 2,
                      "cantidad": 3
                    }
                ],
                detalle_otros: [
                      {
                        "glosa": "descripcion de la tarea 1", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1,
                        "unitario_pesos": 1,
                        "total_pesos": 1
                      },
                      {
                        "glosa": "descripcion de la tarea 2", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1,
                        "unitario_pesos": 1,
                        "total_pesos": 1
                      }
                ]
            }
        } */
  try{
      let salir = false;
      const campos = [
        'id_obra', 'codigo_cotizacion', 'solicitado_por', 'direccion', 'supervisor'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send("No puede estar nulo el campo " + element
          );
          return;
        }
      };
      const id_obra = req.body.id_obra;


        // procesa detalle de actividad
        for (const element of req.body.detalle_actividad) {
          if (!element.clase || !element.actividad || !element.cantidad) {
            res.status(400).send("No puede estar nulo el campo " + element
            );
            return;
          }
        };

        const detalle_actividad = req.body.detalle_actividad;
        const detalle_otros = req.body.detalle_otros;
        if (Array.isArray(detalle_actividad)) {
          if (detalle_actividad.length==0) {
            //revisar arreglo de otras actividades
            if (Array.isArray(detalle_otros)) {
              if (detalle_otros.length==0) {
                res.status(400).send("Debe especificar al menos una actividad");
                return;
              }
            }
          }else {
            if (!detalle_actividad[0]) {
              res.status(400).send("El detalle debe tener al menos una actividad");
              return;
            }
            if (!detalle_actividad[0].clase) {
              salir = true;
              res.status(400).send("El campo clase en el detalle debe tener valor");
              return;
            }
            if (!detalle_actividad[0].tipo) {
              //console.log('a4')
              res.status(400).send("El campo tipo en el detalle debe tener valor");
              return;
            }
            if (!detalle_actividad[0].actividad) {
              //console.log('a5')
              res.status(400).send("El campo actividad en el detalle debe tener valor");
              return;
            }
            if (!detalle_actividad[0].cantidad) {
              //console.log('a6')
              res.status(400).send("El campo cantidad en el detalle debe tener valor");
              return;
            }
          }
        } else {
          //revisar arreglo de otras actividades
          if (Array.isArray(detalle_otros)) {
            if (detalle_otros.length==0) {
              res.status(400).send("Debe especificar al menos una actividad");
              return;
            }
          }else {
            res.status(400).send("Debe especificar al menos una actividad");
            return;
          }
        }


        // Busca el ID de encabezado disponible
        let sql = "select nextval('obras.encabezado_cotizacion_id_seq'::regclass) as valor";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let encabezado_cotizacion_id = 0;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          encabezado_cotizacion_id = data[0].valor;
        }).catch(err => {
          res.status(500).send(err.message );
        })

        //Determina el valor de la UC para esa obra
        let valor_uc = 0;
        sql = "SELECT (vu.precio*(100 - o.descuento_uc)/100)::integer AS valor_uc FROM obras.obras o	JOIN obras.oficina_supervisor os ON o.oficina = os.id JOIN obras.valor_uc vu ON os.oficina = vu.id WHERE o.id = " + id_obra + ";";
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          valor_uc = data[0].valor_uc;
        }).catch(err => {
          res.status(500).send(err.message );
        })
        if (!valor_uc) {
          res.status(500).send( 'No hay valor de UC para esta obra');
          return;
        }

        //determina el usario que está modificando
        let id_usuario = req.userId;
        let user_name;
        sql = "select username from _auth.users where id = " + id_usuario;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          user_name = data[0].username;
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })

        //determina fecha actual
        //const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
        //const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

        //determina datos para encabezado desde tabla obras
        let datos_obra = {};
        sql = `SELECT o.id as id_obra, 
        substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::date as fecha_cotizacion, 
        d.id as cliente, o.fecha_llegada as fecha_asignacion, tt.id as tipo_trabajo, s.id as segmento, c.codigo as comuna, 
        o.jefe_delegacion FROM obras.obras o 
        JOIN obras.tipo_trabajo tt ON o.tipo_trabajo = tt.id 
        LEFT JOIN obras.delegaciones d ON o.delegacion = d.id	
        LEFT JOIN obras.segmento s ON o.segmento = s.id 
        LEFT JOIN _comun.comunas c ON o.comuna = c.codigo 
        WHERE o.id = ${id_obra}`;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          datos_obra = data[0];
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })




        //Guarda historial

        const encabezado_cotizacion = {
            id: encabezado_cotizacion_id,
            id_obra: Number(id_obra),
            fecha_cotizacion: String(datos_obra.fecha_cotizacion),
            cliente: Number(datos_obra.cliente),
            fecha_asignacion: String(datos_obra.fecha_asignacion),
            tipo_trabajo: Number(datos_obra.tipo_trabajo),
            segmento: Number(datos_obra.segmento),
            solicitado_por: String(req.body.solicitado_por),
            comuna: String(datos_obra.comuna),
            direccion: String(req.body.direccion),
            fecha_ejecucion: String(req.body.fecha_ejecucion),
            jefe_delegacion: String(datos_obra.jefe_delegacion),
            codigo_pelom: String(req.body.codigo_cotizacion),
            jefe_faena: Number(req.body.jefe_faena),
            estado: 1,  //inicial
            supervisor: Number(req.body.supervisor),
            valor_uc: Number(valor_uc)
        }

        //console.log(encabezado_cotizacion);

        let salida = {};
        const t = await sequelize.transaction();
        try {

          salida = {"error": false, "message": "Cotización ingresada ok"};
          const encabezadoCotizacion = await EncabezadoCotizacion.create(encabezado_cotizacion, { transaction: t });
      

          for (const element of req.body.detalle_actividad) {
          const det_actividad = {
            id_encabezado_cotizacion: Number(encabezado_cotizacion_id),
            tipo_operacion: Number(element.clase),
            id_actividad: Number(element.actividad),
            cantidad: Number(element.cantidad)
          }
            await DetalleCotizacionActividad.create(det_actividad, { transaction: t });
          }


          for (const element of req.body.detalle_otros) {

            const unitario_pesos = element.unitario_pesos?Number(element.unitario_pesos):0;
            const cantidad = element.cantidad?Number(element.cantidad):0;
            const uc_unit = unitario_pesos&&valor_uc?Number(unitario_pesos/valor_uc):0;
            const uc_total = Number(uc_unit*cantidad);

            const det_otros = {
              id_encabezado_cotizacion: Number(encabezado_cotizacion_id),
              glosa: String(element.glosa),
              uc_unitaria: uc_unit,
              total_uc: uc_total,
              cantidad: cantidad,
              unitario_pesos: element.unitario_pesos?Number(element.unitario_pesos):0,
              total_pesos: element.total_pesos?Number(element.total_pesos):0
            }
            await DetalleCotizacionOtrasActividades.create(det_otros, { transaction: t });
          }

    
          await t.commit();
        } catch (error) {
          salida = { error: true, message: error }
          //console.log('Error Result ---> ', error);
          await t.rollback();
        }
        if (salida.error) {
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }
  }catch (error) {
    //console.log('error general 500 --> ', error);
    res.status(500).send(error);
  }
}

exports.updateEncabezadoCotizacion = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Cotizaciones']
      #swagger.description = 'Actualiza un encabezado de cotización'
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos encabezado reporte diario',
            required: true,
            schema: {
                id_obra: 1,
                codigo_cotizacion: "123456",
                solicitado_por: "Nombre apellido",
                direccion: "direccion",
                fecha_ejecucion: "2026-10-25",
                jefe_faena: 1,
                supervisor: 1,
                detalle_actividad: [
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 1,
                      "cantidad": 1
                    },
                    {
                      "clase": 1,
                      "tipo": 1,
                      "actividad": 2,
                      "cantidad": 3
                    }
                ],
                detalle_otros: [
                      {
                        "glosa": "descripcion de la tarea 1", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1,
                        "unitario_pesos": 1,
                        "total_pesos": 1
                      },
                      {
                        "glosa": "descripcion de la tarea 2", 
                        "uc_unitaria": 1, 
                        "cantidad": 1, 
                        "uc_total": 1,
                        "unitario_pesos": 1,
                        "total_pesos": 1
                      }
                ]
            }
        } */
  try{
      const encabezado_cotizacion_id = req.params.id;
      let salir = false;
      const campos = [
        'id_obra', 'codigo_cotizacion', 'solicitado_por', 'direccion', 'supervisor'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send("No puede estar nulo el campo " + element
          );
          return;
        }
      };
      const id_obra = req.body.id_obra;


        // procesa detalle de actividad
        for (const element of req.body.detalle_actividad) {
          if (!element.clase || !element.actividad || !element.cantidad) {
            res.status(400).send("No puede estar nulo el campo " + element
            );
            return;
          }
        };

        const detalle_actividad = req.body.detalle_actividad;
        const detalle_otros = req.body.detalle_otros;
        if (Array.isArray(detalle_actividad)) {
          if (detalle_actividad.length==0) {
            //revisar arreglo de otras actividades
            if (Array.isArray(detalle_otros)) {
              if (detalle_otros.length==0) {
                res.status(400).send("Debe especificar al menos una actividad");
                return;
              }
            }
          }else {
            if (!detalle_actividad[0]) {
              res.status(400).send("El detalle debe tener al menos una actividad");
              return;
            }
            if (!detalle_actividad[0].clase) {
              salir = true;
              res.status(400).send("El campo clase en el detalle debe tener valor");
              return;
            }
            if (!detalle_actividad[0].tipo) {
              //console.log('a4')
              res.status(400).send("El campo tipo en el detalle debe tener valor");
              return;
            }
            if (!detalle_actividad[0].actividad) {
              //console.log('a5')
              res.status(400).send("El campo actividad en el detalle debe tener valor");
              return;
            }
            if (!detalle_actividad[0].cantidad) {
              //console.log('a6')
              res.status(400).send("El campo cantidad en el detalle debe tener valor");
              return;
            }
          }
        } else {
          //revisar arreglo de otras actividades
          if (Array.isArray(detalle_otros)) {
            if (detalle_otros.length==0) {
              res.status(400).send("Debe especificar al menos una actividad");
              return;
            }
          }else {
            res.status(400).send("Debe especificar al menos una actividad");
            return;
          }
        }


        //Determina el valor de la UC para esa obra
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let valor_uc = 0;
        sql = "SELECT (vu.precio*(100 - o.descuento_uc)/100)::integer AS valor_uc FROM obras.obras o	JOIN obras.oficina_supervisor os ON o.oficina = os.id JOIN obras.valor_uc vu ON os.oficina = vu.id WHERE o.id = " + id_obra + ";";
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          valor_uc = data[0].valor_uc;
        }).catch(err => {
          res.status(500).send(err.message );
        })
        if (!valor_uc) {
          res.status(500).send( 'No hay valor de UC para esta obra');
          return;
        }

        //determina el usario que está modificando
        let id_usuario = req.userId;
        let user_name;
        sql = "select username from _auth.users where id = " + id_usuario;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          user_name = data[0].username;
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })

        //determina fecha actual
        //const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
        //const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

        //determina datos para encabezado desde tabla obras
        let datos_obra = {};
        sql = `SELECT o.id as id_obra, 
        substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::date as fecha_cotizacion, 
        d.id as cliente, o.fecha_llegada as fecha_asignacion, tt.id as tipo_trabajo, s.id as segmento, c.codigo as comuna, 
        o.jefe_delegacion FROM obras.obras o 
        JOIN obras.tipo_trabajo tt ON o.tipo_trabajo = tt.id 
        LEFT JOIN obras.delegaciones d ON o.delegacion = d.id	
        LEFT JOIN obras.segmento s ON o.segmento = s.id 
        LEFT JOIN _comun.comunas c ON o.comuna = c.codigo 
        WHERE o.id = ${id_obra}`;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          datos_obra = data[0];
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })




        //Guarda historial

        const encabezado_cotizacion = {
            id_obra: Number(id_obra),
            fecha_cotizacion: String(datos_obra.fecha_cotizacion),
            cliente: Number(datos_obra.cliente),
            fecha_asignacion: String(datos_obra.fecha_asignacion),
            tipo_trabajo: Number(datos_obra.tipo_trabajo),
            segmento: Number(datos_obra.segmento),
            solicitado_por: String(req.body.solicitado_por),
            comuna: String(datos_obra.comuna),
            direccion: String(req.body.direccion),
            fecha_ejecucion: String(req.body.fecha_ejecucion),
            jefe_delegacion: String(datos_obra.jefe_delegacion),
            codigo_pelom: String(req.body.codigo_cotizacion),
            jefe_faena: Number(req.body.jefe_faena),
            supervisor: Number(req.body.supervisor),
            valor_uc: Number(valor_uc)
        }

        //console.log(encabezado_cotizacion);

        let salida = {};
        const t = await sequelize.transaction();
        try {

          salida = {"error": false, "message": "Cotización ingresada ok"};
          //Limpia tablas de detalle
          await DetalleCotizacionActividad.destroy({ where: { id_encabezado_cotizacion: encabezado_cotizacion_id }, transaction: t });
          await DetalleCotizacionOtrasActividades.destroy({ where: { id_encabezado_cotizacion: encabezado_cotizacion_id }, transaction: t });

          //actualiza encabezado cotizacion
          const encabezadoCotizacion = await EncabezadoCotizacion.update(encabezado_cotizacion, { where: { id: encabezado_cotizacion_id }, transaction: t });
      

          for (const element of req.body.detalle_actividad) {
            const det_actividad = {
              id_encabezado_cotizacion: Number(encabezado_cotizacion_id),
              tipo_operacion: Number(element.clase),
              id_actividad: Number(element.actividad),
              cantidad: Number(element.cantidad)
            }
            await DetalleCotizacionActividad.create(det_actividad, { transaction: t });
          }


          for (const element of req.body.detalle_otros) {

            const unitario_pesos = element.unitario_pesos?Number(element.unitario_pesos):0;
            const cantidad = element.cantidad?Number(element.cantidad):0;
            const uc_unit = unitario_pesos&&valor_uc?Number(unitario_pesos/valor_uc):0;
            const uc_total = Number(uc_unit*cantidad);

            const det_otros = {
              id_encabezado_cotizacion: Number(encabezado_cotizacion_id),
              glosa: String(element.glosa),
              uc_unitaria: uc_unit,
              total_uc: uc_total,
              cantidad: cantidad,
              unitario_pesos: element.unitario_pesos?Number(element.unitario_pesos):0,
              total_pesos: element.total_pesos?Number(element.total_pesos):0
            }
            await DetalleCotizacionOtrasActividades.create(det_otros, { transaction: t });
          }

    
          await t.commit();
        } catch (error) {
          salida = { error: true, message: error }
          //console.log('Error Result ---> ', error);
          await t.rollback();
        }
        if (salida.error) {
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }
  }catch (error) {
    //console.log('error general 500 --> ', error);
    res.status(500).send(error);
  }
}

exports.deleteEncabezadoCotizacion = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Cotizaciones']
      #swagger.description = 'Borra un encabezado de cotización y sus detalles por ID' */
  try{
    const id = req.params.id;
    const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
    const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

  
    //Primer debe eliminar el detalle actividad por id de encabezado, luego borrar el detalle otros y por ultimo el encabezado

    const sequelize = db.sequelize;
    const result = await sequelize.transaction(async () => {
        let salida = {};
        await DetalleCotizacionActividad.destroy({ where: { id_encabezado_cotizacion: id } });
        await DetalleCotizacionOtrasActividades.destroy({ where: { id_encabezado_cotizacion: id } });


        await EncabezadoCotizacion.destroy({
          where: { id: id }
        }).then(data => {
          if (data > 0) {
            salida = { message: `Cotización eliminada`}
          } else {
            salida = { message: `No existe la cotización con id ${id}` }
          }
        });
        return salida;
      });
    if (result.message==="Cotización eliminada") {
      res.status(200).send(result);
    }else {
      res.status(400).send(result.message);
    }
  }catch (error) {
    //console.log('error general 500 --> ', error);
    res.status(500).send(error);
  }

}

exports.getHistoricoEstadosPagoByIdCotizacion = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Cotizaciones']
      #swagger.description = 'Obtiene todos los datos para completar la cotización por id ' */
      try {
        const id_cotizacion = req.query.id_cotizacion;
        const campos = [
            'id_cotizacion'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send(
                "No puede estar nulo el campo " + element
              );
              return;
            }
          };
  


              const encabezado = await DeterminaEncabezadoCotizacion(id_cotizacion);
              //console.log(encabezado);
              if (encabezado.error) {
                res.status(500).send(encabezado.detalle);
                return;
              } 

              const detalle_avances = []
              let descuento_avance = 0;

              const actividadesNormales = await listadoActividadesByIdCotizacion(id_cotizacion);
              let subtotal1 = actividadesNormales.detalle.reduce(((total, num) => total + num.total_pesos), 0);
                
              const actividadesAdicionales = await listadoActividadesAdicionalesByIdObra(id_cotizacion);
              let subtotal2 = actividadesAdicionales.detalle.reduce(((total, num) => total + num.total_pesos), 0);

              let subtotal3 = 0;

              let recargosExtra = null;

               //Chequear si que el total del estado paga sea mayor a cero, si no es así se debe devolver un error
              if (subtotal1+subtotal2+subtotal3-descuento_avance <= 0 ) {
                res.status(500).send("No es posible crear una cotización con un total menor o igual a 0");
                return;
              }

                const valorNeto = Number(Number(subtotal1)+Number(subtotal2)+Number(subtotal3));
                const totalNeto = Number(valorNeto - Number(descuento_avance));
                const total = Number((totalNeto * 1.19).toFixed(0));
                const iva = Number(Number(total - totalNeto).toFixed(0));

                const totales = {

                  subtotal1: Number(subtotal1),
                  subtotal2: Number(subtotal2),
                  subtotal3: Number(subtotal3),
                  valorNeto: valorNeto,
                  descuentoAvance: Number(descuento_avance),
                  totalNeto: totalNeto,
                  total: total,
                  iva: iva
                }

                const detalle_salida = {
                  encabezado: encabezado.detalle[0],
                  totales: totales,
                  actividades_por_obra: !actividadesNormales.error?actividadesNormales.detalle:undefined,
                  actividades_adicionales: !actividadesAdicionales.error?actividadesAdicionales.detalle:undefined,
                  actividades_hora_extra: undefined,
                  avances_estado_pago: detalle_avances,
                  recargos_extra: recargosExtra
                }

              res.status(200).send(detalle_salida);
            
          
      } catch (error) {
          //console.log('error Historico  --> ', error)
          res.status(500).send(error);
      }
}


let listadoActividadesByIdCotizacion = async (id_cotizacion) => {
  try {

    const sql = `SELECT 
                    top.clase, 
                    ta.descripcion tipo, 
                    (case when e.porcentaje is null or e.porcentaje = 0 then '' else e.nombre_corto end || ma.actividad) as actividad, 
                    mu.codigo_corto as unidad, 
                    e.cantidad, 
                    case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' 
                    then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, 
                    (SELECT (precio*(100 - e.descuento_uc)/100)::integer AS precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    e.porcentaje as porcentaje, 
                    e.recargo_distancia,
                    e.descripcion_hextra,
                    e.descripcion_distancia 
                FROM 
                  (SELECT drda.tipo_operacion, 
                          drda.id_actividad, 
                          sum(drda.cantidad) as cantidad, 
                          ''::varchar as nombre_corto,
                          ''::varchar as descripcion_hextra,  
                          rec1.porcentaje as recargo_distancia,
                          rec1.nombre as descripcion_distancia, 
                          0 as porcentaje, 
                          o.oficina, o.descuento_uc 
                    FROM obras.encabezado_cotizacion erd 
                      JOIN obras.detalle_cotizacion_actividad drda 
                            ON erd.id = drda.id_encabezado_cotizacion 
                      JOIN obras.obras o 
                            ON erd.id_obra = o.id 
                      LEFT JOIN obras.recargos rec1 
                            ON o.recargo_distancia = rec1.id 
                    WHERE erd.id = ${id_cotizacion}
                    GROUP BY 
                        drda.tipo_operacion, 
                        drda.id_actividad, 
                        rec1.porcentaje, 
				   		rec1.nombre,
                        o.oficina,
                        o.descuento_uc
                  ) e 
                JOIN obras.maestro_actividades ma 
                    ON e.id_actividad = ma.id 
                JOIN obras.tipo_operacion top 
                    ON e.tipo_operacion = top.id 
                JOIN obras.tipo_actividad ta 
                    ON ma.id_tipo_actividad = ta.id 
                JOIN obras.maestro_unidades mu 
                    ON ma.id_unidad = mu.id 
                WHERE 
                    e.porcentaje = 0 
                    AND ta.id <> 9`;
            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;
            const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
            let salida = [];
            if (actividades) {
                
                for (const element of actividades) {

                      const total_neto = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));
                      const total_peso = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));

                      const detalle_salida = {
                        clase: String(element.clase),
                        tipo: String(element.tipo),
                        actividad: String(element.actividad), 
                        unidad: String(element.unidad),
                        cantidad: Number(element.cantidad),
                        unitario: Number(element.unitario),
                        unitario_pesos: Number(element.unitario * element.valor_uc),
                        total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                        recargos: undefined,
                        total_pesos: total_peso,
                        total_neto: total_neto,                       
                      }
                      salida.push(detalle_salida);
                };
              }
              const retorna = {
                error: false,
                detalle: salida
              }
              return retorna;
  }catch (error) {
   
    const retorna = {
      error: true,
      detalle: error
    }
    return retorna;
  }
  
}

let listadoActividadesAdicionalesByIdObra = async (id_cotizacion) => {
  try {


    const sql = `SELECT 
                    top.clase, 
                    ta.descripcion tipo, 
                    (case when e.porcentaje is null or e.porcentaje = 0 
                          then '' else e.nombre_corto end || ma.actividad) as actividad, 
                    mu.codigo_corto as unidad, 
                    e.cantidad, 
                    case when top.clase = 'I' then ma.uc_instalacion when top.clase = 'R' 
                          then ma.uc_retiro when top.clase = 'T' then ma.uc_traslado else 999::double precision end as unitario, 
                    (SELECT  (precio*(100 - e.descuento_uc)/100)::integer AS precio FROM obras.valor_uc where oficina = e.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    e.porcentaje as porcentaje, 
                    e.recargo_distancia 
                FROM 
                    (SELECT 
                        drda.tipo_operacion, 
                        drda.id_actividad, 
                        sum(drda.cantidad) as cantidad, 
                        ''::varchar as nombre_corto, 
                        rec1.porcentaje as recargo_distancia, 
                        0 as porcentaje, 
                        o.oficina, o.descuento_uc 
                            FROM 
                                obras.encabezado_cotizacion erd 
                            JOIN obras.detalle_cotizacion_actividad drda 
                                ON erd.id = drda.id_encabezado_cotizacion 
                            JOIN obras.obras o 
                                ON erd.id_obra = o.id 
                            LEFT JOIN obras.recargos rec1 
                                ON o.recargo_distancia = rec1.id 
                            WHERE erd.id = ${id_cotizacion} 
                            GROUP BY 
                                drda.tipo_operacion, 
                                drda.id_actividad,  
                                rec1.porcentaje, 
                                o.oficina,
                                o.descuento_uc
                    ) e 
                JOIN obras.maestro_actividades ma 
                      ON e.id_actividad = ma.id 
                JOIN obras.tipo_operacion top 
                      ON e.tipo_operacion = top.id 
                JOIN obras.tipo_actividad ta 
                      ON ma.id_tipo_actividad = ta.id 
                JOIN obras.maestro_unidades mu 
                      ON ma.id_unidad = mu.id 
                WHERE e.porcentaje = 0 
                AND ta.id = 9 
            UNION 
                SELECT 
                    'I'::char as clase, 
                    'Adicionales'::varchar as tipo, 
                    glosa as actividad, 
                    'CU'::varchar, 
                    cantidad, 
                    uc_unitaria::double precision as unitario, 
                    (SELECT  (precio*(100 - o.descuento_uc)/100)::integer AS precio FROM obras.valor_uc where oficina = o.oficina order by oficina, fecha desc limit 1) as valor_uc, 
                    0 as porcentaje, 
                    rec1.porcentaje as recargo_distancia 
                FROM 
                    obras.detalle_cotizacion_otras_actividades drdoa 
                JOIN obras.encabezado_cotizacion erd 
                    ON drdoa.id_encabezado_cotizacion = erd.id
                JOIN obras.obras o 
                    ON erd.id_obra = o.id  
                LEFT JOIN obras.recargos rec1 
                    ON o.recargo_distancia = rec1.id 
                WHERE erd.id = ${id_cotizacion} 
                ORDER BY 1,2,3;`;

    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const actividades = await sequelize.query(sql, { type: QueryTypes.SELECT });
    let salida = [];
    if (actividades) 
    {    
        for (const element of actividades) 
        {
              const total_neto = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc).toFixed(0));
              const total_peso = Number((Number(element.cantidad) * Number(element.unitario) * element.valor_uc * (1+element.recargo_distancia/100)).toFixed(0));

  
              const detalle_salida = 
              {
                  clase: String(element.clase),
                  tipo: String(element.tipo),
                  actividad: String(element.actividad),
                  unidad: String(element.unidad),
                  cantidad: Number(element.cantidad),
                  unitario: Number(element.unitario).toFixed(3),
                  unitario_pesos: Number(element.unitario * element.valor_uc),
                  total: Number((Number(element.cantidad) * Number(element.unitario)).toFixed(2)),
                  recargos: element.recargo_distancia?element.recargo_distancia.toString()+'%':'0%',
                  total_pesos: total_peso,
                  total_neto: total_neto
                  
              }
              salida.push(detalle_salida);
        };
    }
    const retorna = 
    {
        error: false,
        detalle: salida
    }
    return retorna;
  } 
    catch (error) 
  {
    const retorna = 
    {
        error: true,
        detalle: error
    }
    return retorna;
  }
}

let DeterminaEncabezadoCotizacion = async (id_cotizacion) => {

  try {
    if (!id_cotizacion) return { error: true, detalle: 'No puede estar vacio el id_obra' };

     const sql = `SELECT ec.id , json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, 
              fecha_cotizacion, row_to_json(d) as cliente, fecha_asignacion, row_to_json(tt) as tipo_trabajo
              , row_to_json(s) as segmento, solicitado_por, row_to_json(c) as comuna, direccion, fecha_ejecucion
              , ec.jefe_delegacion, codigo_pelom, row_to_json(jf) as jefe_faena, row_to_json(eco) as estado
              , row_to_json(ofi) as supervisor_pelom, valor_uc
              FROM obras.encabezado_cotizacion ec 
              JOIN obras.tipo_trabajo tt 
                            ON ec.tipo_trabajo = tt.id 
                        JOIN obras.obras o 
                            ON ec.id_obra = o.id 
                        LEFT JOIN obras.jefes_faena jf 
                            ON ec.jefe_faena = jf.id 
                  LEFT JOIN obras.delegaciones d
                    ON ec.cliente = d.id
                  LEFT JOIN obras.segmento s
                    ON ec.segmento = s.id
                  LEFT JOIN _comun.comunas c
                    ON ec.comuna = c.codigo
                  LEFT JOIN obras.estado_cotizacion eco 
                    ON ec.estado = eco.id
                  LEFT JOIN obras.supervisores_contratista sc
                    ON ec.supervisor = sc.id
				  LEFT JOIN (SELECT os.id, o.nombre as oficina, initcap(so.nombre) as supervisor,
                              so.rut as rut 
                                  FROM obras.oficina_supervisor os 
                                  JOIN _comun.oficinas o ON os.oficina = o.id 
                                  JOIN obras.supervisores_contratista so ON os.supervisor = so.id) ofi 
                            ON o.oficina = ofi.id
            WHERE ec.id = ${id_cotizacion};`;
          
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const nuevoEncabezado = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = [];
        if (nuevoEncabezado) {
            
            for (const element of nuevoEncabezado) {
      
                  const detalle_salida = {
                    id_obra: Number(element.id_obra.id),
                    fecha_cotizacion: element.fecha_cotizacion?String(element.fecha_cotizacion):null,
                    cliente: element.cliente,
                    fecha_asignacion: element.fecha_asignacion?String(element.fecha_asignacion):null,
                    tipo_trabajo: element.tipo_trabajo,
                    segmento: element.segmento,
                    solicitado_por: element.solicitado_por?String(element.solicitado_por):null,
                    comuna: element.comuna,
                    direccion: element.direccion?String(element.direccion):null,
                    fecha_ejecucion: element.fecha_ejecucion?String(element.fecha_ejecucion):null,
                    jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
                    codigo_pelom: element.codigo_pelom?String(element.codigo_pelom):null,
                    jefe_faena: element.jefe_faena,
                    estado: Number(element.estado.id),
                    supervisor_pelom: element.supervisor_pelom,
                    valor_uc: element.valor_uc?Number(element.valor_uc):null,
                  }
                  salida.push(detalle_salida);
            };
          }
          if (salida===undefined){
            //res.status(500).send("Error en la consulta (servidor backend)");
            const retorna = 
              {
                  error: true,
                  detalle: "Error en la consulta (servidor backend)"
              }
              return retorna;
          }else{
            //res.status(200).send(salida);
            const retorna = 
              {
                  error: false,
                  detalle: salida
              }
              return retorna;
          }

  }catch (error) 
  {
    const retorna = 
      {
          error: true,
          detalle: error
      }
      return retorna;

  }


}

