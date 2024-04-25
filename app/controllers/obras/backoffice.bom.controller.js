const db = require("../../models");
const z = require('zod');
const ZodError = z.ZodError;

const Bom = db.bom;
const BomZero = db.vwBomZero;
const BomFinal = db.vwBomFinal;
/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 BILL OF MATERIALS BOM                           */
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
/* Consulta todos los registros de la tabla Bom
;
*/
exports.findAllBom = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve todos los materiales en el bom' */

    try {
      const sql = "SELECT b.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, reserva, \
      json_build_object('codigo_sap', mm.codigo_sap, 'descripcion', mm.descripcion) as codigo_sap_material, \
      cantidad_requerida FROM obras.bom b left join obras.obras o on o.id = b.id_obra left join \
      obras.maestro_materiales mm on mm.codigo_sap = b.codigo_sap_material";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const bom = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (bom) {
        for (const element of bom) {
  
              const detalle_salida = {
  
                id: Number(element.id),
                id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
                reserva: Number(element.reserva),
                codigo_sap_material: element.codigo_sap_material, //json {"codigo_sap": codigo_sap, "descripcion": descripcion}
                cantidad_requerida: Number(element.cantidad_requerida)
              }
              salida.push(detalle_salida);
        };
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
  /***********************************************************************************/
  /* Consulta los registros de la tabla Bom por parametros
  ;
  */
exports.findBomByParametros = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve todos los materiales en el bom de acuerdo a los parámetros' */
  
    const parametros = {
      id_obra: req.query.id_obra,
      reserva: req.query.reserva,
      codigo_sap_material: req.query.codigo_sap_material
    }
    const keys = Object.keys(parametros)
    let sql_array = [];
    let param = {};
    for (element of keys) {
      if (parametros[element]){
        sql_array.push("b." + element + " = :" + element);
        param[element] = parametros[element];
      }
    }
  
    if (sql_array.length === 0) {
      res.status(500).send("Debe incluir algun parametro para consultar");
    }else {
      try {
        let b = sql_array.reduce((total, num) => total + " AND " + num);
        if (b){
          const sql = "SELECT b.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, reserva, \
          json_build_object('codigo_sap', mm.codigo_sap, 'descripcion', mm.descripcion) as codigo_sap_material, \
          cantidad_requerida FROM obras.bom b left join obras.obras o on o.id = b.id_obra left join \
          obras.maestro_materiales mm on mm.codigo_sap = b.codigo_sap_material WHERE "+b;
          console.log("sql: "+sql);
          const { QueryTypes } = require('sequelize');
          const sequelize = db.sequelize;
          const bom = await sequelize.query(sql, { replacements: param, type: QueryTypes.SELECT });
          let salida = [];
          if (bom) {
            for (const element of bom) {
  
                  const detalle_salida = {
  
                    id: Number(element.id),
                    id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
                    reserva: Number(element.reserva),
                    codigo_sap_material: element.codigo_sap_material, //json {"codigo_sap": codigo_sap, "descripcion": descripcion}
                    cantidad_requerida: Number(element.cantidad_requerida)
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
/***********************************************************************************/
  /* Consulta los registros de la tabla BomZero (inicial) por id_obra
  ;
  */
 exports.getBomZero = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve todos los registros del Bom inicial de acuerdo al id de obra' */

      const dataInput = {
        id_obra: req.query.id_obra
      }

      const IDataInputSchema = z.object({
        id_obra: z.coerce.number(),
      });

      const IDataOutputSchema = z.object({
        id: z.coerce.number(),
        id_obra: z.coerce.number(),
        cod_reserva: z.coerce.number(),
        codigo_sap_material: z.coerce.number(),
        cantidad_requerida: z.coerce.number(),
        fecha_ingreso: z.coerce.string(),
        rut_usuario: z.coerce.string(),
        persona: z.coerce.string(),
      });

      const IArrayDataOutputSchema = z.array(IDataOutputSchema);
      

      try {

        const validated = IDataInputSchema.parse(dataInput);

        const bom = await BomZero.findAll({
          where: {
            id_obra: validated.id_obra}
        });
        const data = IArrayDataOutputSchema.parse(bom);
        res.status(200).send(data);
        
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
 /***********************************************************************************/
  /* Consulta los registros de la tabla BomFinal (actual) por id_obra
  ;
  */
  exports.getBomFinal = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve todos los registros del Bom final de acuerdo al id de obra' */

      const dataInput = {
        id_obra: req.query.id_obra
      }

      const IDataInputSchema = z.object({
        id_obra: z.coerce.number(),
      });

      const IDataOutputSchema = z.object({
        id: z.coerce.number(),
        id_obra: z.coerce.number(),
        cod_reserva: z.coerce.number(),
        codigo_sap_material: z.coerce.number(),
        cantidad_requerida: z.coerce.number(),
        fecha_ingreso: z.coerce.string(),
        rut_usuario: z.coerce.string(),
        persona: z.coerce.string(),
      });

      const IArrayDataOutputSchema = z.array(IDataOutputSchema);
      

      try {

        const validated = IDataInputSchema.parse(dataInput);

        const bom = await BomFinal.findAll({
          where: {
            id_obra: validated.id_obra}
        });
        const data = IArrayDataOutputSchema.parse(bom);
        res.status(200).send(data);
        
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
  /***********************************************************************************/
  /* Crea un nuevo bom de forma masiva
  ;
  */
  exports.createBomMasivo = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Ingresa un grupo de materiales en el bom de una sola vez' */
  

        //ejemplo: { "materiales": "1219_3-1220_2", "id_obra": 22, "reserva": 3456}
    const campos = [
      'id_obra', 'reserva', 'materiales'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send("No puede estar nulo el campo " + element
        );
        return;
      }
    };
  
    try {
      let todoOk = false;
      let materiales = req.body.materiales;
      //reemplaza las comas por puntos, por si hay alguna cantidad decimal
      materiales = materiales.replace(",", ".");
      let id_obra = req.body.id_obra;
      let reserva = req.body.reserva;
      //el simblo guion separa la información de materiales
      let materiales_input = materiales.split("-");
      let sql = "";
      let sql_chek = "";
      let inicia = false;

      //Verifica que no repitan los código sap
      let materiales_repetidos = []
      for (const element of materiales_input) {
        if (!element) {
          const valores = element.split("_")
          const valor = {"cod_sap": valores[0], "cantidad": valores[1]}
          materiales_repetidos.push(valor);
        }
      };

      const arreglo_materiales = obtenerValoresUnicosConSuma(materiales_repetidos);


      for ( const element of arreglo_materiales)
        {
          const valores = element.split("_")
          const cod_sap = valores[0]
          const cantidad = valores[1]
  
          if (!inicia){
            inicia = true;
            if (cod_sap){
              sql_chek = sql_chek + "select m.sap_material from (select unnest(array[" + cod_sap;
            }
          }else{
            if (cod_sap){
              sql_chek = sql_chek + ", " + cod_sap;
            }
          }
          sql = sql + "insert into obras.bom (id_obra, reserva, codigo_sap_material, cantidad_requerida) values (" + id_obra + ", " + reserva + ", " + cod_sap + ", " + cantidad + ");"
  
        }
        if (sql_chek){
          sql_chek = sql_chek + "]) as sap_material) as m left join obras.maestro_materiales mm on m.sap_material = mm.codigo_sap where mm.codigo_sap is null;";

          console.log('sql_chek', sql_chek);
          const { QueryTypes } = require('sequelize');
          const sequelize = db.sequelize;
          const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
          if (bom) {
              if (bom.length > 0){
                    //Hay materiales no definidos
                    const detalle_salida = {
                      error: Boolean(true),
                      mensaje: String("Hay códigos de material no definidos en la base de datos"),
                      detalle: bom
                    }
                    res.status(200).send(detalle_salida);
                  }else {
                    //Chequear si la reserva existe en la tabla mat_bom_reservas
                    //Si existe, chequear que el id_obra sea el mismo que se está ingresando
                    //Si no es el mismo quiere decir que la reserva ya está asignada a otra obra, por lo que debe arrojar error
                    //Si la reserva no se encuentra se debe crear en la tabla mat_bom_reservas y asignarla al codigo de obra
                    sql_chek = "select * from obras.mat_bom_reservas where reserva = " + reserva;
                    const { QueryTypes } = require('sequelize');
                    const sequelize = db.sequelize;
                    const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                    if (bom){
                      if (bom.length > 0){
                        //La reserva se encuentra en la tabla de mat_bom_reservas
                        //Chequear ahora si el id_obra es el mismo que se estaba ingresando
                        sql_chek = "select * from obras.mat_bom_reservas where reserva = " + reserva + " and id_obra = " + id_obra;
                        const { QueryTypes } = require('sequelize');
                        const sequelize = db.sequelize;
                        const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                        if (bom){
                          if (bom.length > 0){
                              //El id_obra se encuentra en la tabla de mat_bom_reservas
                              //No hay errores, proceder a ingresar el bom
                              //Revisar si la combinacion de id_obra y reserva ya existe en la tabla bom_zero
                              sql = sql + ";";
                              const { QueryTypes } = require('sequelize');
                              const sequelize = db.sequelize;
                              const bom = await sequelize.query(sql, { type: QueryTypes.SELECT });
                              if (bom){
                                  //La combinacion de id_obra y reserva ya existe en la tabla bom_zero
                                  //No hay errores, no hacer nada
                                  todoOk = true;
                              }else {
                                  //La combinacion de id_obra y reserva no existe en la tabla bom_zero
                                  //Insertar la combinacion de id_obra y reserva en la tabla bom_zero
                                  const sql_insert = "INSERT INTO obras.bom_zero (id_obra, reserva) VALUES (" + id_obra + ", " + reserva + ");";
                                  sql = sql_insert + sql;
                                  todoOk = true;
                              }
                          }else {
                          //El id_obra no se encuentra en la tabla de mat_bom_reservas 
                          //La reserva está asignada a otro id_de obra, arrojar un error
                          throw new Error("La reserva está asignada a otro id_obra");
                          }
                        }else {res.status(500).send("Error en la consulta (servidor backend)");}
  
                      }else{
                        //La reserva no se encuentra en la tabla mat_bom_reservas, se debe ingresar junto con el id de obra
                        // Si la reserva no se encuentra en la tabla de mat_bom_reservas
                        // Se debe ingresar junto con el id de obra
                        const sql_insert = "INSERT INTO obras.mat_bom_reservas (reserva, id_obra) VALUES (" + reserva + ", " + id_obra + ");";
                        sql = sql_insert + sql;
                        todoOk = true;
                      }
                        if (sql && todoOk) {
                                    // Si todos los materiales estan definidos
                                    const { QueryTypes } = require('sequelize');
                                    const sequelize = db.sequelize;
                                    const bom = await sequelize.query(sql, { type: QueryTypes.INSERT });
                                    if (bom) {
                                      res.status(200).send(bom);
                                    }else{res.status(500).send("Error en la consulta (servidor backend)");}
                        } else {res.status(500).send("Consulta vacía (error servidor backend)");}
  
                    }else{res.status(500).send("Error en la consulta (servidor backend)");}
                  }
          }else{res.status(500).send("Error en la consulta (servidor backend)");}
        }else{res.status(500).send("Error en la consulta (servidor backend)");}
    }catch (error) {
      res.status(500).send(error);
    }   
  }
  /***********************************************************************************/
  /* Crea un nuevo bom de forma masiva, Version 2
  ;
  */
  exports.createBomMasivo_v2 = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Ingresa un grupo de materiales en el bom de una sola vez Version 2' */
  

        //ejemplo: { "materiales": "1219_3-1220_2.5-3567_3", "id_obra": 22, "reserva": 3456}

        //chequeo con Zod
        const inputDatosSchema = z.object({
          materiales: z.string().regex(/^([1-9]\d+|[1-9])+_\d+(.\d+)?(-([1-9]\d+|[1-9])+_\d+(.\d+)?)*$/gm),
          id_obra: z.coerce.number().int().positive(),
          reserva: z.coerce.number().int().positive(),
        })

        const inputDatos = {
          materiales: req.body.materiales,
          id_obra: req.body.id_obra,
          reserva: req.body.reserva,
        }
       
        try {
            //valida datos de entrada
            const bom = inputDatosSchema.parse(inputDatos);

            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;

            let todoOk = false;
            let materiales = bom.materiales;
            //reemplaza las comas por puntos, por si hay alguna cantidad decimal
            materiales = materiales.replace(",", ".");
            console.log('materiales -> ',materiales);
            let id_obra = bom.id_obra;
            let reserva = bom.reserva;
            //el simblo guion separa la información de materiales
            let materiales_input = materiales.split("-");
            console.log('materiales_input -> ',materiales_input);

            let sql = "";
            let sql_chek = "";
            let sql_reservas = "";
            let sql_bom_movimientos = "";

            let id_usuario = req.userId;
            let rut_usuario;
            sql = "select username from _auth.users where id = " + id_usuario;
            await sequelize.query(sql, {
              type: QueryTypes.SELECT
            }).then(data => {
              rut_usuario = data[0].username;
            }).catch(err => {
              res.status(500).send(err.message );
              return;
            })

            //Verifica que no repitan los código sap
            let materiales_repetidos = []
            for (const element of materiales_input) {
              if (element) {
                const valores = element.split("_")
                const valor = {"codigo_sap": valores[0], "cantidad": Number(valores[1])}
                materiales_repetidos.push(valor);
              }
            };

            const arreglo_materiales = obtenerValoresUnicosConSuma(materiales_repetidos);
            console.log('materiales_repetidos',materiales_repetidos);
            console.log('arreglo_materiales',arreglo_materiales);

            const codigos_sap = arreglo_materiales.reduce((acumulador, elemento, indice) => {
                // Agregar coma si no es el primer elemento
                if (indice !== 0) {
                    acumulador += ', ';
                }
                // Concatenar el elemento actual al acumulador
                return acumulador + elemento.codigo_sap;
            }, '');
            const cantidades = arreglo_materiales.reduce((acumulador, elemento, indice) => {
                // Agregar coma si no es el primer elemento
                if (indice !== 0) {
                    acumulador += ', ';
                }
                // Concatenar el elemento actual al acumulador
                return acumulador + elemento.cantidad;
            }, '');

            if (codigos_sap) {
              sql_chek = "select m.sap_material from (select unnest(array[" + codigos_sap + "]) as sap_material) as m left join obras.maestro_materiales mm on m.sap_material = mm.codigo_sap where mm.codigo_sap is null;";

              sql_bom_movimientos = `INSERT INTO obras.mat_bom_ingresos (
                                            id_obra, 
                                            cod_reserva, 
                                            codigo_sap_material, 
                                            cantidad_requerida_old, 
                                            cantidad_requerida_new, 
                                            tipo_movimiento, 
                                            fecha_movimiento, 
                                            rut_usuario
                                          )
                                    SELECT 
                                        m.id_obra, 
                                        m.cod_reserva, 
                                        m.sap_material, 
                                        case when bm.cantidad_requerida_new is null then 0::bigint else bm.cantidad_requerida_new end 
                                          as cantidad_requerida_old, 
                                        case when m.cant_material <= 0 then 0::numeric else  m.cant_material end 
                                          as cantidad_requerida_new, 
                                        case when m.cant_material <= 0 then 'ELIMINADO' else case when bm.cantidad_requerida_new 
                                          is null then 'INGRESADO' else 'MODIFICADO' end end as tipo_movimiento, 
                                          substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp as fecha_movimiento, 
                                        '${rut_usuario}'::varchar as rut_usuario 
                                    FROM 
                                      (SELECT ${id_obra}::bigint as id_obra, 
                                            ${reserva}::bigint as cod_reserva, 
                                            unnest(array[${codigos_sap}]) as sap_material, 
                                            unnest(array[${cantidades}]) as cant_material) as m 
                                    LEFT JOIN 
                                      (SELECT DISTINCT ON (id_obra, codigo_sap_material) 
                                          id_obra, 
                                          codigo_sap_material, 
                                          cantidad_requerida_new, 
                                          fecha_movimiento 
                                      FROM obras.mat_bom_ingresos 
                                      ORDER BY 
                                          id_obra, 
                                          codigo_sap_material, 
                                          fecha_movimiento desc
                                      ) bm 
                                    ON bm.id_obra = m.id_obra 
                                    AND bm.codigo_sap_material = m.sap_material`;
            }
        
            /******************** Chequea materiales no existentes */
            if (sql_chek){

              console.log('sql_chek -> ', sql_chek);

              const check_mat = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
              if (check_mat) {
                  if (check_mat.length > 0){
                    res.status(500).send("Hay códigos de material no definidos en la base de datos");
                    return;
                  } else {
                    todoOk = true;
                  }
              } else {
                res.status(500).send("Error en la consulta (servidor backend)");
                return;
              }
            } else {
              res.status(500).send("Error en la consulta (servidor backend)");
              return;
            }

            /******************** Chequea si la reserva existe */
            sql_chek = "select * from obras.mat_bom_reservas where reserva = " + reserva;
            
            const check_reserva = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
            if (check_reserva){
              if (check_reserva.length > 0){
                //la reserva existe, verificar que este asociada al mismo id_obra
                sql_chek = sql_chek + " and id_obra = " + id_obra;
              } else {
                //la reserva no existe, se debe insertar en la tabla mat_bom_reservas
                sql_chek = null;
                sql_reservas = "insert into obras.mat_bom_reservas (id_obra, reserva) values (" + id_obra + ", " + reserva + ");";
              }
            } else {
              res.status(500).send("Error en la consulta (servidor backend)");
              return;
            }

            /******************** Chequea si la reserva está asociada al mismo id_obra */
            if (sql_chek){
              const check_asociada = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
              if (check_asociada){
                if (check_asociada.length > 0){
                  //La reserva está asociada al mismo id_obra, todo ok
                  todoOk = true;
                } else {
                  //La reserva está asociada a otro id_obra, error
                  res.status(500).send("La reserva está asignada a otro id_obra");
                  return;
                }
              } else {
                res.status(500).send("Error en la consulta (servidor backend)");
                return;
              }
            }

            /******************** Genera la consulta total 
            */
            if (todoOk){
              if (sql_reservas){
                sql = sql_reservas + sql_bom_movimientos;
              } else {
                sql = sql_bom_movimientos;
              }
            }
            if (sql){
                const crea_bom = await sequelize.query(sql, { type: QueryTypes.INSERT });
                if (crea_bom) {
                  res.status(200).send(crea_bom);
                  return;
                }else
                {
                  res.status(500).send("Error en la consulta (servidor backend)");
                  return;
                }
            } else {
              res.status(500).send("Error en la consulta (servidor backend)");
              return;
            }
        } catch (error) {
          //console.log('error -> ', error);
          if (error instanceof ZodError) {
            console.log(error.issues);
            const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
            res.status(400).send(mensaje);  //bad request
            return;
          }
          res.status(500).send(error);
        }

  }
 /***********************************************************************************/
  /* Crea un nuevo pedido de material para una obra
  ;
  */
  exports.createPedidoMaterial = async (req, res) => {
       /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Ingresa un grupo de materiales para generan un pedido de material' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos para solicitud de material',
            required: true,
            schema: {
                id_obra: 1,
                solicitud: 1,
                materiales: [
                    {
                      "codigo_sap": 1,
                      "cantidad": 1
                    }
                ]
            }
        }*/
  

        //ejemplo: { "materiales": "1219_3-1220_2.5-3567_3", "id_obra": 22}

        const inputDatos = {
          materiales: req.body.materiales,
          id_obra: req.body.id_obra,
          pedido: req.body.solicitud,
          estado: req.body.estado
        }

        const inputMaterialSchema = z.object ({
          codigo_sap: z.coerce.number().int().gt(0),
          cantidad: z.coerce.number().gt(0)
        })

        //chequeo con Zod
        const inputDatosSchema = z.object({
          //materiales: z.string().regex(/^([1-9]\d+|[1-9])+_\d+(.\d+)?(-([1-9]\d+|[1-9])+_\d+(.\d+)?)*$/gm),
          materiales: z.array(inputMaterialSchema),
          id_obra: z.coerce.number().int().gt(0),
          pedido: z.nullable(z.coerce.number().int().gt(0)).optional(),
          estado: z.nullable(z.coerce.string()).optional()
        })

        
       
        try {
          //Considerar que para poder crear un pedido nuevo el numero de pedido no debe existir
          //En caso de estar modificando un pedido existente, el pedido debe estar en estado 'pendiente'

            //valida datos de entrada
            const pedido = inputDatosSchema.parse(inputDatos);

            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;


            let id_solicitud = 0;
            const estado = pedido.estado || 'PENDIENTE';
            if (estado !== 'PENDIENTE' && estado !== 'GENERADO'){
              res.status(500).send("El estado debe ser 'PENDIENTE' o 'GENERADO'");
              return;
            }

            if (!pedido.pedido){
              let sql_nextval = "select nextval('obras.mat_solicitudes_obras_id_seq'::regclass) as valor";
            
              await sequelize.query(sql_nextval, {
                type: QueryTypes.SELECT
              }).then(data => {
                id_solicitud = data[0].valor;
              }).catch(err => {
                res.status(500).send(err.message );
              })
              
            }else {
              id_solicitud = pedido.pedido;
            }
            

            const sql_consulta_pedido = `SELECT id_obra FROM obras.mat_solicitudes_obras 
                            WHERE id_obra = ${pedido.id_obra} AND estado = 'PENDIENTE' AND id <> ${id_solicitud} LIMIT 1;`;

            const consulta_pedido = await sequelize.query(sql_consulta_pedido, { type: QueryTypes.SELECT });
            if (consulta_pedido) { 
              //HAy un estado con estado pendiente, no puede ebtregar un nuevo numero hasta que no quede ningun pendiente
              if (consulta_pedido.length > 0){
                res.status(400).send('Aún existe un pedido pendiente para esta obra, debe finalizarlo o cancelarlo antes de generar un nuevo pedido');
                return;
              }
            }

            let todoOk = false;
            let materiales = pedido.materiales;
            //reemplaza las comas por puntos, por si hay alguna cantidad decimal
            //materiales = materiales.replace(",", ".");
            console.log('materiales -> ',materiales);
            let id_obra = pedido.id_obra;
            const num_pedido = id_solicitud;
            //el simblo guion separa la información de materiales
            //let materiales_input = materiales //.split("-");
            //console.log('materiales_input -> ',materiales_input);

            if (!num_pedido) {
              res.status(400).send("No puede estar vacío el campo pedido");
              return;
            }

            let sql = "";
            let sql_chek = "";
            let sql_pedido_movimientos = "";
            let sql_pedidos = "";

            let id_usuario = req.userId;
            let rut_usuario;
            sql = "select username from _auth.users where id = " + id_usuario;
            await sequelize.query(sql, {
              type: QueryTypes.SELECT
            }).then(data => {
              rut_usuario = data[0].username;
            }).catch(err => {
              res.status(500).send(err.message );
              return;
            })

            //Verifica que no repitan los código sap
            /*
            let materiales_repetidos = []
            for (const element of materiales_input) {
              if (element) {
                const valores = element.split("_")
                const valor = {"codigo_sap": valores[0], "cantidad": Number(valores[1])}
                materiales_repetidos.push(valor);
              }
            };
            */
            let materiales_repetidos = materiales;

            const arreglo_materiales = obtenerValoresUnicosConSuma(materiales_repetidos);
            console.log('materiales_repetidos',materiales_repetidos);
            console.log('arreglo_materiales',arreglo_materiales);

            const codigos_sap = arreglo_materiales.reduce((acumulador, elemento, indice) => {
                // Agregar coma si no es el primer elemento
                if (indice !== 0) {
                    acumulador += ', ';
                }
                // Concatenar el elemento actual al acumulador
                return acumulador + elemento.codigo_sap;
            }, '');
            const cantidades = arreglo_materiales.reduce((acumulador, elemento, indice) => {
                // Agregar coma si no es el primer elemento
                if (indice !== 0) {
                    acumulador += ', ';
                }
                // Concatenar el elemento actual al acumulador
                return acumulador + elemento.cantidad;
            }, '');

            if (codigos_sap) {
              sql_chek = "select m.sap_material from (select unnest(array[" + codigos_sap + "]) as sap_material) as m left join obras.maestro_materiales mm on m.sap_material = mm.codigo_sap where mm.codigo_sap is null;";

              //No considerar los tipo_movimiento 'CANCELADO'
              sql_pedido_movimientos = `
                              INSERT INTO obras.mat_solicitudes_detalle (
                                id_obra, 
                                pedido,
                                codigo_sap_material, 
                                cantidad_requerida_old, 
                                cantidad_requerida_new, 
                                tipo_movimiento, 
                                fecha_movimiento, 
                                rut_usuario
                              )
                              SELECT m.id_obra,
                              ${num_pedido}::bigint AS pedido,
                              m.sap_material AS codigo_sap_material,
                                  CASE
                                      WHEN bm.cantidad_requerida_new IS NULL THEN 0::bigint::numeric
                                      ELSE bm.cantidad_requerida_new
                                  END AS cantidad_requerida_old,
                              m.cant_material AS cantidad_requerida_new,
                              'INGRESADO'::character varying AS tipo_movimiento,
                              "substring"(((now()::timestamp without time zone AT TIME ZONE 'utc'::text) AT TIME ZONE 'america/santiago'::text)::text, 1, 19)::timestamp without time zone AS fecha_movimiento,
                              '${rut_usuario}'::character varying AS rut_usuario
                            FROM ( SELECT ${id_obra}::bigint AS id_obra,
                              ${num_pedido}::bigint AS pedido,
                                      unnest(ARRAY[${codigos_sap}]) AS sap_material,
                                      unnest(ARRAY[${cantidades}]) AS cant_material) m
                              LEFT JOIN ( SELECT DISTINCT ON (msd.id_obra, msd.pedido, msd.codigo_sap_material) msd.id_obra,
                                      msd.pedido,
                                      msd.codigo_sap_material,
                                      msd.cantidad_requerida_new,
                                      msd.fecha_movimiento
                                    FROM obras.mat_solicitudes_detalle msd
                                      JOIN obras.mat_solicitudes_obras mso ON msd.pedido = mso.id
                                    WHERE mso.estado::text = 'PENDIENTE'::text
                                    ORDER BY msd.id_obra, msd.pedido, msd.codigo_sap_material, msd.fecha_movimiento DESC) bm ON bm.id_obra = m.id_obra AND bm.codigo_sap_material = m.sap_material AND bm.pedido = m.pedido
                            WHERE bm.codigo_sap_material IS NULL
                          UNION
                          SELECT bm.id_obra,
                            ${num_pedido}::bigint AS pedido,
                              bm.codigo_sap_material AS codigo_sap_material,
                              bm.cantidad_requerida_new AS cantidad_requerida_old,
                              0::numeric AS cantidad_requerida_new,
                              'ELIMINADO'::character varying AS tipo_movimiento,
                              "substring"(((now()::timestamp without time zone AT TIME ZONE 'utc'::text) AT TIME ZONE 'america/santiago'::text)::text, 1, 19)::timestamp without time zone AS fecha_movimiento,
                              '${rut_usuario}'::character varying AS rut_usuario
                            FROM ( SELECT DISTINCT ON (msd.id_obra, msd.pedido, msd.codigo_sap_material) msd.id_obra,
                                      msd.pedido,
                                      msd.codigo_sap_material,
                                      msd.cantidad_requerida_new,
                                      msd.fecha_movimiento
                                    FROM obras.mat_solicitudes_detalle msd
                                      JOIN obras.mat_solicitudes_obras mso ON msd.pedido = mso.id
                                    WHERE mso.estado::text = 'PENDIENTE'::text AND msd.id_obra = ${id_obra} AND msd.pedido = ${num_pedido}
                                    ORDER BY msd.id_obra, msd.pedido, msd.codigo_sap_material, msd.fecha_movimiento DESC) bm
                              LEFT JOIN ( SELECT ${id_obra}::bigint AS id_obra,
                                      ${num_pedido}::bigint AS pedido,
                                      unnest(ARRAY[${codigos_sap}]) AS sap_material,
                                      unnest(ARRAY[${cantidades}]) AS cant_material) m ON bm.id_obra = m.id_obra AND bm.codigo_sap_material = m.sap_material AND bm.pedido = m.pedido
                            WHERE m.sap_material IS NULL
                          UNION
                          SELECT m.id_obra,
                              ${num_pedido}::bigint AS pedido,
                              m.sap_material AS codigo_sap_material,
                              bm.cantidad_requerida_new AS cantidad_requerida_old,
                              m.cant_material AS cantidad_requerida_new,
                              'MODIFICADO'::character varying AS tipo_movimiento,
                              "substring"(((now()::timestamp without time zone AT TIME ZONE 'utc'::text) AT TIME ZONE 'america/santiago'::text)::text, 1, 19)::timestamp without time zone AS fecha_movimiento,
                              '${rut_usuario}'::character varying AS rut_usuario
                            FROM ( SELECT ${id_obra}::bigint AS id_obra,
                                    ${num_pedido}::bigint AS pedido,
                                      unnest(ARRAY[${codigos_sap}]) AS sap_material,
                                      unnest(ARRAY[${cantidades}]) AS cant_material) m
                              JOIN ( SELECT DISTINCT ON (msd.id_obra, msd.pedido, msd.codigo_sap_material) msd.id_obra,
                                      msd.pedido,
                                      msd.codigo_sap_material,
                                      msd.cantidad_requerida_new,
                                      msd.fecha_movimiento
                                    FROM obras.mat_solicitudes_detalle msd
                                      JOIN obras.mat_solicitudes_obras mso ON msd.pedido = mso.id
                                    WHERE mso.estado::text = 'PENDIENTE'::text AND msd.pedido = ${num_pedido}
                                    ORDER BY msd.id_obra, msd.pedido, msd.codigo_sap_material, msd.fecha_movimiento DESC) bm ON bm.id_obra = m.id_obra AND bm.codigo_sap_material = m.sap_material AND bm.pedido = m.pedido
                            WHERE m.cant_material::numeric <> bm.cantidad_requerida_new;`;

            }
        
            console.log('sql_pedido_movimientos -> ', sql_pedido_movimientos);
            /******************** Chequea materiales no existentes */
            if (sql_chek){

              console.log('sql_chek -> ', sql_chek);

              const check_mat = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
              if (check_mat) {
                  if (check_mat.length > 0){
                    res.status(500).send("Hay códigos de material no definidos en la base de datos");
                    return;
                  } else {
                    todoOk = true;
                  }
              } else {
                res.status(500).send("Error en la consulta (servidor backend)");
                return;
              }
            } else {
              res.status(500).send("Error en la consulta (servidor backend)");
              return;
            }

            /******************** Chequea si el pedido existe */
            sql_chek = "select * from obras.mat_solicitudes_obras where id= " + num_pedido;

            const check_pedido = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
            if (check_pedido){
              if (check_pedido.length > 0){
                //la reserva existe, verificar que este asociada al mismo id_obra
                sql_chek = sql_chek + " and id_obra = " + id_obra;
              } else {
                //el pedido no existe, se debe insertar en la tabla mat_solicitudes_obras
                sql_chek = null;
                sql_pedidos = `INSERT INTO 
                                obras.mat_solicitudes_obras (id_obra, id, estado, fecha_hora, rut_usuario) 
                                VALUES ( ${id_obra},${num_pedido}, '${estado}', 
                                substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp, '${rut_usuario}' );`;
              }
            } else {
              res.status(500).send("Error en la consulta (servidor backend)");
              return;
            }

            /******************** Chequea si el pedido está asociado al mismo id_obra */
            if (sql_chek){
              const check_asociada = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
              if (check_asociada){
                if (check_asociada.length > 0){
                  //El pedido está asociada al mismo id_obra, por último el pedido debe estar en estado 'pendiente'
                  if (check_asociada[0].estado != 'PENDIENTE'){
                    res.status(500).send("El id de pedido no se encuentra en estado pendiente, no es posible hacerle modificaciones");
                    return;
                  }
                  sql_pedidos = `UPDATE 
                                  obras.mat_solicitudes_obras 
                                SET estado = '${estado}', rut_usuario = '${rut_usuario}', fecha_hora = substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp 
                                WHERE id = ${num_pedido};`;
                  todoOk = true;
                } else {
                  //El pedido está asociada a otro id_obra, error
                  res.status(500).send("El id de pedido está asignado a otro id_obra");
                  return;
                }
              } else {
                res.status(500).send("Error en la consulta (servidor backend)");
                return;
              }
            }

            /******************** Genera la consulta total 
            */
            if (todoOk){
              if (sql_pedidos){
                sql = sql_pedidos + sql_pedido_movimientos;
              } else {
                sql = sql_pedido_movimientos;
              }
               
            }
            if (sql){
                const crea_pedido = await sequelize.query(sql, { type: QueryTypes.INSERT });
                if (crea_pedido) {
                  res.status(200).send(crea_pedido);
                  return;
                }else
                {
                  res.status(500).send("Error en la consulta (servidor backend)");
                  return;
                }
            } else {
              res.status(500).send("Error en la consulta (servidor backend)");
              return;
            }
        } catch (error) {
          console.log('error create pedido  -> ', error);
          if (error instanceof ZodError) {
            console.log(error.issues);
            const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
            res.status(400).send(mensaje);  //bad request
            return;
          }
          res.status(500).send(error);
        }
  }

   /***********************************************************************************/
  /* Obtiene numero de pedido para crear un pedido
  ;
  */
 exports.getNumeroPedido = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve el numero de pedido' */
    try {
        const dataInput = {
          id_obra: req.query.id_obra
        }

        const IDataInputSchema = z.object({
          id_obra: z.coerce.number(),
        });

        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;

        const validated = IDataInputSchema.parse(dataInput);

        const sql_pedido = `SELECT id_obra FROM obras.mat_solicitudes_obras 
                            WHERE id_obra = ${validated.id_obra} AND estado = 'PENDIENTE' LIMIT 1;`;

        const pedido = await sequelize.query(sql_pedido, { type: QueryTypes.SELECT });
        if (pedido) { 
          //HAy un estado con estado pendiente, no puede ebtregar un nuevo numero hasta que no quede ningun pendiente
          if (pedido.length > 0){
            res.status(400).send('Aún existe un pedido pendiente para esta obra, debe finalizarlo o cancelarlo antes de generar un nuevo pedido');
            return;
          }
        }


        const sql = "select nextval('obras.mat_solicitudes_obras_id_seq'::regclass) as valor;";
        
        const nextval = await sequelize.query(sql, { type: QueryTypes.SELECT });
        if (nextval) { 
          res.status(200).send(nextval[0].valor);
          return;
        }else
        {
          res.status(500).send("Error en la consulta (servidor backend)");
          return;
        }
    } catch (error) {
      if (error instanceof ZodError) {
        const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
        res.status(400).send(mensaje);  //bad request
        return;
      }
      res.status(500).send(error);
    }
  }
  /***********************************************************************************/
  /* Modifica una solicitud a estado GENERADA
  ;
  */
  exports.generaOcancelaSolicitud = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Modifica una solicitud a estado GENERADA' */
    try {

        const dataInput = {
          id: req.query.id_solicitud,
          nuevo_estado: req.query.nuevo_estado
        }

        const IDataInputSchema = z.object({
          id: z.coerce.number(),
          nuevo_estado: z.coerce.string()
        });

        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;

        const validated = IDataInputSchema.parse(dataInput);

        if (validated.nuevo_estado !== 'GENERADO' && validated.nuevo_estado !== 'CANCELADO'){
          res.status(400).send('El nuevo estado debe ser GENERADO o CANCELADO');
          return;
        }

        const sql_consulta_pedido = `SELECT id, estado FROM obras.mat_solicitudes_obras 
                            WHERE id = ${validated.id};`;

        const consulta_pedido = await sequelize.query(sql_consulta_pedido, { type: QueryTypes.SELECT });
        if (consulta_pedido) { 
          //HAy un estado con estado pendiente, no puede ebtregar un nuevo numero hasta que no quede ningun pendiente
          if (consulta_pedido.length > 0){
            if (consulta_pedido[0].estado !== 'PENDIENTE'){
              res.status(400).send('La solicitud debe estar en estado pendiente para ser generada [' + consulta_pedido[0].estado + ']');
              return;
            } //ok
          } else {
            res.status(400).send('La solicitud no existe');
            return;
          }
        } else {
          res.status(500).send("Error en la consulta (servidor backend)");
          return;
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

        const sql_detalle = validated.nuevo_estado === 'CANCELADO' ? 
        `UPDATE obras.mat_solicitudes_detalle SET tipo_movimiento = 'CANCELADO', rut_usuario = '${rut_usuario}',
        fecha_movimiento = substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp WHERE pedido = ${validated.id};` 
        :"";
        const sql = `${sql_detalle}UPDATE obras.mat_solicitudes_obras SET estado = '${validated.nuevo_estado}', rut_usuario = '${rut_usuario}', 
        fecha_hora = substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp WHERE id = ${validated.id};`;
        const pedido = await sequelize.query(sql, { type: QueryTypes.UPDATE });
        if (pedido) {
          res.status(200).send(pedido);
          return;
        }else
        {
          res.status(500).send("Error en la consulta (servidor backend)");
          return;
        } 
    } catch (error) {
      if (error instanceof ZodError) {
        const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
        res.status(400).send(mensaje);  //bad request
        return;
      }
      res.status(500).send(error);
    }
  }
  /***********************************************************************************/
  /* Obtiene listado de pedidos de marterial para una obra
  ;
  */
  exports.getPedidosPorObra = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve el listado de pedidos para una obra' */
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
        const sql = `SELECT mso.id as solicitud,
                      mso.id_obra,
                      mso.estado,
                      mso.fecha_HORA::text as fecha_hora,
                      (((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) ||
                          CASE
                              WHEN p.apellido_2 IS NULL THEN ''::character varying
                              ELSE p.apellido_2
                          END::text AS persona
                    FROM obras.mat_solicitudes_obras mso
                      JOIN _auth.personas p ON mso.rut_usuario::text = p.rut::text
                    WHERE mso.id_obra = ${id_obra};`;
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
   /***********************************************************************************/
  /* Obtiene listado de materiales para un pedido
  ;
  */
  exports.getMaterialPorPedido = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve el listado de materiales para un pedido' */
    try {
        const dataInput = {
          id: req.query.id_solicitud
        }

        const IDataInputSchema = z.object({
          id: z.coerce.number(),
        });

        const ISapMaterialSchema = z.object({
          codigo_sap: z.coerce.number(),
          texto_breve: z.coerce.string(),
          descripcion: z.coerce.string(),
          unidad: z.coerce.string(),
        })

        const IDataOutputSchema = z.object({
          id: z.coerce.number(),
          id_obra: z.coerce.number(),
          solicitud: z.coerce.number(),
          sap_material: ISapMaterialSchema,
          cantidad_requerida: z.coerce.number(),
          fecha_ingreso: z.coerce.string(),
          rut_usuario: z.coerce.string(),
          persona: z.coerce.string()
        });

        const IArrayDataOutputSchema = z.array(IDataOutputSchema);

        const validated = IDataInputSchema.parse(dataInput);

        const id = validated.id;
        const sql = `SELECT DISTINCT ON (msd.pedido, msd.codigo_sap_material) 
                          msd.id,
                          msd.id_obra,
                          msd.pedido as solicitud,
                          row_to_json(mm) as sap_material,
                          msd.cantidad_requerida_new AS cantidad_requerida,
                          msd.fecha_movimiento::text AS fecha_ingreso,
                          msd.rut_usuario,
                          (((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) ||
                          CASE
                              WHEN p.apellido_2 IS NULL THEN ''::character varying
                              ELSE p.apellido_2
                          END::text AS persona
                        FROM obras.mat_solicitudes_detalle msd
                        JOIN _auth.personas p ON msd.rut_usuario::text = p.rut::text
                      LEFT JOIN (SELECT codigo_sap, texto_breve, descripcion, mu.codigo_corto as unidad
                        FROM obras.maestro_materiales mm join obras.maestro_unidades mu
                        ON mm.id_unidad = mu.id) mm 
                      ON msd.codigo_sap_material = mm.codigo_sap 
                        WHERE msd.pedido = ${id}
                        ORDER BY msd.pedido, msd.codigo_sap_material, msd.fecha_movimiento desc;`;
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
     /***********************************************************************************/
  /* Obtiene listado de materiales para una reserva
  ;
  */
  exports.getMaterialPorReserva = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve el listado de materiales para una reserva' */
    try {
        const dataInput = {
          cod_reserva: req.query.codigo_reserva
        }

        const IDataInputSchema = z.object({
          cod_reserva: z.coerce.number(),
        });

        const ISapMaterialSchema = z.object({
          codigo_sap: z.coerce.number(),
          texto_breve: z.coerce.string(),
          descripcion: z.coerce.string()
        })

        const IDataOutputSchema = z.object({
          id: z.coerce.number(),
          id_obra: z.coerce.number(),
          reserva: z.coerce.number(),
          sap_material: ISapMaterialSchema,
          cantidad_requerida: z.coerce.number(),
          fecha_ingreso: z.coerce.string(),
          rut_usuario: z.coerce.string(),
          persona: z.coerce.string()
        });

        const IArrayDataOutputSchema = z.array(IDataOutputSchema);

        const validated = IDataInputSchema.parse(dataInput);

        const cod_reserva = validated.cod_reserva;
        const sql = `SELECT DISTINCT ON (mbi.cod_reserva, mbi.codigo_sap_material) 
                          mbi.id,
                          mbi.id_obra,
                          mbi.cod_reserva as reserva,
                          row_to_json(mm) as sap_material,
                          mbi.cantidad_requerida_new AS cantidad_requerida,
                          mbi.fecha_movimiento::text AS fecha_ingreso,
                          mbi.rut_usuario,
                          (((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) ||
                          CASE
                              WHEN p.apellido_2 IS NULL THEN ''::character varying
                              ELSE p.apellido_2
                          END::text AS persona
                        FROM obras.mat_bom_ingresos mbi
                        JOIN _auth.personas p ON mbi.rut_usuario::text = p.rut::text
                      LEFT JOIN obras.maestro_materiales mm 
                      ON mbi.codigo_sap_material = mm.codigo_sap 
                        WHERE mbi.cod_reserva = ${cod_reserva}
                        ORDER BY mbi.cod_reserva, mbi.codigo_sap_material, mbi.fecha_movimiento desc;`;
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const reservas = await sequelize.query(sql, { type: QueryTypes.SELECT });
        if (reservas) {
          const data = IArrayDataOutputSchema.parse(reservas);
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
  /***********************************************************************************/
  /* Obtiene listado de obras para pedido
  ;
  */
  exports.getAllObrasParaBom = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve el listado de obras para un pedido' */
    try {
      const IDataOutputSchema = z.object({
        codigo_obra: z.coerce.string(),
        cant_reservas: z.coerce.number(),
        cant_pedidos: z.coerce.number(),
      });
      const IArrayDataOutputSchema = z.array(IDataOutputSchema);
      const sql = `SELECT o.codigo_obra,
                    CASE
                        WHEN mbr.cant_reservas IS NULL THEN 0::bigint
                        ELSE mbr.cant_reservas
                    END AS cant_reservas,
                    CASE
                        WHEN mso.cant_pedidos IS NULL THEN 0::bigint
                        ELSE mbr.cant_reservas
                    END AS cant_pedidos
                  FROM obras.obras o
                    LEFT JOIN ( SELECT mat_bom_reservas.id_obra,
                            count(mat_bom_reservas.id_obra) AS cant_reservas
                          FROM obras.mat_bom_reservas
                          GROUP BY mat_bom_reservas.id_obra) mbr ON o.id = mbr.id_obra
                    LEFT JOIN ( SELECT mat_solicitudes_obras.id_obra,
                            count(mat_solicitudes_obras.id_obra) AS cant_pedidos
                          FROM obras.mat_solicitudes_obras
                          GROUP BY mat_solicitudes_obras.id_obra) mso ON o.id = mso.id_obra
                  WHERE o.estado = ANY (ARRAY[1, 4, 5])
                  ORDER BY o.codigo_obra;`;

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
 /***********************************************************************************/
  /* Obtiene listado de reservas en el bom para una obra
  ;
  */
  exports.getReservasPorObra = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Devuelve el listado de reservas dentro del bom para una obra' */
      try {
        const dataInput = {
          id_obra: req.query.id_obra
        }

        const IDataInputSchema = z.object({
          id_obra: z.coerce.number(),
        });

        const IDataOutputSchema = z.object({
          reserva: z.coerce.number(),
          id_obra: z.coerce.number(),
          estado: z.coerce.string(),
          fecha_hora: z.coerce.string(),
          persona: z.coerce.string(),
        });

        const IArrayDataOutputSchema = z.array(IDataOutputSchema);

        const validated = IDataInputSchema.parse(dataInput);

        const id_obra = validated.id_obra;
        const sql = `SELECT ro.reserva as reserva,
                    ro.id_obra,
                    'CARGADA'::text as estado,
                    bm.fecha_movimiento::text as fecha_hora,
                    (((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) ||
                      CASE
                        WHEN p.apellido_2 IS NULL THEN ''::character varying
                        ELSE p.apellido_2
                      END::text AS persona
                  FROM obras.mat_bom_reservas ro
                    JOIN ( SELECT DISTINCT ON (mat_bom_ingresos.cod_reserva) mat_bom_ingresos.cod_reserva,
                      mat_bom_ingresos.id_obra,
                      mat_bom_ingresos.fecha_movimiento,
                      mat_bom_ingresos.rut_usuario
                      FROM obras.mat_bom_ingresos
                      ORDER BY mat_bom_ingresos.cod_reserva, mat_bom_ingresos.fecha_movimiento DESC) bm 
                      ON ro.reserva = bm.cod_reserva AND ro.id_obra = bm.id_obra
                    JOIN _auth.personas p ON bm.rut_usuario::text = p.rut::text
                  WHERE ro.id_obra = ${id_obra}
                  ORDER BY bm.fecha_movimiento DESC`;
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
/***********************************************************************************/
  /* Crea listado de materiales para salida a faena desde bodega
  ;
  */
  exports.createListaFaena = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Crea un listado de materiales para salida a faena desde bodega' */

    try {
      
      console.log("createListaFaena");
      const dataInput = {
        id_obra: req.body.id_obra,
        detalle: req.body.detalle
      }
      
      const IDetalleSchema = z.object({
        id_obra: z.coerce.number(),
        materiales: z.string().regex(/^([1-9]\d+|[1-9])+_\d+(.\d+)?(-([1-9]\d+|[1-9])+_\d+(.\d+)?)*$/gm)
      });

      const IDataInputSchema = z.object({
        id_obra: z.coerce.number(),
        detalle: z.array(IDetalleSchema),
      });

      const validated = IDataInputSchema.parse(dataInput);
      const id_obra = validated.id_obra;
      const detalleInput = validated.detalle;

      if (detalleInput.length === 0) {
        res.status(400).send( "Debe existir al menos un material" );
        return;
      }

      const detalle = uniformarArregloFaena(detalleInput);
      //Consultar el id de encabezado libre
        /*
        const sql_nextval = "select nextval('obras.mat_faena_encabezado_id_seq'::regclass) as valor;";
        let id_encabezado;
        
        const querynextval = await sequelize.query(sql_nextval, { type: QueryTypes.SELECT });
        if (querynextval) { 
          id_encabezado = querynextval[0].valor;
        }else
        {
          res.status(500).send("Error en la consulta (servidor backend)");
          return;
        }
        */

        let id_usuario = req.userId;
        let rut_usuario;
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const sql_usuario = "select username from _auth.users where id = " + id_usuario;
        await sequelize.query(sql_usuario, {
          type: QueryTypes.SELECT
        }).then(data => {
          rut_usuario = data[0].username;
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })

        let id_encabezado = 1;
        const sql_inserta_encabezado = `INSERT INTO 
                                        obras.mat_faena_encabezado (id, id_obra, estado, fecha_hora, rut_usuario) 
                                        VALUES (${id_encabezado}, ${id_obra}, 'GENERADO', substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp, '${rut_usuario}');`;



      let sql_inserta_detalle = "";
      for (const element of detalle) {
        
        let materiales = element.materiales;
        let id_obra_presta = element.id_obra;

        if (!materiales) {
          res.status(400).send( "Debe existir al menos un material" );
          return;
        }

        if (!id_obra_presta) {
          res.status(400).send( "Debe existir al menos un material" );
          return; 
        }

        materiales = materiales.replace(",", ".");
        let materiales_input = materiales.split("-");
        let materiales_repetidos = []
        //sql_inserta_detalle = "";
        for (const element of materiales_input) {
          if (element) {
            const valores = element.split("_")
            const valor = {"codigo_sap": valores[0], "cantidad": Number(valores[1])}
            materiales_repetidos.push(valor);
          }
        };

        const arreglo_materiales = obtenerValoresUnicosConSuma(materiales_repetidos);
        console.log('id_obra e id_obra_presta: ',id_obra ,id_obra_presta);
        console.log('materiales_repetidos',materiales_repetidos);
        console.log('arreglo_materiales',arreglo_materiales);

        for (const element of arreglo_materiales) {
          const cod_reserva = 100;
          sql_inserta_detalle = sql_inserta_detalle + `INSERT INTO 
                                                    obras.mat_faena_detalle 
                                                    (id_encabezado, id_obra, cod_reserva, codigo_sap_material, cantidad) 
                                                    VALUES `;
          sql_inserta_detalle = sql_inserta_detalle + `(${id_encabezado}, ${id_obra}, ${cod_reserva}, ${element.codigo_sap}, ${element.cantidad});`;
        }
      };

      const sql_completo = sql_inserta_encabezado + sql_inserta_detalle;

      res.status(200).send(sql_completo);

    } catch (error) {
      console.log('error -> ', error);
      if (error instanceof ZodError) {
        console.log(error.issues);
        const mensaje = error.issues.map(issue => 'Error en campo: '+issue.path[0]+' -> '+issue.message).join('; ');
        res.status(400).send(mensaje);  //bad request
        return;
      }
      res.status(500).send(error);

    }
  }
  /***********************************************************************************/
  /* Crea un nuevo bom de forma masiva
  ;
  */
  exports.createBomIndividual = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Ingresa un sólo material en el bom' */
    const campos = [
      'id_obra', 'reserva', 'codigo_sap_material', 'cantidad_requerida'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send("No puede estar nulo el campo " + element
        );
        return;
      }
    };
  
    try {
      const cod_sap = req.body.codigo_sap_material
      const cantidad = req.body.cantidad_requerida
      const id_obra = req.body.id_obra;
      const reserva = req.body.reserva;
      console.log("cod_sap", cod_sap);
      console.log("id_obra", id_obra);
      console.log("reserva", reserva);
      console.log("cantidad", cantidad);
  
      let sql_chek = "select m.sap_material from (select unnest(array[" + cod_sap + "]) as sap_material) as m left join obras.maestro_materiales mm on m.sap_material = mm.codigo_sap where mm.codigo_sap is null;";
      let sql = "insert into obras.bom (id_obra, reserva, codigo_sap_material, cantidad_requerida) values (" + id_obra + ", " + reserva + ", " + cod_sap + ", " + cantidad + ");"
  
      let todoOk = false;
  
        if (sql_chek){
          const { QueryTypes } = require('sequelize');
          const sequelize = db.sequelize;
          const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
          if (bom) {
              if (bom.length > 0){
                    //Hay materiales no definidos
                    const detalle_salida = {
                      error: Boolean(true),
                      mensaje: String("Hay códigos de material no definidos en la base de datos"),
                      detalle: bom
                    }
                    res.status(200).send(detalle_salida);
                  }else {
                    //Chequear si la reserva existe en la tabla mat_bom_reservas
                    //Si existe, chequear que el id_obra sea el mismo que se está ingresando
                    //Si no es el mismo quiere decir que la reserva ya está asignada a otra obra, por lo que debe arrojar error
                    //Si la reserva no se encuentra se debe crear en la tabal mat_bom_reservas y asignarla al codigo de obra
                    sql_chek = "select * from obras.mat_bom_reservas where reserva = " + reserva;
                    const { QueryTypes } = require('sequelize');
                    const sequelize = db.sequelize;
                    const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                    if (bom){
                      if (bom.length > 0){
                        //La reserva se encuentra en la tabla de mat_bom_reservas
                        //Chequear ahora si el id_obra es el mismo que se estaba ingresando
                        sql_chek = "select * from obras.mat_bom_reservas where reserva = " + reserva + " and id_obra = " + id_obra;
                        const { QueryTypes } = require('sequelize');
                        const sequelize = db.sequelize;
                        const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                        if (bom){
                          if (bom.length > 0){
                          //El id_obra se encuentra en la tabla de mat_bom_reservas
                          //No hay errores, proceder a ingresar el bom
                          todoOk = true;
                          }else {
                          //El id_obra no se encuentra en la tabla de mat_bom_reservas 
                          //La reserva está asignada a otro id_de obra, arrojar un error
                          throw new Error("La reserva está asignada a otro id_obra");
                          }
                        }else {res.status(500).send("Error en la consulta (servidor backend)");}
  
                      }else{
                        //La reserva no se encuentra en la tabla mat_bom_reservas, se debe ingresar junto con el id de obra
                        // Si la reserva no se encuentra en la tabla de mat_bom_reservas
                        // Se debe ingresar junto con el id de obra
                        const sql_insert = "INSERT INTO obras.mat_bom_reservas (reserva, id_obra) VALUES (" + reserva + ", " + id_obra + ");";
                        sql = sql_insert + sql;
                        todoOk = true;
                      }
                        if (sql && todoOk) {
                                    // Si todos los materiales estan definidos
                                    const { QueryTypes } = require('sequelize');
                                    const sequelize = db.sequelize;
                                    const bom = await sequelize.query(sql, { type: QueryTypes.INSERT });
                                    if (bom) {
                                      res.status(200).send(bom);
                                    }else{res.status(500).send("Error en la consulta (servidor backend)");}
  
                        } else {res.status(500).send("Consulta vacía (error servidor backend)");}
  
                    }else{res.status(500).send("Error en la consulta (servidor backend)");}
  
                  }
          }else{res.status(500).send("Error en la consulta (servidor backend)");}
  
        }else{res.status(500).send("Error en la consulta (servidor backend)");}
      
    }catch (error) {
      res.status(500).send(error);
    }   
    
  }
  /***********************************************************************************/
  /* Elimina bom por reserva
  ;
  */
  exports.deleteBomByReserva = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Borra un grupo de materiales asociados a una reserva' */
  
    const reserva = req.params.reserva;
    Bom.destroy({
      where: { reserva: reserva }
    }).then(data => {
      console.log('data', data);
      if (data > 0) {
        res.status(400).send(`Reserva eliminada del Bom. Cantidad de registros eliminados: ${data}`);
      } else {
        res.status(400).send(`No existe la reserva ${reserva}` );
      }
    }).catch(err => {
      res.status(500).send(err.message );
    })
  
  }
  /***********************************************************************************/
  /* Elimina material del bom, por cod_sap de material y numero de reserva
  ;
  */
  exports.deleteBomByMaterial = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Borra un sólo material asociado a una reserva' */
    const reserva = req.params.reserva;
    const cod_sap = req.params.cod_sap;
    if (!cod_sap || !reserva){
      res.status(400).send("Debe especificar el código de material y la reserva a borrar");
    } else {
        Bom.destroy({
          where: { reserva: reserva, codigo_sap_material: cod_sap }
        }).then(data => {
          console.log('data', data);
          if (data > 0) {
            res.status(400).send("Material eliminado del Bom" );
          } else {
            res.status(400).send(`No existe el codigo material ${cod_sap} para la reserva ${reserva}`);
          }
        }).catch(err => {
          res.status(500).send(err.message );
        })
    }
  }

  function obtenerValoresUnicosConSuma(arreglo) {
    const objetoResultante = {};

    // Iterar sobre el arreglo
    arreglo.forEach((elemento) => {
        const codigo_sap = elemento.codigo_sap;
        const cantidad = elemento.cantidad;

        // Si el código ya existe en el objeto, suma el valor al valor existente
        if (objetoResultante[codigo_sap]) {
            objetoResultante[codigo_sap] += cantidad;
        } else {
            // Si el código no existe en el objeto, simplemente agrega el código y el valor
            objetoResultante[codigo_sap] = cantidad;
        }
    });

    // Convertir el objeto en un arreglo de objetos si es necesario
    const resultado = Object.keys(objetoResultante).map((codigo_sap) => ({
        codigo_sap: codigo_sap,
        cantidad: objetoResultante[codigo_sap]
    }));

    return resultado;
}

function uniformarArregloFaena(arreglo) {
  console.log( "uniformarArregloFaena", arreglo );
  const objetoResultante = {};

  // Iterar sobre el arreglo
  arreglo.forEach((elemento) => {
    const id_obra = elemento.id_obra;
    const materiales = elemento.materiales;

    // Si el código ya existe en el objeto, suma el valor al valor existente
    if (objetoResultante[id_obra]) {
        objetoResultante[id_obra] += '-' + materiales;
    } else {
        // Si el código no existe en el objeto, simplemente agrega el código y el valor
        objetoResultante[id_obra] = materiales;
    }
    });

    // Convertir el objeto en un arreglo de objetos si es necesario
    const resultado = Object.keys(objetoResultante).map((id_obra) => ({
        id_obra: id_obra,
        materiales: objetoResultante[id_obra]
    }));

    return resultado;
}
