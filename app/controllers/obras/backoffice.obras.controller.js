const db = require("../../models");
const Obra = db.obra;
const ObrasHistorialCambios = db.obrasHistorialCambios;
const ObrasCierres = db.obrasCierres;
const ObrasParalizacion = db.obrasParalizacion;
const logMovimiento = db.logMovimiento;
const accion = require("../../data/accion.data");
const modulo = "OBRAS";
const { v4: uuidv4 } = require('uuid');

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
    /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Devuelve todas las obras de la tabla de obras' */
    try {
      const vista = req.query.vista;
      let where = " and 111 = ANY (vistas)";
      if (vista) {
        where = " and " + vista + " = ANY (vistas)";
      }

      const sql = `SELECT o.id,
                  o.codigo_obra,
                  o.numero_ot,
                  o.nombre_obra,
                  row_to_json(z.*) AS zona,
                  row_to_json(d.*) AS delegacion,
                  o.gestor_cliente,
                  o.numero_aviso,
                  o.numero_oc,
                  o.monto,
                  o.cantidad_uc,
                  o.fecha_llegada::text AS fecha_llegada,
                  o.fecha_inicio::text AS fecha_inicio,
                  o.fecha_termino::text AS fecha_termino,
                  row_to_json(tt.*) AS tipo_trabajo,
                  o.persona_envia_info,
                  o.cargo_persona_envia_info,
                  row_to_json(ec.*) AS empresa_contratista,
                  row_to_json(cc.*) AS coordinador_contratista,
                  row_to_json(c.*) AS comuna,
                  o.ubicacion,
                  row_to_json(eo.*) AS estado,
                  row_to_json(tob.*) AS tipo_obra,
                  row_to_json(s.*) AS segmento,
                  o.eliminada,
                      CASE
                          WHEN erd.cuenta IS NULL THEN 0::bigint
                          ELSE erd.cuenta
                      END AS cantidad_reportes,
                      CASE
                          WHEN erd.pendiente IS NULL THEN 0::bigint
                          ELSE erd.pendiente
                      END AS reportes_pendientes,
                  o.jefe_delegacion,
                      CASE
                          WHEN cep.cuenta IS NULL THEN 0::bigint
                          ELSE cep.cuenta
                      END AS cantidad_estados_pago,
                  CASE
                          WHEN cep.cuenta IS NULL THEN null
                          ELSE cep.cod_estados
                      END AS codigo_estados,
                      CASE
                          WHEN cep.cuenta IS NULL THEN null
                          ELSE cep.codigos_pelom
                      END AS codigos_pelom,
                  row_to_json(ofi.*) AS oficina,
                  row_to_json(rec.*) AS recargo_distancia,
                  ohc.fecha_hora::text AS fecha_estado,
                  row_to_json(op.*) AS obra_paralizada,
                  row_to_json(oc.*) AS obras_cierres,
                  evm.vistas,
                  cep.hay_dato AS hay_ep,
                  erd.hay_dato AS hay_rd,
                  vt.hay_dato_vt AS hay_vt
                FROM obras.obras o
                  LEFT JOIN ( SELECT DISTINCT ON (obras_historial_cambios.id_obra) obras_historial_cambios.id_obra,
                          obras_historial_cambios.fecha_hora
                        FROM obras.obras_historial_cambios
                        ORDER BY obras_historial_cambios.id_obra, obras_historial_cambios.fecha_hora DESC) ohc ON o.id = ohc.id_obra
                  LEFT JOIN ( SELECT DISTINCT ON (obras_paralizacion.id_obra) obras_paralizacion.id_obra,
                          obras_paralizacion.fecha_hora::text AS fecha_hora,
                          obras_paralizacion.responsable,
                          obras_paralizacion.motivo,
                          obras_paralizacion.observacion
                        FROM obras.obras_paralizacion
                        ORDER BY obras_paralizacion.id_obra, (obras_paralizacion.fecha_hora::text) DESC) op ON o.id = op.id_obra
                  LEFT JOIN ( SELECT DISTINCT ON (obras_cierres.id_obra) obras_cierres.id_obra,
                          obras_cierres.fecha_hora::text AS fecha_hora,
                          obras_cierres.supervisor_responsable,
                          obras_cierres.coordinador_responsable,
                          obras_cierres.ito_mandante,
                          obras_cierres.observacion
                        FROM obras.obras_cierres
                        ORDER BY obras_cierres.id_obra, (obras_cierres.fecha_hora::text) DESC) oc ON o.id = oc.id_obra
                  LEFT JOIN _comun.zonal z ON o.zona = z.id
                  LEFT JOIN obras.delegaciones d ON o.delegacion = d.id
                  LEFT JOIN obras.tipo_trabajo tt ON o.tipo_trabajo = tt.id
                  LEFT JOIN obras.empresas_contratista ec ON o.empresa_contratista = ec.id
                  LEFT JOIN obras.coordinadores_contratista cc ON o.coordinador_contratista = cc.id
                  LEFT JOIN _comun.comunas c ON o.comuna::text = c.codigo::text
                  LEFT JOIN obras.estado_obra eo ON o.estado = eo.id
                  LEFT JOIN obras.tipo_obra tob ON o.tipo_obra = tob.id
                  LEFT JOIN obras.segmento s ON o.segmento = s.id
                  LEFT JOIN ( SELECT encabezado_reporte_diario.id_obra,
                          count(encabezado_reporte_diario.id) AS cuenta,
                          sum(
                              CASE
                                  WHEN encabezado_reporte_diario.id_estado_pago IS NULL THEN 1
                                  ELSE 0
                              END) AS pendiente,
                              CASE
                                  WHEN count(encabezado_reporte_diario.id) > 0 THEN true
                                  ELSE false
                              END AS hay_dato
                        FROM obras.encabezado_reporte_diario
                        GROUP BY encabezado_reporte_diario.id_obra) erd ON o.id = erd.id_obra
                  LEFT JOIN ( SELECT encabezado_estado_pago.id_obra,
                          count(encabezado_estado_pago.id) AS cuenta,
                              CASE
                                  WHEN count(encabezado_estado_pago.id) > 0 THEN true
                                  ELSE false
                              END AS hay_dato, array_agg(json_build_object('id', id, 'codigo_pelom', codigo_pelom)) as cod_estados,
                              array_agg(codigo_pelom) as codigos_pelom
                        FROM obras.encabezado_estado_pago
                        GROUP BY encabezado_estado_pago.id_obra) cep ON o.id = cep.id_obra
                  LEFT JOIN ( SELECT visitas_terreno.id_obra,
                              CASE
                                  WHEN count(visitas_terreno.id_obra) > 0 THEN true
                                  ELSE false
                              END AS hay_dato_vt
                        FROM obras.visitas_terreno
                        GROUP BY visitas_terreno.id_obra) vt ON o.id = vt.id_obra
                  LEFT JOIN ( SELECT os.id,
                          o_1.nombre AS oficina,
                          so.nombre AS supervisor
                        FROM obras.oficina_supervisor os
                          JOIN _comun.oficinas o_1 ON os.oficina = o_1.id
                          JOIN obras.supervisores_contratista so ON os.supervisor = so.id) ofi ON o.oficina = ofi.id
                  JOIN ( SELECT vista_estado_muestra.estado_obra_id,
                          vista_estado_muestra.requiere_rep_dia,
                          vista_estado_muestra.requiere_est_pago,
                          array_agg(vista_estado_muestra.vista) AS vistas
                        FROM obras.vista_estado_muestra
                        GROUP BY vista_estado_muestra.estado_obra_id, vista_estado_muestra.requiere_rep_dia, vista_estado_muestra.requiere_est_pago) evm ON o.estado = evm.estado_obra_id
                  LEFT JOIN ( SELECT recargos.id,
                          recargos.nombre,
                          recargos.porcentaje
                        FROM obras.recargos
                        WHERE recargos.id_tipo_recargo = 2) rec ON o.recargo_distancia = rec.id
                WHERE
                      CASE
                          WHEN evm.requiere_rep_dia THEN
                          CASE
                              WHEN erd.hay_dato THEN true
                              ELSE false
                          END
                          ELSE true
                      END AND
                      CASE
                          WHEN evm.requiere_est_pago THEN
                          CASE
                              WHEN cep.hay_dato THEN true
                              ELSE false
                          END
                          ELSE true
                      END AND NOT o.eliminada ${where}
                ORDER BY o.id DESC;`;

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
                eliminada: element.eliminada,
                cantidad_reportes: Number(element.cantidad_reportes),
                reportes_pendientes: Number(element.reportes_pendientes),
                jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
                cantidad_estados_pago: Number(element.cantidad_estados_pago),
                codigo_estados: element.codigo_estados?element.codigo_estados:null,
                codigos_pelom: element.codigos_pelom?element.codigos_pelom:null,
                oficina: element.oficina, //json
                recargo_distancia: element.recargo_distancia, //json
                fecha_estado: String(element.fecha_estado),
                obra_paralizada: element.obra_paralizada?element.obra_paralizada:null,
                obras_cierres: element.obras_cierres?element.obras_cierres:null,
                hay_vt: element.hay_vt?element.hay_vt:null
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
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Crea una nueva obra' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos básicos de una obra',
            required: true,
            schema: {
              codigo_obra: "CGED-123456",
                nombre_obra: "nombre de la obra",
                numero_ot: "123456",
                zona: 1,
                delegacion: 1,
                gestor_cliente: "nombre gestor cliente (cge)",
                numero_aviso: 123456,
                numero_oc: "123456",
                monto: 1000,
                cantidad_uc: 100,
                fecha_llegada: "2023-10-25",
                fecha_inicio: "2023-10-25",
                fecha_termino: "2023-10-25",
                tipo_trabajo: 1,
                persona_envia_info: "nombre persona envia info",
                cargo_persona_envia_info: "cargo persona envia info",
                empresa_contratista: 1,
                coordinador_contratista: 1,
                comuna: "07201",
                ubicacion: "dirección donde se trabajará en la obra",
                tipo_obra: 1,
                segmento: 1,
                jefe_delegacion: "nombre jefe delegacion",
                oficina: {'id':1,'oficina':'Curicó','supervisor':'Eduardo Soto'},
                recargo_distancia: {'id':7,'nombre':'Menos de 30km','porcentaje':0}
            }
        }
      */
  try {

      let salir = false;
      const campos = [
        'codigo_obra', 'nombre_obra'
      ];
      for (const element of campos) {
        if (!req.body[element]) {
          res.status(400).send( "No puede estar nulo el campo " + element
          );
          return;
        }
      };

      //Verificar el formato del Codigo de Obra
      /*
      if (!/^[a-zA-Z0-9-]+$/.test(req.body.codigo_obra)) {
        res.status(400).send('El Codigo de Obra solo puede contener letras y numeros' );
        return;
      }
      */
      if (!/^CGED-\d+$/.test(req.body.codigo_obra) && !/^E-\d{10}$/.test(req.body.codigo_obra)) {
        
        res.status(400).send('El Codigo de Obra tiene un formato incorrecto: debe ser CGED-XXXXXXX o E-XXXXXXXX');
        return;
      }

    
      //Verifica que el codigo obra no se encuentre
      await Obra.findAll({where: {codigo_obra: req.body.codigo_obra}}).then(data => {
        //el rut ya existe
        if (data.length > 0) {
          salir = true;
          res.status(400).send('El Codigo de Obra ya se encuentra ingresado en la base' );
        }
      }).catch(err => {
          salir = true;
          res.status(500).send( err.message );
      })
    
      if (salir) {
        return;
      }
      // Busca el ID de encabezado disponible
      let sql = "select nextval('obras.obras_id_seq'::regclass) as valor";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      let id_obra = 0;
      await sequelize.query(sql, {
        type: QueryTypes.SELECT
      }).then(data => {
        id_obra = data[0].valor;
      }).catch(err => {
        res.status(500).send(err.message );
        return;
      })

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

      const obra = {
          id: id_obra,
          codigo_obra: req.body.codigo_obra,
          nombre_obra: req.body.nombre_obra,
          numero_ot: 0,
          zona: req.body.zona,
          delegacion: req.body.delegacion,
          gestor_cliente: req.body.gestor_cliente,
          numero_aviso: req.body.numero_aviso,
          numero_oc: req.body.numero_oc,
          monto: 0,
          cantidad_uc: req.body.cantidad_uc,
          fecha_llegada: req.body.fecha_llegada,
          fecha_inicio: req.body.fecha_inicio,
          fecha_termino: req.body.fecha_termino,
          tipo_trabajo: req.body.tipo_trabajo,
          persona_envia_info: "",
          cargo_persona_envia_info: "",
          empresa_contratista: req.body.empresa_contratista,
          coordinador_contratista: req.body.coordinador_contratista,
          comuna: req.body.comuna,
          ubicacion: req.body.ubicacion,
          estado: 1,
          tipo_obra: req.body.tipo_obra,
          segmento: req.body.segmento,
          eliminada: false,
          jefe_delegacion: req.body.jefe_delegacion,
          oficina: req.body.oficina?req.body.oficina.id:null,
          recargo_distancia: req.body.recargo_distancia?req.body.recargo_distancia.id:null

      }
      const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
      const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

      const obra_historial = {
        id_obra: id_obra,
        fecha_hora: fechahoy,
        usuario_rut: user_name,
        estado_obra: 1,
        datos: obra
      }

        let salida = {};
        const t = await sequelize.transaction();

        try {


          salida = {"error": false, "message": "obra ingresada"};
          const obra_creada = await Obra.create(obra, { transaction: t });

          const obra_historial_creado = await ObrasHistorialCambios.create(obra_historial, { transaction: t });

          const creaLogMovimiento = await logMovimiento.create({
            usuario_rut: user_name, 
            fecha_hora: fechahoy,
            modulo: modulo, 
            accion: accion.crear,
            comentario: 'Obra creada ' + req.body.codigo_obra,
            datos: obra }, { transaction: t });

          await t.commit();

        } catch (error) {
          salida = { error: true, message: error }
          await t.rollback();
        }


      if (salida.error) {
        console.log('Error Result ---> ', salida.message);
        res.status(500).send(salida.message.parent.detail);
      }else {
        res.status(200).send(salida);
      }
      
    }catch (error) {
      console.log('Error General ---> ', error);
      res.status(500).send(error);
    }
  }
  /*********************************************************************************** */


