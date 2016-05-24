package com.vhall.app.net
{
	public class MessageType
	{
		/**	socket 内部消息使用*/
		public static const CONNECT:String = "connect";
		public static const IOERROR:String =  "ioError";
		public static const CLOSE:String = "close";
		public static const SECURITY_ERROR:String = "securityError";
		
		public static const Init:String = "*init";
		
		public static const setDoc:String = "*setDoc";
		
		public static const Died:String = "*died";
		
	}
}