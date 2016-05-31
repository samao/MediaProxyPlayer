package com.vhall.app.view.warn
{
	import com.vhall.framework.ui.controls.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class WarnPanel extends BlackBox
	{
		private var label:Label;
		public function WarnPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			initLabel();
		}
		
		protected function initLabel():void{
			label = new Label();
			var df:TextFormat = label.textField.defaultTextFormat;
			df.color = 0xFFFFFF;
			df.size = 14;
			df.align = TextFieldAutoSize.CENTER;
			label.textField.defaultTextFormat = df;
			label.x = 0;
			label.y = 71;
			label.width = 320;
			label.height = 28;
			this.addChild(label);
		}
		
		
		public function setLabel(value:String):void{
			label.text = value;
			label.textField.width = label.textField.textWidth +4;
			label.x = (this.width - label.textField.width)/2
		}
		
		public function labelRePosition(tx:int,ty:int):void{
			label.x = tx;
			label.y = ty;
		}
	}
}