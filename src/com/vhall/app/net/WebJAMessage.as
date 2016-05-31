package com.vhall.app.net
{
	import com.vhall.app.actions.Actions_Report2JS;
	import com.vhall.app.actions.Actions_UI;
	import com.vhall.app.model.Model;
	import com.vhall.framework.app.net.AbsMsgReceiver;
	
	import appkit.responders.NResponder;
	
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
			register(MessageType.JA_FULLSCREEN,onFullScreen);
			register(MessageType.JA_GET_INITPARAMS,onGetInitParams);
			register(MessageType.JA_OPENAST,onOpenAST);
			register(MessageType.JA_SET_ISPRES,onSetPres);
		}
		
		private function onSetPres():void
		{
			// TODO Auto Generated method stub
		}
		
		private function onOpenAST():void
		{
			// TODO Auto Generated method stub
		}
		
		private function onGetInitParams():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function onFullScreen():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function onBarrage():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function onActivedPres():void
		{
			// TODO Auto Generated method stub
			
		}
		/**
		 *会议结束 
		 * 
		 */		
		private function onMettingOver():void
		{
			// TODO Auto Generated method stub
			Model.Me().meetingInfo.is_over = true;
			NResponder.dispatch(Actions_UI.SHOW_OVER_PIC);
			NResponder.dispatch(Actions_Report2JS.JS_TELL_TO_CLOSEREPEAT);
		}
	}
}