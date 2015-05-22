var express = require('express');
var router = express.Router();

var PosInfo = require('./routing/posInfo.js');
var TimeInfo = require('./routing/timeInfo.js');
var TrafInfo = require('./routing/trafInfo.js');
var SiteInfo = require('./routing/siteInfo.js');

var sites = [];
var results = [];

var currentPosition = new PosInfo();
var currentTime;
var currentDay;
var endTime;

function initialize(siteData, lat, lon)
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
	currentTime = date.getHours() + date.getMinutes()/60.0;
	//currentTime = 9.0;
	endTime = 18.5;
};

function reorder(isPopularity, isOpenTime)
{
	while(true)
	{
		var minDist = Number.MAX_VALUE;
		var minSite = -1;
		var minTime = 0.0;
		
		for(var i = 0; i < sites.length; i++)
		{
			var tempSite = sites[i];
			
			if(tempSite.isVisited())
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
			selectedSite.setVisited(true);
			currentPosition.setCoord(selectedSite.getCoord().getLatitude(), selectedSite.getCoord().getLongitude());
			currentTime += (selectedSite.getTripTime() + minTime);
		}
		else
			break;
	}
};


router.post('/', function(req, res){
	var lat = req.body.latitude;
	var lon = req.body.longitude;
	var sites = req.body.sitename.split(",");
	var result = [];

	for (var i = 0; i < sites.length; i++) {
		var name = sites[i];
		var queryString = 'Select * FROM Sites WHERE Sites.name = "' + name + '";';
		console.log(queryString);
		connection.query(queryString, function(err, rows, fields) {
			var elem = [name: rows[0].name, latitude: rows[0].latitude, longitude:rows[0].longtitude];
			result.push(elem);
			console.dir("Current elem: " + elem + " And current result array: " + result + " and current i: " + i);
			if (results.length == sites.length) {
				initialize(result, lat, lon);				
			}
		});
	}
});
//The args you should put into.


reorder(true, true);
		
var index = 0;
for(var i = 0; i < results.length; i++)
{
	index++;
	console.log("Site " + index + ": " + results[i].getName());

	//results[i].getName();
	//results[i].getCoord().getLatitude();
	//results[i].getCoord().getLongitude();
}


module.exports = router;