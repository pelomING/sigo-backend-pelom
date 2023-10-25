const db = require("../../models");
const VisitaTerreno = db.visitaTerreno;

/*********************************************************************************** */
/* Consulta todas las visitas terreno
;
*/
exports.findAllVisitaTerreno = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Visita Terreno']
      #swagger.description = 'Devuelve todas las visitas a terreno' */
    try {
        const sql = "SELECT vt.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, \
        fecha_visita::text, direccion, persona_mandante, cargo_mandante, persona_contratista, cargo_contratista, \
        observacion, row_to_json(ev) as estado, fecha_modificacion::text FROM obras.visitas_terreno vt join \
        obras.obras o on o.id = vt.id_obra join obras.estado_visita ev on vt.estado = ev.id WHERE not o.eliminada";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const obras = await sequelize.query(sql, { type: QueryTypes.SELECT });
        let salida = [];
        if (obras) {
          for (const element of obras) {
    
                const detalle_salida = {
                  id: Number(element.id),
                  id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
                  fecha_visita: String(element.fecha_visita),
                  direccion: String(element.direccion),
                  persona_mandante: String(element.persona_mandante),
                  cargo_mandante: String(element.cargo_mandante),
                  persona_contratista: String(element.persona_contratista),
                  cargo_contratista: String(element.cargo_contratista),
                  observacion: String(element.observacion),
                  estado: element.estado, //json {"id": id, "nombre": nombre}
                  fecha_modificacion: String(element.fecha_modificacion)
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
/* Consulta visitas terreno por id de obra
;
*/
exports.findVisitaTerrenoByIdObra = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Visita Terreno']
      #swagger.description = 'Devuelve las visitas a terreno por ID de obra (id_obra)' */
      try {
        const campos = [
            'id_obra'
          ];
          for (const element of campos) {
            if (!req.query[element]) {
              res.status(400).send({
                message: "No puede estar nulo el campo " + element
              });
              return;
            }
          };
        const id_obra = req.query.id_obra;
        const sql = "SELECT vt.id, json_build_object('id', o.id, 'codigo_obra', o.codigo_obra) as id_obra, \
        fecha_visita::text, direccion, persona_mandante, cargo_mandante, persona_contratista, cargo_contratista, \
        observacion, row_to_json(ev) as estado, fecha_modificacion::text FROM obras.visitas_terreno vt join \
        obras.obras o on o.id = vt.id_obra join obras.estado_visita ev on vt.estado = ev.id WHERE not o.eliminada and o.id = :id_obra";
        const { QueryTypes } = require('sequelize');
        const sequelize = db.sequelize;
        const obras = await sequelize.query(sql, {  replacements: { id_obra: id_obra } , type: QueryTypes.SELECT });
        let salida = [];
        if (obras) {
          for (const element of obras) {
    
                const detalle_salida = {
                  id: Number(element.id),
                  id_obra: element.id_obra, //json {"id": id, "codigo_obra": codigo_obra}
                  fecha_visita: String(element.fecha_visita),
                  direccion: String(element.direccion),
                  persona_mandante: String(element.persona_mandante),
                  cargo_mandante: String(element.cargo_mandante),
                  persona_contratista: String(element.persona_contratista),
                  cargo_contratista: String(element.cargo_contratista),
                  observacion: String(element.observacion),
                  estado: element.estado, //json {"id": id, "nombre": nombre}
                  fecha_modificacion: String(element.fecha_modificacion)
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
/* Crea una visita terreno
;
*/
exports.createVisitaTerreno = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Visita Terreno']
      #swagger.description = 'Crea una visita a terreno' */

    try {

        const campos = [
        'id_obra', 'fecha_visita', 'direccion', 'persona_mandante', 'cargo_mandante', 'persona_contratista', 'cargo_contratista'
        ];
        for (const element of campos) {
        if (!req.body[element]) {
            res.status(400).send({
            message: "No puede estar nulo el campo " + element
            });
            return;
        }
        };
        let fecha_visita = new Date(req.body.fecha_visita).toLocaleString("es-CL", {timeZone: "America/Santiago"}).slice(0, 10);
        fecha_visita = fecha_visita.slice(6,10) + "-" + fecha_visita.slice(3,5) + "-" + fecha_visita.slice(0,2)
        let fecha_hoy = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"}).slice(0, 10);
        fecha_hoy = fecha_hoy.slice(6,10) + "-" + fecha_hoy.slice(3,5) + "-" + fecha_hoy.slice(0,2)

    
        //Verifica que la visita a terreno no se encuentra ya agendada
        await VisitaTerreno.findAll({where: {id_obra: req.body.id_obra, fecha_visita: fecha_visita}}).then(async data => {
            //La obra ya tiene una visita agendada para esa fecha
            if (data.length > 0) {
                res.status(403).send({ message: 'La Visita ya se encuentra agendada' });
            }else {
                const visita = {

                    id_obra: req.body.id_obra,
                    fecha_visita: req.body.fecha_visita,
                    direccion: req.body.direccion,
                    persona_mandante: req.body.persona_mandante,
                    cargo_mandante: req.body.cargo_mandante,
                    persona_contratista: req.body.persona_contratista,
                    cargo_contratista: req.body.cargo_contratista,
                    observacion: req.body.observacion,
                    estado: 1,
                    fecha_modificacion: fecha_hoy
        
                }
        
                await VisitaTerreno.create(visita)
                    .then(data => {
                        res.send(data);
                    }).catch(err => {
                        res.status(500).send({ message: err.message });
                    })
            }
        }).catch(err => {
            res.status(500).send({ message: err.message });
        })
    }catch (error) {
        res.status(500).send(error);
    }   
}
/*********************************************************************************** */
/* Actualizar una visita terreno
;
*/
exports.updateVisitaTerreno = async (req, res) => {
    /*  #swagger.tags = ['Obras - Backoffice - Visita Terreno']
      #swagger.description = 'Actualiza una visita a terreno' */
    try{
        const id = req.params.id;

        let fecha_hoy = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"}).slice(0, 10);
        fecha_hoy = fecha_hoy.slice(6,10) + "-" + fecha_hoy.slice(3,5) + "-" + fecha_hoy.slice(0,2)
        id_obra = req.body.id_obra;
        fecha_visita = req.body.fecha_visita;
        let visita = undefined;

        
        if (id_obra) {
            //El id de obra no se puede cambiar para una visita una vez asignado
            res.status(500).send({ message: 'El id de obra no se puede cambiar' });

        }else {
            //Si viene la fecha de visita verificar que sea mayor o igual al día de hoy
            if (fecha_visita) {

                let today = new Date(fecha_hoy).toISOString();
                let fechaVisita = new Date(fecha_visita).toISOString();

                if (fechaVisita < today) {
                    // La fecha de visita es menor a la fecha actual 
                    res.status(500).send({ message: 'La fecha de la visita no puede ser menor a la fecha actual' });
                }else {
                    visita = {

                        fecha_visita: fechaVisita,
                        direccion: req.body.direccion,
                        persona_mandante: req.body.persona_mandante,
                        cargo_mandante: req.body.cargo_mandante,
                        persona_contratista: req.body.persona_contratista,
                        cargo_contratista: req.body.cargo_contratista,
                        observacion: req.body.observacion,
                        estado: req.body.estado,
                        fecha_modificacion: fecha_hoy
                
                    }
                }
            }else {
                //No viene la fecha de visita
                visita = {

                    direccion: req.body.direccion,
                    persona_mandante: req.body.persona_mandante,
                    cargo_mandante: req.body.cargo_mandante,
                    persona_contratista: req.body.persona_contratista,
                    cargo_contratista: req.body.cargo_contratista,
                    observacion: req.body.observacion,
                    estado: req.body.estado,
                    fecha_modificacion: fecha_hoy
            
                }
            }
            if (visita != undefined) {
                await VisitaTerreno.update(visita, { where: { id: id } })
                    .then(data => {
                        if (data == 1) {
                            res.send({ message: "Visita actualizada" });
                        }else {
                            res.status(500).send({ message: "No se pudo actualizar la Visita" });
                        }
                    }).catch(err => {
                        res.status(500).send({ message: err.message });
                    })
                }
        }
    }catch (error) {
        res.status(500).send(error);
    }
}