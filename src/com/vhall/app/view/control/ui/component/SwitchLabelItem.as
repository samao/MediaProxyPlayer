package com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.app.manager.RenderManager;
	
	import flash.display.DisplayObjectContainer;

	/**
	 * 用户combox显示label的渲染组件 
	 * @author zqh
	 * 
	 */	
	public class SwitchLabelItem extends SwitchItemRender
	{
		public function SwitchLabelItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.setSize(40,20);
		}
		
		override protected function initDrawBg():void{
			this.graphics.clear()
			this.graphics.beginFill(outBgColor,85);
			this.graphics..drawRoundRect(0,0,this._width,this.height,4,4);
			this.graphics.endFill();
			RenderManager.getInstance().invalidate(invalidate);
		}
		
		
		override protected function overDrawBg():void{
			this.graphics.clear()
			this.graphics.beginFill(overBgColor,85);
			this.graphics.drawRoundRect(0,0,this._width,this.height,4,4);
			this.graphics.endFill();
			RenderManager.getInstance().invalidate(invalidate);
		}
	}
}