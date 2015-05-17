//module dependencies
var express        =         require("express");
var bodyParser     =         require("body-parser");
var app            =         express();
var routes = require('./routes/login');
var mysql = require('mysql');

var app = express();
app.use(bodyParser.urlencoded({ extended: false }));

app.post('/login', routes.login);
//app.get('/users', user.list);
 
app.listen(80,function(){
	console.log("Started on PORT 80");
});
