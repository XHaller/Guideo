var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var connection = mysql.createConnection({
	host     : 'e6998.c9qyq3xutthv.us-west-2.rds.amazonaws.com',
	user     : 'xy2251',
	database : 'e6998',
	password : '19921110',
	port     : '3306'
});

connection.connect();
console.log("connected to db")


router.post('/', function(req, res){
	console.log("Handler for /login called");
		var user_name=req.body.user;
		var password=req.body.password;
		console.log("The username is: "+ user_name);
			
		var queryString = 'SELECT password FROM Users WHERE Users.name="' + user_name +'"';
		console.log("Querying db for password of user " + user_name);
		console.log("This is the query " + queryString);
		var pwd;
		 
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
		
			if (result.length < 1)
				return; 
		    pwd = rows[0].password;
		    
		    console.log("And this is the password: "+pwd); 
			if (pwd == password)
	    		res.end(JSON.stringify({ login: 1 }));
			else
	    		res.end(JSON.stringify({ login: 0 }));	

		// for (var i in rows) {
		//      console.log('Row 0: ', rows[0].password);
		//    }
		connection.end();
		console.log("disconnected from db")
		});
});

module.exports = router;