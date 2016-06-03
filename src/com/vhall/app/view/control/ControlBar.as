package com.vhall.app.view.control
{
	import appkit.responders.NResponder;
	
	import com.vhall.app.common.components.TimeLabel;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.Button;
	import com.vhall.framework.ui.controls.Image;
	import com.vhall.framework.ui.controls.ToggleButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 *	控制栏 
	 * @author Sol
	 * 
	 */	
	public class ControlBar extends Box implements IResponder
	{
		private var bg:Image;
		
		private var btnFullscreen:ToggleButton;
		
		private var btnBarrage:ToggleButton;
		
		private var hb:HBox;
		
		private var timerLabel:TimeLabel;
		public function ControlBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			new ResponderMediator(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			// 背景
			bg = new Image(this);
			bg.rect = new Rectangle(4,4,10,10);
			bg.source = "assets/ui/bg.png";
			
			timerLabel = new TimeLabel(this);
			timerLabel.autoStart = true;
			timerLabel.ms = 0;
			timerLabel.color = 0xFFFFFF;
			timerLabel.verticalCenter = 0;
			
			hb = new HBox(this);
			hb.setSize(width / 2,height);
			hb.right = 0;
			hb.verticalAlign = "center";
			hb.horizontalAlign = "right";
			
			var btn:Button = new Button(hb);
			btn.skin = "assets/ui/mic1.png";
			btn.addEventListener(MouseEvent.CLICK,onClick);
			
			btnBarrage = new ToggleButton(hb);
			btnBarrage.skin = "assets/ui/t1.png";
			btnBarrage.downSkin = "assets/ui/t2.png";
			btnBarrage.addEventListener(Event.SELECT, onBarrageSelect);
			
			btnFullscreen = new ToggleButton(hb);
			btnFullscreen.skin = "assets/ui/f2.png";
			btnFullscreen.downSkin = "assets/ui/f1.png";
			btnFullscreen.tooltip = "全屏";
			btnFullscreen.callOut = "top";
			btnFullscreen.addEventListener(MouseEvent.CLICK,onToggleClickHandler);
			
			StageManager.stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFull);
		}

		protected function onBarrageSelect(event:Event):void
		{
			var cmd:String = btnBarrage.selected ? AppCMD.BARRAGE_OPEN : AppCMD.BARRAGE_CLOSE;
			NResponder.dispatch(cmd);
		}
		
		protected function onFull(e:FullScreenEvent):void
		{
			btnFullscreen.setSelected(e.fullScreen);
		}
		
		protected function onToggleClickHandler(e:MouseEvent):void
		{
			StageManager.toggleFullscreen();
		}
		
		private function onClick(e:MouseEvent):void
		{
		}
		
		private function onTimer(e:TimerEvent):void
		{
			NResponder.dispatch(AppCMD.BARRAGE_ADD,[Math.random().toFixed(5)]);
		}
		
		public function careList():Array
		{
			return [];			
		}
		
		public function handleCare(msg:String, ... args):void
		{
			
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bg.width = width;
			hb.width = width / 2;
		}
	}
}