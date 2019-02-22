var db = require(__dirname + '/../lib/mysql');
var dabar = require('./../db/procedures');

exports.putProduct = function(req, res, next){
	var fxn = dabar.procedures.putCartProduct.call;
	var params = [res.locals.user_id, req.body.product_id, req.body.quantity];
	var promiser = {resolve: null, reject: null}

	dabar.executeProcedure(fxn, params, function(err, result){
		if(err && err.code === 'ER_DUP_ENTRY'){
			res.status(401).send({message: "Product already in cart, try adjusting quantity instead", result: err})
		}
		if(err){
			promiser.reject({status: 500, message: `Database error in dabar procedures: ${dabar.procedures.putCartProduct.call}`, result: err})
		}
		promiser.resolve(result)
	}, promiser)
	
	.then(result => {
		if(result[0][0]['@onApproval'] === 1){
			return res.status(400).send({message: "Your cart is on approval, cannot add any product to cart", result: result})
		}
		return res.status(200).send({message: "Successfully put product to cart", result: result})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send(err)
		}
		else{
			res.status(500).send({message: 'Uncatched case in cart.putProduct', result: err.message})
		}
	})
}

exports.checkout = function(req, res, next){
	var fxn = [dabar.procedures.stockCheck.call, dabar.procedures.showCartProducts.call, dabar.procedures.buyProduct.call, dabar.procedures.checkoutCart.call]
	var params = req.params.id
	var x = {resolve: null, reject: null}
	db.beginTransaction()
	
	// check stock if enough
	dabar.executeProcedure(fxn[0], params, function(err, result){
		if(err){
			x.reject({status: 500, message: `Database error in dabar procedures: ${call}`, result: err})
		}
		if(result[0][0].isEnough == 0){
			x.reject({status: 400, message: 'Stocks request too many', result: result[0]})
		}
		else{
			x.resolve('Get cart')
		}
			
	}, x)
	// get cart
	.then(next => {
		return dabar.executeProcedure(fxn[1], params)
	})
	// buy products in cart one by one
	.then(result => {
		var cart = result[0]
		var buyPromises = []
		for(var i in cart){
			buyPromises.push(dabar.executeProcedure(fxn[2], [params, cart[i].product_id]))
		}
		return Promise.all(buyPromises)
	})
	// checkout / make receipt
	.then(result => {
		return dabar.executeProcedure(fxn[3], params)
	})
	// finalize
	.then(result => {
		db.commit()
		res.status(200).send({message: 'Successfully checked out cart', result: result})
	})
	.catch(err => {
		db.rollback()
		if(err.status){
			res.status(err.status).send(err)
		}
		else{
			res.status(500).send({message: 'Uncatched case in cart.checkout', result: err.message}	)
		}
	})
}

exports.getProducts = function(req, res, next){
	var fxn = dabar.procedures.showCartProducts.call;
	var params = res.locals.user_id;
	// var params = [req.body.user];

	// var params = req.body.user_id;
	dabar.executeProcedure(fxn, params)
	
	.then(result => {
		var promises = []
		promises.push(dabar.executeProcedure(dabar.procedures.isForApproval.call, params))
		promises.push(result)
		return Promise.all(promises)
	})
	.then(result => {
		// console.log(JSON.stringify(result, null, 2))
		res.status(200).send({message: 'Successfully gott products', result: result[1][0], forapproval: result[0][0][0].forapproval})
	})
	
	.catch(err => {
		if(err.status){
			res.status(err.status).send({err})
		}
		else{
			res.status(500).send({message: 'Uncatched case in cart.getProducts', result: err.message})
		}
	})		
}

exports.incQuantity = function(req, res, next){
	var fxn = dabar.procedures.incCartProductQuantity.call;
	var params = [res.locals.user_id, req.body.product_id, req.body.quantity]

	dabar.executeProcedure(fxn, params)

	.then(result => {
		res.status(200).send({message: 'Successfully increased quantity', result: result})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send({err})
		}
		else{
			res.status(500).send({message: 'Uncatched case in cart.incQuantity', result: err.message})
		}
	})
}

