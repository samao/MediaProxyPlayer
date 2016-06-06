package com.vhall.app.view.control
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.tween.TweenNano;
	
	import flash.display.DisplayObjectContainer;
	
	public class ControlLayer extends Layer implements IResponder
	{
		
		private var bar:ControlBar;
		
		public function ControlLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			bar = new ControlBar(this);
		}
		
		public function careList():Array
		{
			var arr:Array = [
			AppCMD.UI_SHOW_CONTROLBAR,
			AppCMD.UI_HIDE_CONTROLBAR
			];
			return arr;
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			switch(msg)
			{
				case AppCMD.UI_SHOW_CONTROLBAR:
					toShowControlbar();
					break;
				case AppCMD.UI_HIDE_CONTROLBAR:
					toHideControlbar()
					break;
			}
		}
		
		
		protected function toShowControlbar():void{
			TweenNano.to(bar,.25,{y:StageManager.stage.stageHeight-bar.height});
		}
		
		protected function toHideControlbar():void{
			TweenNano.to(bar,.25,{y:StageManager.stage.stageHeight});
		}
		
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bar.width = width;
		}
	}
}