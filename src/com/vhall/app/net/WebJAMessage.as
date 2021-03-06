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
			register(MessageType.JA_METTING_OVER, onMettingOver);
			register(MessageType.JA_ACTIVEDPRES, onActivedPres);
			register(MessageType.JA_BARRAGE_CHAT, onBarrage);
			register(MessageType.JA_BITRATE, onSetBitRate);
			register(MessageType.JA_FULLSCREEN, onFullScreen);
			register(MessageType.JA_GET_INITPARAMS, onGetInitParams);
			register(MessageType.JA_OPENAST, onOpenAST);
			register(MessageType.JA_SET_ISPRES, onSetPres);
		}

		private function onSetBitRate(data:Object = null):void
		{
			// TODO Auto Generated method stub
			Logger.getLogger("WebJAMsg").info("onSetBitRate Enter");
			dispatch(AppCMD.VIDEO_SET_BITRATE, data.param)
		}


		private function onSetPres(data:Object = null):void
		{
			Logger.getLogger("WebJAMsg").info("onSetPres Enter");
			Model.userInfo.is_pres = data.param;
			if(Model.userInfo.is_pres)
			{
				//发送切换 隐藏清晰度等组件
				dispatch(AppCMD.SWTICHTOYOU);
				dispatch(AppCMD.MEDIA_PLAYER_DISPOSE);
				dispatch(AppCMD.UI_HIDE_LOADING);
			}
			else
			{
				//发送切换 显示清晰度等组件
				dispatch(AppCMD.SWITCHINGPRES);
				//发送停止推流
				dispatch(AppCMD.MEDIA_PLAYER_DISPOSE);
				//发送关闭小助手
				AssistantACMessage.stopEngine();
				//停止上报mic
				dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
			}
			dispatch(AppCMD.UI_CHANGE_CONTROLBAR);
		}

		private function onOpenAST(data:Object = null):void
		{
			Logger.getLogger().info("收到打开小助手消息", Model.userInfo.is_pres);
			// 只有当前人为演讲人，才会执行以下逻辑
			if(Model.userInfo.is_pres)
			{
				dispatch(AppCMD.MEDIA_PLAYER_DISPOSE);
				//开启小助手消息
				AssistantACMessage.startEngine(Model.Me().meetinginfo.pid, Model.Me().userinfo.uname, Model.Me().videoinfo.streamname, Model.Me().videoinfo.streamtoken, Model.Me().playerstatusinfo.hide_powered,
					Model.Me().videoinfo.allPublishServers);
				//停止上报mic
				dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
				// UI显示 使用小助手直播
				dispatch(AppCMD.SWITCH_TO_ASSISTANT);
					// 销毁当前推送流
			}
		}

		private function onGetInitParams(data:Object = null):void
		{
			Logger.getLogger("WebJAMsg").info("onGetInitParams Enter");
			// TODO Auto Generated method stub
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
			// 如果关闭弹幕功能， 返回
			if(Model.playerStatusInfo.hideBarrage == true)
			{
				return;
			}
			//发送弹幕
			dispatch(AppCMD.BARRAGE_ADD, [data.data]);
		}

		private function onActivedPres(data:Object = null):void
		{
			Logger.getLogger("WebJAMsg").info("onActivedPres Enter");
			// TODO Auto Generated method stub
			if(!Model.userInfo.is_pres && !Model.userInfo.is_guest)
			{
				dispatch(AppCMD.SWITCHTOGUEST);
			}
		}

		/**
		 *会议结束
		 *
		 */
		private function onMettingOver(data:Object = null):void
		{
			Logger.getLogger("WebJAMsg").info("onMettingOver Enter");
			// TODO Auto Generated method stub
			Model.Me().meetinginfo.is_over = true;
			dispatch(AppCMD.SHOWWARN_OVER_PIC);
			dispatch(AppCMD.UI_HIDE_CONTROLBAR);
			//关闭推流或者拉流
			dispatch(AppCMD.MEDIA_PLAYER_DISPOSE);
			dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
		}
	}
}


