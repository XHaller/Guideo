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

/*var queryString = 'UPDATE Events SET latitude = "40.7", longtitude = "-74.05" WHERE Events.name = "Christopher Wool";';
connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
		    else console.log("created table Interests");
		});
console.log(queryString);*/

router.post('/', function(req, res){
	console.log("Handler for /event called");
		var queryString = 'SELECT * FROM Events;';
		console.log("Querying db for event info of all events ");
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			if (rows.length > 0) {
				var a = "[";
				var i=0;
				for (i=0; i<rows.length-1; i++) {
					a = a + "{ \"event\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"fee\": \""+rows[i].has_fee +"\"},";
				}
				a = a + "{ \"event\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[0].photourl+"\"}]";
				console.log(a);
				var j = JSON.parse(a);
				res.end(a);
			} else {
			    res.end(JSON.stringify({ event: 0, error_message: "No event found." }));
			}
		});
});

router.post('/detail', function(req, res){
	console.log("Handler for /event/detail called");
		var queryString = 'SELECT * FROM Events WHERE Events.name ="' + req.body.event_name +'";';
		console.log("Querying db for event info of all events ");
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			if (rows.length > 0) {
				var i=0;
				var a = "";
				for (i=0; i<rows.length; i++) {
					a = "{ \"event\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longitude\": \""+rows[i].longtitude +  "\", \"website\": \""+rows[i].website +"\", \"phone\": \""+rows[i].phone + "\", \"address\": \""+rows[i].address +"\", \"date\": \""+rows[i].start_date +"\", \"location\": \""+rows[i].location +"\"}";
				}
				//a = a + "{ \"event\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longitude\": \""+rows[i].longtitude +  "\", \"website\": \""+rows[i].website +"\", \"phone\": \""+rows[i].phone + "\", \"address\": \""+rows[i].address +"\", \"date\": \""+rows[i].date +"\", \"location\": \""+rows[i].location +"\"}]";
				console.log(a);
				var j = JSON.parse(a);
				res.end(a);
			} else {
			    res.end(JSON.stringify({ event: 0, error_message: "No event found." }));
			}
		});
});

module.exports = router;
