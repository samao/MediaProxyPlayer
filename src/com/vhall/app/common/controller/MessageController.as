package com.vhall.app.common.controller
{
	import com.vhall.app.net.AssistantCAMessage;
	import com.vhall.app.net.MediaJAMessage;
	import com.vhall.app.net.SocketCCMessage;
	import com.vhall.app.net.WebJAMessage;
	import com.vhall.framework.app.common.Controller;
	import com.vhall.framework.app.net.MessageManager;

	/**
	 * 消息注册控制 
	 * @author Sol
	 * 
	 */	
	public class MessageController extends Controller
	{
		/**
		 * 消息注册 
		 * 
		 */		
		public function MessageController()
		{
		}
		
		override protected function initController():void
		{
			// 注册接收的回调
			MessageManager.getInstance().addWebCallBack("sendMsgToAs");
			//注册 socket消息
			MessageManager.getInstance().registMessage(new SocketCCMessage(),"SOCKET");
			MessageManager.getInstance().registMessage(new AssistantCAMessage(), "SOCKET");
			// 注册web js消息
			MessageManager.getInstance().registMessage(new MediaJAMessage());
			MessageManager.getInstance().registMessage(new WebJAMessage());
		}
	}
}