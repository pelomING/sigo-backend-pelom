const swaggerAutogen = require('swagger-autogen')();

let ruta_host = "";
let schema = [];
console.log('process.env.PUBLIC_DOMAIN', process.env.PUBLIC_DOMAIN);
if (process.env.PUBLIC_DOMAIN){
  ruta_host = process.env.PUBLIC_DOMAIN;
  schema = ['https'];
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
const endpointsFiles = [
  './app/routes/auth.routes.js', 
  './app/routes/mantenedor.routes.js', 
  './app/routes/obras_backoffice.routes.js',
  './app/routes/sae_movil.routes.js',
  './app/routes/sae_reportes.routes.js',
  './app/routes/sae_paneldecontrol.routes'
];

/* NOTE: if you use the express Router, you must pass in the 
   'endpointsFiles' only the root file where the route starts,
   such as index.js, app.js, routes.js, ... */

   swaggerAutogen(outputFile, endpointsFiles, doc).then(() => {
    require('./server')           // Your project's root file
});