package org.xmrpc.events 
{
	import flash.events.*;
	
	/**
	* Event that is dispatched after a failed request.
	* @author Mika Palmu
	*/
	public class FailureEvent extends Event
	{
		/**
		* Private properties of the class.
		*/
		private var _errorId:Number;
		private var _message:String;
		
		/**
		* Constant value for failure event.
		*/
		public static const FAILURE:String = "failure";
		
		/**
		* Creates a new instance of the class.
		* @param errorId Internal id of the error.
		* @param message Description message of the error.
		*/
		public function FailureEvent(errorId:Number, message:String)
		{
			super(FAILURE);
			this._errorId = errorId;
			this._message = message;
		}
		
		/**
		* Gets the internal id of the error.
		*/
		public function get errorId():Number
		{
			return this._errorId;
		}
		
		/**
		* Gets the description message of the error.
		*/
		public function get message():String
		{
			return this._message;
		}
		
	}
	
}
