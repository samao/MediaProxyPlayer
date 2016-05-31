package com.vhall.app.net
{
	public class MessageType
	{
		/**	socket 内部消息使用*/
		public static const CONNECT:String = "connect";
		public static const IOERROR:String =  "ioError";
		public static const CLOSE:String = "close";
		public static const SECURITY_ERROR:String = "securityError";
		
		public static const Init:String = "*init";
		
		public static const setDoc:String = "*setDoc";
		
		public static const Died:String = "*died";
		
		
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
	}
}