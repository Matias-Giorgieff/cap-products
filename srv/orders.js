//const { log } = require("@sap/cds");
const { log } = require("@sap/cds");
const { serve } = require("@sap/cds");
const cds = require("@sap/cds");
const { Orders } = cds.entities("com.training");


module.exports = (srv) => {
    //****************Read****************//
    srv.on("READ", "Orders", async (req) => {

        if (req.data.ClientEmail !== undefined) {
            //return await SELECT.from`com.training.Orders`.where`ClientEmail = ${req.data.ClientEmail}`;
            return await SELECT.from`${Orders}`.where`ClientEmail = ${req.data.ClientEmail}`;
        }

        return await SELECT.from(Orders);
    });
    // Esto va a cambiar el dato de Reviewed a true, pero es solo lo que muestra, a nivel de BDD no lo actualiza
    // Esto se ejecuta despues del GET y justo antes de mostrar el Odata
    srv.after("READ", "Orders", (data) => {
        return data.map((order) => (order.Reviewed = true));
    });


    //****************Create****************//
    //POST
    srv.on("CREATE", "Orders", async (req) => {

        let returnData = await cds
            .transaction(req)
            .run(
                INSERT.into(Orders).entries({
                    ClientEmail: req.data.ClientEmail,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    CreatedOn: req.data.CreatedOn,
                    Reviewed: req.data.Reviewed,
                    Aprroved: req.data.Aprroved
                })
            ).then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (typeof resolve !== "undefined") {
                    return req.data;
                } else {
                    req.error(409, "Record not Inserted");
                }
            })
            .catch((err) => {
                console.log("Error", err);
                req.error(err.code, err.message);
            });
        console.log("Before End", returnData);
        return returnData;
    });

    // Se ejecuta justo antes de la creacion
    srv.before("CREATE", "Orders", (req) => {
        req.data.CreatedOn = new Date().toISOString().slice(0, 10);
        return req;
    });

    //****************Updae****************//
    //PUT
    srv.on("Update", "Orders", async (req) => {
        let returnData = await cds.transaction(req).run(
            [
                UPDATE(Orders, req.ClientEmail).set({
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                }) //{ key1 : val1, key2 : val3})
            ]
        ).then((resolve, reject) => {
            console.log("Resolve:", resolve);
            console.log("Reject:", reject);

            if (resolve[0] == 0) {
                req.error("409", "Record Not Found");
            }

        }).catch((err) => {
            console.log(err);
            req.error(err.code, err.message);
        });
        console.log("Before End", returnData);
        return returnData;
    });
    //****************Delete****************//
    srv.on("DELETE", "Orders", async (req) => {
        let returnData = await cds.transaction(req).run(
            DELETE.from(Orders).where({
                ClientEmail: req.data.ClientEmail,
            })
        ).then((resolve, reject) => {
            console.log("Resolve:", resolve);
            console.log("Reject:", reject);

            if (resolve !== 1) {
                req.error(409, "Record Not Found");
            }

        }).catch((err) => {
            console.log(err);
            req.error(err.code, err.message);
        });
        console.log("Before End", returnData);

        return await returnData;
    });
    //****************FUNCTION****************//
    srv.on("getClientTaxRate", async req => {
        //No server side-effect
        //destructure
        const { ClientEmail } = req.data;
        const db = srv.transaction(req);
        console.log('bien');
        const result = await db
            .read(Orders)
            .where({ ClientEmail: ClientEmail });

        console.log(result[0]);

        switch (result[0].Country_code) {
            case 'ES':
                console.log("seeee");
                return 21.5;
            case 'UK':
                return 24.7;
            default:
                break;
        }

    });
}