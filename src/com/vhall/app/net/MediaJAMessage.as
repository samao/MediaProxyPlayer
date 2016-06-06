package com.vhall.app.net
{
	import com.vhall.app.actions.Actions_Report2JS;
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	import com.vhall.framework.utils.JsonUtil;
	
	/**
	 *	js推给as的消息， 流媒体相关 
	 * @author Sol
	 * @date 2016-05-24 21:06:36
	 */	
	public class MediaJAMessage extends AbsMsgReceiver
	{
		override protected function collectionObservers():void
		{
			register(MessageType.JA_GET_BUFFER_LENGTH,bufferLengthReq);
			register(MessageType.JA_PUBLISH_START,publishStart);
			register(MessageType.JA_PUBLISH,publish);
		}
		
		private function publish(value:*):void
		{
			var o:* = JsonUtil.decode(value);
			if(o.mediaServer)
			{
				if(o.mediaServer != MediaModel.me().netOrFileUrl)
				{
					//换推流服务器
					MediaModel.me().netOrFileUrl = o.mediaServer;
					dispatch(AppCMD.MEDIA_QUITE_SERVER);
				}
			}
			dispatch(AppCMD.PUBLISH_START);
		}
		
		/**
		 * 关开用户收到开始推流消息
		 * @param value
		 */		
		private function publishStart(value:*):void
		{
			//主播开始直播
			if(!Model.userInfo.is_pres)
			{
				dispatch(AppCMD.TELL_CORE_CAMERA_TO_VIDEO);
				dispatch(AppCMD.TELL_GUEST_TO_END_REPEAT);
				
				var o:Object = JsonUtil.decode(value);
				if(o.hasOwnProperty("isVideoMode"))
				{
					MediaModel.me().videoMode = o.isVideoMode;
					if(!o.isVideoMode)
					{
						dispatch(AppCMD.SHOW_AUDIOLIVE_PIC);
					}
				}
				
			}
		}
		
		private function bufferLengthReq():void
		{
			dispatch(Actions_Report2JS.BUFFER_LENGTH);
		}
	}
}