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
	console.log("Handler for /site called");
		var queryString = 'SELECT * FROM Sites;';
		console.log("Querying db for site info of all events ");
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			var a ="[";
			if (rows.length > 0) {
				var i=0;
				for (i=0; i<rows.length-1; i++) {
					a = a + "{ \"site\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longitude\": \""+rows[i].longtitude +"\"},";
				}
				a = a + "{ \"site\": \"1\", \"topic\": \""+rows[i].name+"\", \"content\": \""+rows[i].description.replace(/"/g, '\\"')+ "\", \"image\": \""+rows[i].photourl+ "\", \"latitude\": \""+rows[i].latitude +"\", \"longtitude\": \""+rows[i].longtitude +"\"}]";
				//console.log(a);
				var j = JSON.parse(a);
				res.end(a);
			} else {
			    res.end(JSON.stringify({ event: 0, error_message: "No site found." }));
			}
		});
});

module.exports = router;
