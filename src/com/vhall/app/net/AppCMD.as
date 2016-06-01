package com.vhall.app.net
{
	public class AppCMD
	{
		private static const APP_BASE:String = "app_";
		
		/**	控制栏相关*/
		private static const CONTROLBAR:String = "controlbar_";
		public static const CONTROLBAR_INITED:String = CONTROLBAR + "INITED";
		
		/**	视频相关*/
		private static const VIDEO:String = "video_";
		public static const VIDEO_INITED:String = VIDEO + "INITED";
		
		public static const VIDEO_SET_BITRATE:String = "video_set_bitrate";
		
		
		/**
		 *发送弹幕 
		 */		
		public static const ADD_BARRAGE:String = "add_barrage";
		
		/**上报 相关*/
		private static const REPORT:String = "report_";
		/** js通知关闭检测麦克风上报**/
		public static const REPORT_JS_CLOS_VOLUME_REEPEAT:String = REPORT+"jsTellToCloseRepeat";
		/**
		 *开启上报 
		 */		
		public static const REPORT_STOP_MIC_REPEAT:String = REPORT+"stopMicRepeat";
		/**
		 *关闭上报 
		 */		
		public static const REPORT_START_MIC_REPEAT:String = REPORT+"startMicRepeat";
		
		/**
		 *ui相关 
		 */		
		public static const UI:String = "ui_"
		/**
		 显示结束播放图 
		 */		
		public static const SHOWWARN_OVER_PIC:String = "showOverPic";
		/**
		 *切换中 
		 */		
		public static const SWITCHINGPRES:String = "switchingPres";
		/**
		 *给你 
		 */		
		public static const SWTICHTOYOU:String = "swtichToYou";
		/**
		 *切换来宾 
		 */		
		public static const SWITCHTOGUEST:String = "switchToGuest"
		
		/**	显示当前正在使用小助手直播*/
		public static const SWITCH_TO_ASSISTANT:String = UI + "switchToAssistant";
		/**
		 * 窗口缩放
		 */		
		public static const UI_WINDOW_RESIZE:String = UI+"windowResize";
	}
}