package com.vhall.app.model.info
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
		
		/**是否正在演讲*/		
		public var is_pres:Boolean;
		
		/** 是否会议嘉宾*/		
		public var is_guest:Boolean;
		
		/**	是否是房间的主人*/
		public var is_host:Boolean;
		
		/**	用户ID*/
		public var uid:String;
		
		/** 参会者名字**/
		public var uname:String = "undefined";
		
		/**	当前角色*/
		public var role:String;
		
		public function UserInfo()
		{
			super();
		}
	}
}
