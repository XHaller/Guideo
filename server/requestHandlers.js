var querystring = require("querystring"), 
	fs =require("fs");
var formidable = require("formidable");

function start(response) {
	console.log("request handler start was called");
}

function login(res, req) {
	var user_name=req.body.user;
	var password=req.body.password;
	console.log(req.body);
	res.setHeader('Content-Type', 'application/json');
	if (pwd == password)
    		res.end(JSON.stringify({ login: 1 }));
	else
    		res.end(JSON.stringify({ login: 0 }));	
	console.log(res.body);
}

function register(response) {
	console.log("request handler show was called");
	response.writeHead(200, {"Content-Type": "img/png"});
	fs.createReadStream("/tmp/test.png").pipe(response);
}

exports.start = start;
exports.login = login;
exports.register = register;