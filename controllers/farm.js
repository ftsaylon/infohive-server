var fs = require('fs-extra');
var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');
var dabar = require('./../db/procedures');
var INFOHIVE_STATIC_BUCKET = "/img/";
var INFOHIVE_STATIC_PATH  = "./../dabar-infohub/img/";
var path = require('path');

exports.selectALL = function(req, res, next) {
	var query = "SELECT * FROM farm";
	dabar.executeProcedure(query)
	.then(result => {
		res.status(200).send(result)
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in farm.selectALL', result: err})
	})
};

exports.selectOne = function(req, res, next) {
	var query = "SELECT * FROM farm WHERE user_id=?";
	var params = res.locals.user_id;

	dabar.executeProcedure(query, params)
	.then(result => {
		var promises = []
		promises.push(dabar.executeProcedure(dabar.procedures.isForApproval.call, params))
		promises.push(result)
		return Promise.all(promises)
	})
	.then(result => {
		res.status(200).send({message: 'Successfully selected one farm', result: result[1][0]})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in farm.selectOne', result: err})
	})
}

exports.selectOneOpen = function(req, res, next) {
	var query = "SELECT * FROM farm WHERE id=?";
	dabar.executeProcedure(query, req.params.id)
	.then(result => {
		res.status(200).send({message: 'Successfully selected one farm', result: result[0]})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in farm.selectOneOpen', result: err})
	})
}

exports.putProductToFarm = function(req, res, next) {
	// var category = req.body.category;
	// delete req.body.category;
	db.query('INSERT INTO farm_product SET ?', req.body, function(err, result) {
		if (err) {
			return res.status(500).send({message: 'Database error while executing statement query node/db', result: err});
		}
		return res.status(200).send({message: 'Product is added to farm', result: result});
	});
};

exports.selectFarmProducts = function(req, res, next) {
	var query = "SELECT * FROM product WHERE id IN (SELECT product_id FROM farm_product WHERE farm_id=?)";
	dabar.executeProcedure(query, req.params.id)
	.then(result => {
		res.status(200).send({message: 'Successfully selected products from farm', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in selectFarmProducts', result: err})
	})
}

exports.selectFarmBees = function(req, res, next) {
	var query = "SELECT * FROM bee WHERE id IN (SELECT bee_id FROM farm_bee WHERE farm_id=?)";
	dabar.executeProcedure(query, req.params.id)
	.then(result => {
		res.status(200).send({message: 'Successfully selected bees from farm', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in selectFarmBees', result: err})
	})
}

exports.putBeeToFarm = function(req, res, next) {
	// var category = req.body.category;
	// delete req.body.category;
	db.query('INSERT INTO farm_bee SET ?', req.body, function(err, result) {
		if (err) {
			return res.status(500).send({message: 'Database error while executing statement query node/db', result: err});
		}
		return res.status(200).send({message: 'Bee is added to farm', result: result});
	});
};

exports.deleteBeeFromFarm = function(req, res, next) {
	db.query('DELETE FROM farm_bee WHERE bee_id=?', req.params.id, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.status(200).send({message: 'Succesfully deleted bee from farm', result: result});
	});
};


exports.deleteProductFromFarm = function(req, res, next) {
	db.query('DELETE FROM farm_product WHERE product_id=?', req.params.id, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.status(200).send({message: 'Succesfully deleted product from farm', result: result});
	});
};