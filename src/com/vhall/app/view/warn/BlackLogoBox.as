package com.vhall.app.view.warn
{
	import com.vhall.framework.ui.controls.Image;

	import flash.display.DisplayObjectContainer;

	public class BlackLogoBox extends BlackBox
	{
		private var logo:Image;

		public function BlackLogoBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			logo = new Image(this);
			logo.source = "../vhall_art/ui/logo_237_66.png";
			logo.move(42,55);
		}

		public function logoRePosition(tx:int, ty:int):void
		{
			logo.move(tx, ty);
		}
	}
}
