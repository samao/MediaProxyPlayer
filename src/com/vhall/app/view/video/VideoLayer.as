package com.vhall.app.view.video
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.net.MediaAJMessage;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.media.provider.MediaProxyStates;
	import com.vhall.framework.media.provider.MediaProxyType;
	import com.vhall.framework.media.video.VideoPlayer;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class VideoLayer extends Layer implements IResponder
	{
		private var _videoPlayer:VideoPlayer;
		
		public function VideoLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			if(stage)
				resize(stage.stageWidth,stage.stageHeight);
			else
				addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_videoPlayer ||= VideoPlayer.create();
			addChild(_videoPlayer);
			_videoPlayer.connect(MediaProxyType.HLS,"http://cnhlsvodhls01.e.vhall.com/vhalllive/199811626/fulllist.m3u8");
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			doubleClickEnabled = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.DOUBLE_CLICK,mouseHandler)
			
			addEventListener(MouseEvent.CLICK,mouseHandler);
			
			resize(stage.stageWidth,stage.stageHeight);
		}
		
		public function careList():Array
		{
			return [AppCMD.UI_WINDOW_RESIZE];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			switch(msg)
			{
				case AppCMD.UI_WINDOW_RESIZE:
					var size:Object = parameters[0];
					resize(size.width,size.height);
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
					break;
				case MediaProxyStates.STREAM_NOT_FOUND:
					break;
				case MediaProxyStates.PUBLISH_NOTIFY:
					MediaAJMessage.publishStart(_videoPlayer.usedCam ? false : true);
					break;
				case MediaProxyStates.STREAM_START:
					break;
				case MediaProxyStates.STREAM_STOP:
					break;
			}
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.CLICK:
					_videoPlayer.toggle();
					break;
				case MouseEvent.DOUBLE_CLICK:
					//全屏切换
					break;
			}
		}
		
		protected function resize(w:Number,h:Number):void
		{
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
	}
}