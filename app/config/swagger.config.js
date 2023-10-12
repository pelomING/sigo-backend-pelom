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
          name: "LogRocket",
          url: "https://logrocket.com",
          email: "info@email.com",
        },
      },
      servers: [
        {
          url: "http://localhost:8080/api/movil/v1/",
        },
      ],
    },
    apis: ["../routes/sae_movil.routes.js"],
  };

  module.exports = options;