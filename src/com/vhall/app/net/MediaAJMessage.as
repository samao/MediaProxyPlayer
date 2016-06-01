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
		private static var sender:WebBridge = MessageManager.getInstance().getBridge();
		
		public static function getCameras():void
		{
			scanHardware();
			sender.sendCMDMsg({type:MessageType.AJ_CAMERA_LIST,names:Camera.names});
		}
		
		public static function getMicrophones():void
		{
			scanHardware();
			sender.sendCMDMsg({type:MessageType.AJ_MICPHONE_LIST,names:Microphone.names});
		}
		
		public static function quiteServer():void
		{
			sender.sendCMDMsg({type:MessageType.AJ_QUITE_SERVER});
		}
		
		public static function sendBufferLength(value:Number):void
		{
			sender.sendCMDMsg({content:value});
		}
		
		public static function streamNotFound():void
		{
			sender.sendCMDMsg({type:MessageType.AJ_STREAM_NOT_FOUND});
		}
		
		public static function connectFail(result:String):void
		{
			switch(result)
			{
				case InfoCode.NetConnection_Connect_Closed:
					sender.sendCMDMsg({type:MessageType.AJ_PULL_CONNECT_CLOSED});
					break;
				case InfoCode.NetConnection_Connect_Failed:
					sender.sendCMDMsg({type:MessageType.AJ_PULL_CONNECT_FAIL});
					break;
			}
		}
		
		public static function publishStart(bool:Boolean):void
		{
			sender.sendCMDMsg({type:MessageType.AJ_PUBLISH_START,isVideoMode:bool});
		}
	}
}