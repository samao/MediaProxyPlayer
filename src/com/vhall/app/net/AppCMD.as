package com.vhall.app.net
{
	public class AppCMD
	{
		private static const APP_BASE:String = "app_";
		
		/**	控制栏相关*/
		private static const CONTROLBAR:String = "controlbar_";
		public static const CONTROLBAR_INITED:String = CONTROLBAR + "INITED";
		
		/**	视频播放控制相关*/
		private static const VIDEO:String = "video_";
		public static const VIDEO_INITED:String = VIDEO + "INITED";
		
		public static const VIDEO_SET_BITRATE:String = "video_set_bitrate";
		
		/** 页面回调的通知从播放摄像头视频转向播放服务器视频（观看端或者切嘉宾状态） **/
		public static const TELL_CORE_CAMERA_TO_VIDEO:String = VIDEO + "tellAsCameraToVideo";
		
		/** 通知已经被收回主讲权的嘉宾去终止上报 **/
		public static const TELL_GUEST_TO_END_REPEAT:String = VIDEO + "tellGuestToEndRepeat";
		/** 显示声音直播图 **/
		public static const SHOW_AUDIOLIVE_PIC:String = VIDEO + "showAudioLivePic";
		
		/** 设置摄像头回显 **/
		public static const VIDEO_KERNEL_CAMERA:String = VIDEO + "setKernelCamera";
		/** 视频播放开始*/
		public static const VIDEO_CONTROL_START:String = VIDEO +　"controlStart";
		/** 外部控制视频暂停*/
		public static const VIDEO_CONTROL_RESUME:String = VIDEO + "controlResume";
		/** 播放器暂停*/
		public static const VIDEO_CONTROL_PAUSE:String = VIDEO + "controlPause";
		/**切换播放器播放暂停状态*/
		public static const VIDEO_CONTROL_TOGGLE:String = VIDEO + "controlToggle";
		/** 回放视频seek*/
		public static const VIDEO_CONTROL_SEEK:String = VIDEO + "controlSeek";
		/** 回放视频停止播放*/
		public static const VIDEO_CONTROL_STOP:String = VIDEO + "controlStop";
		
		/**视频播放状态通知*/
		private static const MEDIA_STATES:String = "mediaState_";
		/** 视频播放开始*/
		public static const MEDIA_STATES_START:String = MEDIA_STATES + "start";
		/** 视频播放完毕*/
		public static const MEDIA_STATES_FINISH:String = MEDIA_STATES + "finish";
		/** 视频播放暂停*/
		public static const MEDIA_STATES_PAUSE:String = MEDIA_STATES + "pause";
		/** 视频播放暂停恢复*/
		public static const MEDIA_STATES_UNPAUSE:String = MEDIA_STATES + "unpause";
		/** 视频seek失败*/
		public static const MEDIA_STATES_SEEK_FAIL:String = MEDIA_STATES + "seekFail";
		/** 视频seek成功*/
		public static const MEDIA_STATES_SEEK_COMPLETE:String = MEDIA_STATES + "seekComplete";
		/**	填充buffer*/		
		public static const MEDIA_STATES_BUFFER_LOADING:String = MEDIA_STATES + "bufferLoaing";
		/** buffer填充完成*/
		public static const MEDIA_STATES_BUFFER_FULL:String = MEDIA_STATES + "bufferFull";
		
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
		/** 更新视频时长*/
		public static const MEDIA_DURATION_UPDATE:String = MEDIA + "durationUpdate";
		/** 播放头位置更新*/
		public static const MEDIA_TIME_UPDATE:String = MEDIA + "timeUpdate";
		
		/** 推流控制相关*/
		private static const PUBLISH:String = "publish_";
		/** 让推流端开始推流*/
		public static const PUBLISH_START:String = PUBLISH + "start";
		/** 让推流端结束推流*/
		public static const PUBLISH_END:String = PUBLISH + "end";
		
		private static const BARRAGE:String = "barrage_"
		/**
		 *发送弹幕 
		 */		
		public static const BARRAGE_ADD:String = BARRAGE + "add";
		/**	开启弹幕功能*/
		public static const BARRAGE_OPEN:String = BARRAGE + "open";
		public static const BARRAGE_CLOSE:String = BARRAGE + "close"
		
		
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