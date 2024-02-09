const db = require("../../models");
const Bom = db.bom;
/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 BILL OF MATERIALS BOM                           */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/
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
  /* Crea un nuevo bom de forma masiva
  ;
  */
  exports.createBomMasivo = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Manejo materiales (bom)']
      #swagger.description = 'Ingresa un grupo de materiales en el bom de una sola vez' */
  
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
      materiales = materiales.replace(",", ".");
      let id_obra = req.body.id_obra;
      let reserva = req.body.reserva;
      let arreglo_materiales = materiales.split("-");
      let sql = "";
      let sql_chek = "";
      let inicia = false;
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