package com.vhall.app.view.barrage
{
	import com.vhall.app.common.Layer;
	import com.vhall.framework.app.mvc.IResponder;
	
	import flash.display.DisplayObjectContainer;
	
	public class BarrageLayer extends Layer implements IResponder
	{
		public function BarrageLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		public function careList():Array
		{
			return null;
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
		}
	}
}