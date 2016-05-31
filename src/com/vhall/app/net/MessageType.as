package com.vhall.app.net
{
	public class MessageType
	{
		/**	socket 内部消息使用*/
		public static const CONNECT:String = "connect";
		public static const IOERROR:String =  "ioError";
		public static const CLOSE:String = "close";
		public static const SECURITY_ERROR:String = "securityError";
		public static const SOCKET_DATA:String = "socketData";
		
		public static const Init:String = "*init";
		
		public static const setDoc:String = "*setDoc";
		
		public static const Died:String = "*died";
		
		/************************************************ WEB AS2JS ***************************************/
		/**
		 *上报mic静音 
		 */		
		public static var AJ_MICMUTEVOLUME:String = "*micMuteVolume";
		/**
		 *上报mic安静 
		 */		
		public static var AJ_MICQUITEVOLUME:String = "*micQuiteVolume";
		
		/**
		 *上报mic噪音
		 */		
		public static var AJ_MICNOISEVOLUME:String = "*micNoiseVolume";
		
		/************************************************ WEB-AS2JS-END***************************************/
		
		/************************************************ WEB JS2AS ***************************************/
		/**
		 *弹幕消息 
		 */		
		public static var JA_BARRAGE_CHAT:String = "*chat";
		/**
		 *主持人退出，结束会议 
		 */		
		public static var JA_METTING_OVER:String = "*over";
		/**
		 *显示正在切换嘉宾
		 */		
		public static var JA_ACTIVEDPRES:String = "*activedpres";
		/**
		 *获取初始化参数
		 */		
		public static var JA_GET_INITPARAMS:String = "*getInitParams";
		
		/**
		 *设施是否正在演讲
		 */		
		public static var JA_SET_ISPRES:String = "*setIsPres";
		
		/**
		 *通知直播助手数据代码去打开直播助手 
		 */		
		public static var JA_OPENAST:String = "*openAst";
		/**
		 *声音设置 
		 */		
		public static var JA_VOLUME:String = "*volume";
		/**
		 *全屏交互 
		 */		
		public static var JA_FULLSCREEN:String = "*fullscreen";
		/************************************************ WEB-JS2AS-END***************************************/		
		

		/** 开始推流*/		
		public static const JA_PUBLISH:String = "*publish";
		/** 停止推流 */		
		public static const JA_UNPUBLISH:String = "*unpublish";
		/** 获取摄像头列表 */		
		public static const JA_GET_CAMERAS:String = "*getCameras";
		/** 拿到所有麦克风 */		
		public static const JA_GET_MICPHONES:String = "*getMicphones";
		
		/** 服务器不存在对应的流*/
		public static const AJ_STREAM_NOT_FOUND:String = "*StreamNotFound";
		/** 拉流服务器连接关闭*/
		public static const AJ_PULL_CONNECT_CLOSED:String = "*pullConnectClosed";
		/** 拉流服务器连接失败*/
		public static const AJ_PULL_CONNECT_FAIL:String = "*pullConnectFail";
		/** 推流服务器连接关闭*/
		public static const AJ_PUBLISH_CONNECT_CLOSED:String = "*publicConnectClosed";
		/** 推流服务器连接失败*/
		public static const AJ_PUBLISH_CONNECT_FAIL:String = "*publicConnectFail";
		/** 推流开始*/
		public static const AJ_PUBLISH_START:String = "*publishStart";
		
		/** 我猜这个是切换线路*/
		public static const AJ_QUITE_SERVER:String = "*quiteServer";
		/** 摄像头列表*/
		public static const AJ_CAMERA_LIST:String = "*cameraList";
		/** 麦克风列表*/
		public static const AJ_MICPHONE_LIST:String = "*micphoneList";
		/** 获取视频buffer*/
		public static const AJ_GET_BUFFERLENGTH:String = "*getBufferLength";
		/** 发送视频buffer*/		
		public static const AJ_SEND_BUFFER_LENGTH:String = "*sendBufferLength";
		
		
		//-----------------------------------------------------------------------
		//								小助手相关消息
		//-----------------------------------------------------------------------
		/**	启动小助手*/
		public static const AC_START_ENGINE:String = "startEngine";
		/**	停止小助手*/
		public static const AC_STOP_ENGINE:String = "stopEngine";
		/**	查询小助手状态*/
		public static const AC_QUERY_ENGINE:String = "queryEngine";
		
		public static const CA_CLOSE_STREAM:String = "closeStream";
		
		public static const CA_PUBLISH_SUCCESS:String = "publishSuccess";
		
		public static const CA_PUBLISH_FAILED:String = "publishFailed";
		
		public static const CA_PUBLISH_STOPED:String = "publishStoped";
		
		public static const CA_HELPER_LIVE:String = "helperLive";
		
		public static const CA_HELPER_DIED:String = "helperDied";
		
		
		
	}
}