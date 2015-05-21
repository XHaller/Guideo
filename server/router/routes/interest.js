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


/*var queryString = 'CREATE TABLE Interests(uid SMALLINT NOT NULL,sid SMALLINT NOT NULL,score INTEGER NOT NULL,PRIMARY KEY (uid, sid), FOREIGN KEY (uid) REFERENCES Users (uid) ON DELETE CASCADE, FOREIGN KEY (sid) REFERENCES Sites (sid) ON DELETE CASCADE) ENGINE = InnoDB DEFAULT CHARSET = UTF8;';
connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
		    else console.log("created table Interests");
		});

*/

router.post('/', function(req, res){
	console.log("Handler for /interest called");
		var user=req.body.userid;
		var site=req.body.siteid;
		var interest = req.body.interest;
		var queryString = 'SELECT * FROM Interests WHERE Interests.uid = '+ user + ' AND Interests.sid = ' + site +';';
		console.log("Querying db for interest of user with id + " + user + " in site with id  " +sid);
		console.log("This is the query " + queryString);
		connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
			if (rows.length > 0) {
				queryString = 'UPDATE Interests SET score = ' + interest + ' WHERE Interests.uid = '+ user + ' AND Interests.sid = ' + site +';'
				connection.query(queryString, function(err, rows, fields){
					if (err) console.log(err);
				});
			} else {
			    queryString = 'INSERT INTO Interests VALUES(' + user + ', ' + site + ', ' + interest +');'
			    connection.query(queryString, function(err, rows, fields){
					if (err) console.log(err);
				});
			}
		});
});

module.exports = router;
