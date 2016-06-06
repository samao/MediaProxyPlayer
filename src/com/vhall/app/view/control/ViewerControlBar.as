package com.vhall.app.view.control
{
	import com.vhall.app.common.components.TimeLabel;
	import com.vhall.app.model.Model;
	import com.vhall.app.model.vo.DefinitionVo;
	import com.vhall.app.model.vo.ServeLinevo;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.view.control.ui.VolumeBar;
	import com.vhall.app.view.control.ui.component.SwitchListBox;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.HBox;
	import com.vhall.framework.ui.controls.Button;
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
		
		private var timerLabel:TimeLabel;
		
		private var definationBox:SwitchListBox;
		
		private var serverLinke:SwitchListBox;
		
		private var changeVideoMode:Sprite;
		
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
			
			onInitDefination();
			
			onInitServerLine();
			
			var btn:Button = new Button(hb);
			btn.skin = "assets/ui/mic1.png";
			
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
		
		protected function onInitDefination():void{
//			if(Model.Me().hideQualitySwitch) return;
			var sdata:Array = Model.Me().definitionInfo;
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
			var sdata:Array = Model.Me().serverLineInfo;
			var showData:Array = []
			if(sdata && sdata.length > 0){
				serverLinke = new SwitchListBox(hb);
				var tmpdta:ServeLinevo;
				var data:Object;
				for (var i:int = 0; i < sdata.length; i++) 
				{
					
					data = new Object();
					tmpdta = sdata[i]
					data.label = tmpdta.sname;
					data.value = tmpdta.sname;
					showData[i] = data;
				}
				serverLinke.initList(showData);
				serverLinke.addEventListener(Event.CHANGE,onServerLineChange);
			}
		}
		
		protected function onDefinationChange(event:Event):void
		{
			// TODO Auto-generated method stub
			trace(definationBox.getSelectData().value);
			NResponder.dispatch(AppCMD.MEDIA_SWITCH_LINE);
		}
		
		protected function onServerLineChange(event:Event):void
		{
			// TODO Auto-generated method stub
			trace(serverLinke.getSelectData().value);
			NResponder.dispatch(AppCMD.MEDIA_SWITCH_QUALITY);
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
