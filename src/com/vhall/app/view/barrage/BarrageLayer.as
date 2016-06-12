package com.vhall.app.view.barrage
{
	import com.vhall.app.common.Layer;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.log.Logger;
	
	import flash.display.DisplayObjectContainer;

	public class BarrageLayer extends Layer implements IResponder
	{

		// 1开启，0关闭
		private var state:int = 1;
		
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
					if(state == 1)
					{
						con.addBarrage(args[0]);
					}
					break;
				case AppCMD.BARRAGE_CLOSE:
					Logger.getLogger("Barrage").info("关闭弹幕");
					state = 0;
					con.clear();
					break;
				case AppCMD.BARRAGE_OPEN:
					state = 1;
					Logger.getLogger("Barrage").info("开启弹幕");
					break;
			}
		}
	}
}