/*********************************************************************************** */
/* Actualiza una obra
;
*/
exports.updateObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Actualiza una obra' 
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos básicos de una obra',
            required: false,
            schema: {
              codigo_obra: "CGE-123456",
                nombre_obra: "nombre de la obra",
                numero_ot: "123456",
                zona: 1,
                delegacion: 1,
                gestor_cliente: "nombre gestor cliente (cge)",
                numero_aviso: 123456,
                numero_oc: "123456",
                monto: 1000,
                cantidad_uc: 100,
                fecha_llegada: "2023-10-25",
                fecha_inicio: "2023-10-25",
                fecha_termino: "2023-10-25",
                tipo_trabajo: 1,
                persona_envia_info: "nombre persona envia info",
                cargo_persona_envia_info: "cargo persona envia info",
                empresa_contratista: 1,
                coordinador_contratista: 1,
                comuna: "07234",
                ubicacion: "dirección donde se trabajará en la obra",
                tipo_obra: 1,
                segmento: 1,
                jefe_delegacion: "nombre jefe delegacion",
                oficina: {'id':1,'oficina':'Curicó','supervisor':'Eduardo Soto'},
                recargo_distancia: {'id':7,'nombre':'Menos de 30km','porcentaje':0}
            }
        }
      */
  
  try{
    const id = req.params.id;
    let id_usuario = req.userId;
    let user_name;

      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      let sql = "select username from _auth.users where id = " + id_usuario;
      await sequelize.query(sql, {
        type: QueryTypes.SELECT
      }).then(data => {
        user_name = data[0].username;
      }).catch(err => {
        res.status(500).send(err.message );
        return;
      })

      let ultimo_estado;
      sql = "select max(a.estado_obra) as estado_obra from (SELECT estado_obra FROM obras.obras_historial_cambios WHERE id_obra = " + id + " order by fecha_hora desc limit 1) as a;"
      await sequelize.query(sql, {
        type: QueryTypes.SELECT
      }).then(data => {
        ultimo_estado = data[0].estado_obra;
      }).catch(err => {
        res.status(500).send(err.message );
        return;
      })
      if (!ultimo_estado) {
        ultimo_estado = 1;
      }

    const obra = {

      codigo_obra: req.body.codigo_obra?req.body.codigo_obra:undefined,
      nombre_obra: req.body.nombre_obra?req.body.nombre_obra:undefined,
      numero_ot: req.body.numero_ot?req.body.numero_ot:undefined,
      zona: req.body.zona?req.body.zona:undefined,
      delegacion: req.body.delegacion?req.body.delegacion:undefined,
      gestor_cliente: req.body.gestor_cliente?req.body.gestor_cliente:undefined,
      numero_aviso: req.body.numero_aviso?req.body.numero_aviso:undefined,
      numero_oc: req.body.numero_oc?req.body.numero_oc:undefined,
      monto: req.body.monto?req.body.monto:undefined,
      cantidad_uc: req.body.cantidad_uc?req.body.cantidad_uc:undefined,
      fecha_llegada: req.body.fecha_llegada?req.body.fecha_llegada:undefined,
      fecha_inicio: req.body.fecha_inicio?req.body.fecha_inicio:undefined,
      fecha_termino: req.body.fecha_termino?req.body.fecha_termino:undefined,
      tipo_trabajo: req.body.tipo_trabajo?req.body.tipo_trabajo:undefined,
      persona_envia_info: req.body.persona_envia_info?req.body.persona_envia_info:undefined,
      cargo_persona_envia_info: req.body.cargo_persona_envia_info?req.body.cargo_persona_envia_info:undefined,
      empresa_contratista: req.body.empresa_contratista?req.body.empresa_contratista:undefined,
      coordinador_contratista: req.body.coordinador_contratista?req.body.coordinador_contratista:undefined,
      comuna: req.body.comuna?req.body.comuna:undefined,
      ubicacion: req.body.ubicacion?req.body.ubicacion:undefined,
      estado: undefined,
      tipo_obra: req.body.tipo_obra?req.body.tipo_obra:undefined,
      segmento: req.body.segmento?req.body.segmento:undefined,
      jefe_delegacion: req.body.jefe_delegacion?req.body.jefe_delegacion:undefined,
      oficina: req.body.oficina?req.body.oficina.id:undefined,
      recargo_distancia: req.body.recargo_distancia?req.body.recargo_distancia.id:undefined

  }
        const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
        const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);
        const obra_historial = {
          id_obra: id,
          fecha_hora: fechahoy,
          usuario_rut: user_name,
          estado_obra: ultimo_estado,
          datos: obra
        }

        let salida = {};
        const t = await sequelize.transaction();

        try {


          salida = {"error": false, "message": "obra actualizda"};
          const obra_creada = await Obra.update(obra, { where: { id: id }, transaction: t });

          const obra_historial_creado = await ObrasHistorialCambios.create(obra_historial, { transaction: t });

          const creaLogMovimiento = await logMovimiento.create({
            usuario_rut: user_name, 
            fecha_hora: fechahoy,
            modulo: modulo, 
            accion: accion.actualizar,
            comentario: 'Obra actualizada con id: ' + id,
            datos: obra }, { transaction: t });

          await t.commit();

        } catch (error) {
          salida = { error: true, message: error }
          await t.rollback();
        }
        if (salida.error) {
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }

  }catch (error) {
    res.status(500).send(error);
  }
}
  /*********************************************************************************** */


