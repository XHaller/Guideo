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

/*var queryString = 'DELETE FROM Notes WHERE nid = 5';

connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
		    else console.log("deleted note");
		});
*/
router.post('/upload', function(req, res){
	console.log("Handler for /note/user called");
		var username=req.body.username;
		var text = req.body.text;

		var queryString = 'SELECT uid FROM Users WHERE Users.name = "' + username + '";';
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) {
		    	console.log(err);
		    	res.end(JSON.stringify({ upload: 0 }));
		    } else if (rows.length > 0) {
				var uid = rows[0].uid;
				queryString = 'INSERT INTO Notes (uid, title) VALUES (' + uid + ',"' + text +'");';
				connection.query(queryString, function(err, rows, fields) {
				    if (err) {
				    	console.log(err);
				    	res.end(JSON.stringify({ upload: 0 }));
				    } else {
				    	res.end(JSON.stringify({ upload: 1 }));
				    }
				});
			} else {
				    res.end(JSON.stringify({ upload: 0 }));
			
			}
		});
});

router.post('/user', function(req, res){
	console.log("Handler for /note/user called");
		var username=req.body.username;

		var queryString = 'SELECT * FROM Notes WHERE Notes.uid IN (SELECT uid FROM Users WHERE Users.name = "' +username + '");';
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			
			if (rows.length > 0) {
				console.log(rows.length + " is the number of notes");
				var i = 0;
				a = "[";
				for (i=0; i<rows.length-1; i++) {
					a = a + "{ \"topic\": \""+rows[i].title +"\", \"nid\": \"" + rows[i].nid +"\", \"image\": \"" + rows[i].image + "\"},"
				}
				a = a + "{ \"topic\": \""+rows[i].title +"\", \"nid\": \"" + rows[i].nid +"\", \"image\": \"" + rows[i].image + "\"}]"
				//console.log(a);[objArr[i].id]
				var j = JSON.parse(a);
				res.end(a);
			} else {
				    res.end(JSON.stringify({ note: 0 }));
			
			}
		});
});

router.post('/', function(req, res){
	console.log("Handler for /note called");
		var id=req.body.id;
//		console.log("The note id is: "+ id);

		var queryString = 'SELECT * FROM Notes;';
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			var a = [];
			for (var k = 0; k<rows.length; k++) {
				a.push("");
			}
			if (rows.length > 0) {
				console.log(rows.length + " is the number of notes");
				for (var i = 0; i < rows.length; i++) {
					(function(i) {
						var b = "";
						var uid = rows[i].uid;
						a[i] = a[i] + "{ \"topic\": \""+rows[i].title +"\", \"nid\": \"" + rows[i].nid +"\", \"image\": \"" + rows[i].image +"\", \"user\": \"";
						var qString = 'SELECT name FROM Users WHERE Users.uid ="' + uid + '";';
						console.log("the query is: " + qString + " at index " + i);
						connection.query(qString, function(err, row, fields){
							
							a[i] = a[i] + row[0].name + "\"}";
							//console.log(c + "for index: "+ i);
							if (i>=rows.length-1) {
								var aa =  "[";
								for (var j = rows.length-1; j >= 0; j--) {
									console.log("appending note " + j);
									aa= aa+ a[j] + ',';// + ',' + a[1];
								}
								aa=aa.slice(0,-1);
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
