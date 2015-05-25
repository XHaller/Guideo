var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var async = require('async');

var PosInfo = require('./routing/posInfo.js');
var TimeInfo = require('./routing/timeInfo.js');
var TrafInfo = require('./routing/trafInfo.js');
var SiteInfo = require('./routing/siteInfo.js');
var connection = mysql.createConnection({
	host     : 'e6998.c9qyq3xutthv.us-west-2.rds.amazonaws.com',
	user     : 'xy2251',
	database : 'e6998',
	password : '19921110',
	port     : '3306'
});

connection.connect();
console.log("connected to db")

var sites = [];
var results = [];

var currentPosition = new PosInfo();
var currentTime;
var currentDay;
var endTime;

function initialize(siteData, lat, lon, callbackA)
{	

	for(var i=0; i<siteData.length; i++)
	{
		var site = new SiteInfo(siteData[i].name, siteData[i].latitude, siteData[i].longitude, 3.0);
		site.setPopularity(Math.random()*10);
		site.setDuringTime("12345", 9.0, 17.5);
		site.setDuringTime("06", 12.0, 21.0);
		sites.push(site);
	}
		
	currentPosition.setCoord(lat, lon);
		
	var date = new Date();
	currentDay = date.getDay();
//	currentTime = date.getHours() + date.getMinutes()/60.0;
	currentTime = 9.0;
	endTime = 18.5;
	console.log("exiting initialize");
//	reorder(true, true);
	callbackA();
};

function reorder(isPopularity, isOpenTime, callbackB)
{
	while(true)
	{
		var minDist = Number.MAX_VALUE;
		var minSite = -1;
		var minTime = 0.0;
		
		for(var i = 0; i < sites.length; i++)
		{
			var tempSite = sites[i];
			//console.dir(tempSite);
			var b = tempSite.isVisited();			
			if(b)
				continue;
			
			var tempTraf = tempSite.computeDist(currentPosition, 1, 0);
			var distance = tempTraf.getDistance();
			
			if(isPopularity == false)
			{
				if(distance < minDist)
				{
					minDist = distance;
					minSite = i;
					minTime = tempTraf.getTrafficTime();
				}
			}
			else
			{
				var tempTime = tempSite.getTimeinfo(currentDay);
				var closeTime = tempTime.getCloseTime();
				var openTime = tempTime.getOpenTime();
				var restTime = closeTime - currentTime - tempTraf.getTrafficTime();
				
				if(restTime > 0)
				{
					var effectiveDist = distance;
					effectiveDist /= (tempSite.getPopularity()/5.0);
					if(isOpenTime == true)
					{
						if(currentTime > openTime)
						{
							effectiveDist *= (restTime/(endTime - currentTime));
						}
						else
						{
							effectiveDist *= ((openTime - currentTime)/(endTime - currentTime));
						}
					}
					if(effectiveDist < minDist)
					{
						minDist = effectiveDist;
						minSite = i;
						minTime = tempTraf.getTrafficTime();
					}
				}
			}
		}	
		
		if(minSite != -1)
		{
			var selectedSite = sites[minSite];
			results.push(selectedSite);
			console.log("Selected Site: " + selectedSite);
			selectedSite.setVisited(true);
			currentPosition.setCoord(selectedSite.getCoord().getLatitude(), selectedSite.getCoord().getLongitude());
			currentTime += (selectedSite.getTripTime() + minTime);
		}
		else
			break;
	}
	console.log("exiting reorder");
	callbackB();
};


router.post('/', function(req, res){
	var lat = req.body.latitude;
	var lon = req.body.longitude;
	if (req.body.sitename.length == 0 ) {
		var t = "[{ \"topic\": \"\", \"content\": \"\", \"latitude\": \"\", \"longitude\": \"\"}]";
		console.log(t);
		res.json(JSON.parse(t));
		return;
	}		
	var siteNames = req.body.sitename.split(",");
	console.log("site names are: " + req.body.sitename.length);
	var siteResult = [];
	results = [];
	sites = [];
//	console.log(results.length);
	for (var i = 0; i < siteNames.length; i++) {
		var name = siteNames[i];
		console.log(siteNames.length);
		var queryString = 'Select * FROM Sites WHERE Sites.name = "' + name + '";';
		console.log(queryString);
		connection.query(queryString, function(err, rows, fields) {
			var elem = {name: rows[0].name, latitude: rows[0].latitude, longitude:rows[0].longtitude};
			siteResult.push(elem);
			console.dir("Current elem: " + elem.name + " And current result array size: " + siteResult.length);
			if (siteResult.length == siteNames.length) {
				console.log("Called Again!");
				console.log(siteResult.length);
				async.parallel([
					function(callbackA) {
						initialize(siteResult, lat, lon, callbackA);
					},
					function(callbackB) {
						reorder(true, true, callbackB);
					}
					], function(err) {
						//console.dir(results);
						var a = "[";
						var qString = 'Select * FROM Sites;';
						connection.query(qString, function(err, rows, fields) {
							for (var j=0; j <results.length-1; j++) {
								for (var k = 0; k < rows.length; k++) {
									if (rows[k].name == results[j].getName()) {
										a = a + "{ \"topic\": \""+rows[k].name+"\", \"content\": \""+rows[k].description.replace(/"/g, '\\"')+ "\", \"latitude\": \""+rows[k].latitude +"\", \"longitude\": \""+rows[k].longtitude +"\"},";
									}
								}
							}
							for (var k = 0; k < rows.length; k++) {
									if (rows[k].name == results[j].getName()) {
										a = a + "{ \"topic\": \""+rows[k].name+"\", \"content\": \""+rows[k].description.replace(/"/g, '\\"')+ "\", \"latitude\": \""+rows[k].latitude +"\", \"longitude\": \""+rows[k].longtitude +"\"}]";
									}
							}
							var f = JSON.parse(a);
							console.log("response " + a);
							res.end(a);
						});
					});
			}
		});
	}
});
//The args you should put into.


//reorder(true, true);
		
/*var index = 0;
for(var i = 0; i < results.length; i++)
{
	index++;
	console.log("Site " + index + ": " + results[i].getName());

	//results[i].getName();
	//results[i].getCoord().getLatitude();
	//results[i].getCoord().getLongitude();
}*/


module.exports = router;
