var table = require("../models/table.js")

module.exports = {
    getAll: function (req, res) {
        let getAllCatergories = "SELECT * FROM pos.tables;"
        table.toServer(getAllCatergories, req, res)
    },
}