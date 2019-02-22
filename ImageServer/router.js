var multiparty 	= require('connect-multiparty');

var multipart = multiparty();

module.exports = function(router) {
	// logs every request, for dev env only
    

    router.post('/upload', product.imageupload);


	router.all('*', function (req, res, next) {
		res.send(404, {message : 'Nothing to do here.'});
	});

	router.use(function (err, req, res, next) {
		logger.log('error', err.message || err);
		return next(err);
		// return res.send(err.code || 400, {Error : true, message : err.message || err});
	});


	return router;	
};
