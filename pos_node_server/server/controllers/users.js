var user = require("../models/user.js")
var bcrypt = require('bcryptjs')

module.exports = {
    getAll: function(req, res){
        let getAllUser = "SELECT * FROM pos.users;"
        user.toServer(getAllUser, req, res)
    }, 

    getUsersOnTitle :function(req, res){
        var sql = ""
        if (req.params.title == 'admin'){
            sql = 'SELECT * FROM pos.users WHERE role = 1 ALLOW FILTERING;'
        }else if (req.params.title == 'employee'){
            sql = 'SELECT * FROM pos.users WHERE role = 5 ALLOW FILTERING;'
        }else if (req.params.title == 'customer'){
            sql = 'SELECT * FROM pos.users WHERE role = 9 ALLOW FILTERING;'
        } else{
            res.json({status:'error'})
            return
        }

        user.toServer(sql, req, res)
    },
    getById: function(req, res){
        let getUser = "SELECT * FROM pos.users WHERE id = ?;"
        user.toServer(getUser, req, res)
    },

    getByEmail: function(req, res){
        var getUser = `SELECT * FROM pos.users WHERE email = '${req.params.email}' ALLOW FILTERING;`
        user.toServer(getUser, req, res)
    },

    newUser : function(req, res){
        bcrypt.hash(req.body.password, 10)
        .then( hashed_password => {
            let insert = `INSERT INTO pos.users (id , email , first_name , last_name , phone_number , password , role ) VALUES ( now(), '${req.body.email}', '${req.body.first_name}', '${req.body.last_name}', '${req.body.phone}','${hashed_password}', 9);`
            user.add(insert, req, res)
        }).catch(error =>{
            res.json({ status: "error", msg: "Hashing errot" })
        })
    },

    logIn : function(req, res){
        var findUser = `SELECT * FROM pos.users WHERE email = '${req.body.email}' ALLOW FILTERING;`
        user.logIn(findUser, req, res)

    },

    changeAccess : function(req, res){
        var sql = ''

        if (req.params.title == 'admin'){
            sql = `UPDATE pos.users SET role = 1 WHERE id = ${req.params.id};` 
        }else if (req.params.title == 'employee'){
            sql = `UPDATE pos.users SET role = 5 WHERE id = ${req.params.id};` 
        }else if (req.params.title == 'customer'){
            sql = `UPDATE pos.users SET role = 9 WHERE id = ${req.params.id};` 
        }else{
            res.json({err:'error'})
            return
        }

        user.toServer(sql, req, res)

    },


    delete: function(req, res){
        let sql = `DELETE FROM pos.users WHERE id = ${req.params.id};`
        user.toServer(sql, req, res)
    }

}