package com.vhall.app.view.control.ui
{
	import com.vhall.framework.ui.controls.HDragBar;
	import com.vhall.framework.ui.controls.Style;
	import com.vhall.framework.ui.utils.ComponentUtils;
	
	import flash.display.Shape;
	
	public class VolumeDragBar extends HDragBar
	{
		public function VolumeDragBar()
		{
			super();
		}
		
		override protected function initSize():void
		{
			// TODO Auto Generated method stub
			_w = 95;
			_h = 24;
		}
		
		
		override protected function initSkin():void{
			bg.source = getBgSource();
			buffer.source = ComponentUtils.genInteractiveRect(80, 3, null, 5, 10, 0x000000);
			finished.source = ComponentUtils.genInteractiveRect(80, 3, null, 5, 10, 0XDE403D);
			quad.source = ComponentUtils.genInteractiveRect(21, 21, null,0,0,0x000000);
			quadSkin = "assets/ui/quad.png";
			quad.setSize(18,18);
			buffer.move(5,10);
			finished.move(5,10);
		}
		
		protected function getBgSource():Shape{
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0x363636,.8);
			shp.graphics.drawRoundRect(0,0,_w,_h,5,5);
			shp.graphics.endFill();
			return shp
		}
		/**
		 *设置bg是否显示
		 * @param visible
		 * 
		 */		
		public function set bgVisible(visible:Boolean):void{
			bg.visible = visible
		}
	}
}