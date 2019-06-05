var fs = require('fs-extra');
var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');

exports.selectByNews = function(req, res, next) {
	var query = "SELECT a.*";
	query += " " + "FROM `news_comment` a";
	query += " " + "WHERE a.news_id='" + req.params.id +"' ORDER BY a.date DESC";
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
	req.body.news_id = req.params.id
	db.query('INSERT INTO news_comment SET ?', req.body, function(err, result) {
		if (err) {
			return res.status(500).send({message: 'Database error while executing statement query node/db', result: err});
		}
		return res.status(200).send({message: 'Successfully posted comment', result: result});
	});
};

exports.delete = function(req, res, next) {
	db.query('DELETE FROM news_comment WHERE id=?', req.params.id, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.status(200).send({message: 'Succesfully deleted comment', result: result});
	});
};