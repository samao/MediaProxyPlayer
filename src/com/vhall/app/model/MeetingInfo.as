package com.vhall.app.model
{
	public class MeetingInfo extends BaseInfo
	{
		public function MeetingInfo()
		{
			super();
		}
		
		/**	是否结束会议 */
		public var is_over:Boolean;
		/*** 会议代码*/
		public var pid:String;
	}
}