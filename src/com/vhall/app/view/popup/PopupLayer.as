package com.vhall.app.view.popup
{
	import com.vhall.app.actions.Actions_UI;
	import com.vhall.app.common.Layer;
	import com.vhall.framework.app.mvc.IResponder;
	
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
				Actions_UI.SHOWWARN_OVER_PIC,
				Actions_UI.SHOWWARN_SWITCHINGPRESPIC
			];
		}
		
	public function handleCare(msg:String, ...parameters):void
		{
			switch(msg)
			{
				case Actions_UI.SHOWWARN_OVER_PIC:
				{
					ShowOver();
					break;
				}
					
				case Actions_UI.SHOWWARN_SWITCHINGPRESPIC:
				{
					showSwitchPres();
					break;
				}
					
				case Actions_UI.SHOWWARN_SWTICHTOYOU:
				{
					showSwitchYou();
					break;
				}
					
				case Actions_UI.SHOWWARN_SWITCHTOGUEST:
				{
					showSwitchGuest();
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		/**
		 *显示结束提示
		 * 
		 */		
		protected function ShowOver():void{
			this.addChild(warn);
			warn.showOverPic();
		}
		
		/**
		 *显示切换中 
		 * 
		 */		
		protected function showSwitchPres():void{
			this.addChild(warn);
			warn.showSwitchPres();
		}
		
		/**
		 *显示切换给你 
		 * 
		 */		
		protected function showSwitchYou():void{
			this.addChild(warn);
			warn.showSwitchToYou();
		}
		/**
		 *显示切换给嘉宾 
		 * 
		 */		
		protected function showSwitchGuest():void{
			this.addChild(warn);
			warn.showSwitchToGuest();
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