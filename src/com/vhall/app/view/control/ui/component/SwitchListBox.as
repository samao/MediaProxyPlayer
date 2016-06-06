package  com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.ui.container.Box;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 用于切换状态带显示按钮的list组件
	 * @author zqh
	 * 
	 */	
	public class SwitchListBox extends Box
	{
		/**
		 *选中项的显示入口控件 
		 */		
		protected var showLab:SwitchLabelItem;
		/**
		 *boxlist 
		 */		
		protected var list:SwitchList;
		/**
		 *当前数据 
		 */		
		protected var datas:Array;
		
		private var _gap:int = 8;
		
		public function SwitchListBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		public function get gap():int
		{
			return _gap;
		}

		public function set gap(value:int):void
		{
			_gap = value;
			showList();
		}

		protected function onAdd(event:Event):void
		{
			// TODO Auto-generated method stub
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			addLisn();
		}
		
		protected function onRemove(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			removeLisn()
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
		}
		
		private function onDrawbg():void{
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFF,0.001);
			this.graphics.drawRect(0,-list.height,this._width,list.height +  showLab.height);
			this.graphics.endFill();
		}
		
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
		}
		/**
		 *设置显示数据 
		 * @param data 数据项
		 * @param itemW list子项的宽高
		 * @param itemH list子项的宽高
		 * @param itemRender 渲染项
		 * <br> 赋值后默认选中第一项
		 */		
		public function initList(data:Array,itemW:int = 70,itemH:int = 30,itemRender:Class = null):void{
			clearAll();
			datas = data;
			list = new SwitchList();
			list.setItemSize(70,30);
			if(itemRender){
				list.itemClass = itemRender;
			}else{
				list.itemClass = SwitchItemRender;
			}
			list.dataProvider = data;
			list.addEventListener(Event.SELECT,onSelect);
			setShowItemSkin(SwitchLabelItem);
		}
		
		protected function onSelect(event:Event):void
		{
			// TODO Auto-generated method stub
			if(list.currentItem){
				showLab.data = list.currentItem.data;
			}
			dispatchEvent(new Event(Event.CHANGE));
			//抛出选择事件
		}
		
		
		/**
		 *获取当前选择数据
		 * @return 
		 * 
		 */		
		public function getSelectData():Object{
			return list.currentItem.data;
		}
		
		public function setSelectData(data:Object):void{
			list.updateSelect(data);
		}
		
		
		/**
		 *设置显示itemSkin 
		 * 
		 */		
		public function setShowItemSkin(showItem:Class = null):void{
			if(showLab && showLab.parent){
				showLab.parent.removeChild(showLab);
			}
			if(showItem){
				showLab = new showItem();
			}else{
				showLab = new SwitchLabelItem();
			}
			this.addChild(showLab);
		}
		
		protected function addLisn():void{
			showLab.addEventListener(MouseEvent.ROLL_OVER,onOver);
		}
		
		protected function onOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.addEventListener(MouseEvent.ROLL_OUT,onOut);
			showLab.selected = true;
			showList();
		}
		
		protected function onOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(MouseEvent.ROLL_OUT,onOut);
			showLab.selected = false;
			hideList();
		}
		
		
		protected function removeLisn():void{
			showLab.removeEventListener(MouseEvent.ROLL_OVER,onOver);
		}
		
		
		protected function clearAll():void{
			if(list){
				while(list.numChildren)
				{
					list.removeChildAt(0);
				}
			}
			datas = [];
		}
		
		
		public function showList():void{
			if(list && !list.parent){
				this.addChild(list);
				list.move((this.showLab.width - list.width) >> 1,showLab.y - list.height - gap);
			}
			list.visible = true;
			onDrawbg();
		}
		
		public function hideList():void{
			if(list && list.parent){
				list.visible = false;
			}
		}
		
	}
}