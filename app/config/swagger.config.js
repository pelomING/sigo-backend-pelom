const options = {
    definition: {
      openapi: "3.0.0",
      info: {
        title: "API sistema SAE",
        version: "0.1.0",
        description:
          "Descripción de las APIs para el sistema SAE.",
        license: {
          name: "MIT",
          url: "https://spdx.org/licenses/MIT.html",
        },
        contact: {
          name: "Tecnología y Negocios Pelom",
          url: "https://www.pelom.cl",
          email: "ti.pelom@pelom.cl",
        },
      },
      servers: [
        {
          url: "http://localhost:8080/",
        },
      ],
    },
    basePath: "/",
    apis: ["../../server.js"],
  };

  module.exports = options;