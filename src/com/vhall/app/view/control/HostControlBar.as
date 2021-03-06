package com.vhall.app.view.control
{
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.view.control.ui.VolumeBar;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.ToggleButton;
	import com.vhall.framework.ui.event.DragEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import appkit.responders.NResponder;

	/**
	 *	主持人端的控制栏 
	 * @author Sol
	 * 
	 */	
	public class HostControlBar extends AbstractControlBar implements IResponder
	{
		/**	全屏按钮*/
		private var btnFullscreen:ToggleButton;
		/**静音前的音量*/		
		private var _volumeBeforeMute:Number = 1;
		/**声音控制条*/
		private var _volumeBar:VolumeBar;
		/**静音按钮*/
		private var _muteBut:ToggleButton;
		
		public function HostControlBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			new ResponderMediator(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var volumeBox:HBox = new HBox(this);
			volumeBox.verticalAlign = "center";
			volumeBox.left = 10;
			volumeBox.verticalCenter = 0;
			
			_muteBut = new ToggleButton(volumeBox);
			_muteBut.skin = "assets/ui/mic_on.png";
			_muteBut.downSkin = "assets/ui/mic_off.png";
			_muteBut.tooltip = "静音";
			_muteBut.callOut = "top";
			_muteBut.addEventListener(Event.SELECT,muteHandler);
			
			_volumeBar = new VolumeBar(volumeBox);
			_volumeBar.volumeSlipComp.addEventListener(DragEvent.CHANGE,volumeChange);
			_volumeBar.setBgVisible(false);
			_volumeBeforeMute = _volumeBar.volumeValue = MediaModel.me().volume * 100;
			
			btnFullscreen = new ToggleButton(this);
			btnFullscreen.skin = "assets/ui/expand.png";
			btnFullscreen.downSkin = "assets/ui/scope.png";
			btnFullscreen.tooltip = "全屏";
			btnFullscreen.callOut = "top";
			btnFullscreen.right = 10;
			btnFullscreen.verticalCenter = 0;
			btnFullscreen.addEventListener(MouseEvent.CLICK,onToggleClickHandler);
		}
		
		private function volumeChange(e:DragEvent):void
		{
			MediaModel.me().volume = e.percent;
			NResponder.dispatch(AppCMD.MEDIA_SET_VOLUME,[e.percent]);
			_muteBut.setSelected(e.percent == 0);
			_volumeBeforeMute = _volumeBar.volumeValue;
			muteHandler();
		}
		
		protected function muteHandler(event:Event = null):void
		{
			if(_muteBut.selected)
			{
				_volumeBeforeMute = _volumeBar.volumeValue;
				_volumeBar.volumeValue = 0;
			}else{
				_volumeBar.volumeValue = _volumeBeforeMute||50;
			}
			if(event)
			{
				MediaModel.me().volume = _volumeBar.volumeValue/100;
				NResponder.dispatch(AppCMD.MEDIA_SET_VOLUME);
			}
		}
		
		public function careList():Array
		{
			var arr:Array = [];
			return arr;
		}
		
		public function handleCare(msg:String, ...args):void
		{
			switch(msg)
			{
			}
		}
		
		protected function onToggleClickHandler(e:MouseEvent):void
		{
			StageManager.toggleFullscreen();
		}
	}
}