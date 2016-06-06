package com.vhall.app.view.control
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.tween.AppTween;
	import com.vhall.framework.tween.TweenNano;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class ControlLayer extends Layer implements IResponder
	{
		
		private var bar:ControlBar;
		
		public var checkTimer:uint;
		
		public function ControlLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void
		{
			super.init();
			StageManager.stage.addEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
			StageManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			bar = new ControlBar(this);
			
			// 默认来一发
			onStageMouseMove(null);
		}
		
		override public function destory():void
		{
			super.destory();
			StageManager.stage.removeEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
			StageManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
		}
		
		public function careList():Array
		{
			var arr:Array = [];
			return arr;
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			switch(msg)
			{
			}
		}
		
		protected function onStageMouseMove(event:MouseEvent):void
		{
			clearTimeout(checkTimer);
			checkTimer = setTimeout(onDelayCheckMouse,2000);
			Mouse.show();
			showBar();
		}
		
		protected function onStageMouseLeave(event:Event):void
		{
			clearTimeout(checkTimer);
			hideBar();
		}
		
		/**
		 *发送隐藏控制栏通知 
		 * 
		 */		
		protected function onDelayCheckMouse():void{
			if(StageManager.stage.displayState==StageDisplayState.FULL_SCREEN)
			{
				Mouse.hide();
			}
			hideBar();
		}
		
		/**	显示控制栏*/
		private function showBar():void
		{
			AppTween.to(bar,.25,{y:0});
		}
		
		/**	隐藏控制栏*/
		private function hideBar():void
		{
			AppTween.to(bar,.25,{y:bar.height});
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bar.width = width;
		}
	}
}