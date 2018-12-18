// var players = require("../controllers/players.js")
var users = require("../controllers/users.js")
var catergories = require("../controllers/catergories.js")
var tables = require("../controllers/tables.js")
var path = require('path');
module.exports = function (app) {
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

    app.all("*", (req, res, next) => {
        res.sendFile(path.resolve("../posAngular/dist/posAngular/index.html"))
    });


}