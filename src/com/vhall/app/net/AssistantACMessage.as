package com.vhall.app.net
{
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.net.MessageManager;
	import com.vhall.framework.app.net.SocketBridge;
	import com.vhall.framework.log.Logger;

	/**
	 * flash 发给小助手的消息  as to client
	 * @author Sol
	 * @date 2016-05-24 21:24:27
	 */
	public class AssistantACMessage
	{
		private static var sender:SocketBridge = MessageManager.getInstance().getBridge("SOCKET");

		/**
		 * 查询小助手是否还活着
		 */
		public static function queryEngine(streamID:String):void
		{
			var obj:Object = {};
			obj.stream = streamID;
			sender.sendMsg(MessageType.AC_QUERY_ENGINE, obj);
		}

		/**
		 * 开启小助手
		 */
		public static function startEngine(pid:String, uname:String, streamName:String, token:String, hidePowered:Boolean, address:Array):void
		{
			var obj:Object = {};
			obj.pid = pid;
			obj.uname = uname;
			obj.streamName = streamName;
			obj.token = token;
			obj.hide_powered = hidePowered;
//			obj.address = com.adobe.serialization.json.JSON.encode(address);
			obj.address = JSON.stringify(address);
			Model.playerStatusInfo.assistantOpened = true;
			sender.sendMsg(MessageType.AC_START_ENGINE, obj);
		}

		/**
		 * 停止小助手
		 */
		public static function stopEngine():void
		{
			Logger.getLogger("CAMSG").info("关闭小助手了");
			sender.sendMsg(MessageType.AC_STOP_ENGINE);
			Model.playerStatusInfo.assistantOpened = false;
		}
	}
}


