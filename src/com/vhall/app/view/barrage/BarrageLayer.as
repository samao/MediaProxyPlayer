package com.vhall.app.view.barrage
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.mvc.IResponder;

	import flash.display.DisplayObjectContainer;

	public class BarrageLayer extends Layer implements IResponder
	{

		private var con:BarrageContainer;

		public function BarrageLayer(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
			super(parent, xpos, ypos);
		}

		override protected function createChildren():void
		{
			super.createChildren();

			con = new BarrageContainer(this);
		}

		public function careList():Array
		{
			var arr:Array = [];
			arr.push(AppCMD.BARRAGE_ADD);
			arr.push(AppCMD.BARRAGE_CLOSE);
			arr.push(AppCMD.BARRAGE_OPEN);
			return arr;
		}

		public function handleCare(msg:String, ... args):void
		{
			switch(msg)
			{
				case AppCMD.BARRAGE_ADD:
					con.addBarrage(args[0]);
					break;
				case AppCMD.BARRAGE_CLOSE:
					con.clear();
					break;
				case AppCMD.BARRAGE_OPEN:
					break;
			}
		}
	}
}
