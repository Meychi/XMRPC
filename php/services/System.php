<?php

class System
{
	/**
	* Gets the version of the system.
	*/
	public function getVersion()
	{
		return VERSION;
	}
	
	/**
	* Gets the time in milliseconds.
	*/
	public function getServerTime()
	{
		date_default_timezone_set("GMT");
		return round(microtime(true) * 1000);
	}
	
}

?>
