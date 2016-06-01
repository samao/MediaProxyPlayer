package com.vhall.app.model
{
	public class MeetingInfo extends BaseInfo
	{
		public function MeetingInfo()
		{
			super();
		}
		private var _is_over:Boolean;
		private var _pid:String;

		/*** 会议代码*/
		public function get pid():String
		{
			return _pid;
		}

		/**
		 * @private
		 */
		public function set pid(value:String):void
		{
			_pid = value;
		}

		/**
		 *是否结束会议 
		 */
		public function get is_over():Boolean
		{
			return _is_over;
		}

		/**
		 * @private
		 */
		public function set is_over(value:Boolean):void
		{
			_is_over = value;
		}

	}
}