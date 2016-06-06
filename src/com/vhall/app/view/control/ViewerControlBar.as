package com.vhall.app.view.control
{
	import com.vhall.app.common.components.TimeLabel;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.view.control.ui.VolumeBar;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.ToggleButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	
	import appkit.responders.NResponder;

	public class ViewerControlBar extends AbstractControlBar implements IResponder
	{
		/**	容器*/
		private var hb:HBox;
		
		private var btnFullscreen:ToggleButton;
		
		private var btnBarrage:ToggleButton;
		
		
		private var volumebar:VolumeBar;
		/**静音按钮*/
		private var _muteBut:ToggleButton;
		/**静音前的音量*/		
		private var _volumeBeforeMute:Number = 1;
		
		private var timerLabel:TimeLabel;
		
		public function ViewerControlBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			new ResponderMediator(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			hb = new HBox(this);
			hb.setSize(width / 2,height);
			hb.right = 0;
			hb.verticalAlign = "center";
			hb.horizontalAlign = "right";
			
			volumebar = new VolumeBar(hb);
			_volumeBeforeMute = volumebar.volumeValue = MediaModel.me().volume * 100;
			
			_muteBut = new ToggleButton(hb);
			_muteBut.skin = "assets/ui/mic2.png";
			_muteBut.downSkin = "assets/ui/mic1.png";
			_muteBut.tooltip = "静音";
			_muteBut.callOut = "top";
			_muteBut.addEventListener(MouseEvent.CLICK,muteHandler);
			
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
		}
		
		protected function muteHandler(event:MouseEvent):void
		{
			if(_muteBut.selected)
			{
				_volumeBeforeMute = volumebar.volumeValue;
				volumebar.volumeValue = 0;
			}else{
				volumebar.volumeValue = _volumeBeforeMute;
			}
			MediaModel.me().volume = volumebar.volumeValue/100;
			NResponder.dispatch(AppCMD.MEDIA_SET_VOLUME);
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
			return arr;
		}

		public function handleCare(msg:String, ... args):void
		{
			switch(msg)
			{
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