package com.vhall.app.net
{
	import com.vhall.framework.app.net.AbsMsgReceiver;

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

		private function onHelperLive(data:Object):void
		{

		}

		private function onHelperDied(data:Object):void
		{

		}

		private function onPublishSuccess(data:Object):void
		{

		}

		private function onCloseStream(data:Object):void
		{

		}

		private function onPublishFailed(data:Object):void
		{

		}

		private function onPublishStoped(data:Object):void
		{

		}
	}
}
