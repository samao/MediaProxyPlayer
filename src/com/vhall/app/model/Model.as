package com.vhall.app.model
{
	import com.adobe.serialization.json.JSON;
	import com.vhall.app.model.vo.DefinitionVo;
	import com.vhall.app.model.vo.ServeLinevo;
	import com.vhall.framework.utils.JsonUtil;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * 数据模型 
	 * @author Sol
	 * 
	 */	
	public class Model
	{
		private static var I:Model;
		
		/**	原始数据*/
		private var originParmeters:Object;
		/**	当前用户信息*/
		public var userinfo:UserInfo;
		
		/**	当前会议的信息*/
		public var meetinginfo:MeetingInfo;
		
		/**	当前流数据的信息*/
		public var videoinfo:VideoInfo;
		
		/*** 是否隐藏微吼的相关标识*/
		public var hide_powered:Boolean;
		
		/*** 是否隐藏线路选择器*/
		public var hideLineSwitch:Boolean;
		
		/*** 是否隐藏清晰度列表*/
		public var hideQualitySwitch:Boolean;
		
		/*** 是否隐藏弹幕开关按钮*/
		public var hideBarrage:Boolean;
		
		public var serverLineInfo:Array = [];
		
		public var definitionInfo:Array = [];
		
		private var _playItem:String;
		
		private var _cdnServers:String;
		/**
		 * 获取初始化的摄像头和麦克风等信息并上报给页面
		 */
		public var scanHardwareLock:Boolean;
		
		/*** 推流时传递给服务器的验证码*/
		public var streamToken:String;
		
		/*** 推起流的名称*/
		public var stream_name:String;
		
		/**	小助手是否处于打开状态*/
		public var assistantOpened:Boolean = false;

		/**
		 *清晰度数据 
		 */
		public function get playItem():String
		{
			return _playItem;
		}

		/**
		 * @private
		 */
		public function set playItem(value:String):void
		{
			_playItem = value;
			try
			{
//				var arr:Array = JsonUtil.decode(_cdnServers) as Array;
//				var item:Object = arr[0];
//				
//				var def:DefinitionVo = new DefinitionVo("default",item.default);
//				var middle:DefinitionVo = new DefinitionVo("middle",item.middle);
//				var low:DefinitionVo = new DefinitionVo("low",item.low);
//				definitionInfo[0] = def;
//				definitionInfo[1] = middle;
//				definitionInfo[2] = low;
			}
			catch(e:Error){}
			definitionInfo.push(new DefinitionVo("default", {"server":"rtmp://ccrtmplive02.t.vhall.com/vhall","file":"465936505_m"}));
			definitionInfo.push(new DefinitionVo("middle", {"server":"rtmp://ccrtmplive02.t.vhall.com/vhall","file":"465936505"}));
			definitionInfo.push(new DefinitionVo("low", {"server":"rtmp://ccrtmplive02.t.vhall.com/vhall","file":"465936505_l"}));
		}

		/**服务器选择器的数据源**/
		public function get cdnServers():String
		{
			return _cdnServers;
		}

		/**
		 * @private
		 */
		public function set cdnServers(value:String):void
		{
			_cdnServers = value;
			try
			{
				var arr:Array = JsonUtil.decode(_cdnServers) as Array;
				for (var i:int = 0; i < arr.length; i++)
				{
					var su:String = ""
					if(arr[i].hasOwnProperty("srv_audio")){
						su = arr[i].srv_audio;
					}
//					serverLineInfo.push(new ServeLinevo(arr[i].srv, arr[i].name,su));
				}
			}
			catch(e:Error){}
			serverLineInfo.push(new ServeLinevo("rtmp://cnrtmplive02.e.vhall.com/vhall", "线路1","rtmp://cnrtmplive02.e.vhall.com/vhall"));
			serverLineInfo.push(new ServeLinevo("rtmp://ccrtmplive02.e.vhall.com/vhall", "线路2","rtmp://ccrtmplive02.e.vhall.com/vhall"));
			serverLineInfo.push(new ServeLinevo("rtmp://rtmplive01.e.vhall.com/vhall", "线路3","rtmp://rtmplive01.e.vhall.com/vhall"));
			
		}

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
			return Me().userinfo;
		}
		
		public function Model()
		{
			if(I)
			{
				throw new Error("Model is singlton");
			}
			
			I = this;
		}
		
		public function init(data:Object):void
		{
			this.originParmeters = data;
			parseData(data,this);
		}
		
		// 递归解析数据
		private function parseData(data:Object, t:*):void
		{
			trace("parsing t:",t);
			var xml:XML = describeType(t);
			var child:XML;
			var varName:String = "";
			var typeName:String = "";
			
			var attrList:XMLList = xml..variable;
			// 公共属性
			for each(child in attrList)
			{
				varName = child["@name"].toString();
				typeName = child["@type"].toString();
				trace("t have property:",varName,"type is ",typeName,data[varName]);
				switch(typeName)
				{
					case "String":
						t[varName] = data[varName];
						break;
					case "Int":
						t[varName] = int(data[varName]);
						break;
					case "Boolean":
						t[varName] = data[varName] == "0"||!data.hasOwnProperty(varName) ? false : true;
						break;
					case "Array":
						break;
					default:
						trace("unrecognition type",typeName);
						var instanceName:String = typeName.toLowerCase().split("::")[1];
						if(t[instanceName] == null)
						{
							t[instanceName] = new (getDefinitionByName(typeName));
						}
						parseData(data,t[instanceName]);
						trace("parse unrecognition " + typeName +" over");
						break;
				}
			}
			
			var accList:XMLList = xml..accessor;
			var accessName:String;
			for each(child in accList)
			{
				accessName = child["@name"];
				if(child["@access"].toString().toLowerCase().indexOf("write") > -1)
				{
					t[accessName] = data[accessName];
				}
			}
		}
	}
}