package com.vhall.app.view.popup
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.log.Logger;
	
	import flash.display.DisplayObjectContainer;
	
	public class PopupLayer extends Layer implements IResponder
	{
		public function PopupLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		/**
		 *提示板 
		 */
		public var warnPop:WarnPop;
		
		public function careList():Array
		{
			return [
				AppCMD.SHOWWARN_OVER_PIC,
				AppCMD.SWITCHINGPRES,
				AppCMD.SWITCH_TO_ASSISTANT
			];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			Logger.getLogger("PopupLayer").info("handleCare Enter MSG:"+msg);
			switch(msg)
			{
				case AppCMD.SHOWWARN_OVER_PIC:
					ShowOver();
					break;
				case AppCMD.SWITCHINGPRES:
					showSwitchPres();
					break;
				case AppCMD.SWTICHTOYOU:
					showSwitchYou();
					break;
				case AppCMD.SWITCHTOGUEST:
					showSwitchGuest();
					break;
				case AppCMD.SWITCH_TO_ASSISTANT:
					showSwitchAssistant();
					break;
				default:
					break;
			}
		}
		
		/**
		 *显示结束提示
		 * 
		 */		
		protected function ShowOver():void{
			hideWarn();
			warn.showOverPic();
			this.addChild(warn);
		}
		
		/**
		 *显示切换中 
		 * 
		 */		
		protected function showSwitchPres():void{
			hideWarn();
			warn.showSwitchPres();
			this.addChild(warn);
		}
		
		/**
		 *显示切换给你 
		 * 
		 */		
		protected function showSwitchYou():void{
			hideWarn();
			warn.showSwitchToYou();
			this.addChild(warn); 
		}
		/**
		 *显示切换给嘉宾 
		 * 
		 */		
		protected function showSwitchGuest():void{
			hideWarn();
			warn.showSwitchToGuest();
			this.addChild(warn);
		}
		
		/**	显示小助手LOGO*/
		protected function showSwitchAssistant():void
		{
			hideWarn();
			warn.showSwitchAssistant();
			this.addChild(warn);
		}
		
		/**
		 *隐藏 
		 * 
		 */		
		protected function hideWarn():void{
			warnPop && warnPop.removeFromParent();
		}
		
		/**
		 *快捷获取提示框 
		 * @return 
		 * 
		 */		
		public function get warn():WarnPop{
			if(warnPop == null){
				warnPop = new WarnPop();
			}
			return warnPop;
		}
	}
}