/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.vhall.com		
 * Created:	Jun 1, 2016 3:39:47 PM
 * ===================================
 */

package com.vhall.app.actions
{
	public class Action_Media
	{
		/** 页面回调的通知从播放摄像头视频转向播放服务器视频（观看端或者切嘉宾状态） **/
		public static const TELL_CORE_CAMERA_TO_VIDEO:String = "tellAsCameraToVideo";
		
		/** 通知已经被收回主讲权的嘉宾去终止上报 **/
		public static const TELL_GUEST_TO_END_REPEAT:String = "tellGuestToEndRepeat";
		
		/** 更改推流服务器*/
		public static const QUITE_SERVER:String = "quiteServer";
		
		/** 设置摄像头回显 **/
		public static const SET_KERNEL_CAMERA:String = "setKernelCamera";
	}
}