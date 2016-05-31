package com.vhall.app.model
{
	/**
	 * 数据模型 
	 * @author Sol
	 * 
	 */	
	public class Model
	{
		private static var I:Model;
		
		/**	当前用户信息*/
		public var userInfo:UserInfo;
		
		/**	当前会议的信息*/
		public var meetingInfo:MeetingInfo;
		
		/**	当前流数据的信息*/
		public var streamInfo:StreamInfo;
		
		/*** 是否隐藏微吼的相关标识*/
		public var hide_powered:Boolean;
		
		/*** 是否隐藏线路选择器*/
		public var hideLineSwitch:Boolean;
		
		/*** 是否隐藏清晰度列表*/
		public var hideQualitySwitch:Boolean;
		
		/*** 是否隐藏弹幕开关按钮*/
		public var hideBarrage:Boolean;
		
		/**服务器选择器的数据源**/
		public var cdnServers:String;
		
		public static function Me():Model
		{
			if(!I)
			{
				I = new Model();
			}
			return I;
		}
		
		/**
		 *用户信息 
		 * @return 
		 * 
		 */		
		public static function get userInfo():UserInfo{
			return Me().userInfo;
		}
		
		public function Model()
		{
			if(I)
			{
				throw new Error("Model is singlton");
			}
			
			I = this;
		}
	}
}