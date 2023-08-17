const express = require("express");
const cors = require("cors");
const cookieSession = require("cookie-session");

const app = express();



app.use(
  cors({
    credentials: true,
    origin: ["http://localhost"],
  })
);

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

const db = require("./app/models");
const Role = db.role;

//se usa db.sequelize.sync({force: true}) para que reconstruya la base
db.sequelize.sync().then(() => {
  console.log('Drop and Resync Db');
  //y se llama a la funcion init() para que reconstruya la base
  //initial();
});

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

// simple route
app.get("/", (req, res) => {
  res.json({ message: "App de ejemplo Authentication" });
});

// routes
require('./app/routes/auth.routes')(app);
require('./app/routes/user.routes')(app);
require('./app/routes/movil.routes')(app);
require('./app/routes/mantenedor.routes')(app);

// set port, listen for requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server [${process.env.NODE_ENV}] is running on port ${PORT}.`);
});