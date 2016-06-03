package com.vhall.app.net
{
	public class AppCMD
	{
		private static const APP_BASE:String = "app_";
		
		/**	控制栏相关*/
		private static const CONTROLBAR:String = "controlbar_";
		public static const CONTROLBAR_INITED:String = CONTROLBAR + "INITED";
		
		/**	视频播放控制播放状态相关*/
		private static const VIDEO:String = "video_";
		public static const VIDEO_INITED:String = VIDEO + "INITED";
		
		public static const VIDEO_SET_BITRATE:String = "video_set_bitrate";
		
		/** 页面回调的通知从播放摄像头视频转向播放服务器视频（观看端或者切嘉宾状态） **/
		public static const TELL_CORE_CAMERA_TO_VIDEO:String = VIDEO + "tellAsCameraToVideo";
		
		/** 通知已经被收回主讲权的嘉宾去终止上报 **/
		public static const TELL_GUEST_TO_END_REPEAT:String = VIDEO + "tellGuestToEndRepeat";
		
		/** 设置摄像头回显 **/
		public static const VIDEO_KERNEL_CAMERA:String = VIDEO + "setKernelCamera";
		/** 视频播放开始*/
		public static const VIDEO_CONTROL_START:String = VIDEO +　"videoStart";
		/** 外部控制视频暂停*/
		public static const VIDEO_CONTROL_RESUME:String = VIDEO + "videoResume";
		/** 播放器暂停*/
		public static const VIDEO_CONTROL_PAUSE:String = VIDEO + "videoPause";
		/**切换播放器播放暂停状态*/
		public static const VIDEO_CONTROL_TOGGLE:String = VIDEO + "videoToggle";
		/** 回放视频seek*/
		public static const VIDEO_CONTROL_SEEK:String = VIDEO + "seek";
		/** 回放视频seek*/
		public static const VIDEO_CONTROL_STOP:String = VIDEO + "controlStop";
		/** 视频seek失败*/
		public static const VIDEO_SEEK_FAIL:String = VIDEO + "seekFail";
		/** 视频seek成功*/
		public static const VIDEO_SEEK_COMPLETE:String = VIDEO + "seekComplete";
		/** 视频播放完毕*/
		public static const VIDEO_FINISH:String = VIDEO + "videoFinish";
		
		/** 视频流数据状态相关*/
		private static const MEDIA:String = "media_";
		/** 更改推流服务器*/
		public static const MEDIA_QUITE_SERVER:String = MEDIA + "quiteServer";
		/** 设置音量,参数0~1*/
		public static const MEDIA_SET_VOLUME:String = MEDIA +　"setVolume";
		/** 切换视频线路*/
		public static const MEDIA_SWITCH_LINE:String = MEDIA + "switchLine";
		/** 切换视频清晰度*/		
		public static const MEDIA_SWITCH_QUALITY:String = MEDIA +　"switchQuality";
		/** 关掉推流端摄像头采集*/
		public static const MEDIA_MUTE_CAMERA:String = MEDIA + "muteCamera";
		/** 关掉推流端麦克风采集*/
		public static const MEDIA_MUTE_MICROPHONE:String = MEDIA + "muteMicrophone";
		/** 关掉推流端硬件采集*/
		public static const MEDIA_MUTE_ALL:String = MEDIA + "muteAll";
		/** 清空当前播放内容*/
		public static const MEDIA_PLAYER_DISPOSE:String = MEDIA + "playerDispose";
		/**	填充buffer*/		
		public static const MEDIA_BUFFER_LOADING:String = MEDIA + "bufferLoaing";
		/** buffer填充完成*/
		public static const MEDIA_BUFFER_FULL:String = MEDIA + "bufferFull";
		/** 更新视频时长*/
		public static const MEDIA_DURATION_UPDATE:String = MEDIA + "durationUpdate";
		/** 播放头位置更新*/
		public static const MEDIA_TIME_UPDATE:String = MEDIA + "timeUpdate";
		
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