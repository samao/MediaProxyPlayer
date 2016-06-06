package com.vhall.app.view.control
{
	import appkit.responders.NResponder;
	
	import com.vhall.app.common.components.TimeLabel;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.view.control.ui.VolumeBar;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.Button;
	import com.vhall.framework.ui.controls.Label;
	import com.vhall.framework.ui.controls.ToggleButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;

	public class ViewerControlBar extends AbstractControlBar implements IResponder
	{
		/**	容器*/
		private var hb:HBox;
		
		private var btnFullscreen:ToggleButton;
		
		private var btnBarrage:ToggleButton;
		
		
		private var volumebar:VolumeBar;
		
		private var timerLabel:TimeLabel;
		
		public function ViewerControlBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			new ResponderMediator(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			timerLabel = new TimeLabel(this);
			timerLabel.color = 0xFFFFFF;
			timerLabel.left = 10;
			timerLabel.verticalCenter = 0;
			
			hb = new HBox(this);
			hb.setSize(width / 2,height);
			hb.right = 10;
			hb.verticalAlign = "center";
			hb.horizontalAlign = "right";
			
			volumebar = new VolumeBar(hb);
			
			var hbarrage:HBox = new HBox(hb);
			hbarrage.gap = 2;
			hbarrage.verticalAlign = "center";
			
			var lblBarrage:Label = new Label(hbarrage);
			lblBarrage.text = "弹幕";
			lblBarrage.color = "0xFFFFFF";
			
			btnBarrage = new ToggleButton(hbarrage);
			btnBarrage.skin = "assets/ui/t1.png";
			btnBarrage.downSkin = "assets/ui/t2.png";
			btnBarrage.addEventListener(Event.SELECT, onBarrageSelect);
			
			btnFullscreen = new ToggleButton(hb);
			btnFullscreen.skin = "assets/ui/f2.png";
			btnFullscreen.downSkin = "assets/ui/f1.png";
			btnFullscreen.tooltip = "全屏";
			btnFullscreen.callOut = "top";
			btnFullscreen.addEventListener(MouseEvent.CLICK,onToggleClickHandler);
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			hb.width = width / 2;
		}
		
		override protected function onFull(e:FullScreenEvent):void
		{
			super.onFull(e);
			btnFullscreen.setSelected(e.fullScreen);
		}

		public function careList():Array
		{
			var arr:Array = [];
			arr.push(AppCMD.MEDIA_DURATION_UPDATE);
			return arr;
		}

		public function handleCare(msg:String, ... args):void
		{
			switch(msg)
			{
				case AppCMD.MEDIA_DURATION_UPDATE:
					timerLabel.ms = MediaModel.me().player.time * 1000;
					break;
			}
		}
		
		protected function onBarrageSelect(event:Event):void
		{
			var cmd:String = btnBarrage.selected ? AppCMD.BARRAGE_OPEN : AppCMD.BARRAGE_CLOSE;
			NResponder.dispatch(cmd);
		}
		
		protected function onToggleClickHandler(e:MouseEvent):void
		{
			StageManager.toggleFullscreen();
		}
	}
}
