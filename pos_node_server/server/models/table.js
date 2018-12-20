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
    toServerSocket: function (sql, req, res, io) {
        client.execute(sql, [], function (err, result) {
            if (err) {
                res.json({ status: "error" })
            } else {
                io.emit('status', { msg: 'reload' }); //3
                res.json({ status: "success" })
            }
        })
    },

    secretExecuse: function (sql) {
        client.execute(sql, [], function (err, result) {
            if (err) {
                console.log(err)
            } else {
            }
        })
    },
}
