package
{
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	import com.vhall.framework.ui.controls.UIComponent;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 主类 
	 * @author Sol
	 * @date 2016-05-24 21:25:26
	 */	
	public class Main extends UIComponent implements IResponder
	{
		public function Main(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			new ResponderMediator(this);
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
	}
}