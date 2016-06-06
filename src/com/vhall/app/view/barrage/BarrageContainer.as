package com.vhall.app.view.barrage
{
	import com.vhall.app.view.barrage.item.AbsBarrageItem;
	import com.vhall.app.view.barrage.item.BarrageFactory;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.ui.container.Box;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * 弹幕容器
	 * @author Sol
	 *
	 */
	public class BarrageContainer extends Box
	{
		public function BarrageContainer(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}
		/**	弹幕显示区域*/
		public var rect:Rectangle;

		public var running:Boolean = false;

		/**
		 * 添加弹幕
		 * @param content 内容，具体解析再各自继承AbsBarrage内进行解析
		 * @param type 默认类型为1，简单文本，后续如果添加新类型的弹幕 添加不同type类内容即可，自己再继承AbsBarrage实现一个新的类型弹幕
		 *
		 */
		public function addBarrage(content:String, type:int = 1):void
		{
			var item:AbsBarrageItem = BarrageFactory.retrieveItem(type);
			item.content = content;
			item.x = StageManager.stageWidth;
			item.y = Math.random() * StageManager.stageHeight * 0.8;
			item.speed = Math.random() * 5 + 8;
			addChild(item);

			if(running == false)
			{
				addEventListener(Event.ENTER_FRAME, onEnterMoveHandler);
				running = true;
			}
		}

		/**
		 * 清空
		 *
		 */
		public function clear():void
		{
			while(numChildren)
			{
				var item:AbsBarrageItem = removeChildAt(0) as AbsBarrageItem;
				BarrageFactory.restoreItem(item);
			}

			pause();
		}

		/**
		 * 暂停 
		 * 
		 */		
		public function pause():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterMoveHandler);
			running = false;
		}

		/**
		 * 恢复 
		 * 
		 */		
		public function resume():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterMoveHandler);
			running = true;
		}

		protected function onEnterMoveHandler(e:Event):void
		{
			//移动
			for each(var item:AbsBarrageItem in children)
			{
				//移动
				item.x -= item.speed;
				//边界检测
				if(item.x < -item.width)
				{
					BarrageFactory.restoreItem(item);
					removeChild(item)
				}
			}
		}
	}
}
