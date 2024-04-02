const express = require("express");
const cors = require("cors");
const cookieSession = require("cookie-session");
const nodeCron = require('node-cron');
//const swaggerJsdoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
const swaggerFile = require('./swagger-output.json')
const bodyParser = require('body-parser')
//const options = require('./app/config/swagger.config');

//const options = swaggerConfig;

const app = express();
const db = require("./app/models");
const cronObras = require("./app/cron/obras.cron");
const Origen_cors = db.backendCors;


app.use(
  cors({
    credentials: true,
    origin: ["http://localhost:4200", 
    "http://localhost:59214", 
    "http://181.42.20.52", 
    "http://186.11.3.23", 
    "https://siscop.up.railway.app", 
    "https://pelom-ing.up.railway.app",
    "https://pelom-ing-dev.up.railway.app",
    "https://pelom-ing-testobras.up.railway.app",
    "https://pelom-ing-test.up.railway.app"
  ],
  })
);


// cors acpeta todas las entradas
// app.use(cors());
// parse requests of content-type - application/json
app.use(express.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

app.use(
  cookieSession({
    name: "pelom-session",
    keys: ["COOKIE_SECRET"], // should use as secret environment variable
    httpOnly: true,
  })
);


const Role = db.role;

//se usa db.sequelize.sync({force: true}) para que reconstruya la base
/*
db.sequelize.sync().then(() => {
  console.log('Drop and Resync Db');
  //y se llama a la funcion init() para que reconstruya la base
  //initial();
});
*/

function initial() {
  Role.create({
    id: 1,
    name: "user"
  });
 
  Role.create({
    id: 2,
    name: "moderator"
  });
 
  Role.create({
    id: 3,
    name: "admin"
  });
}

// Swagger
/*
const specs = swaggerJsdoc(options);
//console.log(options);
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(specs, {
    explorer: true,
    customCssUrl:
      "https://cdn.jsdelivr.net/npm/swagger-ui-themes@3.0.0/themes/3.x/theme-newspaper.css",
  })
);
*/

app.use(bodyParser.json())
app.use('/api-doc', swaggerUi.serve, swaggerUi.setup(swaggerFile))

// simple route
/*
app.get("/", (req, res) => {
  res.json({ message: "App de ejemplo Authentication" });
});
*/
// routes

require('./app/routes/auth.routes')(app);
require('./app/routes/user.routes')(app);
require('./app/routes/sae_movil.routes')(app);
require('./app/routes/mantenedor.routes')(app);
require('./app/routes/sae_reportes.routes')(app);
require('./app/routes/obras_backoffice.routes')(app);
require('./app/routes/sae_paneldecontrol.routes')(app);


const Tiempo = process.env.CRON_TIEMPO || 10;
//Se propgrama el cron
const job = nodeCron.schedule('*/' + Tiempo + ' * * * *', () => {
  console.log('se ejecuta la funcion por cron ' + '*/' + Tiempo + ' * * * *');
  cronObras.resumenObras();
})
job.start();
// set port, listen for requests
const PORT = process.env.PORT || 8080;
const NodeEnv = process.env.PUBLIC_DOMAIN || "local";
app.listen(PORT, () => {
  console.log(`Base de datos entorno [${process.env.DATABASE_URL}] `);
  console.log(`Server [${NodeEnv}] is running on port ${PORT}.`);
});