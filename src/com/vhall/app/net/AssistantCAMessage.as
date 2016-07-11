package com.vhall.app.net
{
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	import com.vhall.framework.log.Logger;

	/**
	 * 小助手发给as的消息 client to as
	 * @author Sol
	 * @date 2016-05-24 21:22:56
	 */
	public class AssistantCAMessage extends AbsMsgReceiver
	{
		override protected function collectionObservers():void
		{
			register(MessageType.CA_HELPER_LIVE, onHelperLive);
			register(MessageType.CA_HELPER_DIED, onHelperDied);
			register(MessageType.CA_PUBLISH_SUCCESS, onPublishSuccess);
			register(MessageType.CA_CLOSE_STREAM, onCloseStream);
			register(MessageType.CA_PUBLISH_FAILED, onPublishFailed);
			register(MessageType.CA_PUBLISH_STOPED, onPublishStoped);
		}

		/**	小助手还活着*/
		private function onHelperLive(data:Object):void
		{
			if(!Model.userInfo.is_pres)
			{
				return;
			}
			Logger.getLogger("CAMSG").info("小助手连着");
			Model.playerStatusInfo.assistantOpened = true;
			dispatch(AppCMD.SWITCH_TO_ASSISTANT);
		}

		/**	小助手挂了*/
		private function onHelperDied(data:Object):void
		{
			if(!Model.userInfo.is_pres)
			{
				return;
			}
			Logger.getLogger("CAMSG").info("小助手挂了");
			Model.playerStatusInfo.assistantOpened = false;

			if(Model.playerStatusInfo.quering)
			{
				Model.playerStatusInfo.quering = false;
				return;
			}
			// 隐藏图片
			dispatch(AppCMD.UI_HIDE_WARN);
			// 调取当前摄像头进行再次推送
			dispatch(AppCMD.PUBLISH_PUBLISH);
		}

		/**	告诉前台JS 发布流成功*/
		private function onPublishSuccess(data:Object):void
		{
			if(!Model.userInfo.is_pres)
			{
				return;
			}
			// 通知JS 发布流成功
			WebAJMessage.sendPublishSuccess();
		}

		/**	小助手发布流之前，会停了当前流*/
		private function onCloseStream(data:Object):void
		{
			if(!Model.userInfo.is_pres)
			{
				return;
			}

			//小助手推流之前，会停止当前流的发送
			dispatch(AppCMD.MEDIA_PLAYER_DISPOSE);
		}

		private function onPublishFailed(data:Object):void
		{
			if(!Model.userInfo.is_pres)
			{
				return;
			}
		}

		private function onPublishStoped(data:Object):void
		{
			if(!Model.userInfo.is_pres)
			{
				return;
			}
			// 隐藏图片
			dispatch(AppCMD.UI_HIDE_WARN);
			// 调取当前摄像头进行再次推送
			dispatch(AppCMD.PUBLISH_PUBLISH);
		}
	}
}


