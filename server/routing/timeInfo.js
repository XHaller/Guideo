module.exports = function TimeInfo()
{
	var len = arguments.length;
	if(0 == len)
	{
		this.openTime = 0;
		this.closeTime = 0;
	}
	else if(2 == len)
	{
		this.openTime = arguments[0];
		this.closeTime = arguments[1];
	}
	
	this.getOpenTime = function() 
	{
			return this.openTime;
	};
	
	this.setOpenTime = function(openTime) 
	{
			this.openTime = openTime;
	};
	
	this.getCloseTime = function() 
	{
			return this.closeTime;
	};
	
	this.setCloseTime = function(closeTime) 
	{
			this.closeTime = closeTime;
	};
	
};


