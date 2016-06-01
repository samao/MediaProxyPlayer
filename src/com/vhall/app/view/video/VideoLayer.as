package com.vhall.app.view.video
{
	import com.adobe.serialization.json.JSON;
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.MediaAJMessage;
	import com.vhall.app.net.MessageType;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.media.provider.MediaProxyStates;
	import com.vhall.framework.media.video.VideoPlayer;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class VideoLayer extends Layer implements IResponder
	{
		private var _videoPlayer:VideoPlayer;
		
		public function VideoLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			stage.addEventListener(Event.RESIZE,resizeHandler);
		}
		
		protected function resizeHandler(event:Event):void
		{
			if(stage)
			{
				var rect:Rectangle = null;
				
				if(stage.displayState != StageDisplayState.NORMAL)
				{
					rect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
				}else{
					//底部控制了高度
					const CONTROL_BAR_HEIGHT:uint = 40;
					rect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight - CONTROL_BAR_HEIGHT);
				}
				_videoPlayer.viewPort = rect;
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_videoPlayer ||= VideoPlayer.create();
			this.addChild(_videoPlayer);
		}
		
		public function careList():Array
		{
			return [MessageType.JA_PUBLISH,MessageType.JA_UNPUBLISH,MessageType.JA_GET_CAMERAS,
				MessageType.JA_GET_MICPHONES,MessageType.JA_GET_BUFFER_LENGTH,MessageType.JA_VOLUME,
				MessageType.AJ_PUBLISH_START
			];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			var o:Object = com.adobe.serialization.json.JSON.decode(parameters[0]);
			switch(msg)
			{
				case MessageType.JA_GET_CAMERAS:
					MediaAJMessage.getCameras();
					break;
				case MessageType.JA_GET_MICPHONES:
					MediaAJMessage.getMicrophones();
					break;
				case MessageType.JA_PUBLISH:
					_videoPlayer.publish(null,null,"rtmp://localhost/live","12",videoHandler);
					break;
				case MessageType.JA_UNPUBLISH:
					_videoPlayer.stop();
					break;
				case MessageType.JA_GET_BUFFER_LENGTH:
					MediaAJMessage.sendBufferLength(_videoPlayer.bufferLength);
					break;
				case MessageType.JA_VOLUME:
					_videoPlayer.volume = o.param||0.6;
					break;
				case MessageType.AJ_PUBLISH_START:
					break;
			}
		}
		
		private function publishNotify():void
		{
			
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
					MediaAJMessage.streamNotFound();
					break;
				case MediaProxyStates.PUBLISH_NOTIFY:
					MediaAJMessage.publishStart(_videoPlayer.usedCam == null ? true : false);
					break;
				case MediaProxyStates.STREAM_START:
					
					break;
				case MediaProxyStates.STREAM_STOP:
					
					break;
			}
		}
	}
}