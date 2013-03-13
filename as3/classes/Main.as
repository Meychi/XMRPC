package
{
	import org.xmrpc.*;
	import org.xmrpc.events.*;
	import flash.display.*;
	
	/**
	* Does some random tests with the XMRPC service.
	* @author Mika Palmu
	*/
	public class Main extends Sprite 
	{
		/**
		* Creates a new instance of the class.
		*/
		public function Main():void
		{
			var xmrpc:XMRPC = new XMRPC("http://www.xmrpc.org/xmrpc/index.php");
			xmrpc.addEventListener(ResponseEvent.RESPONSE, this.onResponse);
			xmrpc.addEventListener(FailureEvent.FAILURE, this.onFailure);
			xmrpc.sendRequest("System.getServerTime");
		}
		
		/**
		* Handles the recieved failure event.
		* @param event Event that describes the failure.
		*/
		private function onFailure(event:FailureEvent):void
		{
			trace("Failure: " + event.errorId + " -> " + event.message);
		}
		
		/**
		* Handles the recieved response event.
		* @param event Event that describes the response.
		*/
		private function onResponse(event:ResponseEvent):void
		{
			trace("Response: " + event.result);
			var date:Date = new Date(); 
			date.setTime(event.result);
			trace("Timestamp: " + date.toString());
		}
		
	}
	
}
