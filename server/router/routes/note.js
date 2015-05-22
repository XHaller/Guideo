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

		var queryString = 'SELECT * FROM Notes;';
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			var a = "[";
			if (rows.length > 0) {
				for (var i = 0; i < rows.length; i++) {
					var b = "";
					var uid = rows[i].uid;
					b = b + "{ \"topic\": \""+rows[i].title + "\", \"user\": \"";
					var qString = 'SELECT name FROM Users WHERE Users.uid ="' + uid + '";';
					connection.query(qString, function(err, rows, fields){
						var c = b + rows[0].name + "\"}";
						console.log(c);
						a = a + c;
						if (i==rows.length-1) {
							a.slice(0,-1);
							a = a+"]";
							console.log("Returning:" +a);
							res.end(JSON.parse(a));
						}
					});
				}

				//res.end(JSON.stringify({ note: 1, id: rows[0].nid, title: rows[0].title}));
			} else {
				    res.end(JSON.stringify({ note: 1 }));
			
			}
		});
});

module.exports = router;
