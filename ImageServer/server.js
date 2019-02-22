var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var multer = require('multer');
var path = require('path');


const storage = multer.diskStorage({
	destination: './public',
	filename: function(req, file, callback){
		callback(null,file.fieldname + '-' + Date.now() + path.extname(file.originalname));
	}
})

const upload = multer({
	storage: storage
}).single('image');



app.use(express.static('public'));

app.use(require(__dirname + '/cors')('*'));
app.use(bodyParser.urlencoded({extended : false}));
app.use(bodyParser.json());
app.use('/images', express.static(__dirname + '/public'));

app.post('/upload',function(req,res){
    console.log("RECIEVED BY IMAGE SERVER");
	upload(req,res,(err)=>{
		if(err){
			console.log(err);
			res.status(200).send({message:err});
		}else{
			res.send(res.req.file.filename);
		}
	})
})
//Serves all the request which includes /images in the url from Images folder
console.log("Starting Server");
var server = app.listen(5000);
