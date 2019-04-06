var fs = require('fs-extra');
var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');
var dabar = require('./../db/procedures');
var INFOHIVE_STATIC_BUCKET = "/img/";
var INFOHIVE_STATIC_PATH  = "./../dabar-infohub/img/";
var path = require('path');


exports.insert = function(req, res, next) {
	// var category = req.body.category;
	// delete req.body.category;
	db.query('INSERT INTO bee SET ?', req.body, function(err, result) {
		if (err) {
			return res.status(500).send({message: 'Database error while executing statement query node/db', result: err});
		}
		return res.status(200).send({message: 'Successfully inserted bee', result: result});
	});

};

exports.selectALL = function(req, res, next) {
	var query = "SELECT * FROM bee";
	dabar.executeProcedure(query)
	.then(result => {
		res.status(200).send(result)
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in bee.selectALL', result: err})
	})
};

exports.selectOne = function(req, res, next) {
	var query = "SELECT * FROM bee WHERE id=?";
	dabar.executeProcedure(query, req.params.id)
	.then(result => {
		res.status(200).send({message: 'Successfully selected one bee', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in bee.selectOne', result: err})
	})
}

exports.delete = function(req, res, next) {
	db.query('DELETE FROM bee WHERE id=?', req.params.id, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.status(200).send({message: 'Succesfully deleted bee', result: result});
	});
};



