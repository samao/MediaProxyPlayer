package com.vhall.app.net
{
	import com.vhall.framework.app.net.MessageManager;
	import com.vhall.framework.app.net.WebBridge;
	import com.vhall.framework.media.provider.InfoCode;
	
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.scanHardware;

	/**
	 * 流媒体推送消息， as to js 
	 * @author Sol
	 * @date 2016-05-24 21:08:05
	 */	
	public class MediaAJMessage
	{
		public static function getCameras():void
		{
			scanHardware();
			notify({type:MessageType.AJ_CAMERA_LIST,names:Camera.names});
		}
		
		public static function getMicrophones():void
		{
			scanHardware();
			notify({type:MessageType.AJ_MICPHONE_LIST,names:Microphone.names})
		}
		
		public static function quiteServer():void
		{
			notify({type:MessageType.AJ_QUITE_SERVER});
		}
		
		public static function sendBufferLength(value:Number):void
		{
			notify({content:value},BridgeMsgType.SEND_MSG_TO_FLASH);
		}
		
		public static function streamNotFound():void
		{
			notify({type:MessageType.AJ_STREAM_NOT_FOUND});
		}
		
		public static function connectFail(result:String):void
		{
			switch(result)
			{
				case InfoCode.NetConnection_Connect_Closed:
					notify({type:MessageType.AJ_PULL_CONNECT_CLOSED});
					break;
				case InfoCode.NetConnection_Connect_Failed:
					notify({type:MessageType.AJ_PULL_CONNECT_FAIL});
					break;
			}
		}
		
		public static function publishStart(bool:Boolean):void
		{
			notify({type:MessageType.AJ_PUBLISH_START,isVideoMode:bool});
		}
		
		private static function notify(body:Object,type:String = BridgeMsgType.SEND_CMD_MSG):void
		{
			var sender:WebBridge = MessageManager.getInstance().getBridge();
			sender.sendMsg(type,body,false);
		}
	}
}