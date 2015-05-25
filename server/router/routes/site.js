var express = require('express');
var router = express.Router();
var geo = require ("geolib");
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
	console.log("Handler for /site called");
		var queryString = 'SELECT * FROM Sites;';
		console.log("Querying db for site info of all events ");
		console.log("This is the query " + queryString);
		var lat = req.body.latitude;
		console.log("latitude: "+ lat);
		var lon = req.body.longitude;
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			var a ="[";
			if (rows.length > 0) {
				/*console.log("testing scoping: " + lat);
				var i=0;
				var d, elem, objArr = [];
				function compare(a,b) {
					if (a.distance < b.distance)
						return -1;
					if (a.distance > b.distance)
						return 1;
					return 0;
				}
				for (i=0; i<rows.length; i++) {
					d = geo.getDistance({latitude: lat, longitude: lon}, {latitude: rows[i].latitude, longitude: rows[i].longtitude});
					elem = {id: i, distance: d};
					console.log("Elem with id " + i + "is " + elem);
					objArr.push(elem);
				}
				objArr.sort(compare);*/

				for (i=0; i<rows.length-1; i++) {
					a = a + "{ \"site\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longitude\": \""+rows[i].longtitude +"\"},";
				}
				a = a + "{ \"site\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longtitude\": \""+rows[i].longtitude +"\"}]";
				//console.log(a);[objArr[i].id]
				var j = JSON.parse(a);
				res.end(a);
			} else {
			    res.end(JSON.stringify({ event: 0, error_message: "No site found." }));
			}
		});
});

router.post('/detail', function(req, res){
	console.log("Handler for /site/detail called");
		var queryString = 'SELECT * FROM Sites WHERE Sites.name ="' + req.body.site_name +'";';
		console.log("Querying db for detailed site info ");
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			var a ="";
			if (rows.length > 0) {
				var i=0;
				for (i=0; i<rows.length; i++) {
					a = "{ \"site\": \"1\", \"topic\": \""+rows[i].name+"\", \"basic\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longitude\": \""+rows[i].longtitude +   "\", \"trip_time\": \""+rows[i].visit_length +"\", \"fee\": \""+rows[i].has_fee +   "\", \"hours\": \""+rows[i].open_time +"\", \"phone\": \""+rows[i].phone +"\", \"address\": \""+rows[i].address + "\", \"history\": \""+rows[i].history.replace(/"/g, '\\"')+ "\", \"culture\": \""+rows[i].culture.replace(/"/g, '\\"') +"\", \"artifact\": \""+rows[i].architact.replace(/"/g, '\\"')+"\"}";
				}
				//a = a + "{ \"site\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longitude\": \""+rows[i].longtitude +   "\", \"trip_time\": \""+rows[i].visit_length +"\", \"fee\": \""+rows[i].has_fee +   "\", \"hours\": \""+rows[i].open_time +"\", \"phone\": \""+rows[i].phone +"\"}]";
				console.log(a);
				var j = JSON.parse(a);
				res.end(a);
			} else {
			    res.end(JSON.stringify({ event: 0, error_message: "No site found." }));
			}
		});
});

module.exports = router;
