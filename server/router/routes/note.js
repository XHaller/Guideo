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
//		console.log("The note id is: "+ id);

		var queryString = 'SELECT * FROM Notes;';
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			var a = [];
			a.push("");
			a.push("");
			if (rows.length > 0) {
				console.log(rows.length + " is the number of notes");
				for (var i = 0; i < rows.length; i++) {
					(function(i) {
						var b = "";
						var uid = rows[i].uid;
						a[i] = a[i] + "{ \"topic\": \""+rows[i].title +"\", \"nid\": \"" + rows[i].nid +"\", \"user\": \"";
						var qString = 'SELECT name FROM Users WHERE Users.uid ="' + uid + '";';
						console.log("the query is: " + qString + " at index " + i);
						connection.query(qString, function(err, row, fields){
							
							a[i] = a[i] + row[0].name + "\"}";
							//console.log(c + "for index: "+ i);
							if (i>=rows.length-1) {
								var aa =  "[";
								aa= aa+ a[0] + ',' + a[1];
								//aa.slice(0,-1);
								aa = aa+"]";
								console.log("Returning:" +aa);
								res.json(JSON.parse(aa));
							}
						});
					})(i);
				}

				//res.end(JSON.stringify({ note: 1, id: rows[0].nid, title: rows[0].title}));
			} else {
				    res.end(JSON.stringify({ note: 1 }));
			
			}
		});
});

module.exports = router;
