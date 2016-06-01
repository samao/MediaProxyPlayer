package com.vhall.app.view.popup
{
	import com.vhall.app.view.warn.WarnLogoPanel;
	import com.vhall.app.view.warn.WarnPanel;
	import com.vhall.framework.ui.container.Box;
	
	public class WarnPop extends Box
	{
		public function WarnPop()
		{
			super();
		}
		public var warn_logo:WarnLogoPanel;
		public var warnPanel:WarnPanel;
		
		/**
		 *显示结束 
		 * 
		 */		
		public function showOverPic():void{
			removeAll();
			if(warn_logo == null){
				warn_logo = new WarnLogoPanel();
				warn_logo.setLabel("直播结束，感谢您的参与！");
			}
			this.addChild(warn_logo);
		}
		
		/**
		 *显示切换 
		 * 
		 */		
		public function showSwitchPres():void{
			removeAll();
			if(warnPanel == null){
				warnPanel = new  WarnPanel();
				warnPanel.setLabel("正在切换主讲人，请稍候...");
			}
			this.addChild(warnPanel);
		}
		
		/**
		 *切换给嘉宾 
		 * 
		 */		
		public function showSwitchToGuest():void{
			removeAll();
			if(warnPanel == null){
				warnPanel = new  WarnPanel();
				warnPanel.setLabel("正在将主讲权限切换给嘉宾,请稍候...");
			}
			this.addChild(warnPanel);
		}
		
		/**
		 *切换给嘉宾 
		 * 
		 */		
		public function showSwitchToYou():void{
			removeAll();
			if(warnPanel == null){
				warnPanel = new  WarnPanel();
				warnPanel.setLabel("正在将主讲权限切换给您，请稍候...");
			}
			this.addChild(warnPanel);
		}
		
		/**
		 *移除所有 
		 * 
		 */		
		public function removeAll():void{
			if(warn_logo && warn_logo.parent){
				this.removeChild(warn_logo);
			}
			
			if(warnPanel && warnPanel.parent){
				this.removeChild(warnPanel);
			}
		}
	}
}