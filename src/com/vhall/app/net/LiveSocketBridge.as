package com.vhall.app.net
{
	import com.vhall.framework.app.net.SocketBridge;
	
	public class LiveSocketBridge extends SocketBridge
	{
		public function LiveSocketBridge(ip:String="", port:int=0)
		{
			super(ip, port);
		}
	}
}