exports.removeProduct = function(req, res, next){
	var fxn = dabar.procedures.deleteCartProduct.call;
	var params = [res.locals.user_id, req.body.product_id];
	
	dabar.executeProcedure(fxn, params)

	.then(result => {
		res.status(200).send({message: 'Successfully removed product', result: result})
		
	})
	
	.catch(err => {
		if(err.status){
			res.status(err.status).send({err})
		}
		else{
			res.status(500).send({message: 'Uncatched case in cart.remove', result: err.message})
		}
	})
}

exports.getOrders = function(req, res, next){
	var fxn = [dabar.procedures.getOrders.call, dabar.procedures.selectCartForOrder.call]
	var params = [res.locals.user_id]

	// get all orders
	dabar.executeProcedure(fxn[0], params)

	// get all products from each order
	.then(result => {
		var orders = result[0]
		var cartPromises = []
		for(var i in orders){
			cartPromises.push(dabar.executeProcedure(fxn[1], orders[i].id))
		}
		cartPromises.push(orders)
		return Promise.all(cartPromises)
	})

	// finalize
	.then(result => {
		var orders = result.pop()
		var orderList = []
		var order
		for(var i in result){
			order = {}
			order['cart'] = result[i][0]
			order['details'] = orders[i]
			orderList.push(order)
		}
		res.status(200).send({message: 'Successfully got orders', result: orderList})
	})

	.catch(err => {
		if(err.status){
			res.status(err.status).send({err})
		}
		else{
			res.status(500).send({message: 'Uncatched case in cart.getOrders', result: err.message})
		}
	})
}

exports.getEyes = function(req, res, next){
	var fxn = dabar.procedures.getEyes.call
	var params = req.body.id

	dabar.executeProcedure(fxn, params)
	.then(result => {
		// console.log(result[0][0])
		res.status(200).send({message: 'Successfully got eyes', potentialBuyers: result[0][0].potentialBuyers, stocksInCarts: result[0][0].stocksInCarts})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send({err})
		}
		return res.status(500).send({message: 'Uncatched case in cart.getEyes', result: err})
	})
}

exports.setForApproval = function(req, res, next){
	var fxn = dabar.procedures.setForApproval.call
	var params = [res.locals.user_id, req.body.forapproval]

	dabar.executeProcedure(fxn, params)
	.then(result => {
		// console.log(result)
		if(result[0][0]['@isEmptyCart'] === 0){
			return res.status(400).send({message: 'Cannot up for approval an empty cart', result: result})
		}
		return res.status(200).send({message: 'Successfully upped cart for approval', result: result[0][0]})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send({err})
		}
		return res.status(500).send({message: 'Uncatched case in cart.setForApproval', result: err})
	})
}

exports.getForApprovals = function(req, res, next){
	var fxn = [dabar.procedures.getForApprovals.call, dabar.procedures.selectCartForOrder.call]
	var params = []
	
	// get all carts for approval
	dabar.executeProcedure(fxn[0])
	// get products of each cart
	.then(result => {
		// console.log(result)
		var carts = result[0]
		var cartPromises = []
		for(var i in carts){
			cartPromises.push(dabar.executeProcedure(fxn[1], carts[i].id))
		}
		cartPromises.push(carts)
		return Promise.all(cartPromises)
	})
	// finalize
	.then(result => {
		console.log(JSON.stringify(result, null, 2))
		var carts = result.pop()
		var fullcartList = []
		var fullcart
		for(var i in result){
			fullcart = {}
			fullcart['products'] = result[i][0]
			fullcart['details'] = carts[i]
			fullcartList.push(fullcart)
		}
		res.status(200).send({message: 'Successfully got for-approvals', result: fullcartList})
	})
	.catch(err => {
		if(err.status){
			return res.status(err.status).send({err})
		}
		return res.status(500).send({message: 'Uncatched case in cart.getForApprovals', result: err})
	})
}