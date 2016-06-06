package
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.common.controller.MenuController;
	import com.vhall.app.common.controller.MessageController;
	import com.vhall.app.manager.LayerManager;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.view.barrage.BarrageLayer;
	import com.vhall.app.view.control.ControlLayer;
	import com.vhall.app.view.effect.EffectLayer;
	import com.vhall.app.view.popup.PopupLayer;
	import com.vhall.app.view.video.VideoLayer;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.container.Box;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import appkit.responders.NResponder;

	/**
	 * 主类
	 * @author Sol
	 * @date 2016-05-24 21:25:26
	 */
	public class Live extends Box implements IResponder
	{
		// 整个视频层
		public var videoLayer:Layer;
		// 控制层，音量，线路，全屏那些
		public var controlLayer:Layer;
		// 弹幕层
		public var barrageLayer:Layer;
		// 特效层 跑马灯，礼物特效？ 等
		public var effectLayer:Layer;
		// 弹框层
		public var popupLayer:Layer;
		
		public var checkTimer:int;

		public function Live(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
			new MenuController();
			new MessageController();
			new ResponderMediator(this);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			videoLayer = new VideoLayer(this);
			controlLayer = new ControlLayer(this);
			controlLayer.height = 35;
			barrageLayer = new BarrageLayer(this);
			effectLayer = new EffectLayer(this);
			popupLayer = new PopupLayer(this);
			LayerManager.initLayer(this);
			addStageListener();
			onTest();
		}

		/**	感兴趣 的消息*/
		public function careList():Array
		{
			var arr:Array = [];
			return arr;
		}

		/**	感兴趣的消息的处理函数*/
		public function handleCare(msg:String, ... parameters):void
		{
			switch(msg)
			{

			}
		}

		override protected function sizeChanged():void
		{
			super.sizeChanged();
			_height = StageManager.stageHeight;
			_width = StageManager.stageWidth;
			controlLayer.width = StageManager.stageWidth;
			popupLayer.setSize(StageManager.stageWidth, StageManager.stageHeight);
			videoLayer.setSize(StageManager.stageWidth, StageManager.stageHeight);
		}
		
		
		
		public function addStageListener():void{
			StageManager.stage.addEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
			StageManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
		}
		
		public function removeStageListener():void{
			StageManager.stage.removeEventListener(Event.MOUSE_LEAVE,onStageMouseLeave);
			StageManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onStageMouseMove);
		}
		
		protected function onStageMouseWheel(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onStageMouseMove(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			Mouse.show();
			NResponder.dispatch(AppCMD.UI_SHOW_CONTROLBAR);
			clearDalayCheck();
			reStartDelayCheck();
		}
		
		protected function onStageMouseLeave(event:Event):void
		{
			// TODO Auto-generated method stub
			//发送显示控制栏
			clearDalayCheck();
			NResponder.dispatch(AppCMD.UI_HIDE_CONTROLBAR);
		}
		
		/**
		 *清理检测 
		 * 
		 */		
		private function clearDalayCheck():void{
			clearTimeout(checkTimer);
		}
		/**
		 *从新开始检测 
		 * 
		 */		
		protected function reStartDelayCheck():void{
			checkTimer = setTimeout(onDelayCheckMouse,2000);
		}
		
		/**
		 *发送隐藏控制栏通知 
		 * 
		 */		
		protected function onDelayCheckMouse():void{
			if(StageManager.stage.displayState==StageDisplayState.FULL_SCREEN)
			{
				Mouse.hide();
			}
			NResponder.dispatch(AppCMD.UI_HIDE_CONTROLBAR);
		}
		
		
		public function onTest():void{
			NResponder.dispatch(AppCMD.UI_SHOW_LOGOLOADING);
		}
	}
}
