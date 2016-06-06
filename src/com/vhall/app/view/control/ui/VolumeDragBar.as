package com.vhall.app.view.control.ui
{
	import com.vhall.framework.ui.controls.HDragBar;
	import com.vhall.framework.ui.controls.Style;
	import com.vhall.framework.ui.utils.ComponentUtils;
	
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
			bg.source = ComponentUtils.genInteractiveRect(_w, _h, null, 0, 0, 0x333333,.8);
			buffer.source = ComponentUtils.genInteractiveRect(80, 3, null, 5, 10, 0x000000);
			finished.source = ComponentUtils.genInteractiveRect(80, 3, null, 5, 10, 0x3DAC63);
			quad.source = ComponentUtils.genInteractiveRect(21, 21, null,0,0,0x000000);
			quadSkin = "assets/ui/volSlipup.png";
			buffer.move(5,10);
			finished.move(5,10);
		}
		
		
		override protected function updateDisplay():void
		{
			super.updateDisplay();
			
		}
	}
}