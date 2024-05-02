const { authJwt } = require("../middleware");
const mantendorController = require("../controllers/comun/mantenedor.controller");
const upload = require("../middleware/upload");
const fs = require('fs').promises;
const axios = require('axios');
const PDFDocument = require('pdfkit');
const excel = require("exceljs");

    
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

      const file = req.file;
      const folderName = req.body.folderName;
      if (!req.file) {
        res.status(400).send('No file uploaded');
        return;
      }
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
    app.post("/api/mantenedor/v1/creadir", [authJwt.verifyToken, authJwt.isSistema], async (req, res) => {
      /*  #swagger.tags = ['SAE - Mantenedores - Upload']
      #swagger.description = 'crea directorio' */
      try {


        let fecha_hoy = new Date().toLocaleString("es-CL", {timeZone: "America/Santiago"}).slice(0, 10);
        const year =  fecha_hoy.slice(6, 10)
        const month = fecha_hoy.slice(3, 5)
        const newDirectory = req.body.nuevodirectorio;
        let arrayDirectorios = [];

        arrayDirectorios.push('/datos/fotos/' + year + '/' + month + '/' + newDirectory);
        let directorio = arrayDirectorios[0];

        //for (const directorio of arrayDirectorios) {
          if (await existeRuta(directorio)) {
            console.log(`La ruta ${directorio} ya existe.`);
            res.status(200).send('Directorio creado correctamente');
          } else {
            // Si la ruta no existe, la creamos
            await crearRuta(directorio).then(() => {
              console.log(`La ruta ${directorio} ha sido creada.`);
              res.status(200).send('Directorio creado correctamente');
            }).catch((error) => {
              let mensaje_error = `Error al crear la ruta ${directorio}: ${error}`
              console.log(mensaje_error);
              res.status(500).send(mensaje_error);
            });
          }
        //}
      } catch (error) {
        console.log('error 5', error)
        res.status(500).send(error);
      }
    });

    //Download file
    app.get("/api/mantenedor/v1/download/:filename", (req, res) => {
      /*  #swagger.tags = ['SAE - Mantenedores - Upload']
      #swagger.description = 'Descarga un archivo' */
      const filename = req.params.filename;
      const filePath = __dirname + './../../public/assets/' + filename;
      console.log('filePath -> ', filePath);
      res.download(
        filePath, 
        "flexiapp.pdf", // Remember to include file extension
        (err) => {
            if (err) {
                res.send({
                    error : err,
                    msg   : "Problem downloading the file"
                })
            }
    });
    
    })

    app.post("/api/geovictoria/v1/login", async (req, res) => {
      /*  #swagger.tags = ['SAE - Geovictoria']
      #swagger.description = 'Hace el login en geovictoria' */
      const { user, password } = req.body;
      const tokenGeoVictoria = await loginGeovictoria();
      res.status(200).send(tokenGeoVictoria);
    });

    app.post("/api/geovictoria/v1/userlist", async (req, res) => {
      /*  #swagger.tags = ['SAE - Geovictoria']
      #swagger.description = 'Consulta usuarios en geovictoria' */
      const userToken = req.body.token;
      const userList = await userListGeoVictoria(userToken);
      res.status(200).send(userList);
    });

    app.post("/api/geovictoria/v1/attendanceBook", async (req, res) => {
      /*  #swagger.tags = ['SAE - Geovictoria']
      #swagger.description = 'Consulta un usuario en geovictoria' */
      const userToken = req.body.token;
      const StartDate = req.body.StartDate;
      const EndDate = req.body.EndDate;
      const UserIds = req.body.UserIds;
      const userAttendanceBook = await attendanceBookGeoVictoria(userToken, StartDate, EndDate, UserIds);
      res.status(200).send(userAttendanceBook);
    });

    app.get("/api/reportes/v1/generapdf", async (req, res) => {
      /*  #swagger.tags = ['SAE - PDF']
      #swagger.description = 'Genera un archivo pdf' */

        // Crear un nuevo documento PDF en memoria
        const doc = new PDFDocument();

        //Inserta lgoo Pelom
        doc.image('/public/assets/logo-pelom.jpg', 0, 15, {width: 300})
        // Escribir contenido en el PDF
        doc.text('¡Hola, este es un PDF generado en memoria!', 100, 100);

        // Establecer el tipo de contenido como PDF
        res.setHeader('Content-Type', 'application/pdf');

        // Devolver el PDF como una respuesta al cliente
        doc.pipe(res);
        doc.end();
      
    })

    app.get("/api/reportes/v1/generaxls", async (req, res) => {
      /*  #swagger.tags = ['SAE - Excel'])
      #swagger.description = 'Genera un archivo excel' */

        // Crear un nuevo documento Excel en memoria
        let workbook = new excel.Workbook();
        let worksheet = workbook.addWorksheet("Tutorials");
        let tutorials = [{
          id: 1,
          title: "Tutorial 1",
          description: "This is tutorial 1",
          published: "Yes",
        }, {
          id: 2,
          title: "Tutorial 2",
          description: "This is tutorial 2",
          published: "No",
        }];

        worksheet.columns = [
          { header: "Id", key: "id", width: 5 },
          { header: "Title", key: "title", width: 25 },
          { header: "Description", key: "description", width: 25 },
          { header: "Published", key: "published", width: 10 },
        ];

        // Add Array Rows
        worksheet.addRows(tutorials);

        // res is a Stream object
        res.setHeader(
          "Content-Type",
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        );
        res.setHeader(
          "Content-Disposition",
          "attachment; filename=" + "tutorials.xlsx"
        );
        
        return workbook.xlsx.write(res).then(function () {
          res.status(200).end();
        });
    
    })
  };

