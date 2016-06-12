package com.vhall.app.net
{
	import com.vhall.app.model.MediaModel;
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.manager.SOManager;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	import com.vhall.framework.utils.JsonUtil;
	
	import flash.media.Camera;
	import flash.media.Microphone;
	
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
			register(MessageType.JA_UNPUBLISH,unpublish);
		}
		
		private function unpublish():void
		{
			dispatch(AppCMD.PUBLISH_END);
			/** 通知直播助手数据代码去关闭直播助手 **/
			//dispatch(AppCMD.AST_COMMAND, {"command": AstStatus.CLOSE_AST});
			/** js通知关闭检测麦克风上报**/
			dispatch(AppCMD.REPORT_JS_CLOS_VOLUME_REEPEAT);
		}
		
		private function publish(value:*):void
		{
			if(MediaModel.me().player.isPlaying)
			{
				dispatch(AppCMD.SHOW_SWITCH_GUEST_BUFFER);
				dispatch(AppCMD.CLEAR_PROVIDER_ABOUT);
			}
			
			if(Model.Me().userinfo.is_guest || Model.Me().userinfo.is_pres)
			{
				dispatch(AppCMD.TELL_GUEST_TURN_TO_PRES);
			}
			
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
			
			//保存设置数据
			var obj:Object = SOManager.getInstance().getValue("setting");
			obj.cameraName = Camera.isSupported && Camera.names.indexOf(o.camName)!=-1 ? o.camName : "禁用视频设备/无设备";
			obj.micName = Microphone.isSupported && Microphone.names.indexOf(o.micName)!=-1?o.micName:"禁用视频设备/无设备";
			obj.micVolume =  MediaModel.me().player.volume ;//model.microPhone.gain;
			obj.width = o.width;
			obj.height = o.height;
			obj.definition = MediaModel.me().defaultDefination;
			obj.serverLine = MediaModel.me().netOrFileUrl;//model.defaultServerLine;
			//Logger.getLogger().info("save SO name:",obj.cameraName,",micName:",obj.micName,",micVolumn:",obj.micVolumn,",witdth:",obj.width,",height:",obj.height,",definition:",obj.definition,",serverLine:",obj.serverLine);
			SOManager.getInstance().setValue("setting", obj);
			
			dispatch(AppCMD.PUBLISH_START);
			
			dispatch(AppCMD.REPORT_START_MIC_REPEAT);
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
				
				if(value.hasOwnProperty("isVideoMode"))
				{
					MediaModel.me().videoMode = value.isVideoMode;
					if(!value.isVideoMode)
					{
						dispatch(AppCMD.SHOW_AUDIOLIVE_PIC);
					}
				}
				dispatch(AppCMD.PUBLISH_START);
			}
		}
		
		private function bufferLengthReq():void
		{
			dispatch(AppCMD.REPROT_BUFFER_LENGTH);
		}
	}
}