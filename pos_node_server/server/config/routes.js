// var players = require("../controllers/players.js")
var users = require("../controllers/users.js")
var catergories = require("../controllers/catergories.js")
var tables = require("../controllers/tables.js")
var orders = require("../controllers/orders.js")
var path = require('path');
var cassandra = require('cassandra-driver')
var client = new cassandra.Client({ contactPoints: ['127.0.0.1'] })


module.exports = function (app, io) {
    app.get("/users", function (req, res) {
        users.getAll(req, res)
    })

    app.get("/users/:title", function (req, res) {
        users.getUsersOnTitle(req, res)
    })

    app.get("/users/id/:id", function (req, res) {
        users.getById(req, res)
    })
    app.get("/users/email/:email", function (req, res) {
        users.getByEmail(req, res)
    })

    app.post("/user", function (req, res) {
        users.newUser(req, res)
    })

    app.delete("/user/:id", function (req, res) {
        users.delete(req, res)
    })

    app.post("/logIn", function (req, res) {
        users.logIn(req, res)
    })

    //*****************ACCESS******************************** */
    app.put("/access/:title/:id", function (req, res) {
        users.changeAccess(req, res)
    })


    //*******************ITEMS******************************* */
    app.get("/categories", function (req, res) {
        catergories.getAll(req, res)
    })

    app.post("/category", function (req, res) {
        catergories.add(req, res)
    })

    //************************************************** */
    app.get('/item/:id', function (req, res) {
        catergories.getItem(req, res)
    })

    app.get("/items", function (req, res) {
        catergories.getItems(req, res)
    })

    app.post('/item', function (req, res) {
        catergories.addItem(req, res)
    })

    app.put('/item', function (req, res) {
        catergories.updateItem(req, res)
    })


    //*******************TABLES******************************* */
    app.get('/tables', function (req, res) {
        tables.getAll(req, res)
    })
    app.post('/table', function (req, res) {
        var object = Object.keys(req.body)[0]
        object = JSON.parse(object);
        var table_id = object["table_id"]

        let updateTable_SQL = `UPDATE pos.tables SET status = 1 WHERE id = ${table_id};`
        let createOrder = `INSERT INTO pos.orders (id, tableid, ischeckedout, total ) VALUES ( now(), ${table_id}, false, 0);`

        client.execute(updateTable_SQL, [], function (err, result) {
            if (err) {
                res.json({ error: err })
            } else {
                client.execute(createOrder, [], function (err, result) {
                    if (err) {
                        res.json({ error: err })
                    } else {
                        let searchSQL = `SELECT * FROM pos.orders WHERE tableid = ${table_id} and ischeckedout = false ALLOW FILTERING ;`
                        client.execute(searchSQL, [], function (err, result) {
                            if (err) {
                                console.log(err)
                                res.json({ error: err })
                            } else {
                                let order_id = result["rows"][0].id
                                let addOrderItem = `INSERT INTO pos.orderitems (id, orderid, itemid , name, price, quanity , size) 
                                                        VALUES ( now(),  ${order_id}, ${object["order"]["item_id"]}, 
                                                        '${object["order"]["name"]}', ${object["order"]["price"]}, ${object["order"]["quanity"]}, '${object["order"]["size"]}');`
                                client.execute(addOrderItem, [], function (err, result) {
                                    if (err) {
                                        console.log(err)
                                        res.json({ error: err })
                                    } else {
                                        res.json({ status: 'success', msg: 'new order created' })
                                    }
                                })

                                let updateTable = `UPDATE pos.tables SET current_order_id = ${order_id} WHERE id = ${table_id};`
                                client.execute(updateTable, [], function (err, result) {
                                    if (err) {
                                        console.log(err)
                                    } else {
                                        io.emit('status', { msg: 'reload' }); //3
                                        console.log("Update Success")
                                    }
                                })



                            }
                        })
                    }
                })
            }
        })



        // res.json({ status: "error" })
    })

    app.post("/table/update", function (req, res) {
        var object = Object.keys(req.body)[0]
        object = JSON.parse(object);
        var table_id = object["table_id"]

        let findSql = `SELECT * FROM pos.orderitems WHERE orderid = ${object["order_id"]} AND itemid = ${object["order"]["item_id"]} and size= '${object["order"]["size"]}' ALLOW FILTERING ;`
        client.execute(findSql, [], function (err, result) {
            if (err) {
                console.log(err)
                res.json({ error: err })
            } else {
                if (result["rowLength"] == 1) {
                    let orderItemId = result["rows"][0].id
                    if (object["order"]["quanity"] > 0) {s
                        let updateSQL = `UPDATE pos.orderitems SET quanity = ${object["order"]["quanity"]} WHERE id = ${orderItemId};`
                        client.execute(updateSQL, [], function (err, result) {
                            if (err) {
                                console.log(err)
                                res.json({ error: err })
                            } else {
                                io.emit('status', { msg: 'reload' }); //3
                                res.json({ status: 'success', msg: 'updated' })
                            }
                        })
                    } else {
                        let deleteSql = `DELETE FROM pos.orderitems WHERE id = ${orderItemId};`
                        client.execute(deleteSql, [], function (err, result) {
                            if (err) {
                                console.log(err)
                                res.json({ error: err })
                            } else {
                                io.emit('status', { msg: 'reload' }); //3
                                res.json({ status: 'success', msg: 'updated' })
                            }
                        })

                        let checkTable = `SELECT * FROM pos.orderitems WHERE orderid = ${object["order_id"]} ALLOW FILTERING ;`
                        client.execute(checkTable, [], function (err, result) {
                            if (err) {
                                console.log(err)
                                res.json({ error: err })
                            } else {
                                if (result["rowLength"] == 0) {
                                    let clearTableSql = `UPDATE pos.tables SET status = 0, current_order_id = null WHERE id = ${object["table_id"]};`
                                    let deleteOrderSQL = ` DELETE FROM pos.orders WHERE id = ${object["order_id"]};`
                                    client.execute(clearTableSql, [], function (err, result) {
                                        if (err) {
                                            console.log(err)
                                        }
                                    })
                                    client.execute(deleteOrderSQL, [], function (err, result) {
                                        if (err) {
                                            console.log(err)
                                        }
                                    })
                                    io.emit('status', { msg: 'reload' }); //3
                                }
                                // res.json({ status: 'success', msg: 'updated' })
                            }
                        })




                    }

                    // console.log(orderItemId)
                } else {
                    let addOrderItem = `INSERT INTO pos.orderitems (id, orderid, itemid , name, price, quanity , size) 
                                                        VALUES ( now(),  ${object["order_id"]}, ${object["order"]["item_id"]}, 
                                                        '${object["order"]["name"]}', ${object["order"]["price"]}, ${object["order"]["quanity"]}, '${object["order"]["size"]}');`
                    client.execute(addOrderItem, [], function (err, result) {
                        if (err) {
                            console.log(err)
                            res.json({ error: err })
                        } else {
                            res.json({ status: 'success', msg: 'new order created' })
                        }
                    })
                }
                // res.json({ error: err })
            }
        })
        // res.json({status:"error"})
    })

    app.post("/table/clean", function (req, res) {
        tables.clean(req, res, io)
    })

    //*******************GET HISTOERY******************************* */
    app.get("/history", function(req, res){
        orders.history(req, res)
    })

    app.get("/order/:id", function (req, res) {
        orders.getOrder(req, res)
    })
    app.all("*", (req, res, next) => {
        res.sendFile(path.resolve("../posAngular/dist/posAngular/index.html"))
    });


}