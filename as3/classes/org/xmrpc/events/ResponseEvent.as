package org.xmrpc.events
{
	import flash.events.*;
	
	/**
	* Event that is dispatched after a succesfull request.
	* @author Mika Palmu
	*/
	public class ResponseEvent extends Event
	{
		/**
		* Private properties of the class.
		*/
		private var _result:*;
		
		/**
		* Constant value for response event.
		*/
		public static const RESPONSE:String = "response";
		
		/**
		* Creates a new instance of the class.
		* @param result Object recieved from the server.
		*/
		public function ResponseEvent(result:*)
		{
			super(RESPONSE);
			this._result = result;
		}
		
		/**
		* Gets the result object recieved from the server.
		*/
		public function get result():*
		{ 
			return this._result;
		}
		
	}
	
}
