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
	console.log("Handler for /note called");
		var id=req.body.id;
		console.log("The note id is: "+ id);

		var queryString = 'SELECT * FROM Notes WHERE Notes.id="' + id +'";';
		console.log("Querying db for notes with id " + id);
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			
			if (rows.length > 0) {
				res.end(JSON.stringify({ note: 1, id: rows[0].nid, title: rows[0].title}));
			} else {
				    res.end(JSON.stringify({ note: 1 }));
				});
			}
		});
});

module.exports = router;