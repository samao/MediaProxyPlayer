package com.vhall.app.net
{
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.manager.SOManager;
	import com.vhall.framework.app.net.MessageManager;
	import com.vhall.framework.app.net.WebBridge;
	import com.vhall.framework.log.Logger;
	
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.scanHardware;

	public class WebAJMessage
	{
		
		private static var sender:LiveWebBridge = MessageManager.getInstance().getBridge() as LiveWebBridge;
			
		
		/**
		 *上报静音 
		 * 
		 */		
		public static function sendReportMicMuteVolume():void{
			sender.sendCMDMsg({type:MessageType.AJ_MICMUTEVOLUME});
		}
		
		/**
		 *上报安静
		 * 
		 */		
		public static function sendReportMicQuiteVolume():void{
			sender.sendCMDMsg({type:MessageType.AJ_MICQUITEVOLUME});
		}
		
		/**
		 *上报噪音
		 * 
		 */		
		public static function sendReportMicNoiseVolume():void{
			sender.sendCMDMsg({type:MessageType.AJ_MICNOISEVOLUME});
		}
		
		/**
		 *发送初始化信息 
		 * 
		 */		
		public static function sendInitParam():void{
			//发送初始化信息
			//摄像头
			//mic
			//以及从Share中读取的信息
			if (!Model.playerStatusInfo.scanHardwareLock)
			{
				scanHardware();
				Model.playerStatusInfo.scanHardwareLock = true;
			}
			var info:Object = {};
			info.type = MessageType.AJ_INITPARAMS;
			var a:Array = Camera.names;
			a.push("禁用视频设备/无设备");
			info.cameras = a;
			info.mics = Microphone.names;
			var obj:Object = SOManager.getInstance().getValue("setting");
			info.currCamera = obj.cameraName;
			info.currMic = obj.micName;
			info.volume = obj.micVolume;
			info.camWidth = obj.width == null ? 854 : obj.width;
			info.camHeight = obj.height == null ? 480 : obj.height;
			info.definiton = obj.definition;
			info.serverLine = obj.serverLine;
			Logger.getLogger("WebAJMessage").info("read SO name:",obj.cameraName,",micName:",obj.micName,",micVolumn:",obj.micVolumn,",witdth:",obj.width,",height:",obj.height,",definition:",obj.definition,",serverLine:",obj.serverLine);
			sender.sendCMDMsg(info);
		}
		
		/**	通知JS 告知发布流成功*/
		public static function sendPublishSuccess():void
		{
			var obj:Object = {};
			obj.type = MessageType.AJ_PUBLISH_START;
			sender.sendCMDMsg(obj);
		}
	}
}