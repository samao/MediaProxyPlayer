/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.vhall.com		
 * Created:	Jun 2, 2016 5:18:59 PM
 * ===================================
 */

package com.vhall.app.model
{
	/**
	 * 视频相关信息
	 */	
	public class MediaModel
	{
		private static var _instance:MediaModel;
		
		public static function me():MediaModel
		{
			return _instance ||= new MediaModel();
		}
	}
}