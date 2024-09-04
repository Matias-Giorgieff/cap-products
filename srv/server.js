//Boostrap para agregar enchacement
// Boostrap - servidor de arranque
// Vamos a exponer una funcion que permite realizar peticiones GET al servidor de sap, peticiones que no tienen que ver con las entidades que tnemos definidas

const cds = require("@sap/cds");
const cors = require('cors');
const adapterProxy = require("@sap/cds-odata-v2-adapter-proxy");

cds.on("bootstrap", (app) => {
    app.use(adapterProxy());
    app.use(cors());

    app.get("/alive", (_, res) => {
        res.status(200).send("Server is Alive");
    });

    
});

module.exports = cds.server;