const db = require("../../models");
const Persona = db.personas;
const User = db.user;
const Role = db.role;
const LoginHistorial = db.loginHistorial;
const Op = db.Sequelize.Op;
const bcrypt = require("bcryptjs");
const sequelize = db.sequelize;
const UsuariosGeneral = db.usuariosGeneral;


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
/* Consulta los roles

*/
  exports.findAllRoles = async (req, res) => {
    /*  #swagger.tags = ['Autenticación']
      #swagger.description = 'Devuelve todos los roles' */
    await Role.findAll().then(data => {
        res.status(200).send(data);
    }).catch(err => {
        res.status(500).send( err.message );
    })
  }
/*********************************************************************************** */


/*********************************************************************************** */

 exports.findAllUsuariosGeneral = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Devuelve todos los usuarios' */
  try {
    
    const Op = db.Sequelize.Op;
    const data = await UsuariosGeneral.findAll(
      { where:  { funcion: { [Op.ne]: 'sistema' } } , order: [['rut', 'ASC']] });
    let salida;
    if (data) {
      salida = [];
      for (const element of data) {

            const password_defecto = bcrypt.compareSync(
              element.rut,
              element.password
            );
            const detalle_salida = {
              rut: element.rut,
              persona: element.persona,
              rol: element.rol,
              email: element.email,
              activo: element.activo,
              base: element.base,
              funcion: element.funcion,
              password_defecto: password_defecto,
              fecha_password: element.fecha_password
            }
            salida.push(detalle_salida);
      };
    }
    if (salida===undefined){
      res.status(500).send("Error en la consulta (servidor backend)");
    }else{
      res.status(200).send(salida);
    }
  } catch (err) {
    res.status(500).send( err.message );
  }
}
/*********************************************************************************** */

