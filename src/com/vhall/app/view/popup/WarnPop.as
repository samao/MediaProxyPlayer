package com.vhall.app.view.popup
{
	import com.vhall.app.view.warn.WarnLogoPanel;
	import com.vhall.app.view.warn.WarnPanel;
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
		public var warnPanel:WarnPanel;
		protected var tParent:DisplayObjectContainer
		public function WarnPop(parent:DisplayObjectContainer)
		{
			super();
			tParent = parent;
			verticalCenter = 0;
			horizontalCenter = 0;
		}
		
		override protected function createChildren():void
		{
			warn_logoPanel = new WarnLogoPanel();
			warnPanel = new WarnPanel();
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
			warnPanel.setLabel(warn);
			this.addChild(warnPanel);
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