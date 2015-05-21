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
	console.log("Handler for /event/detail called");
		var queryString = 'SELECT * FROM Events;';
		console.log("Querying db for event info of all events ");
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			if (rows.length > 0) {
				var i=0;
				for (i=0; i<rows.length-1; i++) {
					a = a + "{ \"event\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+"\"},";
				}
				a = a + "{ \"event\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description+ "\", \"image\": \""+rows[0].photourl+"\"}]";
				console.log(a);
				var j = JSON.parse(a);
				res.end(a);
			} else {
			    res.end(JSON.stringify({ event: 0, error_message: "No event found." }));
			}
		});
});

module.exports = router;