async function existeRuta(ruta) {
  try {
    await fs.access(ruta);
    return true; // La ruta existe
  } catch (error) {
    return false; // La ruta no existe
  }
};

// Función asincrónica para crear una ruta
async function crearRuta(ruta) {
  await fs.mkdir(ruta, { recursive: true }); // Usamos recursive: true para crear rutas anidadas si es necesario
}

async function loginGeovictoria() {
  //Aquí debe logear a la api de geovictoria utilizando axios y el usuario y contraseña 
      //especificados en las variables de ambiente GEOVIC_USER y GEOVIC_PASS

      let respuesta;
      await axios.post('https://customerapi.geovictoria.com/api/v1/Login', {
        user: process.env.GEOVIC_USER,
        password: process.env.GEOVIC_PASS
      })
      .then(function (response) {
        respuesta = response.data;
      })
      .catch(function (error) {
        respuesta = error;
        console.log('error, login geovictoria', respuesta);
      });
      return respuesta;
}

async function userListGeoVictoria(token) {
  let respuesta;
  const headers = {
    Authorization: 'Bearer ' + token
  }
  console.log('headers', headers);
  
  await axios.post("https://customerapi.geovictoria.com/api/v1/User/List", {data: ''},
      {
        headers: headers
      }
)
  .then(function (response) {
    respuesta = response.data;
  })
  .catch(function (error) {
    respuesta = error;
    //console.log('error, userListGeoVictoria', respuesta);
  });
  
  console.log('token', token);
  return respuesta;
}

async function attendanceBookGeoVictoria(token, StartDate, EndDate, UserIds) {
  let respuesta;
  const headers = {
    Authorization: 'Bearer ' + token
  }
  const data = {
    StartDate: StartDate,
    EndDate: EndDate,
    UserIds: UserIds
  }
  console.log('headers', headers);
  
  await axios.post("https://customerapi.geovictoria.com/api/v1/AttendanceBook", data,
      {
        headers: headers
      }
)
  .then(function (response) {
    respuesta = response.data;
  })
  .catch(function (error) {
    respuesta = error;
    //console.log('error, userListGeoVictoria', respuesta);
  });
  
  console.log('token', token);
  return respuesta;
}
