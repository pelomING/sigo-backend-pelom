const db = require("../../models");
const TipoObra = db.tipoObra;
const Zonal = db.zonal;
const Delegacion = db.delegacion;
const TipoTrabajo = db.tipoTrabajo;
const EmpresaContratista = db.empresaContratista;
const CoordinadorContratista = db.coordinadorContratista;
const Comuna = db.comuna;
const EstadoObra = db.estadoObra;
const Segmento = db.segmento;
const Obra = db.obra;
const Bom = db.bom;

exports.findAllTipoObra = async (req, res) => {
    //metodo GET
      await TipoObra.findAll().then(data => {
          res.send(data);
      }).catch(err => {
          res.status(500).send({ message: err.message });
      })
  }
  /*********************************************************************************** */

exports.findAllZonal = async (req, res) => {
    //metodo GET
    try {
      const data = await Zonal.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllDelegacion = async (req, res) => {
    //metodo GET
    try {
      const data = await Delegacion.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


 exports.findAllTipoTrabajo = async (req, res) => {
    //metodo GET
    try {
      const data = await TipoTrabajo.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllEmpresaContratista = async (req, res) => {
    //metodo GET
    try {
      const data = await EmpresaContratista.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllCoordinadorContratista = async (req, res) => {
    //metodo GET
    try {
      const data = await CoordinadorContratista.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */


exports.findAllComuna = async (req, res) => {
    //metodo GET
    try {
      const data = await Comuna.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */

exports.findAllEstadoObra = async (req, res) => {
    //metodo GET
    try {
      const data = await EstadoObra.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */

exports.findAllSegmento = async (req, res) => {
    //metodo GET
    try {
      const data = await Segmento.findAll();
      res.send(data);
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
}
 /*********************************************************************************** */

/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 TABLA OBRAS                                     */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/


/*********************************************************************************** */
/* Consulta todas las Obras
;
*/
exports.findAllObra = async (req, res) => {
    //metodo GET
    try {
      const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, gestor_cliente, \
      numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, fecha_termino::text, row_to_json(tt) as tipo_trabajo, \
      persona_envia_info, cargo_persona_envia_info, row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, \
      row_to_json(c) as comuna, ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada \
      FROM obras.obras o left join _comun.zonal z on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join \
      obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left \
      join obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo \
      left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento \
      s on o.segmento = s.id";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const obras = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (obras) {
        for (const element of obras) {
  
              const detalle_salida = {
                id: Number(element.id),
                codigo_obra: String(element.codigo_obra),
                numero_ot: String(element.numero_ot),
                nombre_obra: String(element.nombre_obra),
                zona: element.zona, //json
                delegacion: element.delegacion, //json
                gestor_cliente: String(element.gestor_cliente),
                numero_aviso: Number(element.numero_aviso),
                numero_oc: String(element.numero_oc),
                monto: Number(element.monto),
                cantidad_uc: Number(element.cantidad_uc),
                fecha_llegada: String(element.fecha_llegada),
                fecha_inicio: String(element.fecha_inicio),
                fecha_termino: String(element.fecha_termino),
                tipo_trabajo: element.tipo_trabajo, //json
                persona_envia_info: String(element.persona_envia_info),
                cargo_persona_envia_info: String(element.cargo_persona_envia_info),
                empresa_contratista: element.empresa_contratista, //json
                coordinador_contratista: element.coordinador_contratista, //json
                comuna: element.comuna, //json
                ubicacion: String(element.ubicacion),
                estado: element.estado, //json
                tipo_obra: element.tipo_obra, //json
                segmento: element.segmento, //json
                eliminada: Boolean(element.eliminada) ? true : false
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


/*********************************************************************************** */
/* Crea una obra
;
*/
exports.createObra = async (req, res) => {

    let salir = false;
    const campos = [
      'codigo_obra', 'nombre_obra'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send({
          message: "No puede estar nulo el campo " + element
        });
        return;
      }
    };
  
    //Verifica que el codigo obra no se encuentre
    await Obra.findAll({where: {codigo_obra: req.body.codigo_obra}}).then(data => {
      //el rut ya existe
      if (data.length > 0) {
        salir = true;
        res.status(403).send({ message: 'El Codigo de Obra ya se encuentra ingresado en la base' });
      }
    }).catch(err => {
        salir = true;
        res.status(500).send({ message: err.message });
    })
  
    if (salir) {
      return;
    }

    const obra = {

        codigo_obra: req.body.codigo_obra,
        nombre_obra: req.body.nombre_obra,
        numero_ot: req.body.numero_ot,
        zona: req.body.zona,
        delegacion: req.body.delegacion,
        gestor_cliente: req.body.gestor_cliente,
        numero_aviso: req.body.numero_aviso,
        numero_oc: req.body.numero_oc,
        monto: req.body.monto,
        cantidad_uc: req.body.cantidad_uc,
        fecha_llegada: req.body.fecha_llegada,
        fecha_inicio: req.body.fecha_inicio,
        fecha_termino: req.body.fecha_termino,
        tipo_trabajo: req.body.tipo_trabajo,
        persona_envia_info: req.body.persona_envia_info,
        cargo_persona_envia_info: req.body.cargo_persona_envia_info,
        empresa_contratista: req.body.companya_contratista,
        coordinador_contratista: req.body.coordinador_contratista,
        comuna: req.body.comuna,
        ubicacion: req.body.ubicacion,
        estado: req.body.estado?req.body.estado:1,
        tipo_obra: req.body.tipo_obra,
        segmento: req.body.segmento,
        eliminada: false

    }

    await Obra.create(obra)
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({ message: err.message });
        })
  
  }
  /*********************************************************************************** */


/*********************************************************************************** */
/* Actualiza una obra
;
*/
exports.updateObra = async (req, res) => {
  const id = req.params.id;


  await Obra.update(req.body, {
    where: { id: id }
  }).then(data => {
    if (data[0] === 1) {
      res.send({ message: "Obra actualizada" });
    } else {
      res.send({ message: `No existe una obra con el id ${id}` });
    }
  }).catch(err => {
    res.status(500).send({ message: err.message });
  })
}
  /*********************************************************************************** */


/*********************************************************************************** */
/* Eliminar una obra
;
*/
exports.deleteObra = async (req, res) => {
  const id = req.params.id;
  const borrar = {"eliminada": true};

  await Obra.update(borrar, {
    where: { id: id }
  }).then(data => {
    if (data[0] === 1) {
      res.send({ message: "Obra eliminada" });
    }
  }).catch(err => {
    res.status(500).send({ message: err.message });
  })

}
  /*********************************************************************************** */


/*********************************************************************************** */
/* Encuentra una obra por id
;
*/
exports.findObraById = async (req, res) => {
  const id = req.params.id;

  try {
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, gestor_cliente, \
    numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, fecha_termino::text, row_to_json(tt) as tipo_trabajo, \
    persona_envia_info, cargo_persona_envia_info, row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, \
    row_to_json(c) as comuna, ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada \
    FROM obras.obras o left join _comun.zonal z on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join \
    obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left \
    join obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo \
    left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento \
    s on o.segmento = s.id WHERE o.id = :id";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const obras = await sequelize.query(sql, { replacements: { id: id }, type: QueryTypes.SELECT });
    let salida = [];
    if (obras) {
      for (const element of obras) {

            const detalle_salida = {
              id: Number(element.id),
              codigo_obra: String(element.codigo_obra),
              numero_ot: String(element.numero_ot),
              nombre_obra: String(element.nombre_obra),
              zona: element.zona, //json
              delegacion: element.delegacion, //json
              gestor_cliente: String(element.gestor_cliente),
              numero_aviso: Number(element.numero_aviso),
              numero_oc: String(element.numero_oc),
              monto: Number(element.monto),
              cantidad_uc: Number(element.cantidad_uc),
              fecha_llegada: String(element.fecha_llegada),
              fecha_inicio: String(element.fecha_inicio),
              fecha_termino: String(element.fecha_termino),
              tipo_trabajo: element.tipo_trabajo, //json
              persona_envia_info: String(element.persona_envia_info),
              cargo_persona_envia_info: String(element.cargo_persona_envia_info),
              empresa_contratista: element.empresa_contratista, //json
              coordinador_contratista: element.coordinador_contratista, //json
              comuna: element.comuna, //json
              ubicacion: String(element.ubicacion),
              estado: element.estado, //json
              tipo_obra: element.tipo_obra, //json
              segmento: element.segmento, //json
              eliminada: Boolean(element.eliminada) ? true : false
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
  /*********************************************************************************** */


/*********************************************************************************** */
/* Encuentra una obra por Codigo Obra
;
*/
exports.findObraByCodigo = async (req, res) => {
  const codigo_obra = req.query.codigo_obra;

  try {
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, gestor_cliente, \
    numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, fecha_termino::text, row_to_json(tt) as tipo_trabajo, \
    persona_envia_info, cargo_persona_envia_info, row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, \
    row_to_json(c) as comuna, ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada \
    FROM obras.obras o left join _comun.zonal z on o.zona = z.id left join obras.delegaciones d on o.delegacion = d.id left join \
    obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join obras.empresas_contratista ec on o.empresa_contratista = ec.id left \
    join obras.coordinadores_contratista cc on o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo \
    left join obras.estado_obra eo on o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento \
    s on o.segmento = s.id WHERE o.codigo_obra = :codigo_obra";
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    const obras = await sequelize.query(sql, { replacements: { codigo_obra: codigo_obra }, type: QueryTypes.SELECT });
    let salida = [];
    if (obras) {
      for (const element of obras) {

            const detalle_salida = {
              id: Number(element.id),
              codigo_obra: String(element.codigo_obra),
              numero_ot: String(element.numero_ot),
              nombre_obra: String(element.nombre_obra),
              zona: element.zona, //json
              delegacion: element.delegacion, //json
              gestor_cliente: String(element.gestor_cliente),
              numero_aviso: Number(element.numero_aviso),
              numero_oc: String(element.numero_oc),
              monto: Number(element.monto),
              cantidad_uc: Number(element.cantidad_uc),
              fecha_llegada: String(element.fecha_llegada),
              fecha_inicio: String(element.fecha_inicio),
              fecha_termino: String(element.fecha_termino),
              tipo_trabajo: element.tipo_trabajo, //json
              persona_envia_info: String(element.persona_envia_info),
              cargo_persona_envia_info: String(element.cargo_persona_envia_info),
              empresa_contratista: element.empresa_contratista, //json
              coordinador_contratista: element.coordinador_contratista, //json
              comuna: element.comuna, //json
              ubicacion: String(element.ubicacion),
              estado: element.estado, //json
              tipo_obra: element.tipo_obra, //json
              segmento: element.segmento, //json
              eliminada: Boolean(element.eliminada) ? true : false
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
  /*********************************************************************************** */

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

  const campos = [
    'id_obra', 'reserva', 'materiales'
  ];
  for (const element of campos) {
    if (!req.body[element]) {
      res.status(400).send({
        message: "No puede estar nulo el campo " + element
      });
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
        console.log(element)
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
          }else {
            res.status(500).send("Error en la consulta (servidor backend)");
          }
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
                      }else{
                        res.status(500).send("Error en la consulta (servidor backend)");
                      }
                    } else {
                      res.status(500).send("Consulta vacía (error servidor backend)");
                    }
      }else{
        res.status(500).send("Error en la consulta (servidor backend)");
      } 
      }
    }else{
          res.status(500).send("Error en la consulta (servidor backend)");
    } 
    }else{
          res.status(500).send("Error en la consulta (servidor backend)");
      }
    
  }catch (error) {
    res.status(500).send(error);
  }   
}
/***********************************************************************************/
/* Crea un nuevo bom de forma masiva
;
*/
exports.createBomIndividual = async (req, res) => {
  const campos = [
    'id_obra', 'reserva', 'codigo_sap_material', 'cantidad_requerida'
  ];
  for (const element of campos) {
    if (!req.body[element]) {
      res.status(400).send({
        message: "No puede estar nulo el campo " + element
      });
      return;
    }
  };
  
}
/***********************************************************************************/
/* Elimina bom por reserva
;
*/
exports.deleteBomByReserva = async (req, res) => {

  const reserva = req.params.reserva;
  Bom.destroy({
    where: { reserva: reserva }
  }).then(data => {
    if (data[0] === 1) {
      res.send({ message: "Reserva eliminada del Bom" });
    } else {
      res.send({ message: `No existe la reserva ${reserva}` });
    }
  }).catch(err => {
    res.status(500).send({ message: err.message });
  })

}
/***********************************************************************************/
/* Elimina material del bom, por cod_sap de material y numero de reserva
;
*/
exports.deleteBomByMaterial = async (req, res) => {
  const reserva = req.params.reserva;
  const cod_sap = req.params.cod_sap;
  if (!cod_sap || !reserva){
    res.status(400).send({message: "Debe especificar el código de material y la reserva a borrar"});
  } else {
      Bom.destroy({
        where: { reserva: reserva, codigo_sap_material: cod_sap }
      }).then(data => {
        if (data[0] === 1) {
          res.send({ message: "Material eliminado del Bom" });
        } else {
          res.send({ message: `No existe el codigo material ${cod_sap} para la reserva ${reserva}` });
        }
      }).catch(err => {
        res.status(500).send({ message: err.message });
      })
  }
}