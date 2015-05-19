//module dependencies
var express        =         require("express");
var bodyParser     =         require("body-parser");
var app            =         express();

var mysql = require('mysql');

var app = express();
var jsonParser = bodyParser.json();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//  app.use(app.router);
//app.post('/login', jsonParser, routes.login);

var router = require('./router')(app);
 
app.listen(80,function(){
	console.log("Started on PORT 80");
})

module.exports = app;
