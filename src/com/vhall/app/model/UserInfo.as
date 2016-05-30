package com.vhall.app.model
{

	/**
	 * 用户信息
	 * @author Sol
	 *
	 */
	public class UserInfo extends BaseInfo
	{
		public static const HOST:String = "host";

		public static const GUEST:String = "guest";

		public static const ASSISTANT:String = "assistant";

		/**	当前角色*/
		public var role:String;
		
		public function UserInfo()
		{
			super();
		}
	}
}