exports.findAllUsuariosGeneral_V2 = async (req, res) => {
  //metodo GET
  /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Devuelve todos los usuarios' */

    try {
      const sql = `SELECT u.username AS rut,
                upper((((p.nombres::text || ' '::text) || p.apellido_1::text) || ' '::text) ||
                    CASE
                        WHEN p.apellido_2 IS NULL THEN ''::character varying
                        ELSE p.apellido_2
                    END::text) AS persona,
              json_build_object('id', r.id, 'nombre', r.descripcion) as rol,
                u.email,
                p.activo,
              row_to_json(b.*) AS base,
              row_to_json(tfp.*) AS funcion,
                u.password,
                u.fecha_password,
              UPPER(p.apellido_1) as apellido_1,
              UPPER(p.apellido_2) as apellido_2,
              UPPER(p.nombres) as nombres
              FROM _auth.users u
                JOIN _auth.user_roles ur ON u.id = ur."userId"
                JOIN _auth.roles r ON ur."roleId" = r.id
                JOIN _auth.personas p ON u.username::text = p.rut::text
                JOIN _comun.base b ON p.base = b.id
                JOIN _comun.tipo_funcion_personal tfp ON p.id_funcion = tfp.id
              ORDER BY u.username;`;
      const { QueryTypes } = require('sequelize');
      const sequelize = db.sequelize;
      const usuario = await sequelize.query(sql, { type: QueryTypes.SELECT });
      let salida = [];
      if (usuario) {
        for (const element of usuario) {
              const password_defecto = bcrypt.compareSync(
                element.rut,
                element.password
              );
  
              const detalle_salida = {
  
                rut: element.rut,
                persona: element.persona,
                rol: element.rol,
                email: element.email,
                activo: element.activo,
                base: element.base,
                funcion: element.funcion,
                password_defecto: password_defecto,
                fecha_password: element.fecha_password,
                apellido_1: element.apellido_1,
                apellido_2: element.apellido_2,
                nombres: element.nombres
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

exports.createFullUser = async (req, res) => {
  /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Crea un nueva persona + usuario' 
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Crea persona y usuario',
            required: true,
            schema: {
                rut: "rut del usuario, sin puntos y guion",
                apellido_1: "primer apellido",
                apellido_2: "segundo apellido",
                nombres: "nombres",
                base: "base en la que trabaja",
                id_funcion: "funcion del usuario",
                id_rol: "rol del usuario",
                email: "usuario@email.com"
            }
        }
        */
  let salir = false;
    const campos = [
      'rut', 'apellido_1', 'nombres', 'base', 'id_funcion', 'email', 'id_rol'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send( {"error": true, "message": "No puede estar nulo el campo " + element }
        );
        return;
      }
    };

    const persona = {
        rut: req.body.rut,
        apellido_1: req.body.apellido_1,
        apellido_2: req.body.apellido_2,
        nombres: req.body.nombres,
        base: req.body.base,
        cliente: req.body.cliente?req.body.cliente:1,
        id_funcion: req.body.id_funcion,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.rut, 8),
        id_rol: req.body.id_rol,
        activo: true
    };

    //let sql_crea = `INSERT INTO _auth.personas (rut, apellido_1, apellido_2, nombres, base, cliente, id_funcion, activo)
	  //VALUES ('${persona.rut}', '${persona.apellido_1}', '${persona.apellido_2}', '${persona.nombres}', '${persona.base}', ${persona.cliente?persona.cliente:1}, '${persona.id_funcion}', true);`
    
    let sql_crea = `WITH inserta_user AS (INSERT INTO _auth.users (username, email, password, fecha_password)
	  VALUES ('${persona.rut}', '${persona.email}', '${persona.password}', now()) RETURNING id),
	  inserta_rol AS (INSERT INTO _auth.user_roles ("roleId", "userId") SELECT '${persona.id_rol}', id FROM inserta_user) 
    SELECT 'Ingresado correctamente!';`;


    //Verifica el rut se encuentra en la tabla usuario
    await User.findAll({where: {username: req.body.rut}}).then(data => {
      //el rut ya existe
      if (data.length > 0) {
        salir = true;
        res.status(403).send( {"error": true, "message": 'El Rut ya se encuentra ingresado en la base'}  );
      }
    }).catch(err => {
        salir = true;
        res.status(500).send( {"error": true, "message": err.message} );
    })
  
    if (salir) {
      return;
    }
  
    salida = {"error": false, "message": "Usuario ingresado correctamente"};
    //Verifica el rut se encuentra en la tabla persona
    await Persona.findAll({where: {rut: req.body.rut}}).then(data => {
      //el rut ya existe en Persona
      if (data.length > 0) {
        sql_crea = `UPDATE _auth.personas SET apellido_1 = '${persona.apellido_1}', apellido_2 = '${persona.apellido_2}', 
        nombres = '${persona.nombres}', base = '${persona.base}', 
        cliente = ${persona.cliente?persona.cliente:1}, id_funcion = '${persona.id_funcion}', activo = true
        WHERE rut = '${persona.rut}';` + sql_crea;
      } else {
       sql_crea = `INSERT INTO _auth.personas (rut, apellido_1, apellido_2, nombres, base, cliente, id_funcion, activo)
	      VALUES ('${persona.rut}', '${persona.apellido_1}', '${persona.apellido_2}', '${persona.nombres}', 
        '${persona.base}', ${persona.cliente?persona.cliente:1}, '${persona.id_funcion}', true);` + sql_crea;

      }
    }).catch(err => {
        salir = true;
        res.status(500).send( {"error": true, "message": err.message}  );
    })
    if (salir) {
      return;
    }

    
  
    await sequelize.query(sql_crea).then(data => {
      res.status(200).send( salida );
    }).catch(err => {
        res.status(500).send( {"error": true, "message": err.message} );
    })

}

/*********************************************************************************** */

exports.updateFullUser = async (req, res) => {
  /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Actualiza persona + usuario' 
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Actualiza persona y usuario',
            required: true,
            schema: {
                apellido_1: "primer apellido",
                apellido_2: "segundo apellido",
                nombres: "nombres",
                base: "base en la que trabaja",
                id_funcion: "funcion del usuario",
                id_rol: "rol del usuario",
                email: "usuario@email.com"
            }
        }
        */
  let salir = false;
    const campos = [
      'apellido_1', 'nombres', 'base', 'id_funcion', 'email', 'id_rol'
    ];
    for (const element of campos) {
      if (!req.body[element]) {
        res.status(400).send({"error": true, "message": "No puede estar nulo el campo " + element}  );
        return;
      }
    };
    let rut = req.params.rut;

    const persona = {
        rut: rut,
        apellido_1: req.body.apellido_1,
        apellido_2: req.body.apellido_2,
        nombres: req.body.nombres,
        base: req.body.base,
        cliente: req.body.cliente?req.body.cliente:1,
        id_funcion: req.body.id_funcion,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.rut, 8),
        id_rol: req.body.id_rol,
    };

    salida = {"error": false, "message": "Usuario ingresado correctamente"};

    let sql_update = `UPDATE _auth.personas SET apellido_1 = '${persona.apellido_1}', apellido_2 = '${persona.apellido_2}', 
        nombres = '${persona.nombres}', base = '${persona.base}', 
        cliente = ${persona.cliente?persona.cliente:1}, id_funcion = '${persona.id_funcion}'
        WHERE rut = '${persona.rut}';`;

    let sql_rol = `UPDATE _auth.user_roles SET "roleId" = '${persona.id_rol}' WHERE "userId" = (SELECT id FROM _auth.users WHERE username = '${persona.rut}');`;

    sql_crea = `UPDATE _auth.users SET email = '${persona.email}' WHERE username = '${persona.rut}';${sql_update}${sql_rol};`;
 
  
    await sequelize.query(sql_crea).then(data => {
      res.status(200).send( salida );
    }).catch(err => {
        res.status(500).send( {"error": true, "message": err.message} );
    })

}

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
            let salida = {};
            const t = await sequelize.transaction();
            try 
            {
                salida = {"error": false, "message": "Reset de password OK!"};
                //Para resetear la password se usará el mismo nombre de usuario como password
                const c = new Date().toLocaleString("es-CL", {"hour12": false, timeZone: "America/Santiago"});
                const fecha_hoy = c.substring(6,10) + '-' + c.substring(3,5) + '-' + c.substring(0,2)
                const password = bcrypt.hashSync(req.body.username, 8);
                await user.update({ password: password, fecha_password: fecha_hoy }, { where: { id: user.id }, transaction: t });
                //* almacenar el log *//
                await LoginHistorial.create({
                    username: user.username,
                    email: user.email,
                    accion: 'Reset Password',
                    fecha_hora: fecha_hoy, 
                    comentario: 'Password reseteada para el usuario ' + user.username,
                }, { transaction: t })
                await t.commit();
            } 
            catch (error) {
              console.log("error rest password -> ", error);
                salida = { error: true, message: error }
                await t.rollback();
              
            }
            if (salida.error) {
              res.status(500).send(salida.message);
            }else {
              res.status(200).send(salida);
            }
          }
        } catch (error) {
          res.status(500).send( error.message );
        }
}


