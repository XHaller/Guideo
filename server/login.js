
exports.login = function(req, res){
  var mysql = require('mysql');

var connection = mysql.createConnection({
	  host     : 'e6998.c9qyq3xutthv.us-west-2.rds.amazonaws.com',
	  user     : 'xy2251',
	  database : 'e6998',
	  password : '19921110',
	  port 	   : '3306'
	});

	connection.connect();
	console.log("connected to db")
	var user_name=req.body.user;
	var password=req.body.password;
	console.log(req.body);
	res.setHeader('Content-Type', 'application/json');
	
	var queryString = 'SELECT password FROM Users WHERE Users.name="' + user_name +'"';
	console.log("Querying db for password of user " + user_name);
	var pwd;
	 
	connection.query(queryString, function(err, rows, fields) {
	    if (err) throw err;
	 
	    pwd = rows[0].password;
	    console.log("And this is the password: + " + pwd); 

	// for (var i in rows) {
	//      console.log('Row 0: ', rows[0].password);
	//    }
	});

	if (pwd == password)
    		res.end(JSON.stringify({ login: 1 }));
	else
    		res.end(JSON.stringify({ login: 0 }));	
	console.log(res.body);

	connection.end();
	console.log("disconnected from db")

};