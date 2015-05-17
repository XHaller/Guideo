//module dependencies
var express        =         require("express");
var bodyParser     =         require("body-parser");
var app            =         express();

var mysql = require('mysql');

var app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//app.post('/login', routes.login);
var router = require('./router')(app);
 
app.listen(80,function(){
	console.log("Started on PORT 80");
})

module.exports = app;