exports.desactivaUser = async (req, res) => { 
    /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Desactiva un usuario'
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Desactiva un usuario',
            required: true,
            schema: {
                rut: "rut del usuario, sin puntos"
            }
        }
        */
        try {
          const persona = await Persona.findOne({where: {rut: req.body.rut}});
          if (!persona) {
            res.status(404).send( {"error": true, "message": 'Rut no encontrado'}  );
          } else {
            let salida = {};
            const t = await sequelize.transaction();
            try 
            {
                salida = {"error": false, "message": "Desactivado OK!"};
                await persona.update({ activo: false }, { where: { rut: persona.rut }, transaction: t });
                await t.commit();
            } 
            catch (error) {
              //console.log("error rest password -> ", error);
                salida = { error: true, message: error }
                await t.rollback();
              
            }
            if (salida.error) {
              res.status(500).send(salida);
            }else {
              res.status(200).send(salida);
            }
          }
        } catch (error) {
          res.status(500).send( { error: true, message: error.Boolean } );
        }
}



exports.activaUser = async (req, res) => { 
    /*  #swagger.tags = ['Autenticación']
        #swagger.description = 'Activa un usuario'
        #swagger.parameters['body'] = {
            in: 'body',
            description: 'Activa un usuario',
            required: true,
            schema: {
                rut: "rut del usuario, sin puntos"
            }
        }
        */
        try {
          const persona = await Persona.findOne({where: {rut: req.body.rut}});
          if (!persona) {
            res.status(404).send( {"error": true, "message": 'Rut no encontrado'}  );
          } else {
            let salida = {};
            const t = await sequelize.transaction();
            try 
            {
                salida = {"error": false, "message": "Activado OK!"};
                await persona.update({ activo: true }, { where: { rut: persona.rut }, transaction: t });
                await t.commit();
            } 
            catch (error) {
              //console.log("error rest password -> ", error);
                salida = { error: true, message: error }
                await t.rollback();
              
            }
            if (salida.error) {
              res.status(500).send(salida);
            }else {
              res.status(200).send(salida);
            }
          }
        } catch (error) {
          res.status(500).send( { error: true, message: error.Boolean } );
        }
}
