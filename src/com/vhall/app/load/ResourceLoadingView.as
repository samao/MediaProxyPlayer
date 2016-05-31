package com.vhall.app.load
{
	import com.vhall.framework.app.App;
	import com.vhall.framework.app.manager.StageManager;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	/**
	 *	资源加载视图 
	 * @author Sol
	 * 
	 */	
	public class ResourceLoadingView extends Sprite
	{
		
		private static var loader:ResourceLoadingView = new ResourceLoadingView();
		private var l:Loader;
		private var ctx:LoaderContext
		
		public function ResourceLoadingView()
		{
			super();
			
			l = new Loader();
			ctx = new LoaderContext(false,ApplicationDomain.currentDomain);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			l.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
		}
		
		public static function show(url:String, complete:Function, progress:Function = null):void
		{
			loader.show(url, complete, progress);
		}
		
		private function createAndConfigUI():void
		{
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0,0,StageManager.stageWidth,StageManager.stageHeight);
			graphics.endFill();
			
			while(numChildren)
			{
				removeChildAt(0);
			}
			
			var logo:Class = getDefinitionByName("logo") as Class;
			var dis:DisplayObject = new logo();
			dis.x = StageManager.stageWidth - dis.width >> 1;
			dis.y = StageManager.stageHeight - dis.height >> 1;
			addChild(dis);
		}
		
		private function show(url:String, complete:Function, progress:Function = null):void
		{
			createAndConfigUI();
			App.app.stage.addChild(this);
			var req:URLRequest = new URLRequest(url);
			this.complete = complete;
			this.progress = progress;
			l.load(req,ctx);
		}
		
		private function hide():void
		{
			App.app.stage.removeChild(this);
		}
		
		private var complete:Function = null;
		private var progress:Function = null;
		
		protected function loaderProgressHandler(event:ProgressEvent):void
		{
			if(this.progress != null)
			{
				progress(event.bytesTotal,event.bytesLoaded);
			}
		}
		
		protected function loaderCompleteHandler(event:Event):void
		{
			if(this.complete != null)
			{
				complete(l.content);
			}
			
			hide();
		}
	}
}