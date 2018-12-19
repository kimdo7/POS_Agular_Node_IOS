var cassandra = require('cassandra-driver')
var client = new cassandra.Client({ contactPoints: ['127.0.0.1'] })

module.exports = {
    toServer: function (sql, req, res) {
        client.execute(sql, [], function (err, result) {
            if (err) {
                res.json({ error: err })
            } else {
                res.json({ data: result["rows"] })
            }
        })
    },

    add: function (sql, req, res) {
        let find_sql = `SELECT * FROM pos.categories WHERE name = '${req.body.name}' ALLOW FILTERING`
        client.execute(find_sql, [], function (err, result) {
            if (result.rowLength) {
                res.json({ status: 'Error', msg: 'Already existed' })

            } else {
                // this.toServer(sql, req, res)
                client.execute(sql, [], function (err, result) {
                    if (err) {
                        res.json({ status: 'Error', msg: err })
                    } else {
                        res.json({ status: 'Success', msg: 'Added' })
                    }
                })
            }
        })
    },

    addItem: function (sql, findSql, req, res) {
        client.execute(findSql, [], function (err, result) {
            if (result["rowLength"]) {
                res.json({ status: "Error", msg: "Item already existed" })
            } else {
                client.execute(sql, [], function (err, result) {
                    if (err) {
                        res.json({ status: "Error", msg: "Item Adding error", err: err })
                    } else {
                        res.json({ status: "Success", msg: "Item Added" })
                    }
                })
            }
        })
    },

    allTableStatus: function (sql) {
        print("****************HERE****************")
        client.execute(sql, [], function (err, result) {
            if (err) {
                return { error: err }
            } else {
                print("****************HERE****************")
                return { data: result["rows"] }
            }
        })
    }


}