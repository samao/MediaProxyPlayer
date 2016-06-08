package com.vhall.app.view.control
{
	import com.vhall.app.model.DataService;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.app.model.info.vo.DefinitionVo;
	import com.vhall.app.model.info.vo.ServeLinevo;
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
	import com.vhall.framework.ui.event.DragEvent;
	
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
		
		private var _volumeBar:VolumeBar;
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
			hb.right = 10;
			hb.verticalAlign = "center";
			hb.horizontalAlign = "right";
			
			// 静音
			var volumeBox:HBox = new HBox(this);
			volumeBox.left = 10;
			volumeBox.verticalCenter = 0;
			volumeBox.verticalAlign = "center";
			_muteBut = new ToggleButton(volumeBox);
			_muteBut.skin = "assets/ui/mic2.png";
			_muteBut.downSkin = "assets/ui/mic1.png";
			_muteBut.tooltip = "静音";
			_muteBut.callOut = "top";
			_muteBut.addEventListener(Event.SELECT,muteHandler);
			_volumeBar = new VolumeBar(volumeBox);
			_volumeBar.volumeSlipComp.addEventListener(DragEvent.CHANGE,volumeChange);
			_volumeBeforeMute = MediaModel.me().volume * 100;
			_volumeBar.volumeValue = MediaModel.me().volume * 100;
			
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
		
		
		private function volumeChange(e:DragEvent):void
		{
			MediaModel.me().volume = e.percent;
			NResponder.dispatch(AppCMD.MEDIA_SET_VOLUME,[e.percent]);
			_muteBut.setSelected(e.percent == 0);
			muteHandler(e);
			_volumeBeforeMute = _volumeBar.volumeValue;
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
		
		
		protected function muteHandler(event:Event):void
		{
			if(_muteBut.selected)
			{
				_volumeBeforeMute = _volumeBar.volumeValue;
				_volumeBar.volumeValue = 0;
			}else{
				_volumeBar.volumeValue = _volumeBeforeMute||50;
			}
			MediaModel.me().volume = _volumeBar.volumeValue/100;
			NResponder.dispatch(AppCMD.MEDIA_SET_VOLUME);
		}
		
		/**
		 *初始化清晰度组件
		 * 
		 */		
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
			definationBox.changeCurrentSelect2Show = true;
			definationBox.initList(showData);
			definationBox.addEventListener(Event.CHANGE,onDefinationChange);
		}
		
		/**
		 *初始化线路组件 
		 * 
		 */		
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
				serverLinke.initList(showData,92);
				serverLinke.setShowItemSize(60,20);
				serverLinke.showlabel = "切换线路";
				
				serverLinke.addEventListener(Event.CHANGE,onServerLineChange);
			}
		}
		
		/**
		 *初始化视频音频模式组件 
		 * 
		 */		
		protected function onInitVideoModeBtn():void{
//			if(!Model.Me().streamType)return;
			changeVideoMode = new VideoAudioChangeBtn(hb)
			changeVideoMode.addEventListener(Event.CHANGE,onVideoModeChange);
		}
		/**
		 *音频视频模式改变时 处理数据，及切换播放 
		 * @param event
		 * 
		 */		
		protected function onVideoModeChange(event:Event):void
		{
			// TODO Auto-generated method stub
			changeVideoMode.isVideoMode;
			DataService.onVideoModelChange(changeVideoMode.isVideoMode);
			DataService.updateMediaInfo();
			MediaModel.me().videoMode = Model.playerStatusInfo.viewVideoMode;
			NResponder.dispatch(AppCMD.MEDIA_CHANGEVIDEO_MODE);
			NResponder.dispatch(AppCMD.UI_SHOW_LOADING);
		}
		/**
		 *清晰度改变时 处理数据 切换播放 
		 * @param event
		 * 
		 */		
		protected function onDefinationChange(event:Event):void
		{
			// TODO Auto-generated method stub
			Logger.getLogger("ViewerControlBar").info("onServerLineChange :",definationBox.getSelectData().value);
			var selectDef:String = definationBox.getSelectData().value
			if(DataService.onSelectDef(selectDef)){
				DataService.updateMediaInfo();
				NResponder.dispatch(AppCMD.MEDIA_SWITCH_QUALITY);
				NResponder.dispatch(AppCMD.UI_SHOW_LOADING);
			}
		}
		/**
		 * 线路改变时 处理数据 切换播放 
		 * @param event
		 * 
		 */		
		protected function onServerLineChange(event:Event):void
		{
			// TODO Auto-generated method stub
			Logger.getLogger("ViewerControlBar").info("onServerLineChange :",serverLinke.getSelectData().value);
			var selectSl:String = serverLinke.getSelectData().value;
			if(DataService.onSelectServerLine(selectSl)){
				DataService.updateMediaInfo();
				NResponder.dispatch(AppCMD.MEDIA_SWITCH_LINE);
				NResponder.dispatch(AppCMD.UI_SHOW_LOADING);
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
	}
}
