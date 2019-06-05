var fs = require('fs-extra');
var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');

exports.selectByUser = function(req, res, next) {
	var query = "SELECT a.*";
	query += " " + "FROM `news` a";
	query += " " + "WHERE a.user_id='" + req.params.id +"' ORDER BY a.date DESC";
	db.query(query, function(err, rows) {
		if (err) {
			return res.send({code: err.code});
		}
		res.send(rows);
	});
};

exports.selectOne = function(req, res, next) {
	var query = "SELECT * FROM news WHERE id=?";
	dabar.executeProcedure(query, req.params.id)
	.then(result => {
		res.status(200).send({message: 'Successfully selected one news', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in news.selectOne', result: err})
	})
}

exports.selectALL = function(req, res, next) {
	var query = "SELECT a.*";
	query += " " + "FROM `news` a";
	query += " " + "ORDER BY a.date DESC";
	db.query(query, function(err, rows) {
		if (err) {
			return res.send({code: err.code});
		}
		res.send(rows);
	});
};

exports.insert = function(req, res, next) {
	// var category = req.body.category;
	// delete req.body.category;
	db.query('INSERT INTO news SET ?', req.body, function(err, result) {
		if (err) {
			return res.status(500).send({message: 'Database error while executing statement query node/db', result: err});
		}
		return res.status(200).send({message: 'Successfully posted news', result: result});
	});
};

exports.delete = function(req, res, next) {
	db.query('DELETE FROM news WHERE id=?', req.params.id, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.status(200).send({message: 'Succesfully deleted news', result: result});
	});
};

exports.selectNewsComments = function(req, res, next) {
	var query = "SELECT * from news_comment WHERE id=? ORDER BY DATE DESC";
	db.query(query, function(err, rows) {
		if (err) {
			return res.send({code: err.code});
		}
		res.send(rows);
	});
};

exports.insertNewsComment = function(req, res, next) {
	// var category = req.body.category;
	// delete req.body.category;
	db.query('INSERT INTO news_comment SET ?', req.body, function(err, result) {
		if (err) {
			return res.status(500).send({message: 'Database error while executing statement query node/db', result: err});
		}
		return res.status(200).send({message: 'Successfully posted news_comment', result: result});
	});
};

exports.deleteNewsComment = function(req, res, next) {
	db.query('DELETE FROM news_comment WHERE id=?', req.params.id, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.status(200).send({message: 'Succesfully deleted news_comment', result: result});
	});
};