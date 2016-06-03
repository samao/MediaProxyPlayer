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
		public var netOrFileUrl:String = "";
		/** 流名称*/		
		public var streamName:String = "";

		public var player:IVideoPlayer;
		
		private static var _instance:MediaModel;
		
		public static function me():MediaModel
		{
			return _instance ||= new MediaModel();
		}
	}
}