/*********************************************************************************** */
/* Eliminar una obra
;
*/
exports.deleteObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Borra una obra, pasando el campo eliminado a true' */
  try{
    const id = req.params.id;
    const borrar = {"eliminada": true, "estado": 8};

    let id_usuario = req.userId;
    let user_name;
    let datos_obra;

    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;
    let sql = "select username from _auth.users where id = " + id_usuario;
    await sequelize.query(sql, {
      type: QueryTypes.SELECT
    }).then(data => {
      user_name = data[0].username;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

    const campos = [
      {
        tabla: 'obras.visitas_terreno',
        mensaje: 'No se puede borrar la obra porque tiene visitas terreno asociadas',
      },
      {
        tabla: 'obras.mat_solicitudes_obras',
        mensaje: 'No se puede borrar la obra porque tiene solicitud de materiales asociada',
      },
      {
        tabla: 'obras.encabezado_reporte_diario',
        mensaje: 'No se puede borrar la obra porque tiene un reporte diario asociado',
      },
      {
        tabla: 'obras.obras_paralizacion',
        mensaje: 'No se puede borrar la obra porque tiene obras paralizadas asociada',
      },
      {
        tabla: 'obras.bom',
        mensaje: 'No se puede borrar la obra porque tiene un bom asociado',
      },
      {
        tabla: 'obras.mat_bom_reservas',
        mensaje: 'No se puede borrar la obra porque tiene una reserva de materiales asociada',
      },
      {
        tabla: 'obras.mat_faena_encabezado',
        mensaje: 'No se puede borrar la obra porque tiene materiales en faena asociada',
      },
      {
        tabla: 'obras.obras_cierres',
        mensaje: 'No se puede borrar la obra porque tiene cierres de obra asociado',
      },
      {
        tabla: 'obras.reservas_obras',
        mensaje: 'No se puede borrar la obra porque tiene una reserva de materiales asociada',
      },
    ];


    let mensaje;
    for (const element of campos) {
      let sql = `SELECT id FROM ${element.tabla} WHERE id_obra = ${id}`;
      await sequelize.query(sql, {
        type: QueryTypes.SELECT
      }).then(data => {
        if (data.length > 0) {
          mensaje = element.mensaje;
        }
      }).catch(err => {
        mensaje = err.message;
      })
      if (mensaje) {
        break;
      }
    }
    if (mensaje) {
      res.status(500).send(mensaje);
      return;
    }

    sql_obra = `select row_to_json(o) as datos_obra from obras.obras o WHERE id = ${id}`;
    await sequelize.query(sql_obra, {
      type: QueryTypes.SELECT
    }).then(data => {
      datos_obra = data[0].datos_obra;
    }).catch(err => {
      res.status(500).send(err.message );
      return;
    })

    const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
    const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);
    const obra_historial = {
      id_obra: id,
      fecha_hora: fechahoy,
      usuario_rut: user_name,
      estado_obra: 8,     // 8 es eliminada
      datos: datos_obra
    }

    let salida = {};
    const t = await sequelize.transaction();

    try {


      salida = {"error": false, "message": "obra eliminada"};
      

      const obra_historial_creado = await ObrasHistorialCambios.create(obra_historial, { transaction: t });

      const creaLogMovimiento = await logMovimiento.create({
        usuario_rut: user_name, 
        fecha_hora: fechahoy,
        modulo: modulo, 
        accion: accion.borrar,
        comentario: 'Obra borrada con id: ' + id,
        datos: datos_obra }, { transaction: t });

        //const obra_creada = await Obra.update(borrar, { where: { id: id }, transaction: t });
        await Obra.destroy({ where: { id: id }, transaction: t });

      await t.commit();

    } catch (error) {
      console.log('error en deleteObra: ', error);
      salida = { error: true, message: error }
      await t.rollback();
    }
    if (salida.error) {
      res.status(500).send(salida.message.parent.detail);
    }else {
      res.status(200).send(salida);
    }
  }catch (error) {
    res.status(500).send(error);
  }

}
  /*********************************************************************************** */
