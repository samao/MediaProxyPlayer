package
{
	import com.vhall.app.common.controller.MessageController;
	import com.vhall.app.net.MediaAJMessage;
	import com.vhall.framework.app.App;
	import com.vhall.framework.app.manager.StageManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			new MessageController();
		}
		
		protected function onResize(event:Event):void
		{
			var obj:DisplayObject = this.getChildAt(0);
			obj.width = StageManager.stageWidth;
			obj.height = StageManager.stageHeight;
		}
	}
}