package com.vhall.app.view.control
{
	import appkit.responders.NResponder;
	
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.manager.RenderManager;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.Button;
	import com.vhall.framework.ui.controls.Image;
	import com.vhall.framework.ui.controls.ToggleButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
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
			
			hb = new HBox(this);
			hb.setSize(width,height);
			hb.verticalAlign = "center";
			hb.horizontalAlign = "right";
			
			var btn:Button = new Button(hb);
			btn.skin = "assets/ui/mic1.png";
			btn.addEventListener(Event.SELECT,onClick);
			
			btnBarrage = new ToggleButton(hb);
			btnBarrage.skin = "assets/ui/t1.png";
			btnBarrage.downSkin = "assets/ui/t2.png";
			
			btnFullscreen = new ToggleButton(hb);
			btnFullscreen.skin = "assets/ui/f2.png";
			btnFullscreen.downSkin = "assets/ui/f1.png";
			btnFullscreen.tooltip = "全屏";
			btnFullscreen.callOut = "top";
			btnFullscreen.addEventListener(MouseEvent.CLICK,onToggleClickHandler);
			
			StageManager.stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFull);
		}
		
		protected function onFull(e:FullScreenEvent):void
		{
			btnFullscreen.selected = e.fullScreen;
		}
		
		protected function onToggleClickHandler(e:MouseEvent):void
		{
			StageManager.toggleFullscreen();
		}
		
		private function onClick(e:MouseEvent):void
		{
			btnFullscreen.visible = !btnFullscreen.visible;
			hb.validateNow();
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
			hb.width = width;
		}
	}
}