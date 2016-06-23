package com.vhall.app.view.popup.ui
{
	import com.vhall.framework.ui.controls.Image;
	import com.vhall.framework.ui.controls.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class WarnPanel extends RectBox
	{
		private var label:Label;
		private var pic:Image;
		public function WarnPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			pic.source=  "assets/ui/logo.png"
			pic.x = 42;
			pic.y = 55;
			this.addChild(pic);
			
			label = new Label(this);
			var df:TextFormat = label.textField.defaultTextFormat;
			df.color = 0xFFFFFF;
			df.size = 18;
			df.align = TextFieldAutoSize.CENTER;
			label.textField.defaultTextFormat = df;
			label.move(0,146)
			label.horizontalCenter = 0;
		}
		
		public function setLabel(value:String):void{
			label.text = value;
			label.textField.width = label.textField.textWidth +4;
			label.horizontalCenter = 0;
		}
		
		public function labelRePosition(tx:int,ty:int):void{
			label.move(tx, ty);
		}
	}
}