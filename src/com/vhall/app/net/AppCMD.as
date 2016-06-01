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
		public static const UI_SHOWWARN_OVER_PIC:String = UI+"showOverPic";
		/**
		 *显示切换中 
		 */		
		public static const UI_SHOWWARN_SWITCHINGPRESPIC:String = UI+"switchingPres";
		/**
		 *切换给你 
		 */		
		public static const UI_SHOWWARN_SWTICHTOYOU:String = UI+"swtichToYou";
		/**
		 *切换给来宾 
		 */		
		public static const UI_SHOWWARN_SWITCHTOGUEST:String = UI+"switchToGuest"
	}
}