package com.vhall.app.view.control
{
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.tween.AppTween;
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.controls.Image;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 抽象控制栏
	 * @author Sol
	 *
	 */
	public class AbstractControlBar extends Box
	{
		public var checkTimer:uint;
		
		/**	背景图*/
		private var bg:Image;

		public function AbstractControlBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void
		{
			super.init();
			return;
			StageManager.stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			StageManager.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			StageManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			// 背景
			bg = new Image(this);
			bg.rect = new Rectangle(4,4,10,10);
			bg.source = "assets/ui/bg.png";
			
			// 默认来一发
//			onStageMouseMove(null);
			StageManager.stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFull);
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bg.width = width;
		}

		override public function destory():void
		{
			super.destory();
			StageManager.stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			StageManager.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			StageManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			clearTimeout(checkTimer);
			checkTimer = setTimeout(onDelayCheckMouse, 2000);
			Mouse.show();
			showBar();
		}
		
		protected function onStageMouseMove(event:MouseEvent):void
		{
			clearTimeout(checkTimer);
			checkTimer = setTimeout(onDelayCheckMouse, 2000);
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
		protected function onDelayCheckMouse():void
		{
			if(StageManager.stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				Mouse.hide();
			}
			hideBar();
		}
		
		protected function onFull(e:FullScreenEvent):void
		{
			
		}

		/**	显示控制栏*/
		private function showBar():void
		{
			AppTween.to(this, .25, {y:0});
		}

		/**	隐藏控制栏*/
		private function hideBar():void
		{
			AppTween.to(this, .25, {y:this.height});
		}

	}
}
