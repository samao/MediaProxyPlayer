package com.vhall.app.net
{
	import com.vhall.app.model.MediaModel;
	import com.vhall.framework.app.net.MessageManager;
	import com.vhall.framework.app.net.WebBridge;
	import com.vhall.framework.log.Logger;
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
		private static var sender:LiveWebBridge = MessageManager.getInstance().getBridge() as LiveWebBridge;
		
		//--------页面请求返回
		
		/**
		 * 发送摄像头列表
		 */		
		public static function getCameras():void
		{
			scanHardware();
			sender.sendCMDMsg({type:MessageType.AJ_CAMERA_LIST,names:Camera.names.concat("禁用视频设备/无设备")});
		}
		
		/**
		 * 发送麦克风列表
		 */		
		public static function getMicrophones():void
		{
			scanHardware();
			sender.sendCMDMsg({type:MessageType.AJ_MICPHONE_LIST,names:Microphone.names});
		}
		
		/**
		 * 发送当前bufferlength
		 * @param value
		 */		
		public static function sendBufferLength():void
		{
			sender.sendBufferMsgToJs(MessageType.AJ_SEND_BUFFER_LENGTH,{content:MediaModel.me().player.bufferLength});
		}
		
		//--------流信息报告
		/**
		 * 通知页面播放的流不存在
		 */		
		public static function streamNotFound():void
		{
			sender.sendCMDMsg({type:MessageType.AJ_STREAM_NOT_FOUND});
			Logger.getLogger("MediaAJ").info("不存在当前播放的流名称:",MediaModel.me().player.uri);
		}
		/**
		 * 通知页面建立服务器链接失败
		 * @param result
		 */		
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
			Logger.getLogger("MediaAJ").info("建立播放通道失败：",result);
		}
		/**
		 * 开始推流通知
		 * @param bool
		 */		
		public static function publishStart():void
		{
			sender.sendCMDMsg({type:MessageType.AJ_PUBLISH_START,isVideoMode:MediaModel.me().player.usedCam?false:true});
		}
		
		/**
		 * 推流端切换线路通知
		 */		
		public static function quiteServer():void
		{
			sender.sendCMDMsg({type:MessageType.AJ_QUITE_SERVER});
		}
	}
}