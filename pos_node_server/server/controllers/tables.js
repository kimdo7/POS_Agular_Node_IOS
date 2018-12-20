var table = require("../models/table.js")

module.exports = {
    getAll: function (req, res) {
        let getAllCatergories = "SELECT * FROM pos.tables;"
        table.toServer(getAllCatergories, req, res)
    },

    clean: function(req, res, io){
        var object = Object.keys(req.body)[0]
        object = JSON.parse(object);
        var table_id = object["table_id"]
        var order_id = object["order_id"]
        var total = object["total"]

        let updateTableSQL = `UPDATE pos.tables SET status = 0, current_order_id = null  WHERE id = ${table_id};`
        let updateOrders = ` UPDATE pos.orders SET ischeckedout = True, total = ${total} WHERE id = ${order_id};`

        table.toServerSocket(updateTableSQL, req, res, io)
        
        table.secretExecuse(updateOrders)
    },
}