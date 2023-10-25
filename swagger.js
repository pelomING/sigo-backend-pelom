const swaggerAutogen = require('swagger-autogen')();

let ruta_host = "";
let schema = [];
if (process.env.NODE_ENV === "production") {
  ruta_host = "backend-sae-postgres-production.up.railway.app";
  schema = ['https'];
}else if(process.env.NODE_ENV === "development"){
  ruta_host = "backend-sae-postgres-desarrollo.up.railway.app";
  schema = ['https'];
}else if(process.env.NODE_ENV === "local"){
  ruta_host = "localhost:8080";
  schema = ['http'];
}else{
  ruta_host = "localhost:8080";
  schema = ['http'];
}

const doc = {
  info: {
    title: 'API Obras',
    description: 'API de Obras',
    contact: {
      name: 'Tecnología y Negocios Pelom',
      url: 'https://www.pelom.cl',
      email: 'ti.pelom@pelom.cl',
    },
  },
  host: `${ruta_host}`,
  schemes: schema,
};

const outputFile = './swagger-output.json';
const endpointsFiles = ['./app/routes/auth.routes.js', './app/routes/mantenedor.routes.js', './app/routes/obras_backoffice.routes.js', 
'./app/routes/sae_movil.routes.js', './app/routes/sae_reportes.routes.js'];

/* NOTE: if you use the express Router, you must pass in the 
   'endpointsFiles' only the root file where the route starts,
   such as index.js, app.js, routes.js, ... */

   swaggerAutogen(outputFile, endpointsFiles, doc).then(() => {
    require('./server')           // Your project's root file
});