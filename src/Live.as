package
{
	import appkit.responders.NResponder;
	
	import com.vhall.app.common.Layer;
	import com.vhall.app.common.controller.MenuController;
	import com.vhall.app.common.controller.MessageController;
	import com.vhall.app.manager.LayerManager;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.AppCMD;
	import com.vhall.app.net.WebAJMessage;
	import com.vhall.app.view.barrage.BarrageLayer;
	import com.vhall.app.view.control.ControlLayer;
	import com.vhall.app.view.debug.DebugLayer;
	import com.vhall.app.view.effect.EffectLayer;
	import com.vhall.app.view.popup.PopupLayer;
	import com.vhall.app.view.video.VideoLayer;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.keyboard.KeyboardMapper;
	import com.vhall.framework.log.Logger;
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.manager.PopupManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.ui.Keyboard;

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
		
		public var debug:DebugLayer;
		
		public function Live(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*"); 
			new MenuController();
			new MessageController();
			super(parent, xpos, ypos);
			new ResponderMediator(this);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			
			var box:Sprite = this;
			videoLayer = new VideoLayer(box);
			barrageLayer = new BarrageLayer(box);
			effectLayer = new EffectLayer(box);
			popupLayer = new PopupLayer(box);
			controlLayer = new ControlLayer(box);
			LayerManager.initLayer(box);
			
			//发送初始化消息
			WebAJMessage.sendInitParam();
			Logger.getLogger().info("is_pres:"+Model.userInfo.is_pres);
			if(!Model.userInfo.is_pres){
				NResponder.dispatch(AppCMD.MEDIA_SWITCH_LINE);
			}
			
			debug = new DebugLayer();
			
			//注册调试信息 快捷键为ctrl+K
			var km:KeyboardMapper = new KeyboardMapper(StageManager.stage);
			km.mapListener(onTest, Keyboard.SHIFT, Keyboard.K);
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
			popupLayer && popupLayer.setSize(_width, _height);
			videoLayer && videoLayer.setSize(_width, _height);
			debug.setSize(_width, _height);
		}
		
		public function onTest():void{
//			Model.videoInfo.cdnServers = "";
//			Model.videoInfo.playItem = "";
//			NResponder.dispatch(AppCMD.UI_SHOW_LOGOLOADING);
			
			PopupManager.addPopup(debug);
		}
	}
}
