package com.vhall.app.view.video
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.net.MediaAJMessage;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.log.Logger;
	import com.vhall.framework.media.provider.MediaProxyStates;
	import com.vhall.framework.media.provider.MediaProxyType;
	import com.vhall.framework.media.video.VideoPlayer;
	import com.vhall.framework.utils.JsonUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import appkit.responders.NResponder;
	
	public class VideoLayer extends Layer implements IResponder
	{
		private var _videoPlayer:VideoPlayer;
		
		private var _postionId:int;
		private var _retryId:int;
		private var _preTime:Number = 0;
		
		public function VideoLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			info.player = _videoPlayer ||= VideoPlayer.create();
			_videoPlayer.volume = info.volume;
			addChild(_videoPlayer);
			
			log("演讲中:",Model.Me().userinfo.is_pres,info.netOrFileUrl,info.streamName);
			if(Model.Me().userinfo.is_pres)
			{
				_videoPlayer.publish(info._soCamera,info._soMicrophone,info.netOrFileUrl,info.streamName,videoHandler,info._soCamWidth,info._soCamHeight);
			}else{
				_videoPlayer.connect(protocol(info.netOrFileUrl),info.netOrFileUrl,info.streamName,videoHandler);
			}
			
			doubleClickEnabled = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.DOUBLE_CLICK,mouseHandler)
			
			//回放增加屏幕暂停功能
			if([MediaProxyType.HLS,MediaProxyType.HTTP].indexOf(_videoPlayer.type) != -1)
			{
				addEventListener(MouseEvent.CLICK,mouseHandler);
			}		
		}
		
		public function careList():Array
		{
			return [AppCMD.REPROT_BUFFER_LENGTH,
				AppCMD.MEDIA_QUITE_SERVER,
				AppCMD.MEDIA_SET_VOLUME,
				AppCMD.MEDIA_SWITCH_LINE,
				AppCMD.MEDIA_SWITCH_QUALITY,
				AppCMD.MEDIA_PLAYER_DISPOSE,
				AppCMD.MEDIA_MUTE_ALL,
				AppCMD.MEDIA_MUTE_CAMERA,
				AppCMD.MEDIA_MUTE_MICROPHONE,
				AppCMD.VIDEO_CONTROL_PAUSE,
				AppCMD.VIDEO_CONTROL_RESUME,
				AppCMD.VIDEO_CONTROL_TOGGLE,
				AppCMD.VIDEO_CONTROL_SEEK,
				AppCMD.VIDEO_CONTROL_START,
				AppCMD.VIDEO_CONTROL_STOP,
				AppCMD.PUBLISH_START,
				AppCMD.PUBLISH_END
			];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			log("收到消息:" + msg + JsonUtil.encode(parameters));
			switch(msg)
			{
				case AppCMD.REPROT_BUFFER_LENGTH:
					MediaAJMessage.sendBufferLength();
					break;
				case AppCMD.MEDIA_QUITE_SERVER:
					MediaAJMessage.quiteServer();
					break;
				case AppCMD.MEDIA_SET_VOLUME:
					_videoPlayer.volume = info.volume;
					break;
				case AppCMD.MEDIA_SWITCH_LINE:
					break;
				case AppCMD.MEDIA_SWITCH_QUALITY:
					//_videoPlayer.attachType(protocol(info.netOrFileUrl),info.netOrFileUrl,info.streamName,true,_videoPlayer.time);
					break;
				case AppCMD.MEDIA_PLAYER_DISPOSE:
					_videoPlayer.dispose();
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
				case AppCMD.VIDEO_CONTROL_PAUSE:
					_videoPlayer.pause();
					break;
				case AppCMD.VIDEO_CONTROL_RESUME:
					_videoPlayer.resume();
					break;
				case AppCMD.VIDEO_CONTROL_TOGGLE:
					_videoPlayer.toggle();
					break;
				case AppCMD.VIDEO_CONTROL_SEEK:
					if([MediaProxyType.HLS,MediaProxyType.HTTP].indexOf(_videoPlayer.type) != -1)
					{
						_videoPlayer.time = parameters[0];
					}
					break;
				case AppCMD.VIDEO_CONTROL_START:
					_videoPlayer.start();
					break;
				case AppCMD.VIDEO_CONTROL_STOP:
					_videoPlayer.stop();
					break;
				case AppCMD.PUBLISH_START:
					if(_videoPlayer.type == MediaProxyType.PUBLISH)
					{
						//开始推流
						_videoPlayer.attachType(protocol(info.netOrFileUrl),info.netOrFileUrl,info.streamName,true,0,info._soCamera,info._soMicrophone,info._soCamWidth,info._soCamHeight);
					}
					break;
				case AppCMD.PUBLISH_END:
					if(_videoPlayer.type == MediaProxyType.PUBLISH)
					{
						_videoPlayer.dispose();
					}
					break;
			}
		} 
		
		private function videoHandler(states:String,...value):void
		{
			switch(states)
			{
				case MediaProxyStates.CONNECT_NOTIFY:
					log("通道建立成功");
					clearTimer();
					_postionId = setInterval(timeCheck,1000);
					break;
				case MediaProxyStates.CONNECT_FAILED:
					clearTimer();
					MediaAJMessage.connectFail(value[0]);
					break;
				case MediaProxyStates.STREAM_NOT_FOUND:
					clearTimer();
					MediaAJMessage.streamNotFound();
					break;
				case MediaProxyStates.PUBLISH_START:
					MediaAJMessage.publishStart();
					break;
				case MediaProxyStates.STREAM_START:
					send(AppCMD.MEDIA_STATES_START);
					loading = true;
					break;
				case MediaProxyStates.STREAM_PAUSE:
					send(AppCMD.MEDIA_STATES_PAUSE);
					break;
				case MediaProxyStates.STREAM_UNPAUSE:
					send(AppCMD.MEDIA_STATES_UNPAUSE);
					break;
				case MediaProxyStates.STREAM_STOP:
					send(AppCMD.MEDIA_STATES_FINISH);
					break;
				case MediaProxyStates.STREAM_FULL:
				case MediaProxyStates.PUBLISH_NOTIFY:
					loading = false;
					break;
				case MediaProxyStates.STREAM_LOADING:
				case MediaProxyStates.UN_PUBLISH_NOTIFY:
					loading = true;
					//_videoPlayer.stop();
					break;
				case MediaProxyStates.PUBLISH_BAD_NAME:
					//重推
					_retryId = setTimeout(publishForBadName,1000);
					break;
				case MediaProxyStates.DURATION_NOTIFY:
					send(AppCMD.MEDIA_DURATION_UPDATE,[_videoPlayer.duration]);
					log("视频时长:"+_videoPlayer.duration);
					break;
				case MediaProxyStates.SEEK_COMPLETE:
					send(AppCMD.MEDIA_STATES_SEEK_COMPLETE);
					break;
				case MediaProxyStates.SEEK_FAILED:
					send(AppCMD.MEDIA_STATES_SEEK_FAIL);
					break;
			}
		}
		
		private function set loading(bool:Boolean):void
		{
			if(_videoPlayer.type != MediaProxyType.PUBLISH)
			{
				if(bool)
				{
					send(AppCMD.MEDIA_STATES_BUFFER_LOADING);
					send(AppCMD.UI_SHOW_LOADING);
				}else{
					send(AppCMD.MEDIA_STATES_BUFFER_FULL);
					send(AppCMD.UI_HIDE_LOADING);
				}
			}
		}
		
		private function publishForBadName():void
		{
			_videoPlayer.changeVideoUrl(info.netOrFileUrl,info.streamName);
		}
		
		private function clearTimer():void
		{
			clearInterval(_postionId);
			clearTimeout(_retryId);
		}
		
		private function timeCheck():void
		{
			if(_videoPlayer.time == _preTime) return;
			_preTime = _videoPlayer.time;
			if(-1 != [MediaProxyType.RTMP,MediaProxyType.PUBLISH].indexOf(_videoPlayer.type))
			{
				send(AppCMD.MEDIA_TIME_UPDATE);
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
					const CONTROL_BAR_HEIGHT:uint = 0;
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
			//log("发送消息",action,param);
			NResponder.dispatch(action,param);
		}
		
		private function log(...value):void
		{
			Logger.getLogger("VideoLayer").info(value);
		}
	}
}