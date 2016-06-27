package com.vhall.app.net
{
	import com.vhall.framework.app.net.WebBridge;

	public class LiveWebBridge extends WebBridge
	{
		public function LiveWebBridge()
		{
			super();
		}

		/**
		 * 只会在bufflength(这个比较特殊，就这个一个用，之后跟js协商解决)
		 * @param type 信息类型
		 * @param body 数据
		 *
		 */
		public function sendBufferMsgToJs(type:String, body:Object):void
		{
			super.sendMsg4Type("sendMsgToFlash", type, body);
		}

		/**
		 * 发送命令给js
		 * @param body 数据
		 *
		 */
		public function sendCMDMsg(body:Object):void
		{
			super.sendMsg("sendCmdMsg", body, true, true);
		}

		/**
		 * 将事件消息发起JS进行处理
		 * @param body 信息
		 *
		 */
		public function sendEventMsg(body:Object):void
		{
			super.sendMsg4Type("sendSocketMsg", "flashMsg", body, true)
		}
	}
}
