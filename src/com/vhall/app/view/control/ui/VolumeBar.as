package com.vhall.app.view.control.ui
{
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.net.AppCMD;
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.controls.Button;
	import com.vhall.framework.ui.event.DragEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import appkit.responders.NResponder;
	
	public class VolumeBar extends Box
	{
		public var volumeBtn:Button;
		public var volumeSlipComp:VolumeDragBar;
		public function VolumeBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			volumeSlipComp = new VolumeDragBar();
			volumeSlipComp.addEventListener(DragEvent.CHANGE,volumeChange);
			this.addChild(volumeSlipComp);
		}
		
		private function volumeChange(e:DragEvent):void
		{
			MediaModel.me().volume = e.percent;
			NResponder.dispatch(AppCMD.MEDIA_SET_VOLUME,[e.percent]);
		}
		
		public function set volumeValue(value:int){
			volumeSlipComp.percent = value/100;
		}
		/**
		 * 声音大小
		 * @return 
		 * 
		 */		
		public function get volumeValue():int{
			return (volumeSlipComp.percent* 100);
		}
		
	}
}