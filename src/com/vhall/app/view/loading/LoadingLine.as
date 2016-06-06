package com.vhall.app.view.loading
{
	import com.vhall.framework.ui.container.Box;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	/**
	 * 暂时不需要
	 * @author zqh 
	 * 
	 */	
	public class LoadingLine extends Box
	{
		private var lineLoading:MovieClip;
		public function LoadingLine(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			var cla:Class = getDefinitionByName("com.vhall.view.LoadingLine") as Class;
			lineLoading = new cla();
			this.addChild(lineLoading);
		}
		
	}
}