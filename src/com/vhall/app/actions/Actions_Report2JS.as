package com.vhall.app.actions
{
	public class Actions_Report2JS
	{
		public function Actions_Report2JS()
		{
		}
		
		/** js通知关闭检测麦克风上报**/
		public static const JS_CLOS_VOLUME_REEPEAT:String = "jsTellToCloseRepeat";
		/**
		 *开启上报 
		 */		
		public static const STOP_MIC_REPEAT:String = "stopMicRepeat";
		/**
		 *关闭上报 
		 */		
		public static const START_MIC_REPEAT:String = "startMicRepeat";
	}
}