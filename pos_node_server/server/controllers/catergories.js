var catergory = require("../models/catergory.js")

module.exports = {
    getAll : function(req, res){
        let getAllCatergories = "SELECT * FROM pos.categories;"
        catergory.toServer(getAllCatergories, req, res)
    },
    
    add : function(req, res){
        let add = `INSERT INTO pos.categories  (id , name ) VALUES ( now(), '${req.body.name}');`
        catergory.add(add, req, res)
    },

    getItems: function(req, res){
        let allItems = 'SELECT * FROM pos.items;'
        catergory.toServer(allItems, req, res)
    },

    addItem: function(req, res){
        let addItem = `INSERT INTO pos.items (id , name , catergory , lrg , med ) VALUES ( now(), '${req.body.name}', '${req.body.category}', '${req.body.lrg}', '${req.body.med}');`
        let findItem = `SELECT * FROM pos.items WHERE name = '${req.body.name}' ALLOW FILTERING;`

        catergory.addItem(addItem, findItem, req, res)
    },

    getItem: function(req, res){
        let sql = `SELECT * FROM pos.items WHERE id = ${req.params.id};`
        catergory.toServer(sql, req, res)
    },

    updateItem: function(req, res){
        let sql = `UPDATE items SET catergory = '${req.body.category}', lrg='${req.body.lrg}', med='${req.body.med}' WHERE id = ${req.body.id} and name = '${req.body.name}';`
        catergory.toServer(sql, req, res)
    }

}