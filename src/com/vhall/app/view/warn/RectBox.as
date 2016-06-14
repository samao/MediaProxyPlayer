package com.vhall.app.view.warn
{
	import com.vhall.framework.ui.container.Box;
	
	import flash.display.DisplayObjectContainer;
	
	public class RectBox extends Box
	{
		public function RectBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		override protected function init():void{
			super.init();
			this.graphics.beginFill(0x000000,0.01);
			this.graphics.drawRect(0,0,320,240);
			this.graphics.endFill();
		}
	}
}