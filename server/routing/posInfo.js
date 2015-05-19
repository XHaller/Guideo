module.exports = function PosInfo()
{
	var len = arguments.length;
	if(0 == len)
	{
		this.latitude = 0;
		this.longitude = 0;
	}
	else if(2 == len)
	{
		this.latitude = arguments[0];
		this.longitude = arguments[1];
	}
	
	this.setCoord = function(val0, val1)
	{
		this.latitude = val0;
		this.longitude = val1;
	};
	
	this.getLongitude = function() 
	{
			return this.longitude;
	};
	
	this.setLongitude = function(longitude) 
	{
			this.longitude = longitude;
	};
	
	this.getLatitude = function() 
	{
			return this.latitude;
	};
	
	this.setLatitude = function(latitude) 
	{
			this.latitude = latitude;
	};

};
	
	
/*
var PosInfo = require('./posInfo.js');
var a = new PosInfo();
console.log(a.getLongitude());
a.setCoord(2, 4);
console.log(a.getLongitude());
*/