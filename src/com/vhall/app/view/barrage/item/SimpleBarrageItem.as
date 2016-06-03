package com.vhall.app.view.barrage.item
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * 简单的弹幕对象
	 * @author Sol
	 *
	 */
	public class SimpleBarrageItem extends AbsBarrageItem
	{

		private var tf:TextField;
		private var fmt:TextFormat;

		public function SimpleBarrageItem()
		{
			super();
			type = 1;
		}

		override protected function createChildren():void
		{
			super.createChildren();

			tf = new TextField();
			tf.defaultTextFormat = new TextFormat("SimSun", 18, null, true);
			tf.textColor = 0xFFFFFF;
			tf.selectable = false;
			tf.autoSize = "left";
			fmt = tf.defaultTextFormat;
			addChild(tf);
		}

		override public function set content(value:String):void
		{
			tf.text = value;
			tf.width = tf.textWidth + 4 + fmt.indent;
			tf.height = Math.max(tf.textHeight + 4, 20);
		}
	}
}
