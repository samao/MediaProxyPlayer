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
		
		public function ControlLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
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
		
		public function careList():Array
		{
			return [
				AppCMD.SWITCHINGPRES,
				AppCMD.SWITCHTOGUEST
			];
		}
		
		public function handleCare(msg:String, ...args):void
		{
			switch(msg)
			{
				case AppCMD.SWITCHINGPRES:
					setToHost();
					break;
				case AppCMD.SWITCHTOGUEST:
					setToView();
					break;
			}
		}
		
		private function setToHost():void
		{
			//if(bar) bar.removeFromParent();
			bar = _hostBar ||= new HostControlBar(this);
			this.addChild(bar);
		}
		
		private function setToView():void
		{
			if(bar) bar.removeFromParent();
			bar = _viewBar ||= new ViewerControlBar(this);
			this.addChild(bar);
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bar.width = width;
		}
	}
}