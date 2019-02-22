var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql'),
    config = require('./../config/config'),
    crypto = require('./../helpers/cryptog')
    axios = require('axios'),
    dabar = require('./../db/procedures');

exports.validateUser = (req, res, next) => {
    new Promise( (resolve, reject) => {
       resolve(crypto.decrypt(JSON.parse(req.body.user_tag))) 
    })

    .then(result => {
        res.locals.user_id = result
        delete req.body.user_tag
        next()
    })

    .catch(err => {
        res.status(400).send({message: 'Error in assessing user_tag', result: err.message})
    })

}

exports.validateAdmin = (req, res, next) => {
    var fxn = dabar.procedures.isAdmin.call
    var params = res.locals.user_id;

    dabar.executeProcedure(fxn, params)

    .then(result => {
        return new Promise( (resolve, reject) => {
            if(result[0][0].is_admin){
                resolve(next())
            }
            reject({status: 401, message: 'Revoked access, you must be an admin to access these services', result: result})
        })
    })
    .catch(err => {
        // console.log(err)
        if(err.status){
            res.status(err.status).send(err)
        }
        else{
           res.status(500).send({message: 'Uncatched case in auth.validateAdmin', result: err.message})
        }
    })
}

exports.login = (req, res, next) => {
    res.status(200).send({message: 'Logged in as Admin', result: true})
}