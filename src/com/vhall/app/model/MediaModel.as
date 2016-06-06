/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.vhall.com		
 * Created:	Jun 2, 2016 5:18:59 PM
 * ===================================
 */

package com.vhall.app.model
{
	import com.vhall.framework.media.video.IVideoPlayer;

	/**
	 * 视频相关信息
	 */	
	public class MediaModel
	{
		/** 禁止摄像头*/
		public var cameraMute:Boolean = false;
		/** 禁止麦克风*/
		public var microphone:Boolean = false;
		/** 当前播放音量*/
		public var volume:Number = 0.68;
		/** netconnection地址或者文件路径*/
		public var netOrFileUrl:String = "http://localhost/vod/1.mp4";
		/** 流名称*/		
		public var streamName:String = "cameraFeed";

		public var player:IVideoPlayer;
		
		/**直播类型,0为视频，其它为语音*/		
		public var videoMode:Boolean = true;
		
		private static var _instance:MediaModel;
		
		public static function me():MediaModel
		{
			return _instance ||= new MediaModel();
		}
	}
}