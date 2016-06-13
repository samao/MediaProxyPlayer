package com.vhall.app.common
{
	/**
	 *	资源路径 
	 * @author Sol
	 * 
	 */	
	public class Resource
	{
		public static var basePath:String = Version.App + "/";
		
		private static var tempUrl:String;
		
		public static function parsePath(url:String, update:Boolean = true):String
		{
			return update ? url + "?v=" + Version.ver : url;
		}
		
		public static function getLoadingResource(id:*):String
		{
			tempUrl = basePath + id + ".swf";
			return parsePath(tempUrl);
		}
		
		public static function getCode(id:*):String
		{
			tempUrl = id + ".swf";
			return parsePath(tempUrl);
		}
	}
}