/* Paraliza una obra
;
*/
exports.paralizaObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Paraliza una obra, pasando el campo paralizada a true'
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos para paralizar una obra',
            required: false,
            schema: {
                id_obra: 45,
                fecha_hora: "2024-01-05 15:30:00",
                motivo: "Motivo de la paralización (descripción corta)",
                observacion: "Observaciones detalladas de la paralización"
            }
        } */
      try{

        const campos = [
          'id_obra', 'fecha_hora', 'motivo', 'observacion'
        ];
        for (const element of campos) {
          if (!req.body[element]) {
            res.status(400).send( "No puede estar nulo el campo " + element
            );
            return;
          }
        };

        const id_obra = req.body.id_obra;
        const estado_obra = 6;    //Paralizada

        

        // obra paralizada = 6
        const obra_cambio = {"estado": estado_obra};
    
        let id_usuario = req.userId;
        let user_name;
        let responsable;
    
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let sql = "select u.username::text, (u.username || ' ' || p.apellido_1 || ' ' || p.nombres) as responsable \
        from _auth.users u join _auth.personas p on u.username = p.rut  where u.id = " + id_usuario;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          user_name = data[0].username;
          responsable = data[0].responsable;
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })
    
        const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
        const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

        const obra_historial = {
          id_obra: id_obra,
          fecha_hora: fechahoy,
          usuario_rut: user_name,
          estado_obra: estado_obra,
          datos: obra_cambio
        }
        const obra_paralizada = {
          id_obra: id_obra, 
          fecha_hora: req.body.fecha_hora,
          responsable: responsable, 
          motivo: req.body.motivo, 
          observacion: req.body.observacion,
          usuario_rut: user_name
        };
    
        let salida = {};
        const t = await sequelize.transaction();
    
        try {
    
    
          salida = {"error": false, "message": "obra paralizada ok"};

          const obra_paralizada_ingresada = await ObrasParalizacion.create(obra_paralizada, { transaction: t });

          const obra_creada = await Obra.update(obra_cambio, { where: { id: id_obra }, transaction: t });
    
          const obra_historial_creado = await ObrasHistorialCambios.create(obra_historial, { transaction: t });

          const creaLogMovimiento = await logMovimiento.create({
            usuario_rut: user_name, 
            fecha_hora: fechahoy,
            modulo: modulo, 
            accion: accion.actualizar,
            comentario: 'Obra paralizada con id: ' + id_obra,
            datos: obra_paralizada }, { transaction: t });
    
          await t.commit();
    
        } catch (error) {
          console.log('error paraliza obra', error)
          salida = { error: true, message: error }
          await t.rollback();
        }
        if (salida.error) {
          console.log('error paraliza obra', error)
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }
    
      }catch (error) {
        console.log('error paraliza obra', error)
        res.status(500).send(error);
      }

}
/*********************************************************************************** */
/* Cierre de una obra
;
*/
exports.cierreObra = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Cierre de una obra'
      #swagger.parameters['body'] = {
            in: 'body',
            description: 'Datos para cerrar una obra',
            required: false,
            schema: {
                id_obra: 45,
                fecha_hora: "2024-01-05 15:30:00",
                supervisor_responsable: "Juan Perez",
                coordinador_responsable: "Juan Perez",
                ito_mandante: "Juan Perez",
                observacion: "Observaciones detalladas del cierre de obra"
            }
        }*/

      try{

        const campos = [
          'id_obra', 'fecha_hora', 'supervisor_responsable', 'coordinador_responsable', 'ito_mandante', 'observacion'
        ];
        for (const element of campos) {
          if (!req.body[element]) {
            res.status(400).send( "No puede estar nulo el campo " + element
            );
            return;
          }
        };

        const id_obra = req.body.id_obra;
        const estado_cierre = 7;

        

        // obra cerrada 
        const obra_cambio = {"estado": estado_cierre};
    
        let id_usuario = req.userId;
        let user_name;
    
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        let sql = "select username from _auth.users where id = " + id_usuario;
        await sequelize.query(sql, {
          type: QueryTypes.SELECT
        }).then(data => {
          user_name = data[0].username;
        }).catch(err => {
          res.status(500).send(err.message );
          return;
        })
    
        const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
        const fechahoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2) + ' ' + c.substring(12);

        const obra_historial = {
          id_obra: id_obra,
          fecha_hora: fechahoy,
          usuario_rut: user_name,
          estado_obra: estado_cierre,
          datos: obra_cambio
        }
        const obra_finalizada = {
          id_obra: id_obra, 
          fecha_hora: req.body.fecha_hora,
          supervisor_responsable: req.body.supervisor_responsable,
          coordinador_responsable: req.body.coordinador_responsable,
          ito_mandante: req.body.ito_mandante,
          observacion: req.body.observacion,
          usuario_rut: user_name
        };
    
        let salida = {};
        const t = await sequelize.transaction();
    
        try {
    
    
          salida = {"error": false, "message": "obra finalizada ok"};

          const obra_cerrada = await ObrasCierres.create(obra_finalizada, { transaction: t });

          const obra_creada = await Obra.update(obra_cambio, { where: { id: id_obra }, transaction: t });
    
          const obra_historial_creado = await ObrasHistorialCambios.create(obra_historial, { transaction: t });

          const creaLogMovimiento = await logMovimiento.create({
            usuario_rut: user_name, 
            fecha_hora: fechahoy,
            modulo: modulo, 
            accion: accion.actualizar,
            comentario: 'Obra cerrada con id: ' + id_obra,
            datos: obra_finalizada }, { transaction: t });
    
          await t.commit();
    
        } catch (error) {
          //console.log('error finaliza obra', error)
          salida = { error: true, message: error }
          await t.rollback();
        }
        if (salida.error) {
          res.status(500).send(salida.message);
        }else {
          res.status(200).send(salida);
        }
    
      }catch (error) {
        res.status(500).send(error);
      }

}

