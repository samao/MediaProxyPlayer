package com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.ui.controls.Button;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	
	/**
	 *
	 *@author zhaoqinghao
	 *@data 2016-6-7 下午6:17:21
	 */
	public class SwitchBtn extends Button
	{
		public function SwitchBtn(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.setSize(50,20);
			this.skin = btnUpBg;
			this.overSkin = btnOverBg;
			this.labelColor = 0xFFFFFF;
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			// TODO Auto Generated method stub
			super.setSize(w, h);
			this.skin = btnUpBg;
			this.overSkin = btnOverBg;
		}
		
		
		protected function get btnUpBg():Shape{
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0x373737);
			shp.graphics.drawRoundRect(0,0,_width,_height,4,4);
			shp.graphics.endFill();
			shp.graphics.beginFill(0x2D2D2D);
			shp.graphics.drawRoundRect(1,1,_width-2,_height-2,4,4);
			shp.graphics.endFill();
			return shp
		}
		
		protected function get btnOverBg():Shape{
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0xE81926);
			shp.graphics.drawRoundRect(0,0,_width,_height,4,4);
			shp.graphics.endFill();
			shp.graphics.beginFill(0xE94644);
			shp.graphics.drawRoundRect(1,1,_width-2,_height-2,4,4);
			shp.graphics.endFill();
			return shp
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
		}
		
		override protected function updateDisplay():void
		{
			super.updateDisplay();
		}
	}
}