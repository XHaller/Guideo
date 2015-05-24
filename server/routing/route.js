var PosInfo = require('./posInfo.js');
var TimeInfo = require('./timeInfo.js');
var TrafInfo = require('./trafInfo.js');
var SiteInfo = require('./siteInfo.js');

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

//The args you should put into.
initialize(<the array of sites with name, latitude, longitude>, <user latitude>, <user longitude>);

reorder(true, true);
		
var index = 0;
for(var i = 0; i < results.length; i++)
{
	index++;
	console.log("Site " + index + ": " + results[i].getName());

	results[i].getName();
	results[i].getCoord().getLatitude();
	results[i].getCoord().getLongitude();
}




