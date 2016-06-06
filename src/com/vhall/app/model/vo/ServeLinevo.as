package com.vhall.app.model.vo
{
	import org.mangui.hls.demux.AACDemuxer;

	/**
	 *切线数据实体 
	 * @author zqh
	 * 
	 */	
	public class ServeLinevo
	{
		public function ServeLinevo(serverUrl:String,sname:String,serverAudioUrl:String)
		{
			_serverUrl = serverUrl;
			_sname = sname;
			_serverAudio = serverAudioUrl;
		}
		
		private var _serverUrl:String;
		private var _sname:String;
		private var _serverAudio:String;

		public function get serverAudio():String
		{
			return _serverAudio;
		}

		public function set serverAudio(value:String):void
		{
			_serverAudio = value;
		}

		public function get sname():String
		{
			return _sname;
		}

		public function set sname(value:String):void
		{
			_sname = value;
		}

		public function get serverUrl():String
		{
			return _serverUrl;
		}

		public function set serverUrl(value:String):void
		{
			_serverUrl = value;
		}
		
		public function clone():ServeLinevo{
			return new ServeLinevo(_serverUrl,_sname,_serverAudio);
		}
	}
}