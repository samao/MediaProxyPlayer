package com.vhall.app.report
{
	import com.vhall.app.actions.Actions_Report2JS;
	import com.vhall.app.model.Model;
	import com.vhall.app.net.WebAJMessage;
	import com.vhall.framework.app.mvc.IResponder;
	import com.vhall.framework.app.mvc.ResponderMediator;
	
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.utils.Timer;

	public class ReportToWeb implements IResponder
	{
		public var timer:Timer;
		private var repeatCount:Number = 0;
		private var muteBool:Boolean;
		private var quiteBool:Boolean;
		private var noiseBool:Boolean;
		public function ReportToWeb()
		{
			new ResponderMediator(this);
		}
		
		public function careList():Array
		{
			// TODO Auto Generated method stub
			return [
				Actions_Report2JS.JS_CLOS_VOLUME_REEPEAT,
				Actions_Report2JS.START_MIC_REPEAT,
				Actions_Report2JS.STOP_MIC_REPEAT
			];
		}
		
		public function handleCare(msg:String, ...parameters):void
		{
			// TODO Auto Generated method stub
			switch(msg)
			{
				case Actions_Report2JS.JS_CLOS_VOLUME_REEPEAT:
				{
					closeMicVolumeRepeat();
					break;
				}
				case Actions_Report2JS.START_MIC_REPEAT:
				{
					if(Model.Me().userInfo.is_pres){
						startMicVolumeRepeat();
					}
					break;
				}
				case Actions_Report2JS.STOP_MIC_REPEAT:
				{
					closeMicVolumeRepeat();
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		/**
		 *开始 上报循环检测
		 * 
		 */		
		public function startMicVolumeRepeat():void
		{
			if(!Model.Me().userInfo.is_pres)
			{
				//ExternalInterface.call("console.log", "开启麦克风声音上报被拦截！原因（非主讲人）！");
				return;
			}
			
			if(Model.Me().meetingInfo.is_over)
			{
				//ExternalInterface.call("console.log", "开启麦克风声音上报被拦截！原因（flashvars.is_over为 true）！");
				return;
			}
			
			if(timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,volumeRepeat);
				timer = null;
			}
			
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,volumeRepeat)
			
			timer.start();
			
			//ExternalInterface.call("console.log", "开启麦克风声音上报！");
		}
		
		
		/**麦克风正在检测的音量。值的范围为 0（未检测到声音）到 100（检测到非常大的声音）。此属性的值有助于确定向 Microphone.setSilenceLevel() 方法传递的适当值。如果麦克风可用，但却因为尚未调用 Microphone.getMicrophone() 而未被使用，则此属性设置为 -1。**/
		private function volumeRepeat(event:TimerEvent):void
		{
			var mic:Microphone;
			if (mic == null)
			{
				//ExternalInterface.call("console.log", "开启麦克风声音上报被拦截！原因（model.microPhone为 空）！");
				return;
			}
			
			if (mic.muted)
			{
				//ExternalInterface.call("console.log", "开启麦克风声音上报被拦截！原因（model.microPhone.muted为 true）！");
				return;
			}
			
			this.repeatCount++;
			var micVolume:Number;
			
			if(mic)
			{
				micVolume = mic.activityLevel / 100;
				
				//ExternalInterface.call("console.log", "摄像头捕获的麦克风声音值持续秒数：(" + repeatCount + ")");
				//				trace("摄像头捕获的麦克风声音值持续秒数：(" + repeatCount + ")");
				//ExternalInterface.call("console.log", "摄像头捕获的麦克风声音值：(" + micVolume + ")");
				//				trace("摄像头捕获的麦克风声音值：(" + micVolume + ")");
				//ExternalInterface.call("console.log", "摄像头捕获的麦克风增益值：(" + model.microPhone.gain + ")");
				//				trace("摄像头捕获的麦克风增益值：(" + model.microPhone.gain + ")");
				
				if(micVolume <= 0)
				{
					if(quiteBool||noiseBool)
					{
						quiteBool = false;
						noiseBool = false;
						this.repeatCount = 0;
					}
					
					muteBool = true;
				}
				else if(micVolume > 0 && micVolume <= 0.2)
				{
					if(muteBool||noiseBool)
					{
						muteBool = false;
						noiseBool = false;
						this.repeatCount = 0;
					}
					quiteBool = true;
				}
				else if(micVolume > 0.2 && micVolume < 1)
				{
					if(muteBool||noiseBool||quiteBool)
					{
						muteBool = false;
						noiseBool = false;
						quiteBool = false;
					}
					this.repeatCount = 0;
				}
				else if(micVolume >= 1)
				{
					if(quiteBool||muteBool)
					{
						quiteBool = false;
						muteBool = false;
						this.repeatCount = 0;
					}
					noiseBool = true;
				}
			}
			
			if(this.repeatCount >=5)
			{
				if((!quiteBool)&&(!noiseBool)&&muteBool)
				{
					var obj:Object = new Object();
					obj.type = "*micMuteVolume";
					WebAJMessage.sendReportMicMuteVolume();
					trace("摄像头捕获的麦克风声音：= 静音");
					//ExternalInterface.call("console.log", "摄像头捕获的麦克风声音状态：(静音)");
				}
				
				if((!muteBool)&&(!noiseBool)&&quiteBool)
				{
					var obj2:Object = new Object();
					obj2.type = "*micQuiteVolume";
					WebAJMessage.sendReportMicQuiteVolume();
					trace("摄像头捕获的麦克风声音：= 安静");
					//ExternalInterface.call("console.log", "摄像头捕获的麦克风声音状态：(安静)");
				}
				
				if((!quiteBool)&&(!muteBool)&&noiseBool)
				{
					var obj3:Object = new Object();
					obj3.type = "*micNoiseVolume";
					WebAJMessage.sendReportMicNoiseVolume();
					trace("摄像头捕获的麦克风声音：= 噪音");
					//ExternalInterface.call("console.log", "摄像头捕获的麦克风声音状态：(噪音)");
				}
				
				this.repeatCount = 0;
			}
		}
		/**
		 *关闭上报检测 
		 * 
		 */		
		public function closeMicVolumeRepeat():void
		{
			if(timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,volumeRepeat)
				timer = null;
			}
			
			this.repeatCount = 0;
			//ExternalInterface.call("console.log", "关闭麦克风声音上报！");
		}
		
		
		
		
	}
}