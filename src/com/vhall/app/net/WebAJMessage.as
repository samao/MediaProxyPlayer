package com.vhall.app.net
{
	import com.vhall.framework.app.net.AbsBridge;
	import com.vhall.framework.app.net.MessageManager;
	import com.vhall.framework.app.net.WebBridge;

	public class WebAJMessage
	{
		
		private static var sender:WebBridge = MessageManager.getInstance().getBridge();
			
		
		/**
		 *上报静音 
		 * 
		 */		
		public static function sendReportMicMuteVolume():void{
			sender.sendCMDMsg({type:"*micMuteVolume"});
		}
		
		/**
		 *上报安静
		 * 
		 */		
		public static function sendReportMicQuiteVolume():void{
			sender.sendCMDMsg({type:"*micQuiteVolume"});
		}
		
		/**
		 *上报噪音
		 * 
		 */		
		public static function sendReportMicNoiseVolume():void{
			sender.sendCMDMsg({type:"*micNoiseVolume"});
		}
		
		
	}
}