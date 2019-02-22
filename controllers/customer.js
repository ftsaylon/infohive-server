var db = require(__dirname + '/../lib/mysql');
var logger = require('./../lib/logger')
var config = require(__dirname + '/../config/config');
var axios = require('axios');
var crypto = require('./../helpers/cryptog');
var dabar = require('./../db/procedures');

exports.insert = function(req, res, next) {
	var fxn = dabar.procedures.insertUser.call;
	var params = [req.body.email];

	new Promise( (resolve, reject) => {
		db.query(fxn, params, function(err, result) {
			if (err && err.code === "ER_DUP_ENTRY") {
				reject({status: 400, message: "Email already has an account", result: err.code})
			}
			if (err) {
				reject({status: 500, message: `Database error in dabar procedures: ${fxn}`, result: err.code})
			}
			resolve(result)
		})
	})

	.then((result) => {
		res.status(200).send({message: 'Successfully created user', result: result})
	})
	
	.catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}
		else{
			res.status(500).send({message: 'Uncatched case in customer.insert', result: err.message})
		}
	})
}


exports.login = function(req, res, next) {
	var fxn = dabar.procedures.getUserId.call;
	var params = [req.params.token, req.params.email, req.params.mode];
	var validatorLink = ''
	if(params[2] === 'facebook'){
		var fbAccessToken = '2212776085617671|vKILJ7DeE5CvcxSe9jlQzjnDUGQ'
		validatorLink = `https://graph.facebook.com/debug_token?input_token=${params[0]}&access_token=${fbAccessToken}`
	}
	else{
		validatorLink = `https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=${params[0]}`
	}
	new Promise( (resolve, reject) => {
		axios.get(validatorLink)
		.then(result => {
			if(params[2] === 'facebook' && result.data.data.is_valid === true){
				resolve(true)
			}
			else if(params[2] === 'googleplus' && result.status === 200){
				resolve(true)
			}
			reject({status: 400, message: 'Access token invalid'})
		})
		.catch(err => {
			logger.log('error', err)
		})
	})

	.then(next => {
		var promiser = {resolve: null, reject: null};
		return dabar.executeProcedure(fxn, params[1], function(err, result){
			if(err){
				promiser.reject({status: 500, message: `Database error in dabar procedures: ${fxn}`, result: err})
			}
			else if(result[0].length === 0){
				promiser.reject({status: 404, message: "Email not found, sign up first", result: result})
			}
			else{
				// console.log(promiser)
				promiser.resolve(result[0][0].id)
			}
		}, promiser)
	})

	.then(userId => {
		// console.log(userId)
		res.status(200).send({message: `Successfully logged in with ${params[2]}`, result: crypto.encrypt(JSON.stringify(userId))})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}
		else{
			res.status(500).send({message: 'Uncatched case in customer.getId', result: err})
		}
	})

}

exports.setAdmin = function(req, res, next) {
	var fxn = dabar.procedures.setAdmin.call;
	var params = [req.params.id, req.body.privileges];

	dabar.executeProcedure(fxn, params)

	.then(result => {
		res.status(200).send({message: 'Successfully set privileges', result: result})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}
		else{
			res.status(500).send({message: 'Uncatched case in customer.setAdmin', result: err.message})
		}	
	})
}

exports.select = function(req, res, next) {
	var query = "SELECT * FROM user;"
	db.query(query, function(err, rows) {
		if (err) {
			return res.status(500).send({code: err.code});
		}
		res.status(200).send(rows);
	});
};

exports.delete = function(req, res, next) {
	var fxn = 'DELETE FROM user WHERE id=?'
	var params = req.params.id;
	
	dabar.executeProcedure(fxn, params)
	.then(result => {
		res.status(200).send({message: 'Successfully deleted user', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in user.delete', result: err})
	})
};
