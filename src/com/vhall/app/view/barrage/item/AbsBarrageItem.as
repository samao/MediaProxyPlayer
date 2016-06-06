package com.vhall.app.view.barrage.item
{
	import flash.display.Sprite;

	/**
	 * 抽象的弹幕实例
	 * @author Sol
	 *
	 */
	public class AbsBarrageItem extends Sprite implements IBarrage
	{
		public function AbsBarrageItem()
		{
			super();

			createChildren();
		}

		/**	弹幕类型*/
		public var type:int;

		private var _speed:int;

		private var _content:String;

		protected function createChildren():void
		{

		}

		public function set speed(value:int):void
		{
			this._speed = value;
		}

		public function get speed():int
		{
			return this._speed;
		}

		public function set content(value:String):void
		{
			this._content = value;
		}

		public function get content():String
		{
			return this._content;
		}
	}
}
