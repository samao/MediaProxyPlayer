package com.vhall.app.view.popup
{
	import com.vhall.app.view.warn.WarnLogoPanel;
	import com.vhall.app.view.warn.WarnPanel;
	import com.vhall.framework.ui.container.Box;
	
	public class WarnPop extends Box
	{
		public var warn_logo:WarnLogoPanel;
		public var warnPanel:WarnPanel;
		
		public function WarnPop()
		{
			super();
			verticalCenter = 0;
			horizontalCenter = 0;
		}
		
		override protected function createChildren():void
		{
			warn_logo = new WarnLogoPanel();
			warnPanel = new WarnPanel();
		}
		
		/**
		 *显示结束 
		 * 
		 */		
		public function showOverPic():void{
			removeAllChild();
			warn_logo.setLabel("直播结束，感谢您的参与！");
			addChild(warn_logo);
		}
		
		/**
		 *显示切换 
		 * 
		 */		
		public function showSwitchPres():void{
			removeAllChild();
			warnPanel.setLabel("正在切换主讲人，请稍候...");
			addChild(warnPanel);
		}
		
		/**
		 *切换给嘉宾 
		 * 
		 */		
		public function showSwitchToGuest():void{
			removeAllChild();
			warnPanel.setLabel("正在将主讲权限切换给嘉宾,请稍候...");
			addChild(warnPanel);
		}
		
		/**
		 *切换给嘉宾 
		 * 
		 */		
		public function showSwitchToYou():void{
			removeAllChild();
			warnPanel.setLabel("正在将主讲权限切换给您，请稍候...");
			this.addChild(warnPanel);
		}
		
		public function showSwitchAssistant():void
		{
			removeAllChild();
			warn_logo.setLabel("您正在使用小助手");
			this.addChild(warn_logo);
		}
		
	}
}