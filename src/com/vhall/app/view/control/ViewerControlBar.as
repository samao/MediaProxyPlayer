package com.vhall.app.view.control
{
	import com.vhall.app.common.components.TimeLabel;
	import com.vhall.app.model.DataService;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.app.model.vo.DefinitionVo;
	import com.vhall.app.model.vo.ServeLinevo;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.view.control.ui.VolumeBar;
	import com.vhall.app.view.control.ui.component.SwitchListBox;
	import com.vhall.app.view.control.ui.component.VideoAudioChangeBtn;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.log.Logger;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.Label;
	import com.vhall.framework.ui.controls.ToggleButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
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
		/***切换清晰度组件*/		
		protected var definationBox:SwitchListBox;
		/**切换线路组件**/		
		protected var serverLinke:SwitchListBox;
		/**切换视频 音频 模式组件**/			
		protected var changeVideoMode:VideoAudioChangeBtn;
		
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
			
			// 静音
			var hbVolumn:HBox = new HBox(this);
			hbVolumn.verticalCenter = 0;
			hbVolumn.verticalAlign = "center";
			_muteBut = new ToggleButton(hbVolumn);
			_muteBut.skin = "assets/ui/mic2.png";
			_muteBut.downSkin = "assets/ui/mic1.png";
			_muteBut.tooltip = "静音";
			_muteBut.callOut = "top";
			_muteBut.addEventListener(MouseEvent.CLICK,muteHandler);
			volumebar = new VolumeBar(hbVolumn);
			_volumeBeforeMute = MediaModel.me().volume * 100;
			volumebar.volumeValue = MediaModel.me().volume * 100;
			
			onInitServerLine();
			
			onInitVideoModeBtn();
			
			onInitDefination();
			
			
			// 弹幕按钮
			var hbarrage:HBox = new HBox(hb);
			hb.verticalAlign = "center";
			var lblBarrage:Label = new Label(hbarrage);
			lblBarrage.text = "弹幕";
			lblBarrage.color = 0xFFFFFF;
			btnBarrage = new ToggleButton(hbarrage);
			btnBarrage.skin = "assets/ui/t1.png";
			btnBarrage.downSkin = "assets/ui/t2.png";
			btnBarrage.addEventListener(Event.SELECT, onBarrageSelect);
			
			// 全屏按钮
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
		
		protected function onInitVideoModeBtn():void{
//			changeVideoMode 
		}
		
		protected function onInitDefination():void{
		
//			if(Model.Me().hideQualitySwitch) return;
			var sdata:Array = Model.videoInfo.definitionInfo;
			definationBox = new SwitchListBox(hb);
			var showData:Array = []
			var tmpdta:DefinitionVo;
			var data:Object;
			for (var i:int = 0; i < sdata.length; i++) 
			{
				data = new Object();
				tmpdta = sdata[i]
				data.label = tmpdta.sName;
				data.value = tmpdta.key;
				showData[i] = data;
			}
			definationBox.initList(showData);
			definationBox.addEventListener(Event.CHANGE,onDefinationChange);
		}
		
		protected function onInitServerLine():void{
//			if(Model.Me().hideLineSwitch) return;
			var sdata:Array = Model.videoInfo.serverLineInfo;
			var showData:Array = []
			if(sdata && sdata.length > 0){
				serverLinke = new SwitchListBox(hb);
				var tmpdta:ServeLinevo;
				var data:Object;
				for (var i:int = 0; i < sdata.length; i++) 
				{
					data = new Object();
					tmpdta = sdata[i]
					data.label = tmpdta.sName;
					data.value = tmpdta.sName;
					showData[i] = data;
				}
				serverLinke.initList(showData);
				serverLinke.addEventListener(Event.CHANGE,onServerLineChange);
			}
		}
		
		protected function onDefinationChange(event:Event):void
		{
			// TODO Auto-generated method stub
			Logger.getLogger("ViewerControlBar").info("onServerLineChange :",definationBox.getSelectData().value);
			var selectDef:String = definationBox.getSelectData().value
			if(DataService.onSelectDef(selectDef)){
				DataService.updateMediaInfo();
				NResponder.dispatch(AppCMD.MEDIA_SWITCH_QUALITY);
			}
		}
		
		protected function onServerLineChange(event:Event):void
		{
			// TODO Auto-generated method stub
			Logger.getLogger("ViewerControlBar").info("onServerLineChange :",serverLinke.getSelectData().value);
			var selectSl:String = serverLinke.getSelectData().value;
			if(DataService.onSelectServerLine(selectSl)){
				DataService.updateMediaInfo();
				NResponder.dispatch(AppCMD.MEDIA_SWITCH_LINE);
			}
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
