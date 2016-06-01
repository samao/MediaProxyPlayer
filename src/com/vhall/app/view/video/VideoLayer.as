package com.vhall.app.view.video
{
	import com.vhall.app.actions.Action_Media;
	import com.vhall.app.actions.Actions_Report2JS;
	import com.vhall.app.common.Layer;
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
			_videoPlayer.connect(MediaProxyType.HLS,"http://cnhlsvodhls01.e.vhall.com/vhalllive/199811626/fulllist.m3u8");
			
			doubleClickEnabled = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.DOUBLE_CLICK,mouseHandler)
			
			addEventListener(MouseEvent.CLICK,mouseHandler);
		}
		
		public function careList():Array
		{
			return [Actions_Report2JS.BUFFER_LENGTH,Action_Media.QUITE_SERVER];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			switch(msg)
			{
				case Actions_Report2JS.BUFFER_LENGTH:
					MediaAJMessage.sendBufferLength(_videoPlayer.bufferLength);
					break;
				case Action_Media.QUITE_SERVER:
					MediaAJMessage.quiteServer();
					//_videoPlayer.attachType(MediaProxyType.PUBLISH);
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
					break;
				case MediaProxyStates.PUBLISH_NOTIFY:
					MediaAJMessage.publishStart(_videoPlayer.usedCam ? false : true);
					break;
				case MediaProxyStates.UN_PUBLISH_NOTIFY:
					break;
				case MediaProxyStates.PUBLISH_BAD_NAME:
					//重推
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
					//_videoPlayer.toggle();
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
	}
}