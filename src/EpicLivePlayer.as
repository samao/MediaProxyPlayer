package
{
	import com.vhall.app.common.controller.MenuController;
	import com.vhall.app.common.controller.MessageController;
	import com.vhall.app.load.ResourceLoadingView;
	import com.vhall.framework.app.App;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.load.ResourceLibrary;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	
	[SWF(width="960",height="640",backgroundColor="0xC0C0C0")]
	public class EpicLivePlayer extends App
	{
		public function EpicLivePlayer()
		{
			super();
			
			addEventListener(Event.COMPLETE, onInited);
		}
		
		protected function onInited(event:Event):void
		{
			removeEventListener(Event.COMPLETE, onInited);
			StageManager.stage.addEventListener(Event.RESIZE,onResize);
			//new MenuController();
			new MessageController();
			
			// load live.swf
			var arr:Array = [];
			arr.push({id:"ui",url:"ui.swf"});
			arr.push({id:"live",url:"Live.swf"});
			//ResourceLoadingView.show(arr,itemComplete,progress,allComplete);
		}
		
		protected function onResize(event:Event):void
		{
			var obj:DisplayObject = this.getChildAt(0);
			obj.width = StageManager.stageWidth;
			obj.height = StageManager.stageHeight;
		}
		
		protected function itemComplete(item:Object, content:Object, domain:ApplicationDomain):void
		{
			switch(item.id)
			{
				case "ui":
					ResourceLibrary.addLibrary("ui",content.getAssets());
					break;
				case "live":
					addChild(content as DisplayObject);
					break;
			}
				
		}
		
		protected function progress(totalCount:int, loadedCount:int, bytesTotal:Number, bytesLoaded:Number, currentItem:Object):void
		{
			
		}
		
		protected function allComplete():void
		{
			
		}
	}
}