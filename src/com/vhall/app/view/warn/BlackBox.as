package com.vhall.app.view.warn
{
	import com.vhall.framework.ui.container.Box;
	
	import flash.display.DisplayObjectContainer;
	
	public class BlackBox extends Box
	{
		public function BlackBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			init();
			super(parent, xpos, ypos);
		}
		
		override protected function init():void{
			super.init();
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,320,240);
			this.graphics.endFill();
		}
	}
}