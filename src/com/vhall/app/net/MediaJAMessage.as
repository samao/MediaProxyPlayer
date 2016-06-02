package com.vhall.app.net
{
	import com.vhall.app.actions.Actions_Report2JS;
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
				if(o.mediaServer != "flashvars.media_server")
				{
					//换推流服务器
					dispatch(AppCMD.QUITE_SERVER);
				}
			}
		}
		
		private function publishStart(value:*):void
		{
			//主播开始直播
			if(!Model.userInfo.is_pres)
			{
				dispatch(AppCMD.TELL_CORE_CAMERA_TO_VIDEO);
				dispatch(AppCMD.TELL_GUEST_TO_END_REPEAT);
				var o:Object = JsonUtil.decode(value);
				if(o["isVideoMode"])
				{
					if(int(o.isVideoMode))
					{
						//???
						dispatch("showAudioLivePic");
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