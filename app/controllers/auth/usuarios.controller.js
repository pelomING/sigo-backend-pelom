const db = require("../../models");
const Persona = db.personas;
const User = db.user;
const Role = db.role;
const Op = db.Sequelize.Op;
const bcrypt = require("bcryptjs");


/*********************************************************************************** */
/* Crea una persona
  app.post("/api/usuarios/v1/creapersona", usuariosController.createPersona);
*/
exports.createPersona = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'crea una persona' */
  
    let salir = false;
    const campos = [
      'rut', 'apellido_1', 'nombres', 'base', 'id_funcion'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send( "No puede estar nulo el campo " + element
        );
        return;
      }
    };
  
    //Verifica que el rut no se encuentre
    await Persona.findAll({where: {rut: req.body.rut}}).then(data => {
      //el rut ya existe
      if (data.length > 0) {
        salir = true;
        res.status(403).send( 'El Rut ya se encuentra ingresado en la base' );
      }
    }).catch(err => {
        salir = true;
        res.status(500).send( err.message );
    })
  
    if (salir) {
      return;
    }
  
    const persona = {
        rut: req.body.rut,
        apellido_1: req.body.apellido_1,
        apellido_2: req.body.apellido_2,
        nombres: req.body.nombres,
        base: req.body.base,
        cliente: req.body.cliente?req.body.cliente:1,
        id_funcion: req.body.id_funcion,
        activo: true
    };
  
    await Persona.create(persona)
        .then(data => {
            res.status(200).send(data);
        }).catch(err => {
            res.status(500).send( err.message );
        })
  
  }
  /*********************************************************************************** */

/*********************************************************************************** */
/* Consulta las personas
  app.get("/api/usuarios/v1/findallpersonas", usuariosController.findAllPersonas)
*/
exports.findAllPersonas = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Devuelve todos las personas' */
    try {
      const sql = "SELECT p.id, p.rut, p.apellido_1, p.apellido_2, p.nombres, p.base, p.cliente, \
      p.id_funcion, p.activo, c.nombre as nom_cliente, pq.nombre as oficina, tfp.nombre as nom_funcion \
      FROM _auth.personas p JOIN _comun.tipo_funcion_personal tfp on p.id_funcion = tfp.id JOIN _comun.cliente \
      c on p.cliente = c.id JOIN _comun.base b on p.base = b.id JOIN _comun.paquete pq on pq.id = b.id_paquete WHERE not tfp.sistema ORDER BY p.id ASC;";
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const personas = await sequelize.query(sql, { type: QueryTypes.SELECT });
  
      //Chequear los campos que vienen de la consulta
      let salida = [];
      if (personas) {
        for (const element of personas) {
          if (typeof element.id === 'number' && 
                typeof element.rut === 'string' && 
                typeof element.apellido_1 === 'string' &&
                (typeof element.apellido_2 === 'string' || typeof element.apellido_2 === 'object') && //acepta nulos
                typeof element.nombres === 'string' &&
                typeof element.base === 'number' &&
                typeof element.cliente === 'number' &&
                typeof element.id_funcion === 'number' &&
                typeof element.activo === 'boolean' &&
                typeof element.nom_cliente === 'string' &&
                typeof element.oficina === 'string' &&
                typeof element.nom_funcion === 'string'
          ) {
                      const detalle_salida = {
                        id: Number(element.id),
                        rut: String(element.rut),
                        apellido_1: String(element.apellido_1),
                        apellido_2: String(element.apellido_2),
                        nombres: String(element.nombres),
                        base: Number(element.base),
                        cliente: Number(element.cliente),
                        id_funcion: Number(element.id_funcion),
                        activo: Boolean(element.activo),
                        nom_cliente: String(element.nom_cliente),
                        oficina: String(element.oficina),
                        nom_funcion: String(element.nom_funcion),
                      }
                      salida.push(detalle_salida);
          }else {
            salida=undefined;
            break;
          }
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
/* Crea un nuevo usuario
  app.post("/api/usuarios/v1/creausuario", usuariosController.createUser);
*/
exports.createUser = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Crea un nuevo usuario' 
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Crear un usuario nuevo, el rut debe exister en la tabla persona',
            required: true,
            schema: {
                username: "rut del usuario, sin puntos",
                email: "usuario@email.com",
                password: "password usuario",
                roles: ["admin", "user"]
            }
        }
        */
        try {
          let salir = false;
          const campos = [
            'username', 'email', 'password'
          ];
          for (const element of campos) {
            if (!req.body[element]) {
              res.status(400).send( "No puede estar nulo el campo " + element
              );
              return;
            }
          };

          await Persona.findAll({where: {rut: req.body.username}}).then(async data => {
            if (data.length > 0) {
              //el rut se encuentra en la tabla de personas
              const user = await User.create({
                username: req.body.username,
                email: req.body.email,
                password: bcrypt.hashSync(req.body.password, 8),
              });
              if (req.body.roles) {
                const roles = await Role.findAll({
                  where: {
                    name: {
                      [Op.or]: req.body.roles,
                    },
                  },
                });
                const result = user.setRoles(roles);
                if (result) res.status(200).send( "User registered successfully!" );
              } else {
                // user has role = 1
                const result = user.setRoles([1]);
                if (result) res.status(200).send("User registered successfully!" );
              }
            }else {
              //el rut no existe
              salir = true;
              res.status(403).send( 'El Rut no se encuentra en la tabla de personas' );
            }
          }).catch(err => {
              salir = true;
              res.status(500).send( err.message );
          })
        } catch (error) {
          res.status(500).send( error.message );
          
        }
}
/*********************************************************************************** */
/* Resetea password para un usuario
  app.post("/api/usuarios/v1/resetpassword", usuariosController.resetPassword);
*/
exports.resetPassword = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Resetea password para un usuario'
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Resetea password para un usuario',
            required: true,
            schema: {
                username: "rut del usuario, sin puntos"
            }
        }
        */
        try {
          const user = await User.findOne({where: {username: req.body.username}});
          if (!user) {
            res.status(404).send( 'Usuario no encontrado' );
          } else {
            //Para resetear la password se usará el mismo nombre de usuario como password
            user.password = bcrypt.hashSync(req.body.username, 8);
            await user.save();
            res.status(200).send( 'Reset de password OK!' );
          }
        } catch (error) {
          res.status(500).send( error.message );
        }
}
