package com.vhall.app.view.control
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.mvc.IResponder;
	
	import flash.display.DisplayObjectContainer;
	
	public class ControlLayer extends Layer implements IResponder
	{
		/** 控制栏*/
		private var bar:AbstractControlBar;
		
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
				bar = new HostControlBar(this);	
			}
			else
			{
				bar = new ViewerControlBar(this);
			}
		}
		
		public function careList():Array
		{
			var arr:Array = [];
			return arr;
		}
		
		public function handleCare(msg:String, ...args):void
		{
			switch(msg)
			{
			}
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bar.width = width;
		}
	}
}