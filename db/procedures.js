var db = require(__dirname + '/../lib/mysql');
var logger = require('./../lib/logger')

exports.executeProcedure = (call, params, callback, promiser) => {
	logger.log('silly', 'querry: ' + call)
	logger.log('silly', 'params: ' + params)
	return new Promise( (resolve, reject) => {
		if(callback){
			promiser.resolve=resolve
			promiser.reject=reject
			db.query(call, params, callback)
		}
		else{
			db.query(call, params, function(err, result){
				if(err){
					reject({status: 500, message: `Database error in dabar procedures: ${call}`, result: err})
				}
				else{
					resolve(result);
				}
			})
		}
	})
}

exports.procedures = {
	insertUser: {
		call: 'CALL dabar_user_insertOne(?)',
		params: 'gemail VARCHAR(256)'
	},
	getUserId: {
		call: 'CALL dabar_user_getId(?)',
		params: 'gemail VARCHAR(256)'
	},
	getCartId: {
		call: 'CALL dabar_cart_getId(?, ?)',
		params: 'guser_id INT(11), OUT cartId INT(11)'
	},
	updateCartTotal: {
		call: 'CALL dabar_cart_updateTotal(?)',
		params: 'gcart_id INT(11)'
	},
	putCartProduct: {
		call: 'CALL dabar_cart_putProductToCart(?, ?, ?)',
		params: 'guser_id INT(11), gproduct_id INT(11), gquantity INT(24)'
	},
	checkoutCart: {
		call: 'CALL dabar_cart_checkout(?)',
		params: 'guser_id INT(11)'
	},
	stockCheck: {
		call: 'CALL dabar_cart_isEnough(?)',
		params: 'guser_id INT(11)'
	},
	buyProduct: {
		call: 'CALL dabar_cart_buyProduct(?, ?)',
		params: 'guser_id INT(11), gproduct_id INT(11)'
	},
	showCartProducts: {
		call: 'CALL dabar_cart_showProducts(?)',
		params: 'guser_id INT(11)'
	},
	incCartProductQuantity: {
		call: 'CALL dabar_cart_incQuantity(?, ?, ?)',
		params: 'guser_id INT(11), gproduct_id INT(11), gincrease INT(24)'
	},
	deleteCartProduct: {
		call: 'CALL dabar_cart_delProduct(?, ?)',
		params:	'guser_id INT(11), gproduct_id INT(11)'
	},
	reportSales: {
		call: 'CALL salesreport(?, ?)',
		params: 'gstart DATE(YYYY-MM-DD), gend DATE(YYYY-MM-DD)'
	},
	priceChangeLog: {
		call: 'CALL dabar_pricechange_insertOne(?, ?)',
		params: 'gproduct_id INT(11), gprice FLOAT'
	},
	isAdmin: {
		call: 'CALL dabar_user_isAdmin(?)',
		params: 'guser_id INT(11)'
	},
	setAdmin: {
		call: 'CALL dabar_user_setAdmin(?, ?)',
		params: 'guser_id INT(11), gprivileges TINYINT(1)'
	},
	setStock: {
		call: 'CALL dabar_product_setStock(?, ?, ?)',
		params: 'gproduct_id INT(11), newstocks INT(10), stockschange INT(10)'
	},
	getFirstTransaction: {
		call: 'CALL get_first_transaction'
	},
	getLatestTransaction: {
		call: 'CALL get_latest_transaction'
	},
	getOrders: {
		call: 'CALL dabar_cart_getOrders(?)',
		params: 'guser_id INT(11)'
	},
	selectCartForOrder: {
		call: 'CALL dabar_cart_selectOne(?)',
		params: 'gcart_id INT(11)'
	},
	updateProduct: {
		call: 'CALL dabar_product_updateOne(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
		params: 'category_insert int(11), name_insert varchar(256), description_insert text, distributorId_insert int(11), contactId_insert int(11), price_insert float, stock_insert int(10), size_insert varchar(128), imageUrl_insert varchar(1024), siteUrl_insert varchar(1024)'
	},
	insertProduct: {
		call: 'CALL dabar_product_insertOne(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
		params: 'category_insert int(11), name_insert varchar(256), description_insert text, distributorId_insert int(11), contactId_insert int(11), price_insert float, stock_insert int(10), size_insert varchar(128), imageUrl_insert varchar(1024), siteUrl_insert varchar(1024)'
	},
	getPriceChange: {
		call: 'CALL dabar_pricechange_selectAll()',
		params: ''
	},
	getStockChange: {
		call: 'CALL dabar_stocklog_selectAll()',
		params: ''
	},
	deleteDistributor: {
		call: 'CALL dabar_distributor_softDeleteOne(?)',
		params: 'gid INT(11)'
	},
	getEyes: {
		call: 'CALL dabar_cart_getEyes(?)',
		params: 'gproduct_id INT(11)'
	},
	setForApproval: {
		call: 'CALL dabar_cart_setForApproval(?, ?)',
		params: 'guser_id INT(11), gapproval TINYINT(1)'
	},
	getForApprovals: {
		call: 'CALL dabar_cart_getForApprovals()',
		params: ''
	},
	isForApproval: {
		call: 'CALL dabar_cart_isForApproval(?)',
		params: 'guser_id INT(11)'
	}
}

