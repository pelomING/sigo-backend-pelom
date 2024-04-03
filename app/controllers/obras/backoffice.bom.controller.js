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
                    //Chequear si la reserva existe en la tabla reservas_obras
                    //Si existe, chequear que el id_obra sea el mismo que se está ingresando
                    //Si no es el mismo quiere decir que la reserva ya está asignada a otra obra, por lo que debe arrojar error
                    //Si la reserva no se encuentra se debe crear en la tabla reservas_obras y asignarla al codigo de obra
                    sql_chek = "select * from obras.reservas_obras where reserva = " + reserva;
                    const { QueryTypes } = require('sequelize');
                    const sequelize = db.sequelize;
                    const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                    if (bom){
                      if (bom.length > 0){
                        //La reserva se encuentra en la tabla de reservas_obras
                        //Chequear ahora si el id_obra es el mismo que se estaba ingresando
                        sql_chek = "select * from obras.reservas_obras where reserva = " + reserva + " and id_obra = " + id_obra;
                        const { QueryTypes } = require('sequelize');
                        const sequelize = db.sequelize;
                        const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                        if (bom){
                          if (bom.length > 0){
                              //El id_obra se encuentra en la tabla de reservas_obras
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
                          //El id_obra no se encuentra en la tabla de reservas_obras 
                          //La reserva está asignada a otro id_de obra, arrojar un error
                          throw new Error("La reserva está asignada a otro id_obra");
                          }
                        }else {res.status(500).send("Error en la consulta (servidor backend)");}
  
                      }else{
                        //La reserva no se encuentra en la tabla reservas_obras, se debe ingresar junto con el id de obra
                        // Si la reserva no se encuentra en la tabla de reservas_obras
                        // Se debe ingresar junto con el id de obra
                        const sql_insert = "INSERT INTO obras.reservas_obras (reserva, id_obra) VALUES (" + reserva + ", " + id_obra + ");";
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

              sql_bom_movimientos = `INSERT INTO obras.bom_movimientos (
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
                                      FROM obras.bom_movimientos 
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
            sql_chek = "select * from obras.reservas_obras where reserva = " + reserva;
            
            const check_reserva = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
            if (check_reserva){
              if (check_reserva.length > 0){
                //la reserva existe, verificar que este asociada al mismo id_obra
                sql_chek = sql_chek + " and id_obra = " + id_obra;
              } else {
                //la reserva no existe, se debe insertar en la tabla reservas_obras
                sql_chek = null;
                sql_reservas = "insert into obras.reservas_obras (id_obra, reserva) values (" + id_obra + ", " + reserva + ");";
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
      #swagger.description = 'Ingresa un grupo de materiales para generan un pedido de material' */
  

        //ejemplo: { "materiales": "1219_3-1220_2.5-3567_3", "id_obra": 22}

        const inputDatos = {
          materiales: req.body.materiales,
          id_obra: req.body.id_obra,
          pedido: req.body.pedido
        }

        //chequeo con Zod
        const inputDatosSchema = z.object({
          materiales: z.string().regex(/^([1-9]\d+|[1-9])+_\d+(.\d+)?(-([1-9]\d+|[1-9])+_\d+(.\d+)?)*$/gm),
          id_obra: z.coerce.number().int().positive(),
          pedido: z.coerce.number().int().positive()
        })

        
       
        try {
          //Considerar que para poder crear un pedido nuevo el numero de pedido no debe existir
          //En caso de estar modificando un pedido existente, el pedido debe estar en estado 'pendiente'

            //valida datos de entrada
            const pedido = inputDatosSchema.parse(inputDatos);

            const { QueryTypes } = require('sequelize');
            const sequelize = db.sequelize;

            let todoOk = false;
            let materiales = pedido.materiales;
            //reemplaza las comas por puntos, por si hay alguna cantidad decimal
            materiales = materiales.replace(",", ".");
            console.log('materiales -> ',materiales);
            let id_obra = pedido.id_obra;
            const num_pedido = pedido.pedido;
            //el simblo guion separa la información de materiales
            let materiales_input = materiales.split("-");
            console.log('materiales_input -> ',materiales_input);

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

              //No considerar los tipo_movimiento 'CANCELADO'
              sql_pedido_movimientos = `INSERT INTO obras.pedido_material_mandante (
                                            id_obra, 
                                            pedido,
                                            codigo_sap_material, 
                                            cantidad_requerida_old, 
                                            cantidad_requerida_new, 
                                            tipo_movimiento, 
                                            fecha_movimiento, 
                                            rut_usuario
                                          )
                                    SELECT 
                                        m.id_obra,
                                        ${num_pedido}::bigint,
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
                                            ${num_pedido}::bigint as pedido,
                                            unnest(array[${codigos_sap}]) as sap_material, 
                                            unnest(array[${cantidades}]) as cant_material) as m 
                                    LEFT JOIN 
                                      (SELECT DISTINCT ON (id_obra, codigo_sap_material) 
                                          id_obra, 
                                          codigo_sap_material, 
                                          cantidad_requerida_new, 
                                          fecha_movimiento 
                                      FROM obras.pedido_material_mandante 
                                      WHERE tipo_movimiento <> 'CANCELADO'
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

            /******************** Chequea si el pedido existe */
            sql_chek = "select * from obras.pedidos_mandante_obras where id= " + num_pedido;

            const check_pedido = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
            if (check_pedido){
              if (check_pedido.length > 0){
                //la reserva existe, verificar que este asociada al mismo id_obra
                sql_chek = sql_chek + " and id_obra = " + id_obra;
              } else {
                //el pedido no existe, se debe insertar en la tabla pedidos_mandante_obras
                sql_chek = null;
                sql_pedidos = "insert into obras.pedidos_mandante_obras (id_obra, id, estado) values (" + id_obra + ", " + num_pedido + ", 'PENDIENTE');";
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

        const sql_pedido = `SELECT id_obra FROM obras.pedidos_mandante_obras 
                            WHERE id_obra = ${validated.id_obra} AND estado = 'PENDIENTE' LIMIT 1;`;

        const pedido = await sequelize.query(sql_pedido, { type: QueryTypes.SELECT });
        if (pedido) { 
          //HAy un estado con estado pendiente, no puede ebtregar un nuevo numero hasta que no quede ningun pendiente
          if (pedido.length > 0){
            res.status(400).send('Aún existe un pedido pendiente para esta obra, debe finalizarlo o cancelarlo antes de generar un nuevo pedido');
            return;
          }
        }


        const sql = "select nextval('obras.pedidos_mandante_obras_id_seq'::regclass) as valor;";
        
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
          id: z.coerce.number(),
          id_obra: z.coerce.number(),
          estado: z.coerce.string(),
          fecha_hora: z.coerce.string()
        });

        const IArrayDataOutputSchema = z.array(IDataOutputSchema);

        const validated = IDataInputSchema.parse(dataInput);

        const id_obra = validated.id_obra;
        const sql = `SELECT 
                      pmo.id, 
                      pmo.id_obra, 
                      pmo.estado, 
                      max(pmm.fecha_movimiento)::text as fecha_hora
                    FROM 
                      obras.pedidos_mandante_obras pmo 
                    JOIN obras.pedido_material_mandante pmm
                    ON 
                      pmo.id = pmm.pedido 
                    WHERE pmo.id_obra = ${id_obra}
                    GROUP BY pmo.id, pmo.id_obra, pmo.estado
                    ORDER BY pmo.id DESC`;
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
          id: req.query.id
        }

        const IDataInputSchema = z.object({
          id: z.coerce.number(),
        });

        const IDataOutputSchema = z.object({
          id: z.coerce.number(),
          id_obra: z.coerce.number(),
          id_material: z.coerce.number(),
          estado: z.coerce.string(),
          fecha_hora: z.coerce.string()
        });

        const IArrayDataOutputSchema = z.array(IDataOutputSchema);

        const validated = IDataInputSchema.parse(dataInput);

        const id = validated.id;
        const sql = `SELECT
                      pmm.id, 
                      pmm.id_obra, 
                      pmm.id_material, 
                      pmm.estado, 
                      max(pmm.fecha_movimiento)::text as fecha_hora     
                    FROM 
                      obras.pedido_material_mandante pmm
                    WHERE pmm.pedido = ${id}
                    GROUP BY pmm.id, pmm.id_obra, pmm.id_material, pmm.estado
                    ORDER BY pmm.id DESC`;
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
                    //Chequear si la reserva existe en la tabla reservas_obras
                    //Si existe, chequear que el id_obra sea el mismo que se está ingresando
                    //Si no es el mismo quiere decir que la reserva ya está asignada a otra obra, por lo que debe arrojar error
                    //Si la reserva no se encuentra se debe crear en la tabal reservas_obras y asignarla al codigo de obra
                    sql_chek = "select * from obras.reservas_obras where reserva = " + reserva;
                    const { QueryTypes } = require('sequelize');
                    const sequelize = db.sequelize;
                    const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                    if (bom){
                      if (bom.length > 0){
                        //La reserva se encuentra en la tabla de reservas_obras
                        //Chequear ahora si el id_obra es el mismo que se estaba ingresando
                        sql_chek = "select * from obras.reservas_obras where reserva = " + reserva + " and id_obra = " + id_obra;
                        const { QueryTypes } = require('sequelize');
                        const sequelize = db.sequelize;
                        const bom = await sequelize.query(sql_chek, { type: QueryTypes.SELECT });
                        if (bom){
                          if (bom.length > 0){
                          //El id_obra se encuentra en la tabla de reservas_obras
                          //No hay errores, proceder a ingresar el bom
                          todoOk = true;
                          }else {
                          //El id_obra no se encuentra en la tabla de reservas_obras 
                          //La reserva está asignada a otro id_de obra, arrojar un error
                          throw new Error("La reserva está asignada a otro id_obra");
                          }
                        }else {res.status(500).send("Error en la consulta (servidor backend)");}
  
                      }else{
                        //La reserva no se encuentra en la tabla reservas_obras, se debe ingresar junto con el id de obra
                        // Si la reserva no se encuentra en la tabla de reservas_obras
                        // Se debe ingresar junto con el id de obra
                        const sql_insert = "INSERT INTO obras.reservas_obras (reserva, id_obra) VALUES (" + reserva + ", " + id_obra + ");";
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
