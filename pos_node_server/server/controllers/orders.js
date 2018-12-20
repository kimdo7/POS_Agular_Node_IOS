var order = require("../models/order.js")

module.exports = {
    getOrder: function(req, res){
        let sql = `select * from pos.orderitems WHERE orderid = ${req.params.id} ALLOW FILTERING ;`
        order.toServer(sql, req, res)
    },

    history: function(req, res){
        let sql = `select * FROM  pos.orders WHERE ischeckedout = True ALLOW FILTERING ;`
        order.toServer(sql, req, res)
    }
}