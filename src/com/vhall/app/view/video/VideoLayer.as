package com.vhall.app.view.video
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.common.Resource;
	import com.vhall.app.model.DataService;
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
	import com.vhall.framework.media.provider.UniquePublishKeeper;
	import com.vhall.framework.media.video.VideoPlayer;

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

	import appkit.responders.NResponder;

	public class VideoLayer extends Layer implements IResponder
	{

		public function VideoLayer(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}

		/**拉流重试最大次数*/
		private const MAX_RETRY:uint = 16;
		/**麦克状态ui*/
		private var _micActivity:AudioModelPicComp;

		/**播放时间当前位置计时器id*/
		private var _postionId:int;
		/**上一次计时器获取的视频播放时间*/
		private var _preTime:Number = 0;
		/**推流名称重复，重推延时id*/
		private var _retryId:int;
		/**当前重试次数*/
		private var _retryTimes:uint = 0;
		/**视频模块*/
		private var _videoPlayer:VideoPlayer;

		public function careList():Array
		{
			return [AppCMD.REPROT_BUFFER_LENGTH, AppCMD.MEDIA_QUITE_SERVER, AppCMD.MEDIA_SET_VOLUME, AppCMD.MEDIA_SWITCH_LINE, AppCMD.MEDIA_SWITCH_QUALITY, AppCMD.MEDIA_CHANGEVIDEO_MODE, AppCMD.MEDIA_PLAYER_DISPOSE, AppCMD.MEDIA_MUTE_ALL, AppCMD.MEDIA_MUTE_CAMERA, AppCMD.MEDIA_MUTE_MICROPHONE, AppCMD.VIDEO_CONTROL_PAUSE, AppCMD.VIDEO_CONTROL_RESUME, AppCMD.VIDEO_CONTROL_TOGGLE, AppCMD.VIDEO_CONTROL_SEEK, AppCMD.VIDEO_CONTROL_START, AppCMD.VIDEO_CONTROL_STOP, AppCMD.PUBLISH_PUBLISH, AppCMD.PUBLISH_START, AppCMD.PUBLISH_END, AppCMD.SHOW_AUDIOLIVE_PIC];
		}

		public function handleCare(msg:String, ... parameters):void
		{
			log("收到消息:" + msg + JSON.stringify(parameters));
			switch(msg)
			{
				case AppCMD.REPROT_BUFFER_LENGTH:
					MediaAJMessage.sendBufferLength();
					break;
				case AppCMD.MEDIA_QUITE_SERVER:
					MediaAJMessage.quiteServer();
					break;
				case AppCMD.MEDIA_SET_VOLUME:
					//log("设置视频声音：",info.volume);
					setVolume(info.volume);
					break;
				case AppCMD.MEDIA_CHANGEVIDEO_MODE:
				case AppCMD.MEDIA_SWITCH_LINE:
				case AppCMD.MEDIA_SWITCH_QUALITY:
					play();
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
				case AppCMD.PUBLISH_PUBLISH:
					publish();
					break;
				case AppCMD.PUBLISH_START:
					//开始推流
					play();
					break;
				case AppCMD.PUBLISH_END:
					if(isPublish)
						_videoPlayer.dispose();
					break;
				case AppCMD.SHOW_AUDIOLIVE_PIC:
					videoMode = info.videoMode;
					break;
			}
		}

		/**
		 * 舞台resize时重绘视频大小
		 * @param w
		 * @param h
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);

			if(stage)
			{
				var rect:Rectangle = null;

				if(stage.displayState != StageDisplayState.NORMAL)
				{
					rect = new Rectangle(0, 0, w, h);
				}
				else
				{
					//底部控制了高度
					const CONTROL_BAR_HEIGHT:uint = 0;
					rect = new Rectangle(0, 0, w, h - CONTROL_BAR_HEIGHT);
				}
				_videoPlayer.viewPort = rect;
			}
		}

		override protected function createChildren():void
		{
			super.createChildren();

			info.player = _videoPlayer ||= VideoPlayer.create();
			_videoPlayer.volume = info.volume;
			addChild(_videoPlayer);

			doubleClickEnabled = true;
			mouseChildren = false;

			addEventListener(MouseEvent.DOUBLE_CLICK, mouseHandler)

			var l:ResourceLoader = new ResourceLoader();
			l.load({type:1, url:Resource.getResource("MicrophoneActivity")}, function(item:Object, content:Object, domain:ApplicationDomain):void
			{
				log("加载语音状态资源成功");
				_micActivity = new AudioModelPicComp();
				_micActivity.skin = content as MovieClip;

				videoMode = info.videoMode;
				autoStart();
			}, null, function():void
			{
				log("加载语音状态资源失败");
				autoStart();
			});
		}

		private function autoStart():void
		{

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
		 * MediaModel数据
		 * @return
		 */
		private function get info():MediaModel
		{
			return MediaModel.me();
		}

		/**
		 * 是否为直播或者推流
		 * @return
		 */
		private function get isLive():Boolean
		{
			return [MediaProxyType.RTMP, MediaProxyType.PUBLISH].indexOf(type) != -1;
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
		 * 发送bufferloading 状态
		 * @param bool
		 */
		private function set loading(bool:Boolean):void
		{
			if(!isPublish)
			{
				if(bool)
				{
					send(AppCMD.MEDIA_STATES_BUFFER_LOADING);
					send(AppCMD.UI_SHOW_LOADING);
				}
				else
				{
					send(AppCMD.MEDIA_STATES_BUFFER_FULL);
					send(AppCMD.UI_HIDE_LOADING);
					send(AppCMD.UI_HIDE_WARN);
				}
			}
		}

		/**
		 * 统一打印日志
		 * @param value
		 */
		private function log(... value):void
		{
			Logger.getLogger("VideoLayer").info(value);
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

		private function play():void
		{
			UniquePublishKeeper.keeper.close();
			_preTime = 0;
			if(!Model.userInfo.is_pres)
			{
				const server:String = MediaModel.me().netOrFileUrl;
				const stream:String = MediaModel.me().streamName;
				log("拉流地址：", protocol(server), server, stream, "用户isPres:", Model.userInfo.is_pres);
				if(_videoPlayer.type == null)
				{
					_videoPlayer.connect(protocol(server), server, stream, videoHandler, true, 0);
				}
				else
				{
					_videoPlayer.attachType(protocol(server), server, stream);
				}
			}
			else
			{
				log("当前正在直播用户不能拉流");
			}
			_videoPlayer.useStrategy = false;
			_videoPlayer.visible = true
			videoPausedByClick = !isLive;
			videoMode = info.videoMode;
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

			const p:String = uri.replace(/\?.+/ig, "");
			const exName:String = ".m3u8";
			const lastIndexExName:int = p.length - exName.length;
			if(lastIndexExName >= 0 && lastIndexExName == p.indexOf(exName))
			{
				return MediaProxyType.HLS;
			}

			return MediaProxyType.HTTP;
		}

		private function publish():void
		{
			UniquePublishKeeper.keeper.close();
			_preTime = 0;
			if(Model.userInfo.is_pres)
			{
				const server:String = Model.userInfo.is_pres ? MediaModel.me().publishUrl : MediaModel.me().netOrFileUrl;
				const stream:String = Model.userInfo.is_pres ? MediaModel.me().publishStreamName : MediaModel.me().streamName;
				log("推流地址：", protocol(server), server, stream, "用户isPres:", Model.userInfo.is_pres, info._soCamWidth, info._soCamHeight);
				if(_videoPlayer.type != null)
				{
					_videoPlayer.dispose();
				}
				_videoPlayer.publish(info._soCamera, info._soMicrophone, server, stream, videoHandler, info._soCamWidth, info._soCamHeight);
			}
			else
			{
				log("非当前正在直播用户不能推流");
			}
			videoPausedByClick = false;
			_videoPlayer.visible = true;
			videoMode = info.videoMode
		}

		/**
		 * 推流名称重复，不停重复尝试
		 */
		private function publishForBadName():void
		{
			log("服务器已存在对应流，尝试重推");
			_videoPlayer.changeVideoUrl(info.publishUrl, info.publishStreamName);
		}

		/**
		 * 播放失败尝试重连
		 */
		private function retry(result:String = ""):void
		{
			++_retryTimes;
			if(Model.userInfo.is_pres)
			{
				log("推流失败重推", result, _retryTimes);
				_videoPlayer.useStrategy = true;
				publish();
			}
			else
			{
				if(_retryTimes > MAX_RETRY)
				{
					//连接失败，抛到外层
					_retryTimes = 0;
					log("拉流重连尝试完毕，请手动刷新");
					return;
				}
				else
				{
					log("拉流失败", result, _retryTimes);
					if(_retryTimes == (MAX_RETRY >> 1) && DataService.connFailed2ChangeServerLine())
					{
						DataService.updateMediaInfo();
						log("更换拉流服务器");
					}
					play();
				}
			}
		}

		/**
		 * 发送内部通讯事件
		 * @param action
		 * @param param
		 */
		private function send(action:String, param:Array = null):void
		{
			//log("发送消息",action,param);
			NResponder.dispatch(action, param);
		}

		private function setVolume(value:Number):void
		{
			_videoPlayer.volume = value;
		}

		/**
		 * 计时器发送回放当前时间变更
		 */
		private function timeCheck():void
		{
			if(_videoPlayer.time == _preTime)
				return;
			_preTime = _videoPlayer.time;
			if(!isLive)
			{
				send(AppCMD.MEDIA_TIME_UPDATE);
			}
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

		private function videoHandler(states:String, ... value):void
		{
			//log("视频状态:",states);
			switch(states)
			{
				case MediaProxyStates.CONNECT_NOTIFY:
					log("通道建立成功");
					clearTimer();
					_postionId = setInterval(timeCheck, 1000);
					_retryTimes = 0;
					loading = true;
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
					var streaminfo:String = _videoPlayer.stream && _videoPlayer.stream.info ? _videoPlayer.stream.info.uri : "";
					log("推流成功,推流限制网速:", value[0], "推流地址：", streaminfo);
					MediaAJMessage.publishStart();
					if(isPublish)
					{
						log("推流模式：",info.videoMode,_videoPlayer.usedCam,_videoPlayer.usedMic);
						videoMode = info.videoMode || !_videoPlayer.usedCam;

						var publishUrl:String = escape(info.publishUrl + "/" + info.publishStreamName);
						if(!UniquePublishKeeper.keeper.add(publishUrl))
						{
							log("上一次推流还在进行，自动断掉老推流,重试推流");
							UniquePublishKeeper.keeper.send(publishUrl,"dispose",info.publishStreamName);
							publish();
						}else{
							UniquePublishKeeper.keeper.client = {
									"dispose":function(streamName:String):void
									{
										if(isPublish && streamName == info.publishStreamName)
										{
											_videoPlayer.dispose();
											UniquePublishKeeper.keeper.close();
										}
									}
								};
						}
					}
					break;
				case MediaProxyStates.STREAM_START:
					log("拉流视频", _videoPlayer.stream && _videoPlayer.stream.info ? _videoPlayer.stream.info.uri + "/" + _videoPlayer.stream.info.resourceName : "");
					send(AppCMD.MEDIA_STATES_START);
					//loading = true;
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
				case MediaProxyStates.STREAM_TRANSITION:
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
					_retryId = setTimeout(publishForBadName, 1000);
					break;
				case MediaProxyStates.DURATION_NOTIFY:
					send(AppCMD.MEDIA_DURATION_UPDATE, [_videoPlayer.duration]);
					log("视频时长:" + _videoPlayer.duration);
					break;
				case MediaProxyStates.SEEK_COMPLETE:
					send(AppCMD.MEDIA_STATES_SEEK_COMPLETE);
					break;
				case MediaProxyStates.SEEK_FAILED:
					send(AppCMD.MEDIA_STATES_SEEK_FAIL);
					break;
				case MediaProxyStates.NO_HARD_WARE:
					log("未找到硬件:", value);
					break;
				case MediaProxyStates.CAMERA_IS_USING:
					log("推流摄像头被占用，请关闭摄像头占用程序,重新推流");
					break;
			}
		}

		private function set videoMode(bool:Boolean):void
		{
			log("videoMode:", info.videoMode,Model.playerStatusInfo.videoMode);
			if(!bool)
			{
				_micActivity && contains(_micActivity) && this.removeChild(_micActivity);
				//_videoPlayer.start();
				_videoPlayer.visible = true;
			}
			else
			{
				_micActivity && addChild(_micActivity);
				//_videoPlayer.stop();
				_videoPlayer.visible = false;
			}
		}

		private function set videoPausedByClick(bool:Boolean):void
		{
			//回放启动点击暂停
			if(bool && !hasEventListener(MouseEvent.CLICK))
			{
				addEventListener(MouseEvent.CLICK, mouseHandler);
			}
			else if(!bool && hasEventListener(MouseEvent.CLICK))
			{
				removeEventListener(MouseEvent.CLICK, mouseHandler);
			}
		}
	}
}


