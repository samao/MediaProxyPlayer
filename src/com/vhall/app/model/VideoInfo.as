package com.vhall.app.model
{
	import com.vhall.app.model.vo.DefinitionVo;
	import com.vhall.app.model.vo.ServeLinevo;
	import com.vhall.framework.utils.JsonUtil;

	/**
	 * 当前流数据的一些信息 
	 * @author Sol
	 * 
	 */	
	public class VideoInfo extends BaseInfo
	{
		public function VideoInfo()
		{
			super();
		}
		
		/**
		 *选中线路 
		 */		
		public var selectLineVo:ServeLinevo;
		/**
		 *选中清晰度 
		 */		
		public var selectDefVo:DefinitionVo;
		
		/**
		 *音频流名字(语音流名rtmp下有) 
		 */		
		public var media_srv:String;
		
		/*** 推起流的名称*/
		public var stream_name:String;
		/**
		 *线路数据 
		 */		
		public var serverLineInfo:Array = [];
		/**
		 *清晰度数据 
		 */		
		public var definitionInfo:Array = [];
		/**
		 *清晰度数据(源数据) 
		 */		
		private var _playItem:String;
		
		/**
		 *线路数据(源数据)  
		 */		
		private var _cdnServers:String;
		/**
		 *清晰度数据 
		 */
		public function get playItem():String
		{
			return _playItem;
		}
		
		/**
		 * @private
		 */
		public function set playItem(value:String):void
		{
			_playItem = value;
			try
			{
				//				var arr:Array = JsonUtil.decode(_cdnServers) as Array;
				//				var item:Object = arr[0];
				//				
				//				var def:DefinitionVo = new DefinitionVo("default",item.default);
				//				var middle:DefinitionVo = new DefinitionVo("middle",item.middle);
				//				var low:DefinitionVo = new DefinitionVo("low",item.low);
				//				definitionInfo[0] = def;
				//				definitionInfo[1] = middle;
				//				definitionInfo[2] = low;
			}
			catch(e:Error){}
			definitionInfo.push(new DefinitionVo("default", {"server":"rtmp://ccrtmplive02.t.vhall.com/vhall","file":"465936505_m"}));
			definitionInfo.push(new DefinitionVo("middle", {"server":"rtmp://ccrtmplive02.t.vhall.com/vhall","file":"465936505"}));
			definitionInfo.push(new DefinitionVo("low", {"server":"rtmp://ccrtmplive02.t.vhall.com/vhall","file":"465936505_l"}));
		}
		
		/**服务器选择器的数据源**/
		public function get cdnServers():String
		{
			return _cdnServers;
		}
		
		/**
		 * @private
		 */
		public function set cdnServers(value:String):void
		{
			_cdnServers = value;
			try
			{
				var arr:Array = JsonUtil.decode(_cdnServers) as Array;
				for (var i:int = 0; i < arr.length; i++)
				{
					var su:String = ""
					if(arr[i].hasOwnProperty("srv_audio")){
						su = arr[i].srv_audio;
					}
					//					serverLineInfo.push(new ServeLinevo(arr[i].srv, arr[i].name,su));
				}
			}
			catch(e:Error){}
			serverLineInfo.push(new ServeLinevo("rtmp://cnrtmplive02.e.vhall.com/vhall", "线路1","rtmp://cnrtmplive02.e.vhall.com/vhall"));
			serverLineInfo.push(new ServeLinevo("rtmp://ccrtmplive02.e.vhall.com/vhall", "线路2","rtmp://ccrtmplive02.e.vhall.com/vhall"));
			serverLineInfo.push(new ServeLinevo("rtmp://rtmplive01.e.vhall.com/vhall", "线路3","rtmp://rtmplive01.e.vhall.com/vhall"));
			
		}
	}
}