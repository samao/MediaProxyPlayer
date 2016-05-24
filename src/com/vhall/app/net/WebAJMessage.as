package com.vhall.app.net
{
	import com.vhall.framework.app.net.AbsBridge;
	import com.vhall.framework.app.net.MessageManager;

	public class WebAJMessage
	{
		private static var sender:AbsBridge = MessageManager.getInstance().getBridge()
	}
}