package com.vhall.app.view.video
{
	import appkit.responders.NResponder;
	
	import com.vhall.app.common.Layer;
	import com.vhall.app.model.DataService;
	import com.vhall.app.common.Resource;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.net.MediaAJMessage;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.load.ResourceLoader;
	import com.vhall.framework.log.Logger;
	import com.vhall.framework.media.provider.MediaProxyStates;
	import com.vhall.framework.media.provider.MediaProxyType;
	import com.vhall.framework.media.video.VideoPlayer;
	import com.vhall.framework.utils.JsonUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	public class VideoLayer extends Layer implements IResponder
	{
		private var _videoPlayer:VideoPlayer;
		
		private var _postionId:int;
		private var _retryId:int;
		private var _preTime:Number = 0;
		
		private var _micActivity:AudioModelPicComp;
		
		private const MAX_RETRY:uint = 6;
		
		private var _retryTimes:uint = 0;
		
		private var _loading:Boolean = false;
		
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
			
			doubleClickEnabled = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.DOUBLE_CLICK,mouseHandler)
			
			var l:ResourceLoader =new ResourceLoader();
			l.load({type:1,url:Resource.getResource("MicrophoneActivity")},function(item:Object, content:Object, domain:ApplicationDomain):void
			{
				_micActivity = new AudioModelPicComp();
				_micActivity.skin = content as MovieClip;
				autoStart();
			},null,function():void
			{
				log("加载语音状态资源失败");
				autoStart();
			});
		}
		
		private function autoStart():void
		{
			//log("演讲中:",Model.userInfo.is_pres,info.netOrFileUrl,info.streamName);
			
			/*if(Model.userInfo.is_pres)
			{
				_videoPlayer.publish(info._soCamera,info._soMicrophone,info.netOrFileUrl,info.streamName,videoHandler,info._soCamWidth,info._soCamHeight);
			}else{
				_videoPlayer.connect(protocol(info.netOrFileUrl),info.netOrFileUrl,info.streamName,videoHandler);
			}
			
			//回放增加屏幕暂停功能
			if([MediaProxyType.HLS,MediaProxyType.HTTP].indexOf(_videoPlayer.type) != -1)
			{
				addEventListener(MouseEvent.CLICK,mouseHandler);
			}*/
		}
		
		public function careList():Array
		{
			return [AppCMD.REPROT_BUFFER_LENGTH,
				AppCMD.MEDIA_QUITE_SERVER,
				AppCMD.MEDIA_SET_VOLUME,
				AppCMD.MEDIA_SWITCH_LINE,
				AppCMD.MEDIA_SWITCH_QUALITY,
				AppCMD.MEDIA_CHANGEVIDEO_MODE,
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
				case AppCMD.MEDIA_CHANGEVIDEO_MODE:
				case AppCMD.MEDIA_SWITCH_LINE:
				case AppCMD.MEDIA_SWITCH_QUALITY:
					connectServer();
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
					if(!isLive)
						_videoPlayer.time = parameters[0];
					break;
				case AppCMD.VIDEO_CONTROL_START:
					_videoPlayer.start();
					break;
				case AppCMD.VIDEO_CONTROL_STOP:
					_videoPlayer.stop();
					break;
				case AppCMD.PUBLISH_START:
					//开始推流
					connectServer();
					break;
				case AppCMD.PUBLISH_END:
					if(isPublish)
						_videoPlayer.dispose();
					break;
			}
		} 
		
		private function connectServer():void
		{
			_preTime = 0;
			if(!Model.userInfo.is_pres)
			{
				videoMode = info.videoMode;
			}
			const server:String = (Model.userInfo.is_pres?MediaModel.me().publishUrl:MediaModel.me().netOrFileUrl);
			const stream:String = Model.userInfo.is_pres?MediaModel.me().publishStreamName:MediaModel.me().streamName;
			log("连接地址：",protocol(server),server,stream,"用户isPres:",Model.userInfo.is_pres);
			if(_videoPlayer.type == null)
			{
				if(Model.userInfo.is_pres)
				{
					_videoPlayer.publish(info._soCamera,info._soMicrophone,server,stream,videoHandler,info._soCamWidth,info._soCamHeight);
				}else{
					_videoPlayer.connect(protocol(server),server,stream,videoHandler,true,0);
				}
			}else{
				_videoPlayer.attachType(protocol(server),server,stream,true,_videoPlayer.time,info._soCamera,info._soMicrophone,info._soCamWidth,info._soCamHeight);
			}
			
			videoPausedByClick = !isLive;
		}
		
		private function set videoPausedByClick(bool:Boolean):void
		{
			//回放启动点击暂停
			if(bool&&!hasEventListener(MouseEvent.CLICK))
			{
				addEventListener(MouseEvent.CLICK,mouseHandler);
			}else if(!bool&&hasEventListener(MouseEvent.CLICK)){
				removeEventListener(MouseEvent.CLICK,mouseHandler);
			}
		}
		
		private function set videoMode(bool:Boolean):void
		{
			if(info.videoMode)
			{
				_micActivity&&contains(_micActivity)&&this.removeChild(_micActivity);
				_videoPlayer.start();
			}else{
				_micActivity&&addChild(_micActivity);
				_videoPlayer.stop();
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
					_retryTimes = 0;
					break;
				case MediaProxyStates.CONNECT_FAILED:
					clearTimer();
					MediaAJMessage.connectFail(value[0]);
					retry(states);
					break;
				case MediaProxyStates.STREAM_NOT_FOUND:
					clearTimer();
					MediaAJMessage.streamNotFound();
					break;
				case MediaProxyStates.PUBLISH_START:
					log("推流成功");
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
				case MediaProxyStates.STREAM_TRANSITION:
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
		
		/**
		 * 播放失败尝试重连
		 */		
		private function retry(result:String = ""):void
		{
			if(++_retryTimes > MAX_RETRY)
			{
				//连接失败，抛到外层
				_retryTimes = 0;
				log("重连尝试完毕，请手动刷新");
				return;
			}
			//调用更新数据方法
			if(DataService.connFailed2ChangeServerLine())
			{
				log("连接失败:",result,"尝试重连：",_retryTimes);
				DataService.updateMediaInfo();
				//重新播放
				connectServer();
			}else{
				log("全部线路都失败了");
			}
		}
		
		/**
		 * 发送bufferloading 状态
		 * @param bool
		 */		
		private function set loading(bool:Boolean):void
		{
			if(bool != _loading)
			{
				if(!isPublish)
				{
					if(bool)
					{
						send(AppCMD.MEDIA_STATES_BUFFER_LOADING);
						send(AppCMD.UI_SHOW_LOADING);
					}else{
						send(AppCMD.MEDIA_STATES_BUFFER_FULL);
						send(AppCMD.UI_HIDE_LOADING);
						send(AppCMD.UI_HIDE_WARN);
					}
				}else{
					send(AppCMD.MEDIA_STATES_BUFFER_FULL);
					send(AppCMD.UI_HIDE_LOADING);
					send(AppCMD.UI_HIDE_WARN);
				}
			}
			_loading = bool;
		}
		
		/**
		 * 推流名称重复，不停重复尝试
		 */		
		private function publishForBadName():void
		{
			_videoPlayer.changeVideoUrl(info.publishUrl,info.publishStreamName);
		}
		
		/**
		 * 清楚计时器
		 */		
		private function clearTimer():void
		{
			clearInterval(_postionId);
			clearTimeout(_retryId);
		}
		
		/**
		 * 计时器发送回放当前时间变更
		 */		
		private function timeCheck():void
		{
			if(_videoPlayer.time == _preTime) return;
			_preTime = _videoPlayer.time;
			if(!isLive)
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
		
		/**
		 * 舞台resize时重绘视频大小
		 * @param w
		 * @param h
		 */		
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
				if(Model.userInfo.is_pres)
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
		
		/**
		 * 是否为直播或者推流
		 * @return 
		 */		
		private function get isLive():Boolean
		{
			return [MediaProxyType.RTMP,MediaProxyType.PUBLISH].indexOf(type) != -1;
		}
		
		/**
		 * 是否为推流
		 * @return 
		 */		
		private function get isPublish():Boolean
		{
			return type == MediaProxyType.PUBLISH
		}
		
		/**
		 * MediaModel数据
		 * @return 
		 */		
		private function get info():MediaModel
		{
			return MediaModel.me();
		}
		
		/**
		 * 当前播放的视频类型
		 * @return 
		 */		
		private function get type():String
		{
			if(_videoPlayer)
				return _videoPlayer.type;
			return null;
		}
		
		/**
		 * 发送内部通讯事件
		 * @param action
		 * @param param
		 */		
		private function send(action:String,param:Array = null):void
		{
			//log("发送消息",action,param);
			NResponder.dispatch(action,param);
		}
		
		/**
		 * 统一打印日志
		 * @param value
		 */		
		private function log(...value):void
		{
			Logger.getLogger("VideoLayer").info(value);
		}
	}
}