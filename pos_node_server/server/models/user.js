var cassandra = require('cassandra-driver')
var bcrypt = require('bcryptjs')
var client = new cassandra.Client({ contactPoints: ['127.0.0.1'] })

client.connect(function (err, result) {
    console.log("cassandra connected", err)
})

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

    /*******************************
     * Check if user not existed
     * then add
     * 
     * else respone error
     ********************/
    add: function (sql, req, res) {
        let searchSQL = `SELECT * FROM pos.users WHERE email = '${req.body.email}' ALLOW FILTERING;`;
        client.execute(searchSQL, [], function (err, result) {
            if (err) {
                res.json({ error: err })
            } else {

                if (result["rowLength"] == 0) {
                    client.execute(sql, [], function (err, result) {
                        if (err) {
                            res.json({ error: err })
                        } else {
                            res.json({ status: "success", msg: "user added" })
                        }
                    })
                } else {
                    res.json({ status: "error", msg: "user already existed" })
                }
            }
        })

    },


    logIn: function (sql, req, res) {
        client.execute(sql, [], function (err, result) {
            if (err) {
                res.json({ error: err })
            } else {
                if (result["rowLength"] == 0) {
                    res.json({ status: "error", msg: "user not existed" })
                } else {
                    bcrypt.compare(result["rows"][0]['password'], 'Helloworld123')
                        .then(x => {
                            res.json({ status: "success", data: result['rows'][0]})
                        })
                        .catch(error => {
                            res.json({ status: "error", msg: "Password not match" })

                        })
                }
            }
        })
    },

    


}