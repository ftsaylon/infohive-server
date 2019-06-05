var multiparty 	= require('connect-multiparty');
// Modules
var product = require('./../controllers/product'),
	category = require('./../controllers/category'),
	distributor = require('./../controllers/distributor'),
	contact = require('./../controllers/contact'),
	comment = require('./../controllers/comment'),
	auth = require('./../controllers/auth'),
	customer = require('./../controllers/customer'),
	cart = require('./../controllers/cart'),
	log = require('./../controllers/log'),
	farm = require('./../controllers/farm'),
	bee = require('./../controllers/bee'),
	news = require('./../controllers/news'),
	newscomment = require('./../controllers/newscomment');

var multipart = multiparty();

module.exports = function(router, logger) {
	// logs every request, for dev env only
	router.all('*', function (req, res, next) {
		logger.log('verbose', req.method);
		logger.log('verbose', req.params);
		logger.log('verbose', req.query);
		logger.log('verbose', req.body);
		next();
	});
	// product controller
	router.get('/product', product.select); 											//Done Test
	router.get('/product/search', product.select);										//Done Test
	router.get('/product/:id', product.selectOne);										//Done Test
	router.get('/category/count', category.countProducts);								//Done Test
	router.get('/distributor', distributor.select);										//Done Test
	router.get('/contact', contact.select);												//Done Test
	router.get('/category', category.select);											//Done Test
	router.get('/product/:id/comment', comment.selectByProduct);						//Done Test
	router.post('/customer', customer.insert);									//Exposed - Can insert users w/o validation from Facebook
	router.get('/customer/login/:mode/:email/:token', customer.login);//Exposed - Only email is needed to get key
	router.post('/cart/getEyes', cart.getEyes)

	//farm controller
	router.get('/farm', farm.selectALL);
	router.get('/farm/:id/products', farm.selectFarmProducts);
	router.get('/farm/:id', farm.selectOneOpen);
	//bee controller 
	router.get('/bee', bee.selectALL);
	router.get('/bee/:id', bee.selectOne);
	router.get('/farm/:id/bees', farm.selectFarmBees);
	
	// news routes
	router.get('/users/:id/news', news.selectByUser);
	router.get('/news', news.selectALL);
	router.get('/news/:id', news.selectOne);
	router.get('/news/:id/comment', newscomment.selectByNews);
	
	// authentication required for customer priveleges
	router.all('*', auth.validateUser)
	router.all("*",function(req,res,next){
		logger.log(`verbose`,"passed user validation");
		next();
	});
	
	router.delete('/comment/:id', comment.delete);//Exposed - No user validation
	router.delete('/newscomment/:id', newscomment.delete);//Exposed - No user validation
	
	// farm routes
	router.post('/farm', farm.selectOne);
	//bee routes
	//news routers
	router.post('/news/insert', news.insert);
	router.delete('/news/:id', news.delete);
	router.post('/news/:id/newscomment', newscomment.insert);	
	router.delete('/newscomment/:id', newscomment.delete);

	//bee routers
	router.delete('/bee/:id', bee.delete);
	router.post('/bee/insertbee', bee.insert);
	router.put('/bee/:id', bee.update);
	router.post('/bee/:id/photo', multipart, bee.photo);

	router.post('/product/:id/comment', comment.insert);	
	router.put('/cart/putproduct/', cart.putProduct);
	router.post('/cart/', cart.getProducts);
	router.put('/cart/incQuantity', cart.incQuantity)
	router.delete('/cart/remove', cart.removeProduct)
	router.post('/cart/orders', cart.getOrders)
	router.post('/cart/setForApproval', cart.setForApproval)
	router.delete('/comment/:id/', comment.delete);
	
	// authentication required for admin privelges
	router.all('*', auth.validateAdmin)
	router.post('/admin', auth.login)
	// product routes
	router.post('/product/records', product.selectALL)
	router.post('/product', product.insert);
	router.put('/product/changestocks', product.setStock)
	router.put('/product/:id', product.update);
	router.delete('/product/:id', product.delete);
	router.post('/product/:id/photo', multipart, product.photo);
	router.post('/sales', product.report)
	router.post('/sales/latest', product.latestTransaction);
	router.post('/sales/first', product.firstTransaction);
	// distributor routes
	router.post('/distributor', distributor.insert);
	router.put('/distributor/:id', distributor.update);
	router.delete('/distributor/:id', distributor.delete);
	// contact routes
	router.post('/contact', contact.insert);
	router.put('/contact/:id', contact.update);
	router.delete('/contact/:id', contact.delete);
	// category routes
	router.post('/category', category.insert);
	router.put('/category/:id', category.update);
	router.delete('/category/:id', category.delete);
	// user routes
	router.put('/user/setAdmin', customer.setAdmin);
	// cart routes
	router.post('/cart/forApprovals', cart.getForApprovals)
	router.post('/cart/approve/:id', cart.checkout)
	// log routes
	router.post('/logs/pricechange', log.getPriceChange);
	router.post('/logs/stockchange', log.getStockChange);
	// user routes
	router.post('/users', customer.select);
	router.delete('/users/:id', customer.delete);
	router.put('/users/:id', customer.setAdmin);
	// farm routes
	router.post('/farm/putproduct', farm.putProductToFarm);
	router.post('/farm/putbee', farm.putBeeToFarm);
	router.delete('/farm-product/:id', farm.deleteProductFromFarm);
	router.delete('/farm-bee/:id', farm.deleteBeeFromFarm);
	
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
