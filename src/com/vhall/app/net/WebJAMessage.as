package com.vhall.app.net
{
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.manager.StageManager;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	import com.vhall.framework.log.Logger;
	
	import flash.display.StageDisplayState;
	
	/**
	 * web端传过来的js消息 js to as 
	 * @author Sol
	 * @date 2016-05-24 21:19:42
	 */	
	public class WebJAMessage extends AbsMsgReceiver
	{
		override protected function collectionObservers():void
		{
			register(MessageType.JA_METTING_OVER,onMettingOver);
			register(MessageType.JA_ACTIVEDPRES,onActivedPres);
			register(MessageType.JA_BARRAGE_CHAT,onBarrage);
			register(MessageType.JA_BITRATE,onSetBitRate);
			register(MessageType.JA_FULLSCREEN,onFullScreen);
			register(MessageType.JA_GET_INITPARAMS,onGetInitParams);
			register(MessageType.JA_OPENAST,onOpenAST);
			register(MessageType.JA_SET_ISPRES,onSetPres);
		}
		
		private function onSetBitRate(data:Object = null):void
		{
			// TODO Auto Generated method stub
			Logger.getLogger("WebJAMsg").info("onSetBitRate Enter");
			dispatch(AppCMD.VIDEO_SET_BITRATE,data.param)
		}		
		
		
		private function onSetPres(data:Object = null):void
		{
			// TODO Auto Generated method stub
			Logger.getLogger("WebJAMsg").info("onSetPres Enter");
			Model.userInfo.is_pres = data.param;
			if(Model.userInfo.is_pres){
				//发送切换 隐藏清晰度等组件
				dispatch(AppCMD.SWITCHINGPRES);
			}else{
				//发送切换 显示清晰度等组件
				dispatch(AppCMD.SWITCHTOGUEST);
				//发送停止推流
				//发送关闭小助手
				AssistantACMessage.stopEngine();
				//停止上报mic
				dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
			}
		}
		
		private function onOpenAST(data:Object = null):void
		{
			// 只有当前人为演讲人，才会执行以下逻辑
			if(Model.userInfo.is_pres)
			{
				var self:Model = Model.Me();
				//开启小助手消息
				AssistantACMessage.startEngine(self.meetingInfo.pid,self.userInfo.uname,self.stream_name,self.streamToken,self.hide_powered,self.cdnServers);
				//停止上报mic
				dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
				// UI显示 使用小助手直播
				dispatch(AppCMD.SWITCH_TO_ASSISTANT);
			}
		}
		
		private function onGetInitParams(data:Object = null):void
		{
			Logger.getLogger("WebJAMsg").info("onGetInitParams Enter");
			// TODO Auto Generated method stub
			//发送初始化信息
			//摄像头
			//mic
			//以及从Share中读取的信息
			
			WebAJMessage.sendInitParam();
		}
		
		private function onFullScreen(data:Object = null):void
		{
			if(Boolean(data.param))
			{
				StageManager.stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else
			{
				StageManager.stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function onBarrage(data:Object = null):void
		{
			// TODO Auto Generated method stub
			//发送弹幕
			dispatch(AppCMD.ADD_BARRAGE,data.data);
		}
		
		private function onActivedPres(data:Object = null):void
		{
			Logger.getLogger("WebJAMsg").info("onActivedPres Enter");
			// TODO Auto Generated method stub
			if(!Model.userInfo.is_pres){
				if(!Model.userInfo.is_guest){
					dispatch(AppCMD.SWITCHINGPRES);
				}
			}
		}
		/**
		 *会议结束 
		 * 
		 */		
		private function onMettingOver():void
		{
			Logger.getLogger("WebJAMsg").info("onMettingOver Enter");
			// TODO Auto Generated method stub
			Model.Me().meetingInfo.is_over = true;
			dispatch(AppCMD.SHOWWARN_OVER_PIC);
			dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
		}
	}
}