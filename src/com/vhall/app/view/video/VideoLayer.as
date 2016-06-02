package com.vhall.app.view.video
{
	import com.vhall.app.actions.Actions_Report2JS;
	import com.vhall.app.common.Layer;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.net.MediaAJMessage;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.media.provider.MediaProxyStates;
	import com.vhall.framework.media.provider.MediaProxyType;
	import com.vhall.framework.media.video.VideoPlayer;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import appkit.responders.NResponder;
	
	public class VideoLayer extends Layer implements IResponder
	{
		private var _videoPlayer:VideoPlayer;
		
		public function VideoLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_videoPlayer ||= VideoPlayer.create();
			addChild(_videoPlayer);
			_videoPlayer.connect(MediaProxyType.HTTP,"http://localhost/vod/1.mp4");
			
			doubleClickEnabled = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.DOUBLE_CLICK,mouseHandler)
			
			//回放增加屏幕暂停功能
			if(_videoPlayer.type == MediaProxyType.PUBLISH || _videoPlayer.type == MediaProxyType.RTMP)
			{
				addEventListener(MouseEvent.CLICK,mouseHandler);
			}		
		}
		
		public function careList():Array
		{
			return [Actions_Report2JS.BUFFER_LENGTH,
				AppCMD.QUITE_SERVER,
				AppCMD.MEDIA_SET_VOLUME,
				AppCMD.MEDIA_SWITCH_LINE,
				AppCMD.MEDIA_SWITCH_QUALITY,
				AppCMD.MEDIA_PLAYER_DISPOSE,
				AppCMD.MEDIA_MUTE_ALL,
				AppCMD.MEDIA_MUTE_CAMERA,
				AppCMD.MEDIA_MUTE_MICROPHONE
			];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			switch(msg)
			{
				case Actions_Report2JS.BUFFER_LENGTH:
					MediaAJMessage.sendBufferLength(_videoPlayer.bufferLength);
					break;
				case AppCMD.QUITE_SERVER:
					_videoPlayer.attachType(protocol(info.netOrFileUrl),info.netOrFileUrl,info.streamName);
					break;
				case AppCMD.MEDIA_SET_VOLUME:
					_videoPlayer.volume = info.volume;
					break;
				case AppCMD.MEDIA_SWITCH_LINE:
					_videoPlayer.attachType(protocol(info.netOrFileUrl),info.netOrFileUrl,info.streamName);
					break;
				case AppCMD.MEDIA_MUTE_ALL:
					_videoPlayer.cameraMuted = info.cameraMute;
					_videoPlayer.microphoneMuted = info.microphone;
					break;
				case AppCMD.MEDIA_MUTE_CAMERA:
					_videoPlayer.cameraMuted = info.cameraMute;
					break;
				case AppCMD.MEDIA_MUTE_MICROPHONE:
					_videoPlayer.microphoneMuted = info.microphone;
					break;
				case AppCMD.MEDIA_PLAYER_DISPOSE:
					_videoPlayer.stop();
					break;
			}
		}
		
		private function videoHandler(states:String,...value):void
		{
			switch(states)
			{
				case MediaProxyStates.CONNECT_NOTIFY:
					break;
				case MediaProxyStates.CONNECT_FAILED:
					MediaAJMessage.connectFail(value[0]);
					break;
				case MediaProxyStates.STREAM_NOT_FOUND:
					MediaAJMessage.streamNotFound(value[0]);
					break;
				case MediaProxyStates.PUBLISH_NOTIFY:
					MediaAJMessage.publishStart(_videoPlayer.usedCam ? false : true);
					break;
				case MediaProxyStates.STREAM_START:
					send(AppCMD.VIDEO_START);
					break;
				case MediaProxyStates.STREAM_STOP:
					send(AppCMD.VIDEO_FINISH);
					break;
				case MediaProxyStates.STREAM_LOADING:
					send(AppCMD.BUFFER_LOADING);
					break;
				case MediaProxyStates.STREAM_FULL:
					send(AppCMD.BUFFER_FULL);
					break;
				case MediaProxyStates.UN_PUBLISH_NOTIFY:
					break;
				case MediaProxyStates.PUBLISH_BAD_NAME:
					//重推
					break;
			}
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.CLICK:
					_videoPlayer.toggle();
					//_videoPlayer.isPlaying?send():send();
					break;
				case MouseEvent.DOUBLE_CLICK:
					//全屏切换
					StageManager.toggleFullscreen(e);
					break;
			}
		}
		
		override public function setSize(w:Number,h:Number):void
		{
			super.setSize(w,h);
			
			if(stage)
			{
				var rect:Rectangle = null;
				
				if(stage.displayState != StageDisplayState.NORMAL)
				{
					rect = new Rectangle(0,0,w,h);
				}else{
					//底部控制了高度
					const CONTROL_BAR_HEIGHT:uint = 35;
					rect = new Rectangle(0,0,w,h - CONTROL_BAR_HEIGHT);
				}
				_videoPlayer.viewPort = rect;
			}
		}
		
		/**
		 * 根据业务逻辑和用户数据返回当前协议类型
		 * @param uri
		 * @return 
		 */		
		private function protocol(uri:String):String
		{
			if(uri.indexOf("rtmp://") == 0)
			{
				if(Model.Me().userinfo.is_pres)
				{
					return MediaProxyType.PUBLISH;
				}
				return MediaProxyType.RTMP
			}
			
			const p:String = uri.replace(/\?.+/ig,"");
			const exName:String = ".m3u8";
			const lastIndexExName:int = p.length - exName.length;
			if(lastIndexExName >= 0 && lastIndexExName == p.indexOf(exName)){
				return MediaProxyType.HLS;
			}
			
			return MediaProxyType.HTTP;
		}
		
		private function get info():MediaModel
		{
			return MediaModel.me();
		}
		
		private function send(action:String,param:Array = null):void
		{
			NResponder.dispatch(action,param);
		}
	}
}