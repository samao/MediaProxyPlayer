package com.vhall.app.view.warn
{
	import com.vhall.app.model.Model;
	import com.vhall.framework.ui.controls.Label;
	
	import flash.display.DisplayObjectContainer;

	public class WarnLogoPanel extends LogoBox
	{
		private var label:Label;

		public function WarnLogoPanel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			label = new Label(this);
			label.color = 0xFFFFFF;
			label.fontSize = 18;
			label.move(0, 146);
			label.setSize(320, 28);
			label.align = "center";
			
			if(Model.playerStatusInfo.hide_powered){
				logo && logo.visible;
			}
		}

		public function setLabel(value:String):void
		{
			label.text = value;
		}

		public function labelRePosition(tx:int, ty:int):void
		{
			label.move(tx, ty);
		}

	}
}
