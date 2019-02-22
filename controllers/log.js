var db = require(__dirname + '/../lib/mysql');
var dabar = require('./../db/procedures');

exports.getPriceChange = function(req, res, next){
    var fxn = [dabar.procedures.getPriceChange.call]

    dabar.executeProcedure(fxn[0])
    .then(result => {
        res.status(200).send(result[0])
    })
    .catch(err => {
        if(err.status){
            return res.status(err.status).send(err)
        }
        return res.status(500).send({message: "Uncatched case in log.getPriceChange", result: err})
    })
}

exports.getStockChange = function(req, res, next){
    var fxn = [dabar.procedures.getStockChange.call]

    dabar.executeProcedure(fxn[0])
    .then(result => {
        res.status(200).send(result[0])
    })
    .catch(err => {
        if(err.status){
            return res.status(err.status).send(err)
        }
        return res.status(500).send({message: "Uncatched case in log.getStockChange", result: err})
    })
}