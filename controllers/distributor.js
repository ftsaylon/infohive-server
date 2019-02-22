var	logger = require(__dirname + '/../lib/logger'),
    db = require(__dirname + '/../lib/mysql');
    dabar = require('./../db/procedures');


exports.select = function(req, res, next) {
	var query = "SELECT id, name, address, city, province, zipcode,";
	query += " " + "CONCAT_WS(', ', address, city, province, zipcode) AS completeAddress,";
	query += " " + "phone AS phone,";
	query += " " + "webUrl AS webUrl";
	query += " " + "FROM distributor";
	query += " " + "WHERE deleted=0";
	query += " " + "ORDER BY name";
	db.query(query, function(err, rows) {
		if (err) {
			return res.send({code: err.code});
		}
		res.send(rows);
	});
};


exports.insert = function(req, res, next) {
	db.query('INSERT INTO distributor SET ?', req.body, function(err, result) {
		if (err) {
			return res.send(500, {code: err.code});
		}
		return res.send(result);
	});
};

exports.update = function(req, res, next) {
	delete req.body.completeAddress;
        db.query('UPDATE distributor SET ? WHERE id=?', [req.body, req.params.id], function(err, result) {
                if (err) {
                        return res.status(500).send({message: 'Database error in updating distributor', result: err});
                }
                return res.send(result);
        });
};


exports.delete = function(req, res, next) {
	var fxn = dabar.procedures.deleteDistributor.call
	var params = req.params.id 
	dabar.executeProcedure(fxn, params)
	.then(result => {
		res.status(200).send({message: 'Successfully deleted distributor', result: result})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send(err)
		}
		return res.status(500).send({message: 'Uncatched case in distributor.delete', result: err})
	})
};
