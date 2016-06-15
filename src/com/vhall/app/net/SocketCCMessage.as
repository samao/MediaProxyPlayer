package com.vhall.app.net
{
	import com.vhall.app.model.Model;
	import com.vhall.app.net.MessageType;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	import com.vhall.framework.log.Logger;
	
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
			log("socket close");
		}
		
		private function onConnect(data:Object):void
		{
			log("socket connect, pid:" + Model.Me().meetinginfo.pid);
			AssistantACMessage.queryEngine(Model.Me().meetinginfo.pid);
		}
		
		private function onIOError(data:Object):void
		{
			log("socket IOError");
		}
		
		private function onSecurityError(data:Object):void
		{
			log("socket SecurityError");
		}
		
		private function log(...args):void
		{
			Logger.getLogger("[Socket CC]").info(args);
		}
	}
}