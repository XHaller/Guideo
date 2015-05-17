//module dependencies
var express        =         require("express");
var bodyParser     =         require("body-parser");
var app            =         express();
var routes = require('./routes');
var mysql = require('mysql');

var app = express();

//environment
app.set('port', 80);
app.use(app.router);

app.post('/login', routes.login);
//app.get('/users', user.list);
 
http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
