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


router.get('/info', function(req, res){
	console.log("Handler for /event/detail called");
		//var name=req.body.topic;
		
		//console.log("The name is: "+ name);

		//var queryString = 'SELECT * FROM Events WHERE Events.name="' + name +'";';
		var queryString = 'SELECT * FROM Events;';
		console.log("Querying db for event info of all events ");
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			
			if (rows.length > 0) {
				res.end(JSON.stringify({ event: 1, topic: rows[0].name, content: rows[0].description, image: rows[0].photourl}));
				//res.end(JSON.stringify({ event: 1, address: rows[0].address, phone: rows[0].phone, start_date: rows[0].start_date, description: rows[0].description, photourl: rows[0].photourl, latitude: rows[0].latitude, longtitude: rows[0].longtitude}));
			} else {
			    res.end(JSON.stringify({ event: 1, error_message: "No event found." }));
			}
		});
});

module.exports = router;