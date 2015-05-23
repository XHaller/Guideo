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
		var username=req.body.username;
		var password=req.body.password;
		var email = req.body.email;
		console.log("The username is: "+ username);

		var queryString = 'SELECT * FROM Users WHERE Users.name="' + username +'";';
		console.log("Querying db for password of user " + username);
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			
			if (rows.length > 0) {
				res.end(JSON.stringify({ signup: 0, error_message: "Username Already Exists.\nPlease try another username!" }));
			} else {
				var queryString = 'INSERT INTO Users (name, password, email) VALUES ("' + username + '","' + password + '","' + email + '");';
				console.log("Querying db for password of user " + username);
				console.log("This is the query " + queryString);
				var pwd;
				 
				connection.query(queryString, function(err, rows, fields) {
				    if (err) console.log(err);
				    res.end(JSON.stringify({ signup: 1 }));
				});
			}
		});
});

module.exports = router;