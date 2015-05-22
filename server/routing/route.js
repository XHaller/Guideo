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

function initialize()
{	
	var site1 = new SiteInfo("site1", 12.8397, 45.6636, 1.0);
	site1.setPopularity(3.0);
	site1.setDuringTime("12345", 9.0, 17.5);
	site1.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site1);
		
	var site2 = new SiteInfo("site2", 15.6616, 43.2897, 1.0);
	site2.setPopularity(5.5);
	site2.setDuringTime("12345", 9.0, 17.5);
	site2.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site2);
		
	var site3 = new SiteInfo("site3", 11.2144, 43.3715, 2.5);
	site3.setPopularity(8.2);
	site3.setDuringTime("12345", 9.0, 17.5);
	site3.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site3);
		
	var site4 = new SiteInfo("site4", 15.4335, 42.7262, 2.0);
	site4.setPopularity(7.4);
	site4.setDuringTime("12345", 9.0, 17.5);
	site4.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site4);
		
	var site5 = new SiteInfo("site5", 13.5847, 43.2792, 0.5);
	site5.setPopularity(3.8);
	site5.setDuringTime("12345", 9.0, 17.5);
	site5.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site5);
		
	var site6 = new SiteInfo("site6", 13.6277, 44.9985, 1.0);
	site6.setPopularity(6.6);
	site6.setDuringTime("12345", 9.0, 17.5);
	site6.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site6);
		
	var site7 = new SiteInfo("site7", 12.2819, 43.5648, 0.5);
	site7.setPopularity(5.3);
	site7.setDuringTime("12345", 9.0, 17.5);
	site7.setDuringTime("06", 12.0, 21.0);
		
	sites.push(site7);
		
	currentPosition.setCoord(13.0, 45.0);
		
	var date = new Date();
	currentDay = date.getDay();
	//currentTime = date.getHours() + date.getMinutes()/60.0;
	currentTime = 9.0;
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


initialize();
reorder(true, true);
		
var index = 0;
for(var i = 0; i < results.length; i++)
{
	index++;
	console.log("Site " + index + ": " + results[i].getName());
}