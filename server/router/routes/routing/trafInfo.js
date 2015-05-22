module.exports = function TrafInfo()
{
	var len = arguments.length;
	if(0 == len)
	{
		this.distance = -1;
		this.trafficTime = -1;
	}
	else if(2 == len)
	{
		this.distance = arguments[0];
		this.trafficTime = arguments[1];
	}
	
	this.getDistance = function() 
	{
			return this.distance;
	};
	
	this.setDistance = function(distance) 
	{
			this.distance = distance;
	};
	
	this.getTrafficTime = function() 
	{
			return this.trafficTime;
	};

	this.setTrafficTime = function(trafficTime) 
	{
			this.trafficTime = trafficTime;
	};
	
};


/*
var TrafInfo = require('./trafInfo.js');

var a = new TrafInfo();
console.log(a.getTrafficTime());

var b = new TrafInfo(2, 4);
console.log(b.getTrafficTime());


var TimeInfo = require('./timeInfo.js');

var c = new TimeInfo();
console.log(c.getOpenTime());

var d = new TimeInfo(2, 4);
console.log(d.getOpenTime());

*/