package com.vhall.app.net
{
	import com.vhall.app.net.MessageType;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	
	public class SocketCCMessage extends AbsMsgReceiver
	{
		override protected function collectionObservers():void
		{
			register(MessageType.CLOSE, onClose);
			register(MessageType.CONNECT, onConnect);
			register(MessageType.IOERROR,onIOError);
			register(MessageType.SECURITY_ERROR, onSecurityError);
		}
		
		private function onClose(data:Object):void
		{
			
		}
		
		private function onConnect(data:Object):void
		{
//			trace(data);
		}
		
		private function onIOError(data:Object):void
		{
			
		}
		
		private function onSecurityError(data:Object):void
		{
			
		}
	}
}