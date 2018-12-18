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
    }
}
