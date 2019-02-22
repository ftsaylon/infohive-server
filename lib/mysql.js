var mysql = require('mysql'),
	config = require(__dirname + '/../config/config').db,
	db = mysql.createConnection({
		host     : config.host,
		user     : config.user,
		password : config.pass,
		database : config.name
});

db.connect(err => {
	if (err) {
		console.log("Error connecting to database");
		console.log(err);
	}
})

module.exports = db;