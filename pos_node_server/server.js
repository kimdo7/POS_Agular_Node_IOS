var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
var socketserver = require('http').createServer();
const io = require('socket.io')(socketserver);
// table = require("./server/models/table.js")

var app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, './static')));
app.use(express.static('../posAngular/dist/posAngular/'));

io.on('connection', function (socket) { //2

    console.log ("connected: " + socket.id); // print to console the incoming socket ID

    socket.emit('status', { msg: '' }); //3
    socket.on('thankyou', function (data) { //7
        console.log(data); //8 (note: this log will be on your server's terminal)
    });

    // let allTable_SQL = "SELECT * FROM pos.tables;"
    // var tables_json = table.allTable_SQL(allTable_SQL)
    
    // socket.emit("loadTables", {tables: "hello"})

});

require("./server/config/routes.js")(app, io)

socketserver.listen(8080, '192.168.0.51', function () {
    console.log("*SOCKET* listening on 192.168.0.51 port 8080");
})

app.listen(8000, '192.168.0.51', function () {
    console.log("listening on 192.168.0.51 port 8000");
})