var PosInfo = require('./posInfo.js');
var TimeInfo = require('./timeInfo.js');
var TrafInfo = require('./trafInfo.js');

module.exports = function SiteInfo() 
{ 
	this.visited = false;
	this.timeinfo = [];
	this.specialDate = [];
	
	for(var i = 0; i < 7; i++)
	{
		this.timeinfo.push(new TimeInfo());
	}
	this.coord = new PosInfo();
	
	var len = arguments.length; 
	if(0 == len)
	{
		this.tripTime = 2;
	}
	else if(4 == len)
	{
		this.name = arguments[0];
		this.coord.setCoord(arguments[1], arguments[2]);
		this.tripTime = arguments[3];
	}
	
	this.addSpecialDate = function(val0, val1, val2)
	{
		this.specialDate[val0] = new TimeInfo(val1, val2);
	};
	
	this.computeDist = function(pos, trafficType, time)
	{
		var latitude = this.coord.getLatitude();
		var longitude = this.coord.getLongitude();
		
		var pow1 = (latitude - pos.getLatitude()) * (latitude - pos.getLatitude());
		var pow2 = (longitude - pos.getLongitude()) * (longitude - pos.getLongitude());
		
		var distance = Math.sqrt(pow1 + pow2);
		
		var velocity = 100;
		switch(trafficType)
		{
		case 1:
			velocity = 100;
			break;
		case 2:
			velocity = 1000;
			break;
		case 3:
			velocity = 800;
			break;
		case 4:
			velocity = 500;
			break;
		default:
			velocity = 100;	
			break;
		}
		
		var trafficTime;
		if(trafficType == 0)
		{
			trafficTime = time;
		}
		else
		{
			trafficTime = distance / velocity;
		}
		
		var tempTraf = new TrafInfo(distance, trafficTime);
		
		return tempTraf;
	};
	
	this.setDuringTime = function(index, open, close)
	{
		for(var i = 0 ; i < index.length; i++)
		{
			var ind = index.substring(i, i+1);
			this.timeinfo[ind].setOpenTime(open);
			this.timeinfo[ind].setCloseTime(close);
		}
	};
	
	this.getTripTime = function() 
	{
		return this.tripTime;
	};
	
	this.setTripTime = function(tripTime) 
	{
		this.tripTime = tripTime;
	};
	
	this.getTimeinfo = function() 
	{
		var len = arguments.length;
		if(0 == len)
		{
			return this.timeinfo;
		}
		else if(1 == len)
		{
			return this.timeinfo[arguments[0]];	
		}
	};
	
	this.setTimeinfo = function(timeinfo) 
	{
		this.timeinfo = timeinfo;
	};
	
	this.getName = function() 
	{
		return this.name;
	};
	
	this.setName = function(name) 
	{
		this.name = name;
	};
	
	this.getSpecialDate = function() 
	{
		return this.specialDate;
	};
	
	this.setSpecialDate = function(specialDate) 
	{
		this.specialDate = specialDate;
	};
	
	this.getCoord = function() 
	{
		return this.coord;
	};

	this.setCoord = function(coord) 
	{
		this.coord = coord;
	};

	this.getPopularity = function() 
	{
		return this.popularity;
	};

	this.setPopularity = function(popularity) 
	{
		this.popularity = popularity;
	};

	this.isVisited = function() 
	{
		return this.visited;
	};

 	this.setVisited = function(visited) 
 	{
		this.visited = visited;
	};
	
};

/*
var SiteInfo = require('./siteInfo.js');
var a = new SiteInfo("site1", 12.0, 45.0, 1.0);
a.setPopularity(3.0);
a.setDuringTime("12345", 9.0, 17.5);
a.setDuringTime("06", 12.0, 21.0);
var tra = a.computeDist(new PosInfo(12.0, 44.0), 1, 0);
console.log(tra.getDistance());
*/