package org.xmrpc.enums 
{
	/**
	* Error types used by the XMRPC service.
	* @author Mika Palmu
	*/
	public class ErrorType
	{
		/**
		* Constant value for "flash error" error.
		*/
		public static const FLASH_ERROR:Number = 200;
		
		/**
		* Constant value for "get disabled" error.
		*/
		public static const GET_DISABLED:Number = 300;
		
		/**
		* Constant value for "invalid syntax" error.
		*/
		public static const INVALID_SYNTAX:Number = 301;
		
		/**
		* Constant value for "illegal characters" error.
		*/
		public static const ILLEGAL_CHARACTERS:Number = 302;
		
		/**
		* Constant value for "invalid method" error.
		*/
		public static const INVALID_METHOD:Number = 303;
		
		/**
		* Constant value for "invalid class" error.
		*/
		public static const INVALID_CLASS:Number = 304;
		
		/**
		* Constant value for "server failure" error.
		*/
		public static const SERVER_FAILURE:Number = 305;
		
	}
	
}
