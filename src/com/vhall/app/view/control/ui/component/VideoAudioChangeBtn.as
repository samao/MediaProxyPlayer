package com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.controls.Button;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *
	 *@author zhaoqinghao
	 *@data 2016-6-7 上午10:20:16
	 */
	public class VideoAudioChangeBtn extends Box
	{
		protected var btn:Button;
		public var isVideo:Boolean = true;
		public function VideoAudioChangeBtn(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			btn = new Button(this);
			btn.setSize(70,20);
			btn.addEventListener(MouseEvent.CLICK,onClick);
			updateStatusByMode();
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			isVideo = !isVideo;
			updateStatusByMode();
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function updateStatusByMode():void{
			if(isVideo){
				btn.label = "语音模式";
			}else{
				btn.label = "视频模式";
			}
		}
		
		/**
		 *设置该组件是否可用 
		 * @param value
		 * 
		 */		
		public function set enable(value:Boolean):void{
			this.btn.mouseEnabled = value;
		}
		
		
	}
}