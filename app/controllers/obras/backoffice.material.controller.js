const db = require("../../models");
const fs = require('fs');
const excel = require("exceljs");
const z = require('zod');
const ZodError = z.ZodError;

const Obra = db.obra;
const MaestroMateriales = db.maestroMateriales;
const ConexionDaia = db.conexionDaia;
const MovimientosBodega = db.movimientosBodega;
const MovimientoTipoDoc = db.movimientoTipoDoc;
const SolicitudMaterialEncabezado = db.solicitudMaterialEncabezado;
const SolicitudMaterialDetalle = db.solicitudMaterialDetalle;



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
      if (issue.expected === "object") {
        return { message: "Debe ser un objeto JSON, pero llegó " + issue.received };
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


const ICodigoSapSchema = z.coerce.number().int().gt(0);
const IUnidadSapSchema = z.string().min(1);
const ICantidadMaterialSchema = z.coerce.number().gt(0);

const ISapMaterialSchema = z.object({
  codigo_sap: ICodigoSapSchema,
  descripcion: z.coerce.string().min(1),
  unidad: IUnidadSapSchema,
});

const IMaterialCantidadSchema = z.object({
  sap_material: ISapMaterialSchema,
  cantidad: ICantidadMaterialSchema
});


exports.lee_daia = async (req, res) => {

    try { 
        const sql = `SELECT cd.id, 
                            cd.accion, 
                            cd.fecha_hora, 
                            cd.datos, 
                            cd.estado 
                        FROM material.conexion_daia cd 
                        JOIN material.estado_conexion_daia ecd 
                            ON cd.estado = ecd.id 
                        WHERE ecd.ingresado`;
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const datos_daia = await sequelize.query(sql, { type: QueryTypes.SELECT });
        //let salida = [];
        if (datos_daia && datos_daia.length > 0) {
          console.log('datos_daia', datos_daia);
            for (const elemento of datos_daia) {
                if (elemento.accion == 1) {
                    //Material entrante desde CGE
                    const campo_datos = elemento.datos
                    const IDatoSchema = z.object({
                        codigo_obra: z.string(),
                        guia_despacho: z.string(),
                        reserva: z.string().optional(),
                        centrality: z.string().optional(),
                        numero_oc: z.string().optional(),
                        numero_ot: z.string().optional(),
                        documento: z.string().optional(),
                        detalle: z.array(IMaterialCantidadSchema)
                    })

                    const validated = IDatoSchema.safeParse(campo_datos);
                    const newDato = validated.success ? validated.data : null;
                    console.log('newDato', newDato);
                    if (!newDato) {
                        console.log('Formato incorrecto', validated.error.issues, 'Se deja para revisión manual');
                        await ConexionDaia.update( {estado: 3, observacion: 'Formato incorrecto'}, {where: {id: elemento.id}});
                        continue;
                    }
                    const obra = await Obra.findOne({where: {codigo_obra: newDato.codigo_obra}});
                    // si no encuentra la obra, debe arrojar un error
                    if (!obra) {
                        console.log('No se encontro la obra', newDato.codigo_obra);
                        await ConexionDaia.update( {estado: 3, observacion: 'No se encontro la obra'}, {where: {id: elemento.id}});
                        continue;
                    }

                    // revisar que todos los codigo sap en detalle se encuentren en maestro materiales
                    let valido = true;
                    for (const d of newDato.detalle) {
                        const where = {where: {codigo_sap: d.sap_material.codigo_sap}};
                        console.log('where', where);
                        const material = await MaestroMateriales.findOne(where);
                        if (!material) {
                            console.log('No se encontro el material', d.codigo_sap);
                            await ConexionDaia.update( {estado: 3, observacion: 'No se encontro el material código: '+d.sap_material.codigo_sap}, {where: {id: elemento.id}});
                            valido = false;
                            break;
                        }
                    }

                    if (!valido) {
                        continue;
                    }

                    const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
                    const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

                    const detalle = newDato.detalle
                    

                    
                    const transac = await sequelize.transaction();
                    try {
                      for (const d of detalle) {
                          console.log('d', d);
                          let id_movimiento = 0;
                      
                          const sql = "select nextval('material.movimientos_bodega_id_seq'::regclass) as valor";
                          await sequelize.query(sql, {
                            type: QueryTypes.SELECT
                          }).then(data => {
                            id_movimiento = data[0].valor;
                          }).catch(err => {
                            res.status(500).send(err.message );
                            return;
                          })

                          const registro_movimiento = {
                            id: id_movimiento,
                            codigo_sap_material: d.sap_material.codigo_sap,
                            cantidad: d.cantidad,
                            tipo_movimiento: 'IN_MANDANTE',
                            guia_despacho: newDato.guia_despacho,
                            fecha_movimiento: fechahoy
                          }
                          await MovimientosBodega.create(registro_movimiento, { transaction: transac });

                          const tipos_doc = [
                            {id:1, nombre_campo: 'codigo_obra'}, 
                            {id:2, nombre_campo: 'reserva'}, 
                            {id:3, nombre_campo: 'centrality'}, 
                            {id:4, nombre_campo: 'numero_oc'}, 
                            {id:5, nombre_campo: 'numero_ot'}, 
                            {id:6, nombre_campo: 'documento'}]
                          for (const t of tipos_doc) {
                            console.log(t.nombre_campo, newDato[t.nombre_campo]);
                            if (newDato[t.nombre_campo]) {
                              const registro_tipodoc = {
                                id_movimiento: id_movimiento,
                                id_tipo_doc: t.id,
                                valor: newDato[t.nombre_campo]    
                              }
                              await MovimientoTipoDoc.create(registro_tipodoc, { transaction: transac });
                            }
                          }
                          await ConexionDaia.update( {estado: 2}, {where: {id: elemento.id}, transaction: transac});
                      }
                      await transac.commit();

                    } catch (error) {
                      console.log(error);
                      await transac.rollback();
                    }
                } else if (elemento.accion == 2) {
                    //Material en devolución a CGE
                    console.log('Material en devolución a CGE');
                } else if (elemento.accion == 3) {
                    //Material saliente a terreno
                    console.log('Material saliente a terreno');
                    
                } else if (elemento.accion == 4) {
                    //Material entrante desde terreno
                    console.log('Material entrante desde terreno');
                    
                } else {
                    //desconocido
                    console.log('desconocido');

                }
            }
        } else {
            console.log('no hay datos daia');
        }
    } catch (error) {
      if (error instanceof ZodError) {
        console.log(error.issues);
        const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
        console.log(mensaje);  //bad request
        return
      }
      console.log(error);
    }

}
  
exports.getMaterialDisponibleByObra = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Integración Daia']
      #swagger.description = 'Devuelve el listado de todo el materiales que están disponibles para una obra' */
      try {

        const dataInput = {
          id_obra: req.query.id_obra
        }

        const IDataInputSchema = z.object({
          id_obra: z.coerce.number(),
        });

        /*
        const IMaterialCantidadConPedidosSchema = IMaterialCantidadSchema.extend({
          pedidos: z.array(z.coerce.number())
        })
        */

        const IDataOutputSchema = z.object({
          id_obra: z.coerce.number(),
          codigo_obra: z.coerce.string(),
          materiales: z.array(IMaterialCantidadSchema)
        });

        const IArrayDataOutputSchema = z.array(IDataOutputSchema);

        //const validated = IDataInputSchema.parse(dataInput);
        const validated = IDataInputSchema.safeParse(dataInput);
        const condicion = validated.success ? `AND o.id = ${validated.data.id_obra}` : '';
        
        const sql = `SELECT f.id_obra, f.codigo_obra, array_agg(material) as materiales FROM 
        (SELECT d.*, json_build_object('sap_material', row_to_json(mm), 'cantidad', d.cantidad) as material FROM 
        (SELECT o.id as id_obra, mtd.valor as codigo_obra, mb.codigo_sap_material, 
        sum(mb.cantidad) as cantidad FROM material.movimientos_bodega mb JOIN material.movimiento_tipo_doc 
        mtd ON mb.id = mtd.id_movimiento JOIN obras.obras o ON mtd.valor = o.codigo_obra 
        WHERE mtd.id_tipo_doc = 1 AND mb.tipo_movimiento = 'IN_MANDANTE' ${condicion} 
        GROUP BY o.id, mtd.valor, mb.codigo_sap_material) d LEFT JOIN 
        (SELECT codigo_sap, descripcion, mu.codigo_corto as unidad FROM obras.maestro_materiales mm 
        join obras.maestro_unidades mu ON mm.id_unidad = mu.id) mm ON d.codigo_sap_material = mm.codigo_sap 
        ORDER BY d.id_obra,d.codigo_sap_material) f GROUP BY f.id_obra, f.codigo_obra`;
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const pedidos = await sequelize.query(sql, { type: QueryTypes.SELECT });
        if (pedidos) {
          const data = IArrayDataOutputSchema.parse(pedidos);
          if (data.length > 0) 
            res.status(200).send(data);
          else
            res.status(200).send([]);
          return;
        }else
        {
          res.status(500).send("Error en la consulta (servidor backend)");
          return;
        }
    } catch (error) {
      console.log(error);
        if (error instanceof ZodError) {
          console.log(error.issues);
          const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
          res.status(400).send(mensaje);  //bad request
          return;
        }
        res.status(500).send(error);
    }
}

exports.getMaterialDisponibleExcludeObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Integración Daia']
    #swagger.description = 'Devuelve el listado de todo el materiales que están disponibles para una obra' */
    try {

      const dataInput = {
        id_obra: req.query.id_obra
      }

      const IDataInputSchema = z.object({
        id_obra: z.coerce.number(),
      });

      const IObraOutputSchema = z.object({
        id_obra: z.coerce.number(),
        codigo_obra: z.coerce.string(),
        nombre_obra: z.coerce.string()
      });
      const IObraCantidadOutputSchema = z.object({
        obra: IObraOutputSchema,
        cantidad: z.coerce.number()
      })
      const IStockSchema = z.array(IObraCantidadOutputSchema);

      const IDataMaterialSchema = z.object({
        descripcion: z.coerce.string(),
        unidad: z.coerce.string()
      })

      const IDataOutputSchema = z.object({
        codigo_sap_material: z.coerce.number(),
        stock: IStockSchema,
        material: IDataMaterialSchema
      })
    

      /*
      const IMaterialCantidadConPedidosSchema = IMaterialCantidadSchema.extend({
        pedidos: z.array(z.coerce.number())
      })
      */

      /*
      const IDataOutputSchema = z.object({
        id_obra: z.coerce.number(),
        codigo_obra: z.coerce.string(),
        materiales: z.array(IMaterialCantidadSchema)
      });
      */

      const IArrayDataOutputSchema = z.array(IDataOutputSchema);

      //const validated = IDataInputSchema.parse(dataInput);
      const validated = IDataInputSchema.safeParse(dataInput);
      const condicion = validated.success ? `AND o.id <> ${validated.data.id_obra}` : '';
      /*
      const sql = condicion ? `SELECT f.id_obra, f.codigo_obra, array_agg(material) as materiales FROM 
      (SELECT d.*, json_build_object('sap_material', row_to_json(mm), 'cantidad', d.cantidad) as material FROM 
      (SELECT o.id as id_obra, mtd.valor as codigo_obra, mb.codigo_sap_material, 
      sum(mb.cantidad) as cantidad FROM material.movimientos_bodega mb JOIN material.movimiento_tipo_doc 
      mtd ON mb.id = mtd.id_movimiento JOIN obras.obras o ON mtd.valor = o.codigo_obra 
      WHERE mtd.id_tipo_doc = 1 AND mb.tipo_movimiento = 'IN_MANDANTE' ${condicion} 
      GROUP BY o.id, mtd.valor, mb.codigo_sap_material) d LEFT JOIN 
      (SELECT codigo_sap, descripcion, mu.codigo_corto as unidad FROM obras.maestro_materiales mm 
      join obras.maestro_unidades mu ON mm.id_unidad = mu.id) mm ON d.codigo_sap_material = mm.codigo_sap 
      ORDER BY d.id_obra,d.codigo_sap_material) f GROUP BY f.id_obra, f.codigo_obra` : '';*/


      const sql = condicion ? `SELECT x.codigo_sap_material, x.stock, 
      json_build_object('descripcion', mm.descripcion, 'unidad', mm.unidad) as material 
      FROM 
      (SELECT codigo_sap_material, array_agg(material) as stock	
        FROM (SELECT codigo_sap_material, json_build_object('obra', c.obra, 'cantidad', c.cantidad) material
        	FROM (SELECT json_build_object('id_obra', b.id_obra, 'codigo_obra', b.codigo_obra, 'nombre_obra', b.nombre_obra) as obra,	
          b.codigo_sap_material, b.cantidad 
      FROM 
      (SELECT o.id as id_obra, o.codigo_obra, o.nombre_obra, mb.codigo_sap_material, sum(mb.cantidad) as cantidad 
        FROM material.movimientos_bodega mb 
        JOIN material.movimiento_tipo_doc mtd ON mb.id = mtd.id_movimiento 
        JOIN obras.obras o ON mtd.valor = o.codigo_obra 
      WHERE mtd.id_tipo_doc = 1 AND mb.tipo_movimiento = 'IN_MANDANTE' ${condicion} 
      GROUP BY o.id, mtd.valor, mb.codigo_sap_material) b) c) d GROUP BY codigo_sap_material) x 
        LEFT JOIN 
      (SELECT codigo_sap, descripcion, mu.codigo_corto as unidad FROM obras.maestro_materiales mm 
      join obras.maestro_unidades mu ON mm.id_unidad = mu.id) mm ON x.codigo_sap_material = mm.codigo_sap 
      ORDER BY mm.descripcion` : '';

      if (sql) {
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const pedidos = await sequelize.query(sql, { type: QueryTypes.SELECT });
        if (pedidos) {
          const data = IArrayDataOutputSchema.parse(pedidos);
          if (data.length > 0) 
            res.status(200).send(data);
          else
            res.status(200).send([]);
          return;
        }else
        {
          res.status(500).send("Error en la consulta (servidor backend)");
          return;
        }
      } else {
        res.status(200).send([]);
        return;
      }
      
  } catch (error) {
    console.log(error);
      if (error instanceof ZodError) {
        console.log(error.issues);
        const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
        res.status(400).send(mensaje);  //bad request
        return;
      }
      res.status(500).send(error);
  }
}

