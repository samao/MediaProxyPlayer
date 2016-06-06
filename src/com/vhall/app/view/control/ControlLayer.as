package com.vhall.app.view.control
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.tween.AppTween;
	import com.vhall.framework.tween.TweenNano;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class ControlLayer extends Layer implements IResponder
	{
		
		private var bar:AbstractControlBar;
		
		public function ControlLayer(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void
		{
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
//			Model.Me().userinfo.is_pres = false;
			if(Model.Me().userinfo.is_pres)
			{
				bar = new HostControlBar(this);	
			}
			else
			{
				bar = new ViewerControlBar(this);
			}
		}
		
		public function careList():Array
		{
			var arr:Array = [];
			return arr;
		}
		
		public function handleCare(msg:String, ...args):void
		{
			switch(msg)
			{
			}
		}
		
		override protected function sizeChanged():void
		{
			super.sizeChanged();
			bar.width = width;
		}
	}
}