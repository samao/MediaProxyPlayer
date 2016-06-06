package com.vhall.app.view.barrage.item
{
	import com.vhall.framework.app.net.AbsBridge;

	/**
	 *
	 * @author Sol
	 *
	 */
	public class BarrageFactory
	{
		public function BarrageFactory()
		{

		}

		private static var normalList:Array = [];

		public static function retrieveItem(type:int):AbsBarrageItem
		{
			var item:AbsBarrageItem;
			switch(type)
			{
				case 1:
					item = normalList.length > 0 ? normalList.pop() : new SimpleBarrageItem();
					break;
				default:
					item = normalList.length > 0 ? normalList.pop() : new SimpleBarrageItem();
					break;
			}

			return item;
		}

		public static function restoreItem(item:AbsBarrageItem):void
		{
			switch(item.type)
			{
				case 1:
					normalList.push(item);
					break;
				default:
					normalList.push(item);
					break;
			}
		}
	}
}
