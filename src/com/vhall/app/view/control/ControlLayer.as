package com.vhall.app.view.control
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.MessageType;
	import com.vhall.framework.app.mvc.IResponder;
	
	import flash.display.DisplayObjectContainer;
	
	public class ControlLayer extends Layer implements IResponder
	{
		
		private var bar:ControlBar;
		
		public function ControlLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			bar = new ControlBar(this);
		}
		
		public function careList():Array
		{
			var arr:Array = [];
			return null;
		}
		
		public function handleCare(msg:String, ...parameters):void
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