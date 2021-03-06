package com.vhall.app.view.control
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.mvc.IResponder;

	import flash.display.DisplayObjectContainer;

	public class ControlLayer extends Layer implements IResponder
	{
		/** 控制栏*/
		private var bar:AbstractControlBar;

		private var _hostBar:AbstractControlBar;

		private var _viewBar:AbstractControlBar;

		public function ControlLayer(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			height = 35;
			bottom = 0;
		}

		override protected function init():void
		{
			super.init();
		}

		override protected function createChildren():void
		{
			super.createChildren();
			if(Model.Me().userinfo.is_pres)
			{
				setToHost();
			}
			else
			{
				setToView();
			}
		}


		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bar.width = width;
		}

		protected function setToHost():void
		{
			if(bar)
				bar.removeFromParent();
			bar = _hostBar ||= new HostControlBar();
			this.addChild(bar);
		}

		protected function setToView():void
		{
			if(bar)
				bar.removeFromParent();
			bar = _viewBar ||= new ViewerControlBar();
			this.addChild(bar);
		}

		public function careList():Array
		{
			return [AppCMD.UI_CHANGE_CONTROLBAR, AppCMD.UI_SHOW_CONTROLBAR, AppCMD.UI_HIDE_CONTROLBAR, AppCMD.UI_AUTO_CHANGE_SERVERLINE];
		}

		public function handleCare(msg:String, ... args):void
		{
			switch(msg)
			{
				case AppCMD.UI_CHANGE_CONTROLBAR:
					if(Model.userInfo.is_pres)
					{
						setToHost();
					}
					else
					{
						setToView();
					}
					break;
				case AppCMD.UI_SHOW_CONTROLBAR:
					if(bar)
					{
						bar.visible = true;
					}
					break;
				case AppCMD.UI_HIDE_CONTROLBAR:
					if(bar)
					{
						bar.visible = false;
					}
					break;
				case AppCMD.UI_AUTO_CHANGE_SERVERLINE:
					if(bar && bar is ViewerControlBar)
					{
						(bar as ViewerControlBar).onAutoChangeServeLine();
					}
					break;
			}
		}
	}
}

