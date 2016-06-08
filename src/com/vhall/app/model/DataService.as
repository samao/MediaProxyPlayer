package com.vhall.app.model
{
	import com.vhall.app.model.info.PlayMode;
	

	/**
	 *通用数据处理类 
	 * @author zqh
	 * 
	 */	
	public class DataService
	{
		public function DataService()
		{
		}
		
		/**
		 *更新观看模式 
		 * @param isVideoMode true:音频模式 | false:视频模式
		 * @return 
		 * 
		 */		
		public static function onVideoModelChange(isVideoMode:Boolean):Boolean{
			Model.playerStatusInfo.viewVideoMode = isVideoMode;
			return true;
		}
		
		/**
		 * 更新选择清晰度
		 */	
		public static function onSelectDef(def:String):Boolean{
			var defs:Array = Model.videoInfo.definitionInfo;
			if(defs && defs.length > 0){
				for (var i:int = 0; i < defs.length; i++) 
				{
					if(defs[i].key == def && Model.videoInfo.selectDefVo != defs[i]){
						Model.videoInfo.selectDefVo = defs[i];
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 *更新选择线路 
		 */	
		public static function onSelectServerLine(slName:String):Boolean{
			var sfs:Array = Model.videoInfo.serverLineInfo;
			if(sfs && sfs.length > 0){
				for (var i:int = 0; i < sfs.length; i++) 
				{
					if(sfs[i].sName == slName && Model.videoInfo.selectLineVo != sfs[i]){
						Model.videoInfo.selectLineVo = sfs[i];
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 *更新播放信息 
		 * <br>1.rtmp 视频 需要复制 serverUrl +fileName 需要选择线路，清晰度
		 * <br>2 rtmp 语音 需要复制 serverUrl +fileName 需要选择线路，没有清晰度
		 * <br>3.hls 视频/视频 只需要给serverUrl 没有fileName 只需要选择线路，没有清晰度
		 */	
		public static function updateMediaInfo():void{
			//判断hls还是rtmp
			if(Model.playerStatusInfo.playMode == PlayMode.PLAY_HLS){
				//hls视频语音路径区分
				if(Model.playerStatusInfo.viewVideoMode){
					//当前线路视频地址
					MediaModel.me().netOrFileUrl = Model.videoInfo.selectLineVo.serverUrl;
				}else{
					//当前线路音频地址
					MediaModel.me().netOrFileUrl = Model.videoInfo.selectLineVo.serverAudio;
				}
			}else{
				if(Model.playerStatusInfo.viewVideoMode){
					//当前线路视频地址
					MediaModel.me().netOrFileUrl = Model.videoInfo.selectLineVo.serverUrl;
					MediaModel.me().streamName = Model.videoInfo.selectDefVo.fileName;
				}else{
					//当前线路音频地址
					MediaModel.me().netOrFileUrl = Model.videoInfo.selectLineVo.serverAudio;
					MediaModel.me().streamName = Model.videoInfo.audioSrv;
				}
			}
		}
	
	}
	
}