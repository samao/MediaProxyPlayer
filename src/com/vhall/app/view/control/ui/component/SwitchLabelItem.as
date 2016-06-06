package com.vhall.app.view.control.ui.component
{
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
			this.setSize(36,20);
		}
	}
}