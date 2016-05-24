package com.vhall.app.net
{
	import com.vhall.framework.app.net.AbsBridge;
	import com.vhall.framework.app.net.MessageManager;

	/**
	 * 流媒体推送消息， as to js 
	 * @author Sol
	 * @date 2016-05-24 21:08:05
	 */	
	public class MediaAJMessage
	{
		private static var sender:AbsBridge = MessageManager.getInstance().getBridge();
		
		public static function AJ_XXX():void
		{
			sender.sendMsg(MessageType.Init);
		}
	}
}