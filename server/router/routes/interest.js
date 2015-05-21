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
>>>>>>> 80d56ce664ea63b3e88aba44fd82e11aecab04a3
connection.query(queryString, function(err, rows, fields) {
		    if (err) console.log(err);
		    else console.log("created table Interests");
		});

*/

router.post('/', function(req, res){
	console.log("Handler for /interest called");
		var username=req.body.username;
		var sitename=req.body.sitename;
		var interest = req.body.interested;

		var queryString = 'SELECT * FROM Users WHERE  Users.name="' + username +'"';
		connection.query(queryString, function(err, rows, fields){
			if (err) console.log(err);
		});
		var user = rows[0].uid;

		queryString = 'SELECT * FROM Sites WHERE  Sites.name="' + sitename +'"';
		connection.query(queryString, function(err, rows, fields){
			if (err) console.log(err);
		});
		var site = rows[0].sid;
		
		queryString = 'SELECT * FROM Interests WHERE Interests.uid = '+ user + ' AND Interests.sid = ' + site +';';
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
