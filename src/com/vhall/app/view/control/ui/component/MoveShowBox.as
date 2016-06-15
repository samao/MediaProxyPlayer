package com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.ui.container.Box;
	import com.vhall.framework.ui.controls.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *移动到组件上显示另一个组件
	 *@author zhaoqinghao
	 *@data 2016-6-14 下午4:12:46
	 */
	public class MoveShowBox extends Box
	{
		/**
		 *交互组件 
		 */		
		protected var acti:DisplayObject;
		/**
		 *移入后显示组件 
		 */		
		protected var component:UIComponent;
		
		private var _gap:int = 8;
		public function MoveShowBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		protected function onAdd(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			addLisn();
		}
		
		protected function onRemove(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			removeLisn()
		}
		
		protected function addLisn():void{
			acti.addEventListener(MouseEvent.ROLL_OVER,onOver);
		}
		
		protected function onOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.addEventListener(MouseEvent.ROLL_OUT,onOut);
			showComponent();
		}
		
		protected function onOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(MouseEvent.ROLL_OUT,onOut);
			hideComponent();
		}
		
		
		protected function removeLisn():void{
			acti.removeEventListener(MouseEvent.ROLL_OVER,onOver);
		}
		
		protected function onDrawbg():void{
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFF,0.001);
			this.graphics.drawRect(0,-component.height,this._width,component.height +  acti.height);
			this.graphics.endFill();
		}
		
		public function hideComponent():void{
			if(component && component.parent){
				component.visible = false;
			}
		}
		
		public function showComponent():void{
			if(component && !component.parent){
				this.addChild(component);
				component.move((this.acti.width - component.width) >> 1,acti.y - component.height - gap);
			}
			component.visible = true;
			onDrawbg();
		}
		
		
		public function get gap():int
		{
			return _gap;
		}
		
		public function set gap(value:int):void
		{
			_gap = value;
			showComponent();
		}
		
	}
}