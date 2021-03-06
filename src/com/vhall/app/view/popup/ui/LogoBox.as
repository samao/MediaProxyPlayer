package com.vhall.app.view.popup.ui
{
	import com.vhall.app.common.Resource;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class LogoBox extends RectBox
	{
		protected var logo:DisplayObject;

		public function LogoBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			logo =  Resource.getLogo();
			logo.x = 65;
			logo.y = 55;
			this.addChild(logo);
		}

		public function logoRePosition(tx:int, ty:int):void
		{
			logo.x = tx;
			logo.y = ty;
		}
	}
}


