package org.xmrpc
{
	import org.sepy.io.*
	import org.xmrpc.events.*;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;
	
	/**
	* Handles the sending and receiving data with the XMRPC handler.
	* @author Mika Palmu
	*/
	public class XMRPC extends EventDispatcher
	{
		/**
		* Private properties of the class.
		*/
		private var address:String;
		
		/**
		* Creates a new instance of the class.
		* @param address Address of the service handler.
		*/
		public function XMRPC(address:String)
		{
			this.address = address;
		}
		
		/**
		* Sends a request to the service handler.
		* @param service The service that will be called.
		* @param params An array of parameters to be sent.
		*/
		public function sendRequest(service:String, params:Array = null):void
		{
			try 
			{
				if (params == null) params = [];
				var loader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest(this.address);
				var serialized:String = Serializer.serialize(params);
				loader.addEventListener("complete", this.onResponse);
				loader.addEventListener("securityError", this.onFailure);
				loader.addEventListener("ioError", this.onFailure);
				request.data = "<xmrpc service=\"" + service + "\"><params><![CDATA[" + serialized + "]]></params></xmrpc>";
				request.contentType = "text/xml";
				request.method = "post";
				loader.load(request);
			}
			catch (thrown:Error)
			{
				var error:ErrorEvent = new ErrorEvent("error", false, thrown.message);
				this.onFailure(error);
			}
		}
		
		/**
		* Handles the response recieved from the server.
		* @param event Event that describes the request result.
		*/
		private function onResponse(event:Event):void
		{
			try 
			{
				var xmrpc:XML = new XML(event.target.data);
				var status:String = xmrpc.attribute("status");
				if (status == "ok")
				{
					var result:XMLList = xmrpc.child("result");
					var unserialized:Object = Serializer.unserialize(result);
					var response:ResponseEvent = new ResponseEvent(unserialized);
					this.dispatchEvent(response);
				}
				else
				{
					var message:XMLList = xmrpc.child("error");
					var errorId:Number = Number(message.attribute("id"));
					var failure:FailureEvent = new FailureEvent(errorId, message);
					this.dispatchEvent(failure);
				}
			}
			catch (thrown:Error)
			{
				var error:ErrorEvent = new ErrorEvent("error", false, thrown.message);
				this.onFailure(error);
			}
		}
		
		/**
		* Handles all error events invoked by ActionScript.
		* @param event Error event that describes the error.
		*/
		private function onFailure(event:ErrorEvent):void
		{
			var failure:FailureEvent = new FailureEvent(200, event.text);
			this.dispatchEvent(failure);
		}
		
	}
	
}
