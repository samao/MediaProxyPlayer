package com.vhall.app.net
{
	import com.vhall.framework.app.net.AbsBridge;
	import com.vhall.framework.app.net.MessageManager;

	/**
	 * flash 发给小助手的消息  as to client 
	 * @author Sol
	 * @date 2016-05-24 21:24:27
	 */	
	public class AssistantACMessage
	{
		private static var sender:AbsBridge = MessageManager.getInstance().getBridge("SOCKET");
	}
}