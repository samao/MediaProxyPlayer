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
		/**
		 *是否正在演讲 
		 */		
		public var is_pres:Boolean;
		/**
		 *是否会议嘉宾 
		 */		
		public var is_guest:Boolean;
		/**	当前角色*/
		public var role:String;
		
		public function UserInfo()
		{
			super();
		}
	}
}
