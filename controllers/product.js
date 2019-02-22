var fs = require('fs-extra');
var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');
var dabar = require('./../db/procedures');
var INFOHIVE_STATIC_BUCKET = "/img/";
var INFOHIVE_STATIC_PATH  = "./../dabar-infohub/img/";
var path = require('path');



exports.select = function(req, res, next) {
	var query = "SELECT a.*,";
	query += " " + "d.title AS category,";
	query += " " + "b.name AS distributorName,";
	query += " " + "c.name AS contactName";
	query += " " + "FROM product a, distributor b, contact c, category d";
	query += " " + "WHERE a.distributorId=b.id AND a.contactId=c.id AND d.id = a.category_id AND a.deleted=0";
	query += " " + (req.query.searchKey ? "AND a.name LIKE '%"+req.query.searchKey+"%'" : "");
	query += " " + "ORDER BY a.name";
	dabar.executeProcedure(query)
	.then(result => {
		res.status(200).send(result)
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in product.select', result: err})
	})
};

exports.selectOne = function(req, res, next) {
	var query = "SELECT a.*,";
	query += " " + "b.name AS distributorName,";
	query += " " + "CONCAT_WS(', ', b.address, b.city, b.province, b.zipcode) AS distributorAddress,";
	query += " " + "b.phone AS distributorPhone,";
	query += " " + "b.webUrl AS distributorWebUrl,";
	query += " " + "c.name AS contactName,"
	query += " " + "CONCAT_WS(', ', c.address, c.city, c.province, c.zipcode) AS contactAddress,";
	query += " " + "c.phone AS contactPhone,";
	query += " " + "c.webUrl AS contactWebUrl,";
	query += " " + "d.title AS category";
	query += " " + "FROM product a, distributor b, contact c, category d";
	query += " " + "WHERE a.deleted=0 AND a.distributorId=b.id AND a.contactId=c.id AND d.id=a.category_id AND a.id=?";
	dabar.executeProcedure(query, req.params.id)
	.then(result => {
		res.status(200).send({message: 'Successfully selected one product', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in product.selectOne', result: err})
	})
};

exports.selectALL = function(req, res, next) {
	var query = 'SELECT id, name FROM product'
	dabar.executeProcedure(query)
	.then(result => {
		res.status(200).send(result)
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send(err)
	})
}


exports.insert = async function(req, res, next) {

	console.log(req.file);
	// res.send(req.file);
	db.query('call dabar_product_insertOne (?,?,?,?,?,?,?,?,?,?)', 
		[req.body.category_id,
		req.body.name,
		req.body.description,
		req.body.distributorId,
		req.body.contactId,
		req.body.price,
		req.body.stock,
		req.body.size,
		req.body.imageUrl,
		req.body.siteUrl
		], function(err, result) {
		if (err) {
			console.log(err)
			return res.send(500, {result: err});
		}
		res.send(result);		
	});
};


exports.update = function(req, res, next) {
	var fxn = dabar.procedures.updateProduct.call
	var params = [req.body.category_id,
		req.body.name,
		req.body.description,
		req.body.distributorId,
		req.body.contactId,
		req.body.price,
		req.body.size,
		req.body.imageUrl,
		req.body.siteUrl,			
		req.params.id]
	dabar.executeProcedure(fxn, params)
	.then(result => {
		res.status(200).send({message: 'Successfully updated product', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in product.update', result: err})
	})
};



exports.delete = function(req, res, next) {
	var fxn = 'UPDATE product SET deleted=1 WHERE id=?'
	var params = req.params.id 
	dabar.executeProcedure(fxn, params)
	.then(result => {
		res.status(200).send({message: 'Successfully deleted product', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in product.delete', result: err})
	})
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
		db.query('UPDATE product SET imageUrl="' + INFOHIVE_STATIC_BUCKET + filename +'" WHERE id=' + req.params.id, function(err, result) {
			if (err) {
				return res.send(500, {code: err.code});
			}
			var query = "SELECT a.*,";
			query += " " + "b.name AS distributorName,";
			query += " " + "CONCAT_WS(', ', b.address, b.city, b.province, b.zipcode) AS distributorAddress,";
			query += " " + "b.phone AS distributorPhone,";
			query += " " + "b.webUrl AS distributorWebUrl,";
			query += " " + "c.name AS contactName,"
			query += " " + "CONCAT_WS(', ', c.address, c.city, c.province, c.zipcode) AS contactAddress,";
			query += " " + "c.phone AS contactPhone,";
			query += " " + "c.webUrl AS contactWebUrl,";
			query += " " + "d.category AS category";
			query += " " + "FROM product a, distributor b, contact c, category d";
			query += " " + "WHERE a.distributorId=b.id AND a.contactId=c.id AND d.productId=a.id AND a.id=" + req.params.id;
			query += " " + "ORDER BY a.name";
 			console.log(query);
			db.query(query, function(err, rows) {
				console.log(rows);
				if (err) {
					return res.send(500, {code: err.code});
				}
				if (rows.length === 0) {
					return res.send(404, {error:true, message:'Product not found.'});
				}
				res.send(rows[0]);
			});
		});
	});
};



exports.report = function(req, res){
	var fxn = dabar.procedures.reportSales.call;
	var params = [req.body.start_date, req.body.end_date];

	dabar.executeProcedure(fxn, params)

	.then(result => {
		res.status(200).send({message: 'Successfully generated report', result: result})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}
		res.status(500).send({message: 'Uncatched case in product.report', result: err.message})
	})
}

exports.setStock = function(req, res, next){
	var fxn = dabar.procedures.setStock.call;
	var params = [req.body.product_id, req.body.newstocks]

	dabar.executeProcedure("SELECT stock FROM product WHERE id=?", params[0])

	.then(result => {
		var oldStock = result[0].stock;
		var stockChange = params[1] - oldStock
		return dabar.executeProcedure(fxn, [parseInt(params[0]), parseInt(params[1]), stockChange])
	})
	.then(result => {
		res.status(200).send({message: 'Successfully set stocks', result: result})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}else{
			res.status(500).send({message: 'Uncatched case in product.setStock', result: err.message})
		}
	})
}

exports.firstTransaction = function(req, res){
	var fxn = dabar.procedures.getFirstTransaction.call;

	dabar.executeProcedure(fxn)

	.then(result => {
		res.status(200).send({ message: "Successfully got first transaction", result: result })
	}).catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}else{
			res.status(500).send({ message: "Uncatched case in product.firstTransaction", result: err.message })
		}
	})
}

exports.latestTransaction = function(req, res){
	var fxn = dabar.procedures.getLatestTransaction.call;

	dabar.executeProcedure(fxn)

	.then(result => {
		res.status(200).send({ message: "Successfully got latest transaction", result: result })
	}).catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}else{
			res.status(500).send({ message: "Uncatched case in product.latestTransaction", result: err.message })
		}
	})
}


