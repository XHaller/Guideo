var express        =         require("express");
var bodyParser     =         require("body-parser");
var app            =         express();

var mysql = require('mysql');

var connection = mysql.createConnection({
  host     : 'e6998.c9qyq3xutthv.us-west-2.rds.amazonaws.com',
  user     : 'xy2251',
  database : 'e6998',
  password : '19921110',
  port 	   : '3306'
});




connection.connect();
 
var queryString = 'SELECT password FROM Users WHERE Users.name="xy2251";';
var pwd;
 
connection.query(queryString, function(err, rows, fields) {
    if (err) throw err;
 
    pwd = rows[0].password;
    console.log(pwd); 

// for (var i in rows) {
//      console.log('Row 0: ', rows[0].password);
//    }
});
 
connection.end();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.get('/',function(req,res){
	res.sendFile("index.html");
});
app.post('/login',function(req,res){
	var user_name=req.body.user;
	var password=req.body.password;
	console.log("hello");
	console.log(req.body.user);
	res.setHeader('Content-Type', 'application/json');
	if (pwd == password)
    		res.end(JSON.stringify({ login: 1 }));
	else
    		res.end(JSON.stringify({ login: 0 }));	
	//console.log(res.body);
});

app.listen(80,function(){
	console.log("Started on PORT 80");
})
