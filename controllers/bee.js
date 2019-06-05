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

exports.update = function(req, res, next) {
	delete req.body.completeAddress;
	db.query('UPDATE bee SET ? WHERE id=?', [req.body, req.params.id], function(err, result) {
			if (err) {
					return res.send(500, {code: err.code});
			}
			return res.send(result);
	});
};

exports.photo = function(req, res, next) {
	// console.log(req.files);
	if (req.files.file0 === undefined) {
		res.send(400, {'error': true, 'message': 'Missing photo.'});
		return;
	}
	var regex = /(?:\.([^.]+))?$/;
	var ext = regex.exec(req.files.file0.path)[1]; 
	var filename = req.params.id + Math.round(new Date().getTime()/1000) + "." + ext;

	fs.copy(req.files.file0.path, INFOHIVE_STATIC_PATH + filename, function (e) {
		if (e) {

			res.send(400, {'error': true, 'message': e.err});
			return;
		}
		db.query('UPDATE bee SET imageUrl="' + INFOHIVE_STATIC_BUCKET + filename +'" WHERE id=' + req.params.id, function(err, result) {
			if (err) {
				return res.send(500, {code: err.code});
			}
			
			var query = "SELECT * FROM bee WHERE id=?";
 			console.log(query);
			db.query(query, function(err, rows) {
				console.log(rows);
				if (err) {
					return res.send(500, {code: err.code});
				}
				if (rows.length === 0) {
					return res.send(404, {error:true, message:'Bee not found.'});
				}
				res.send(rows[0]);
			});
		});
	});
};