exports.postIngresaSolicitud = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Integración Daia']
    #swagger.description = 'Ingresa una solicitud de material' 
    #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos de solicitud',
            required: true,
            schema: {
                "id_tipo_doc": 1,
                "codigo_documento": "CGED-24002437",
                "detalle": [
                  {
                    "codigo_sap_material": 4,
                    "cantidad": 1,
                    "id_obra_propietario": 1,
                    "estado": "NORMAL"
                  }
                ]
            }
      }
    
  */
    try {
        const dataInput = {
          id_tipo_doc: req.body.id_tipo_doc,
          codigo_documento: req.body.codigo_documento,
          detalle: req.body.detalle
        }

        const IDetalleSchema = z.object({
          codigo_sap_material: ICodigoSapSchema,
          cantidad: ICantidadMaterialSchema,
          id_obra_propietario: z.coerce.number().gt(0),
          estado: z.string().min(1),
        });

        const IDataInputSchema = z.object({
          id_tipo_doc: z.coerce.number().gt(0),
          codigo_documento: z.coerce.string(),
          detalle: z.array(IDetalleSchema).min(1),
        });

        const validated = IDataInputSchema.parse(dataInput);

        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;

        // Si el tipo_doc es 1, verificar que el código de docuemto se encuentre en tabla Obras
        if (validated.id_tipo_doc === 1) {
          const sql = "SELECT id FROM obras.obras WHERE codigo_obra = '" + validated.codigo_documento + "'";
          const existe = await sequelize.query(sql, {
            type: QueryTypes.SELECT
          });
          if (!existe || existe.length === 0) {
            res.status(400).send("Código de obra " + validated.codigo_documento + " no existe en Obras");
            return;
          }
        }
          

        let id_usuario = req.userId;
        let rut_usuario;
        const sql_usuario = "select username from _auth.users where id = " + id_usuario;
        
        await sequelize.query(sql_usuario, {
          type: QueryTypes.SELECT
        }).then(data => {
          rut_usuario = data[0].username;
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })

        let salida = {};
        const transac = await sequelize.transaction();
        try {
          salida = {"error": false, "message": "solicitud ingresada"};
          let id_movimiento = 0;
                      
          const sql = "select nextval('material.solicitud_material_encabezado_id_seq'::regclass) as valor";
          await sequelize.query(sql, {
            type: QueryTypes.SELECT
          }, { transaction: transac }).then(data => {
            id_movimiento = data[0].valor;
          }).catch(err => {
            res.status(500).send(err.message );
            return;
          })

          const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
          const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);


          const solicitud_encabezado = {
            id: id_movimiento,
            id_tipo_doc: validated.id_tipo_doc,
            codigo_documento: validated.codigo_documento,
            fecha_solicitud: fechahoy,
            rut_usuario: rut_usuario,
            estado: 'PENDIENTE'
          }

          await SolicitudMaterialEncabezado.create(solicitud_encabezado, { transaction: transac });
          for (const d of validated.detalle) {
            // Verificar que el codigo sap se encuentre en la tabla de maestro materiales
            const sql = "SELECT codigo_sap FROM obras.maestro_materiales WHERE codigo_sap = " + d.codigo_sap_material;
            const existe = await sequelize.query(sql, {
              type: QueryTypes.SELECT
            });
            if (!existe || existe.length === 0) {
              await transac.rollback();
              res.status(400).send("Código SAP " + d.codigo_sap_material + " no existe en Maestro de Materiales");
              return;
            }
            const solicitud_material = {
              id_solicitud: id_movimiento,
              codigo_sap_material: d.codigo_sap_material,
              cantidad: d.cantidad,
              id_obra_propietario: d.id_obra_propietario,
              estado: d.estado
            }
            await SolicitudMaterialDetalle.create(solicitud_material, { transaction: transac });
          }
          await transac.commit();
          
        } catch (error) {
            console.log('error 1', error);
            salida = { error: true, message: error }
            await transac.rollback();
        }
        if (salida.error) {
          console.log('error 2', salida.message);
          res.status(400).send(salida.message);
        }else {
          res.status(200).send(salida);
        }

      } catch (error) {
        console.log('postIngresaSolicitud', error);
        if (error instanceof ZodError) {
          console.log(error.issues);
          //const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+ (issue.path[1] !== undefined?'[' + issue.path[1] + ']' + (issue.path[2] !== undefined? '[' + issue.path[2] + ']':''):'') + ' -> '+issue.message).join('; ');
          const mensaje = {errores: error.issues}
          res.status(400).send(mensaje);  //bad request
          return;
        }
        res.status(500).send(error);
        
      }

}


exports.getSolicitudMaterialFaenaPorObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Integración Daia']
    #swagger.description = 'Devuelve el listado de solicitudes para una obra' */
  try {
      const dataInput = {
        id_obra: req.query.id_obra
      }

      const IDataInputSchema = z.object({
        id_obra: z.coerce.number(),
      });

      const IDataOutputSchema = z.object({
        solicitud: z.coerce.number(),
        id_obra: z.coerce.number(),
        estado: z.coerce.string(),
        fecha_hora: z.coerce.string(),
        persona: z.coerce.string(),
      });

      const IArrayDataOutputSchema = z.array(IDataOutputSchema);

      const validated = IDataInputSchema.parse(dataInput);

      const id_obra = validated.id_obra;
      const sql = `SELECT sme.id as solicitud, o.id as id_obra, sme.estado, sme.fecha_solicitud::text as fecha_hora, 
      (((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) || 
      CASE 
        WHEN p.apellido_2 IS NULL THEN ''::character varying 
        ELSE p.apellido_2 
        END::text as persona 
      FROM material.solicitud_material_encabezado sme 
        JOIN _auth.personas p	ON sme.rut_usuario = p.rut 
        JOIN obras.obras o ON sme.codigo_documento = o.codigo_obra 
      WHERE o.id = ${id_obra};`;
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const pedidos = await sequelize.query(sql, { type: QueryTypes.SELECT });
      if (pedidos) {
        const data = IArrayDataOutputSchema.parse(pedidos);
        res.status(200).send(data);
        return;
      }else
      {
        res.status(500).send("Error en la consulta (servidor backend)");
        return;
      }
  } catch (error) {
    if (error instanceof ZodError) {
      console.log(error.issues);
      const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
      res.status(400).send(mensaje);  //bad request
      return;
    }
    res.status(500).send(error);
  } 
}

