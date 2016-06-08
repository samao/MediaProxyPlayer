/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.vhall.com		
 * Created:	Jun 8, 2016 2:11:33 PM
 * ===================================
 */

package com.vhall.app.view.video
{
	import com.vhall.framework.ui.controls.UIComponent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	public class AudioModelPicComp extends UIComponent
	{
		private var isTimeRun:Boolean = false;
		private var byte:ByteArray = new ByteArray();
		
		public var _skin:MovieClip;
		
		public function AudioModelPicComp()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
		}
		
		protected function onAddedToStage(event:Event=null):void
		{
			// TODO Auto Generated method stub
			isTimeRun = true;
			runTime();
			stage.addEventListener(Event.RESIZE,resize);
			resizeHandler();
		}
		
		protected function resizeHandler(e:Event = null):void
		{
			stage && resize(stage.stageWidth,stage.stageHeight);
		}
		
		public function set skin(value:MovieClip):void
		{
			_skin = value.getChildAt(0) as MovieClip;
			this.addChild(_skin);
		}
		
		protected function onRemovedFromStage(event:Event=null):void
		{
			// TODO Auto Generated method stub
			isTimeRun = false;
			stage.removeEventListener(Event.RESIZE,resize);
		}
		
		private function runTime():void{
			if(isTimeRun){
				setTimeout(updateVoic,200);
				isTimeRun = true;
			}
		}
		
		public function resize(swidth:int,shight:int):void{
			var mc:MovieClip = _skin["pic"];
			var vocmc:MovieClip = _skin["voc"]
			if(swidth < 640 || shight < 480){
				var sx:Number = swidth/640;
				var sy:Number = shight/480;
				var ss:Number = Math.min(sx,sy);
				mc.scaleX = mc.scaleY = ss*0.7;
				vocmc.scaleX = vocmc.scaleY = ss* 0.8;
			}else{
				mc.scaleX = mc.scaleY = 1;
				vocmc.scaleX = vocmc.scaleY =  1;
			}
			mc.x = (320 - mc.width)/2;
			mc.y = (240 - mc.height)/2;
			
			vocmc.x =  (320 - vocmc.scaleX*400)/2;
			vocmc.y = (240 - vocmc.scaleY*400)/2;
			try{
				_skin["txt"].y = mc.y + mc.height+5;
			}catch(e:Error){};
			_skin.x = swidth - _skin.width >> 1;
			_skin.y = shight - _skin.height >> 1;
		}
		
		/**
		 *更新音量 
		 * 
		 */		
		public function updateVoic():void{
			runTime();
			var vocmc:MovieClip = _skin.getChildByName("voc") as MovieClip;
			var micVolume:int = activity;
			if(micVolume <=0){
				vocmc.gotoAndStop(0);
			}else if(micVolume > 0 && micVolume <= 30){
				vocmc.gotoAndStop(1);
			}else if(micVolume > 30 && micVolume <= 60){
				vocmc.gotoAndStop(2);
			}else if(micVolume > 60){
				vocmc.gotoAndStop(3);
			}
		}
		
		private function get activity():Number
		{
			var left:Number = 0;
			var right:Number = 0;
			const PLOT_HEIGHT:int = 200; 
			const CHANNEL_LENGTH:int = 256; 
			
			try
			{
				SoundMixer.computeSpectrum(byte, false, 0); 
				//left;
				for (var i:int = 0; i < CHANNEL_LENGTH; i++) 
				{
					left += (byte.readFloat() * PLOT_HEIGHT);
				}
				
				for (i=0; i < CHANNEL_LENGTH; i++) 
				{
					right += (byte.readFloat() * PLOT_HEIGHT);
				}
			} 
			catch(error:Error) 
			{
				
			}
			return (Math.abs(left) + Math.abs(right));
		}
	}	
}