/*********************************************************************************** */
/* Encuentra una obra por id
;
*/
exports.findObraById = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Devuelve una obra por ID' */
  const id = req.params.id;

  try {
   
    const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, \
    o.gestor_cliente, numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, \
    fecha_termino::text, row_to_json(tt) as tipo_trabajo, persona_envia_info, cargo_persona_envia_info, \
    row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, row_to_json(c) as comuna, \
    ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada, \
    case when erd.cuenta is null then 0 else erd.cuenta end as cantidad_reportes, case when erd.pendiente \
    is null then 0 else erd.pendiente end as reportes_pendientes, o.jefe_delegacion, (select count(id) as \
    cantidad_estados_pago FROM obras.encabezado_estado_pago WHERE id_obra = 6) as cantidad_estados_pago, \
    row_to_json(ofi) as oficina, row_to_json(rec) as recargo_distancia, ohc.fecha_hora::text as fecha_estado, row_to_json(op) as \
    obra_paralizada, row_to_json(oc) as obras_cierres FROM obras.obras o left join (select distinct on (id_obra) id_obra, fecha_hora from \
    obras.obras_historial_cambios order by id_obra, fecha_hora desc) ohc on o.id = ohc.id_obra left join \
    (SELECT distinct on (id_obra) id_obra, fecha_hora::text, responsable, motivo, observacion FROM obras.obras_paralizacion \
    order by id_obra, fecha_hora desc) as op on o.id = op.id_obra left join (SELECT distinct on (id_obra) id_obra, fecha_hora::text, \
    supervisor_responsable, coordinador_responsable, ito_mandante, observacion FROM obras.obras_cierres order by id_obra, \
    fecha_hora desc) as oc on o.id = oc.id_obra left join _comun.zonal z on o.zona = z.id left join \
    obras.delegaciones d on o.delegacion = d.id left join obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join \
    obras.empresas_contratista ec on o.empresa_contratista = ec.id left join obras.coordinadores_contratista cc on \
    o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo left join obras.estado_obra eo on \
    o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento s on o.segmento = s.id \
    left join (select id_obra, count(id) as cuenta, sum(case when id_estado_pago is null then 1 else 0 end) as pendiente from obras.encabezado_reporte_diario group by id_obra) as erd on \
    o.id = erd.id_obra left join (SELECT os.id, o.nombre as oficina, so.nombre as supervisor	FROM obras.oficina_supervisor \
      os join _comun.oficinas o on os.oficina = o.id join obras.supervisores_contratista so on os.supervisor = so.id) ofi \
      on o.oficina = ofi.id left join (SELECT id, nombre, porcentaje FROM obras.recargos where id_tipo_recargo = 2) \
      rec on o.recargo_distancia = rec.id WHERE o.id = :id";
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
              eliminada: element.eliminada,
              cantidad_reportes: Number(element.cantidad_reportes),
              reportes_pendientes: Number(element.reportes_pendientes),
              jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
              cantidad_estados_pago: Number(element.cantidad_estados_pago),
              oficina: element.oficina, //json
              recargo_distancia: element.recargo_distancia, //json
              fecha_estado: String(element.fecha_estado),
              obra_paralizada: element.obra_paralizada?element.obra_paralizada:null,
              obras_cierres: element.obras_cierres?element.obras_cierres:null
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
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Devuelve una obra por código de obra' */
  const codigo_obra = req.query.codigo_obra;

  try {
   
        const sql = "SELECT o.id, codigo_obra, numero_ot, nombre_obra, row_to_json(z) as zona, row_to_json(d) as delegacion, \
        o.gestor_cliente, numero_aviso, numero_oc, monto, cantidad_uc, fecha_llegada::text, fecha_inicio::text, \
        fecha_termino::text, row_to_json(tt) as tipo_trabajo, persona_envia_info, cargo_persona_envia_info, \
        row_to_json(ec) as empresa_contratista, row_to_json(cc) as coordinador_contratista, row_to_json(c) as comuna, \
        ubicacion, row_to_json(eo) as estado, row_to_json(tob) as tipo_obra, row_to_json(s) as segmento, eliminada, \
        case when erd.cuenta is null then 0 else erd.cuenta end as cantidad_reportes, case when erd.pendiente \
        is null then 0 else erd.pendiente end as reportes_pendientes, o.jefe_delegacion, (select count(id) as \
        cantidad_estados_pago FROM obras.encabezado_estado_pago WHERE id_obra = 6) as cantidad_estados_pago, \
        row_to_json(ofi) as oficina, row_to_json(rec) as recargo_distancia, ohc.fecha_hora::text as fecha_estado, row_to_json(op) as \
        obra_paralizada, row_to_json(oc) as obras_cierres FROM obras.obras o left join (select distinct on (id_obra) id_obra, fecha_hora from \
        obras.obras_historial_cambios order by id_obra, fecha_hora desc) ohc on o.id = ohc.id_obra left join \
        (SELECT distinct on (id_obra) id_obra, fecha_hora::text, responsable, motivo, observacion FROM obras.obras_paralizacion \
        order by id_obra, fecha_hora desc) as op on o.id = op.id_obra left join (SELECT distinct on (id_obra) id_obra, fecha_hora::text, \
        supervisor_responsable, coordinador_responsable, ito_mandante, observacion FROM obras.obras_cierres order by id_obra, \
        fecha_hora desc) as oc on o.id = oc.id_obra left join _comun.zonal z on o.zona = z.id left join \
        obras.delegaciones d on o.delegacion = d.id left join obras.tipo_trabajo tt on o.tipo_trabajo = tt.id left join \
        obras.empresas_contratista ec on o.empresa_contratista = ec.id left join obras.coordinadores_contratista cc on \
        o.coordinador_contratista = cc.id left join _comun.comunas c on o.comuna = c.codigo left join obras.estado_obra eo on \
        o.estado = eo.id left join obras.tipo_obra tob on o.tipo_obra = tob.id left join obras.segmento s on o.segmento = s.id \
        left join (select id_obra, count(id) as cuenta, sum(case when id_estado_pago is null then 1 else 0 end) as pendiente from obras.encabezado_reporte_diario group by id_obra) as erd on \
        o.id = erd.id_obra left join (SELECT os.id, o.nombre as oficina, so.nombre as supervisor	FROM obras.oficina_supervisor \
          os join _comun.oficinas o on os.oficina = o.id join obras.supervisores_contratista so on os.supervisor = so.id) ofi \
          on o.oficina = ofi.id left join (SELECT id, nombre, porcentaje FROM obras.recargos where id_tipo_recargo = 2) \
          rec on o.recargo_distancia = rec.id WHERE o.codigo_obra = :codigo_obra";
    
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
              eliminada: element.eliminada,
              cantidad_reportes: Number(element.cantidad_reportes),
              reportes_pendientes: Number(element.reportes_pendientes),
              jefe_delegacion: element.jefe_delegacion?String(element.jefe_delegacion):null,
              cantidad_estados_pago: Number(element.cantidad_estados_pago),
              oficina: element.oficina, //json
              recargo_distancia: element.recargo_distancia, //json
              fecha_estado: String(element.fecha_estado),
              obra_paralizada: element.obra_paralizada?element.obra_paralizada:null,
              obras_cierres: element.obras_cierres?element.obras_cierres:null
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
/* Obtiene el código de obra en caso de que sea de tipo emergencia
    GET /api/obras/backoffice/v1/codigodeobraemergencia
*/
exports.getCodigoObraEmergencia = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Obtiene el código de obra en caso de que sea de tipo emergencia' */
  try {
    //tipo_obra igual 7 es emergencia
      //const sql = "select case when maximo is null then 'E-0000000001'::text else \
      //('E-' || to_char(maximo+1, 'FM0999999999'))::text end as valor from \
      //(select max(id) as maximo from obras.obras WHERE tipo_obra = 7) as a";
      const sql = `select case when maximo is null then 'E-0000000001'::text else 
                    ('E-' || to_char(maximo+1, 'FM0999999999'))::text end as valor from 
                    (select max(cod) as maximo FROM
                    (SELECT substring(codigo_obra,6)::bigint as cod FROM obras.obras 
                    WHERE substring(codigo_obra,1,5) = 'E-000') as a) as b`;

      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const codigoEmergencia = await sequelize.query(sql, { type: QueryTypes.SELECT });
      if (codigoEmergencia) {
        res.status(200).send(codigoEmergencia);
      }else{
        res.status(500).send("Error en la consulta (servidor backend)");
      }
  } catch (error) {
    res.status(500).send(error);
  }
}
/*********************************************************************************** */
/* Obtiene el resumen informartivo de obras
    GET /api/obras/backoffice/v1/resumenobras
*/
exports.getResumenObras = async (req, res) => {
  /*  #swagger.tags = ['Obras - Backoffice - Obras']
      #swagger.description = 'Obtiene el resumen informartivo de obras' */
  try {

    const respuesta = await this.genera_resumen(false);
    if (!respuesta) {
      res.status(500).send("Error en la consulta (servidor backend)");
      return;
    }
    if (respuesta.error) {
      res.status(500).send(respuesta.message);
      return;
    }

    res.status(200).send(respuesta);

  } catch (error) {
    console.log('error en getResumenObras: ', error);
    res.status(500).send(error);
  }
}

exports.genera_resumen = async function genera_resumen(cron=false) {

  try {

    console.log('genera_resumen -> ', cron);
    const { QueryTypes } = require('sequelize');
    const sequelize = db.sequelize;

    let generarLogResumen = false;

    if (cron) {
      const sql_resumen = `SELECT * FROM obras."EsHoraDeResumenObras"`;

        const check_log = await sequelize.query(sql_resumen, { type: QueryTypes.SELECT });
        if (check_log) {
            if (check_log.length > 0){
              if (check_log[0].valor){
                console.log("Ya es momento de generar el resumen");
                generarLogResumen = true;
              } else {
                console.log("No es momento de generar el resumen");
                return;
              }
            }else {
              return {error: true, message: "Error en la consulta (servidor backend)"};
            }
        } else {
          //res.status(500).send("Error en la consulta (servidor backend)");
          return {error: true, message: "Error en la consulta (servidor backend)"};
        }
    }

    const respuesta = {
      resumen_estados: [],
      resumen_tipos_obra: [],
      resumen_zonales: [],
      resumen_maule_norte: [],
      resumen_maule_sur: [],
      resumen_mnorte_tipo_obra: [],
      resumen_msur_tipo_obra: [],
    }


    let sql = `
    SELECT 
    a.id,
    a.estado,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje
    FROM ( SELECT eo.id,
            eo.nombre AS estado,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS total
           FROM obras.estado_obra eo
             LEFT JOIN obras.obras o ON o.estado = eo.id
          GROUP BY eo.id, eo.nombre
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS estado,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS total) a
    ORDER BY a.id;`;
    
    const resumenObrasEstados = await sequelize.query(sql, { type: QueryTypes.SELECT });

    if (resumenObrasEstados) {
      respuesta.resumen_estados = resumenObrasEstados;
    }else{
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }

    sql = `
    SELECT a.tipo_obra,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje,
    a.bg_color AS "bg-color",
    a.txt_color AS "text-color"
   FROM ( SELECT tob.id,
            tob.descripcion AS tipo_obra,
            tob.bg_color,
            tob.txt_color,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS total
           FROM obras.tipo_obra tob
             LEFT JOIN obras.obras o ON o.tipo_obra = tob.id
          GROUP BY tob.id, tob.descripcion, tob.bg_color, tob.txt_color
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS tipo_obra,
            'bg-purple-500'::character varying AS bg_color,
            'text-purple-500'::character varying AS txt_color,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS total) a
      ORDER BY a.id;`;
    const resumenObrasTipoEstados = await sequelize.query(sql, { type: QueryTypes.SELECT });
    if (resumenObrasTipoEstados) {
      respuesta.resumen_tipos_obra = resumenObrasTipoEstados;
    }else{
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }

    sql = `SELECT a.zonal,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje
    FROM ( SELECT c.id,
            c.nombre AS zonal,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS total
           FROM _comun.zonal c
             LEFT JOIN obras.obras o ON o.zona = c.id
          GROUP BY c.id, c.nombre
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS estado,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras) AS total) a
      ORDER BY a.id;`;
    const resumenObrasZonales = await sequelize.query(sql, { type: QueryTypes.SELECT });
    if (resumenObrasZonales) {
      respuesta.resumen_zonales = resumenObrasZonales;
    } else {
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }


    sql = `SELECT a.id,
    a.estado,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje
   FROM ( SELECT eo.id,
            eo.nombre AS estado,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 1) AS total
           FROM obras.estado_obra eo
             LEFT JOIN ( SELECT obras.id,
                    obras.codigo_obra,
                    obras.numero_ot,
                    obras.nombre_obra,
                    obras.zona,
                    obras.delegacion,
                    obras.gestor_cliente,
                    obras.numero_aviso,
                    obras.numero_oc,
                    obras.monto,
                    obras.cantidad_uc,
                    obras.fecha_llegada,
                    obras.fecha_inicio,
                    obras.fecha_termino,
                    obras.tipo_trabajo,
                    obras.persona_envia_info,
                    obras.cargo_persona_envia_info,
                    obras.empresa_contratista,
                    obras.coordinador_contratista,
                    obras.comuna,
                    obras.ubicacion,
                    obras.estado,
                    obras.tipo_obra,
                    obras.segmento,
                    obras.eliminada,
                    obras.jefe_delegacion,
                    obras.oficina,
                    obras.recargo_distancia
                   FROM obras.obras
                  WHERE obras.zona = 1) o ON o.estado = eo.id
          GROUP BY eo.id, eo.nombre
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS estado,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 1) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 1) AS total) a
      ORDER BY a.id;`;
    const resumenMauleNorte = await sequelize.query(sql, { type: QueryTypes.SELECT });
    if (resumenMauleNorte) {
      respuesta.resumen_maule_norte = resumenMauleNorte;
    } else {
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }


    sql = `SELECT a.id,
    a.estado,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje
   FROM ( SELECT eo.id,
            eo.nombre AS estado,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 2) AS total
           FROM obras.estado_obra eo
             LEFT JOIN ( SELECT obras.id,
                    obras.codigo_obra,
                    obras.numero_ot,
                    obras.nombre_obra,
                    obras.zona,
                    obras.delegacion,
                    obras.gestor_cliente,
                    obras.numero_aviso,
                    obras.numero_oc,
                    obras.monto,
                    obras.cantidad_uc,
                    obras.fecha_llegada,
                    obras.fecha_inicio,
                    obras.fecha_termino,
                    obras.tipo_trabajo,
                    obras.persona_envia_info,
                    obras.cargo_persona_envia_info,
                    obras.empresa_contratista,
                    obras.coordinador_contratista,
                    obras.comuna,
                    obras.ubicacion,
                    obras.estado,
                    obras.tipo_obra,
                    obras.segmento,
                    obras.eliminada,
                    obras.jefe_delegacion,
                    obras.oficina,
                    obras.recargo_distancia
                   FROM obras.obras
                  WHERE obras.zona = 2) o ON o.estado = eo.id
          GROUP BY eo.id, eo.nombre
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS estado,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 2) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 2) AS total) a
    ORDER BY a.id;`;
    const resumenMauleSur = await sequelize.query(sql, { type: QueryTypes.SELECT });
    if (resumenMauleSur) {
      respuesta.resumen_maule_sur = resumenMauleSur;
    } else {
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }


    sql = `
    SELECT a.tipo_obra,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje,
    a.bg_color AS "bg-color",
    a.txt_color AS "text-color"
   FROM ( SELECT tob.id,
            tob.descripcion AS tipo_obra,
            tob.bg_color,
            tob.txt_color,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 1) AS total
           FROM obras.tipo_obra tob
             LEFT JOIN ( SELECT obras.id,
                    obras.codigo_obra,
                    obras.numero_ot,
                    obras.nombre_obra,
                    obras.zona,
                    obras.delegacion,
                    obras.gestor_cliente,
                    obras.numero_aviso,
                    obras.numero_oc,
                    obras.monto,
                    obras.cantidad_uc,
                    obras.fecha_llegada,
                    obras.fecha_inicio,
                    obras.fecha_termino,
                    obras.tipo_trabajo,
                    obras.persona_envia_info,
                    obras.cargo_persona_envia_info,
                    obras.empresa_contratista,
                    obras.coordinador_contratista,
                    obras.comuna,
                    obras.ubicacion,
                    obras.estado,
                    obras.tipo_obra,
                    obras.segmento,
                    obras.eliminada,
                    obras.jefe_delegacion,
                    obras.oficina,
                    obras.recargo_distancia
                   FROM obras.obras
                  WHERE obras.zona = 1) o ON o.tipo_obra = tob.id
          GROUP BY tob.id, tob.descripcion, tob.bg_color, tob.txt_color
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS tipo_obra,
            'bg-purple-500'::character varying AS bg_color,
            'text-purple-500'::character varying AS txt_color,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 1) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 1) AS total) a
    ORDER BY a.id;`;

    const resumenMnorteTipoObra = await sequelize.query(sql, { type: QueryTypes.SELECT });
    if (resumenMnorteTipoObra) {
      respuesta.resumen_mnorte_tipo_obra = resumenMnorteTipoObra;
    } else {
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }


    sql = `SELECT a.tipo_obra,
    a.cantidad,
        CASE
            WHEN a.total = 0 THEN 0::numeric
            ELSE (a.cantidad::numeric / a.total::numeric * 100::numeric)::numeric(5,2)
        END AS porcentaje,
    a.bg_color AS "bg-color",
    a.txt_color AS "text-color"
   FROM ( SELECT tob.id,
            tob.descripcion AS tipo_obra,
            tob.bg_color,
            tob.txt_color,
            count(o.id) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 2) AS total
           FROM obras.tipo_obra tob
             LEFT JOIN ( SELECT obras.id,
                    obras.codigo_obra,
                    obras.numero_ot,
                    obras.nombre_obra,
                    obras.zona,
                    obras.delegacion,
                    obras.gestor_cliente,
                    obras.numero_aviso,
                    obras.numero_oc,
                    obras.monto,
                    obras.cantidad_uc,
                    obras.fecha_llegada,
                    obras.fecha_inicio,
                    obras.fecha_termino,
                    obras.tipo_trabajo,
                    obras.persona_envia_info,
                    obras.cargo_persona_envia_info,
                    obras.empresa_contratista,
                    obras.coordinador_contratista,
                    obras.comuna,
                    obras.ubicacion,
                    obras.estado,
                    obras.tipo_obra,
                    obras.segmento,
                    obras.eliminada,
                    obras.jefe_delegacion,
                    obras.oficina,
                    obras.recargo_distancia
                   FROM obras.obras
                  WHERE obras.zona = 2) o ON o.tipo_obra = tob.id
          GROUP BY tob.id, tob.descripcion, tob.bg_color, tob.txt_color
        UNION
         SELECT 999::bigint AS id,
            'TOTAL'::character varying AS tipo_obra,
            'bg-purple-500'::character varying AS bg_color,
            'text-purple-500'::character varying AS txt_color,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 2) AS cantidad,
            ( SELECT count(obras.id) AS total
                   FROM obras.obras
                  WHERE obras.zona = 2) AS total) a
    ORDER BY a.id;`;

    const resumenMsurTipoObra = await sequelize.query(sql, { type: QueryTypes.SELECT });
    if (resumenMsurTipoObra) {
      respuesta.resumen_msur_tipo_obra = resumenMsurTipoObra;
    } else {
      //res.status(500).send("Error en la consulta (servidor backend)");
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }
    //res.status(200).send(respuesta);

    if (generarLogResumen) {

        sql = `INSERT INTO obras.log_resumen_obras (codigo, datos, fecha_hora)
                VALUES ('${uuidv4()}', '${JSON.stringify(respuesta)}',
                substring((now()::timestamp at time zone 'utc' at time zone 'america/santiago')::text,1,19)::timestamp)`;

        const crea_log = await sequelize.query(sql, { type: QueryTypes.INSERT });
    }
    /*
    if (crea_log) {
      //res.status(200).send(crea_log);
      console.log("crea_log", crea_log);
    } else {
      //res.status(500).send("Error en la consulta (servidor backend)");
      console.log("Error en crea_log", crea_log);
      return {error: true, message: "Error en la consulta (servidor backend)"};
    }
    */


    return respuesta;

  } catch (error) {
    //res.status(500).send(error);
    console.log('error -> ', error);
    return {error: true, message: error};
  }

}
