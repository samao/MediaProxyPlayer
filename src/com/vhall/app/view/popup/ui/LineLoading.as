package com.vhall.app.view.popup.ui
{
	import com.vhall.framework.ui.container.Box;
	import com.vhall.view.LoadingLine;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * 暂时不需要
	 * @author zqh 
	 * 
	 */	
	public class LineLoading extends Box
	{
		private var lineLoading:MovieClip;
		public function LineLoading(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			lineLoading = new com.vhall.view.LoadingLine();
			this.addChild(lineLoading);
		}
		
	}
}