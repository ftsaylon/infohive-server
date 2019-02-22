var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');


exports.countProducts = function(req, res, next) {
	var query = "SELECT c.id as id, c.title as category, COUNT(p.name) as count from category c, product p where p.category_id = c.id group by p.category_id ORDER BY c.title;";
	db.query(query, function(err, rows) {
		if (err) {
			return res.send({code: err.code});
		}
		res.send(rows);
	});
};

exports.select = function(req, res, next) {
	var query = "SELECT id, title as category FROM category WHERE deleted=0 ORDER BY title;";
	db.query(query, function(err, rows) {
		if (err) {
			return res.send({code: err.code});
		}
		res.send(rows);
	});
};

exports.insert = function(req, res, next) {
	db.query('INSERT INTO category SET ?', req.body, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.send(result);
	});
};

exports.update = function(req, res, next) {
	db.query('UPDATE category SET ? WHERE id=?', [req.body, req.params.id], function(err, result) {
		if (err) {
				return res.send(500, {code: err.code});
		}
		return res.send(result);
	});
};

exports.delete = function(req, res, next) {
	var fxn = 'UPDATE category SET deleted=1 WHERE id=?'
	var params = req.params.id 
	dabar.executeProcedure(fxn, params)
	.then(result => {
		res.status(200).send({message: 'Successfully deleted category', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in category.delete', result: err})
	})
};