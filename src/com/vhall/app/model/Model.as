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
		/***播放器状态信息 */		
		public var statusinfo:PlayerStatusInfo
		
		/*** 是否隐藏微吼的相关标识*/
		public var hide_powered:Boolean;
		
		/*** 是否隐藏线路选择器*/
		public var hideLineSwitch:Boolean;
		
		/*** 是否隐藏清晰度列表*/
		public var hideQualitySwitch:Boolean;
		
		/*** 是否隐藏弹幕开关按钮*/
		public var hideBarrage:Boolean;
		/**
		 *是否显示线路（cdn线路切换） 
		 */		
		public var lineType:int = 1;
		/**
		 *是否显示音频切换 
		 */		
		public var streamType:int = 1;
		/**
		 *观看段视频模式（语音模式为false） 
		 */		
		public var viewVideoMode:Boolean = true;
		
		/**
		 *当前播放模式（RTMP/HLS） 
		 */		
		public var playMode:String = PlayMode.PLAY_RTMP;
		
		/**
		 * 获取初始化的摄像头和麦克风等信息并上报给页面
		 */
		public var scanHardwareLock:Boolean;
		
		/*** 推流时传递给服务器的验证码*/
		public var streamToken:String;
		/**	小助手是否处于打开状态*/
		public var assistantOpened:Boolean = false;


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
		/**
		 *视频信息 
		 * @return 
		 * 
		 */		
		public static function get videoInfo():VideoInfo{
			return Me().videoinfo;
		}
		
		/**
		 *状态信息 
		 * @return 
		 * 
		 */		
		public static function get statusInfo():PlayerStatusInfo{
			return Me().statusinfo;
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
						if(t.hasOwnProperty(instanceName)){
							if(t[instanceName] == null)
							{
								t[instanceName] = new (getDefinitionByName(typeName));
							}
							parseData(data,t[instanceName]);
							trace("parse unrecognition " + typeName +" over");
						}
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