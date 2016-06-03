package com.vhall.app.view.barrage.item
{

	internal interface IBarrage
	{
		/** 设置速度*/
		function set speed(value:int):void;
		/**	获取速度*/
		function get speed():int;
		/**	设置内容*/
		function set content(value:String):void;
		/**	获取内容*/
		function get content():String;
	}
}
