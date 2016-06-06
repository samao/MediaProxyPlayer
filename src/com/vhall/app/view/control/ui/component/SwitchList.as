package com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.ui.controls.ItemRender;
	import com.vhall.framework.ui.controls.List;
	
	import flash.accessibility.Accessibility;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 普通的list组件 
	 * @author zqh
	 * 
	 */	
	public class SwitchList extends List
	{
		protected var itemSize:Array = [];
		private var _currentItem:SwitchItemRender;
		public function SwitchList(direction:String="vertical", parent:DisplayObjectContainer=null, gap:Number=2, xpos:Number=0, ypos:Number=0)
		{
			super(direction, parent, gap, xpos, ypos);
		}
		
		override protected function invalidate():void
		{
			// TODO Auto Generated method stub
				super.invalidate();
				if(con.numChildren > 0){
					_currentItem = con.getChildAt(0) as SwitchItemRender;
					selectIndex = 0;
				}
		}
		
		
		/**
		 *当前选中 
		 */
		public function get currentItem():SwitchItemRender
		{
			return _currentItem;
		}

		/**
		 * @private
		 */
		public function set currentItem(value:SwitchItemRender):void
		{
			_currentItem = value;
		}

		override public function set dataProvider(value:Array):void
		{
			// TODO Auto Generated method stub
			super.dataProvider = value;
			
		}
		
		override protected function itemClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.itemClick(e);
			if(_currentItem){
				_currentItem.selected = false;
			}
			_currentItem = e.target as SwitchItemRender;
			_currentItem.selected = true;
			this.dispatchEvent(new Event(Event.SELECT));
		}
		
		override protected function createItem(data:*):ItemRender
		{
			// TODO Auto Generated method stub
			var itemrender:SwitchItemRender = super.createItem(data) as SwitchItemRender;
			if(itemSize.length >0){
				itemrender.setSize(itemSize[0],itemSize[1]);
			}
			return itemrender;
		}
		
		
		 public function setItemSize(tw:int,th:int):void{
			 itemSize = [tw,th];
		 }
		
		override protected function updateDisplay():void
		{
			super.updateDisplay();
			drawBg();
		}
		
		/**
		 *跟新选中 
		 * @param data 选中数据
		 * @return  是否查找到并选中
		 * 
		 */		
		public function updateSelect(data:Object):Boolean{
			for (var i:int = 0; i < con.numChildren; i++) 
			{
				if(checkSameData(data,con.getChildAt(i) as SwitchItemRender)){
					if(_currentItem){
						_currentItem.selected = false;
					}
					_currentItem = con.getChildAt(i) as SwitchItemRender;
					return true;	
				}
			}
			return false;
		}
		
		protected function checkSameData(data:Object,localItem:SwitchItemRender):Boolean{
			if(data.hasOwnProperty("label") 
				&& localItem.data 
				&& localItem.data.hasOwnProperty("label")
				&& localItem.data.label == data.label
				){
				return true;
			}
			return false;
		}
		
		
		protected function drawBg():void{
			this.graphics.beginFill(0x474747);
			this.graphics.drawRect(0,0,con.width,con.height);
			this.graphics.endFill();
		}
	}
}