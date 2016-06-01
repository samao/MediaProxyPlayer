package
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.manager.LayerManager;
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
		
		public function Live(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			new ResponderMediator(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			videoLayer = new VideoLayer(this);
			controlLayer = new ControlLayer(this);
			controlLayer.setSize(StageManager.stageWidth, 35);
			controlLayer.bottom = 0;
			barrageLayer = new BarrageLayer(this);
			effectLayer = new EffectLayer(this);
			popupLayer = new PopupLayer(this);
			setSize(StageManager.stageWidth,StageManager.stageHeight);
			LayerManager.initLayer(this);
		}
		
		/**	感兴趣 的消息*/
		public function careList():Array
		{
			var arr:Array = [];
			
			return arr;
		}
		
		/**	感兴趣的消息的处理函数*/
		public function handleCare(msg:String, ...parameters):void
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
		}
	}
}