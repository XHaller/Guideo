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


router.post('/detail', function(req, res){
	console.log("Handler for /event/detail called");
		var name=req.body.name;
		
		console.log("The name is: "+ name);

		var queryString = 'SELECT * FROM Events WHERE Events.name="' + name +'";';
		console.log("Querying db for event detais of event " + name);
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			
			if (rows.length > 0) {
				
				res.end(JSON.stringify({ event: 1, address: rows[0].address, phone: rows[0].phone, start_date: rows[0].start_date, description: rows[0].description, photourl: rows[0].photourl, latitude: rows[0].latitude, longtitude: rows[0].longtitude}));
			} else {
			    res.end(JSON.stringify({ event: 1, error_message: "No event by this name found." }));
			}
		});
});

module.exports = router;