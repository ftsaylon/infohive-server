var express = require('express'),
	config = require(__dirname + '/config/config'),
	logger = require(__dirname + '/lib/logger'),
	handlebars = require('express-handlebars'),
	db = require('./lib/mysql'),
	app = express();

logger.log('info', 'Initializing INFOHIVE RESTFul API. ENV = ', process.env['NODE_ENV']);

app.disable('x-powered-by');
app.use('/upload', express.static(__dirname + "/uploads/products"));

app.use(require(__dirname + '/lib/cors')('*'));

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended : false, uploadDir : config.media_dir}));
app.use(bodyParser.json());
app.use(require('morgan')('dev', {immediate : true}));
app.use(require('cookie-parser')(config.cookie_secret));
app.use(require('response-time')());
app.use(require('method-override')());


app.use(require(__dirname + '/config/router')(express.Router(), logger));

app.listen(config.port);
logger.log('info', 'Server listening on port : ', config.port);

module.exports = app;