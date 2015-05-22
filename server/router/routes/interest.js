var express = require('express');
var router = express.Router();
var async = require('async');
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
	console.log("Handler for /interest called");
		var username=req.body.username;
		var sitename=req.body.sitename;
		var interest = req.body.interested;
		var user, site, queryString;
		async.parallel([
			function(callbackA) {
				queryString = 'SELECT * FROM Users WHERE  Users.name="' + username +'"';
				console.log(queryString);
				connection.query(queryString, function(err, rows, fields){
					if (err) console.log(err);
					user = rows[0].uid;
					console.log("The id is " + user);
					callbackA();
				});
			},
			function(callbackB) {
				queryString = 'SELECT * FROM Sites WHERE  Sites.name="' + sitename +'"';
				console.log(queryString);
				connection.query(queryString, function(err, rows, fields){
					if (err) console.log(err);
					else site = rows[0].sid;
					callbackB();
				});	
			}
			], function(err){
				queryString = 'SELECT * FROM Interests WHERE Interests.uid = '+ user + ' AND Interests.sid = ' + site +';';
				console.log("Querying db for interest of user with id + " + user + " in site with id  " +site);
				console.log("This is the query " + queryString);
				connection.query(queryString, function(err, rows, fields) {
				    if (err) console.log(err);
					if (typeof rows!== 'undefined' && rows) {
						queryString = 'UPDATE Interests SET score = ' + interest + ' WHERE Interests.uid = '+ user + ' AND Interests.sid = ' + site +';'
						connection.query(queryString, function(err, rows, fields){
							if (err) console.log(err);
						});
					} else {
					    queryString = 'INSERT INTO Interests VALUES(' + user + ', ' + site + ', ' + interest +');'
					    connection.query(queryString, function(err, rows, fields){
							if (err) console.log(err);
						});
					}
					console.log("updated interest");
					res.end(JSON.stringify({ interest: 1 }));
				});
			});
});

module.exports = router;