exports.getMaterialPorSolicitudFaena = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Integración Daia']
    #swagger.description = 'Devuelve el listado de materiales para una solicitud a faena' */
  try {
      const dataInput = {
        id: req.query.id_solicitud
      }

      const IDataInputSchema = z.object({
        id: z.coerce.number(),
      });

      const ISapMaterialSchema = z.object({
        codigo_sap: z.coerce.number(),
        descripcion: z.coerce.string(),
        unidad: z.coerce.string(),
      })

      const IDataOutputSchema = z.object({
        id: z.coerce.number(),
        id_obra: z.coerce.number(),
        solicitud: z.coerce.number(),
        sap_material: ISapMaterialSchema,
        cantidad: z.coerce.number(),
        fecha_ingreso: z.coerce.string(),
        rut_usuario: z.coerce.string(),
        persona: z.coerce.string()
      });

      const IArrayDataOutputSchema = z.array(IDataOutputSchema);

      const validated = IDataInputSchema.parse(dataInput);

      const id = validated.id;
      const sql = `SELECT smd.id, o.id as id_obra, sme.id as solicitud, row_to_json(mm) as sap_material, 
                  smd.cantidad, sme.fecha_solicitud as fecha_ingreso, sme.rut_usuario, 
                  (((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) ||
                        CASE
                            WHEN p.apellido_2 IS NULL THEN ''::character varying
                            ELSE p.apellido_2
                        END::text AS persona 
                  FROM material.solicitud_material_encabezado sme 
                  JOIN material.solicitud_material_detalle smd ON sme.id = smd.id_solicitud	
                  JOIN obras.obras o ON sme.codigo_documento = o.codigo_obra 
                  JOIN (SELECT codigo_sap, texto_breve, descripcion, mu.codigo_corto as unidad 
                  FROM obras.maestro_materiales mm JOIN obras.maestro_unidades mu ON mm.id_unidad = mu.id) mm 
                  ON mm.codigo_sap = smd.codigo_sap_material	
                  JOIN _auth.personas p	ON sme.rut_usuario = p.rut 
                  WHERE sme.id = ${id} AND sme.id_tipo_doc = 1`;
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const pedidos = await sequelize.query(sql, { type: QueryTypes.SELECT });
      if (pedidos) {
        const data = IArrayDataOutputSchema.parse(pedidos);
        res.status(200).send(data);
        return;
      }else
      {
        res.status(500).send("Error en la consulta (servidor backend)");
        return;
      }
  } catch (error) {
    if (error instanceof ZodError) {
      console.log(error.issues);
      const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
      res.status(400).send(mensaje);  //bad request
      return;
    }
    res.status(500).send(error);
  }

}