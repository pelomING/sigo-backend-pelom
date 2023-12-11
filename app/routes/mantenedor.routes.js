const { authJwt } = require("../middleware");
const mantendorController = require("../controllers/comun/mantenedor.controller");
const upload = require("../middleware/upload");

    
module.exports = function(app) {
    app.use(function(req, res, next) {
      res.header(
        "Access-Control-Allow-Headers",
        "Origin, Content-Type, Accept"
      );
      next();
    });
  
    //crea un nuevo estado, se debe pasar el nombre del estado, ejemplo: { nombre: "estado" }
    app.post("/api/mantenedor/v1/creaestado", [authJwt.verifyToken, authJwt.isSistema], mantendorController.createEstado);

    app.get("/api/mantenedor/v1/estados", [authJwt.verifyToken], mantendorController.estados);

    app.get("/api/mantenedor/v1/findallbases", [authJwt.verifyToken], mantendorController.findAllBases);

    app.get("/api/mantenedor/v1/findallclientes", [authJwt.verifyToken], mantendorController.findAllClientes);

    app.get("/api/mantenedor/v1/findalltipofuncionpersonal", [authJwt.verifyToken], mantendorController.findAllTipofuncionPersonal);

    app.get("/api/mantenedor/v1/oficinas", [authJwt.verifyToken], mantendorController.oficinas);

    // upload.single('file')
    app.post("/api/mantenedor/v1/upload", upload.single('file'), (req, res) => {
      /*  #swagger.tags = ['SAE - Mantenedores - Upload']
      #swagger.description = 'Sube un archivo al servidor' */
      res.json({ message: 'File uploaded successfully!' });
    });

    // Ejecuta comando
    app.post("/api/mantenedor/v1/ejecuta", [authJwt.verifyToken, authJwt.isSistema], (req, res) => {
      /*  #swagger.tags = ['SAE - Mantenedores - Upload']
      #swagger.description = 'ejecuta un comando' */
      try {
 
        const comando = req.body.comando;
        console.log('comando ', comando);
        const { exec } = require('node:child_process')
        exec(comando, (error, stdout, stderr) => {
          if (error) {
            console.log(`error: ${error.message}`);
            res.status(500).send(error.message);
            return;
          }
          if (stderr) {
            console.log(`stderr: ${stderr}`);
            res.status(500).send(stderr);
            return;
          }
          console.log(`stdout: ${stdout}`);
          res.status(200).send(stdout);
        });
      } catch (error) {
        res.status(500).send(error);
      }
    });
    
    // Crea directorio
    app.post("/api/mantenedor/v1/creadir", [authJwt.verifyToken, authJwt.isSistema], (req, res) => {
      /*  #swagger.tags = ['SAE - Mantenedores - Upload']
      #swagger.description = 'crea directorio' */
      try {
        let fecha_hoy = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"}).slice(0, 10);
        const year =  fecha_hoy.slice(6, 10)
        const month = fecha_hoy.slice(3, 5)
        const comando = 'mkdir /datos/fotos/' + year + '/' + month + '/' + req.body.comando + ' && touch uno.txt' ;
        console.log('comando ', comando);
        const { exec } = require('node:child_process')
        exec(comando, (error, stdout, stderr) => {
          if (error) {
            console.log(`error: ${error.message}`);
            res.status(500).send(error.message);
            return;
          }
          if (stderr) {
            console.log(`stderr: ${stderr}`);
            res.status(500).send(stderr);
            return;
          }
          console.log(`stdout: ${stdout}`);
          res.status(200).send(stdout);
        });
      } catch (error) {
        res.status(500).send(error);
      }
    });
  }; 