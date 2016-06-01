package com.vhall.app.view.warn
{
	import com.vhall.framework.ui.controls.Image;
	
	import flash.display.DisplayObjectContainer;
	
	public class BlackLogoBox extends BlackBox
	{
		private var logo:Image;
		public function BlackLogoBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			initLogo();
		}
		
		protected function initLogo():void{
			logo = new Image(this);
			logo.source = "../vhall_art/ui/logo_237_66.png";
			logo.x= 42;
			logo.y = 55;
		}
		
		public function logoRePosition(tx:int,ty:int):void{
			
		}
	}
}