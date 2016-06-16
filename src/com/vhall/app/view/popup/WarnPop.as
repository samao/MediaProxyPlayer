package com.vhall.app.view.popup
{
	import com.vhall.app.view.warn.WarnLogoPanel;
	import com.vhall.app.view.warn.WarnPanel;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.ui.container.Box;
	
	import flash.display.DisplayObjectContainer;

	/**
	 * 提示信息pop
	 * @author zqh
	 * 
	 */	
	public class WarnPop extends Box
	{
		public var warn_logoPanel:WarnLogoPanel;
		protected var tParent:DisplayObjectContainer
		public function WarnPop(parent:DisplayObjectContainer)
		{
			super();
			tParent = parent;
		}
		
		override protected function createChildren():void
		{
			onUpdateBg();
			warn_logoPanel = new WarnLogoPanel();
		}
		
		protected function onUpdateBg():void{
			this.graphics.clear();
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,StageManager.stageWidth,StageManager.stageHeight);
			this.graphics.endFill();
		}
		
		override protected function sizeChanged():void
		{
			// TODO Auto Generated method stub
			super.sizeChanged();
			onUpdateBg();
			if(warn_logoPanel){
				warn_logoPanel.x = (StageManager.stageWidth - warn_logoPanel.width)>>1;
				warn_logoPanel.y = (StageManager.stageHeight - warn_logoPanel.height)>>1;
			}
		}
		
	
		/**
		 *显示带logo的提示 
		 * @param warn
		 * 
		 */		
		public function showLogoWarn(warn:String):void
		{
			removeAllChild();
			warn_logoPanel.setLabel(warn);
			this.addChild(warn_logoPanel);
			show();
		}
		
		/**
		 *显示提示 
		 * @param warn
		 * 
		 */		
		public function showWarn(warn:String):void{
			removeAllChild();
			warn_logoPanel.setLabel(warn);
			this.addChild(warn_logoPanel);
			show();
		}
		
		/**
		 *显示到父级 
		 * 
		 */		
		public function show():void{
			if(this.tParent && !this.parent){
				this.tParent.addChild(this);
			}
		}
	}
}