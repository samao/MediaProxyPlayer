package com.vhall.app.view.control.ui.component
{
	import com.vhall.framework.app.manager.RenderManager;
	import com.vhall.framework.ui.controls.ItemRender;
	import com.vhall.framework.ui.controls.Label;
	
	import flash.display.DisplayObjectContainer;
	/**
	 * 用于list中渲染组件 
	 * @author zqh
	 * 
	 */	
	public class SwitchItemRender extends ItemRender
	{
		protected var lab:Label;
		public var overBgColor:uint = 0x474747;
		public var outBgColor:uint = 0x2B2B2B;
		public function SwitchItemRender(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			this.setSize(80,20);
		}
		
		protected function initBgColors():void{
		}
		
		override public function onMouseClick():void
		{
			// TODO Auto Generated method stub
			super.onMouseClick();
		}
		
		
		override protected function init():void
		{
			super.init();
			initBgColors();
			update4Select();
		}
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			lab = new Label(this);
			lab.color = 0xffffff;
			lab.mouseChildren = lab.mouseEnabled = false;
		}
		
		protected function initDrawBg():void{
			this.graphics.clear()
			this.graphics.beginFill(outBgColor,85);
			this.graphics.drawRect(0,0,this._width,this._height);
			this.graphics.endFill();
			RenderManager.getInstance().invalidate(invalidate);
		}
		
		
		protected function overDrawBg():void{
			this.graphics.clear()
			this.graphics.beginFill(overBgColor,85);
			this.graphics.drawRect(0,0,this._width,this._height);
			this.graphics.endFill();
			RenderManager.getInstance().invalidate(invalidate);
		}
		
		override public function onMouseOut():void
		{
			// TODO Auto Generated method stub
			super.onMouseOut();
			update4Select();
			update4labe();
		}
		
		/**
		 *更新背景颜色 
		 * 
		 */		
		public function update4Select():void{
			if(selected){
				overDrawBg();
			}else{
				initDrawBg()
			}
		}
		
		
		override public function onMouseOver():void
		{
			// TODO Auto Generated method stub
			super.onMouseOver();
			overDrawBg();
			update4labe();
		}
		
		override public function set selected(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.selected = value;
			update4Select();
			update4labe();
		}
		
		/**
		 *更新显示文本 
		 * 
		 */		
		protected function update4labe():void{
			if(selected){
				lab.color = 0xff0000;
			}else{
				lab.color = 0xffffff;
			}
		}
		
		
		override public function set data(value:*):void
		{
			// TODO Auto Generated method stub
			super.data = value;
			updateItem();
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			// TODO Auto Generated method stub
			super.setSize(w, h);
			update4Select();
			updateItem();
		}
		
		protected function updateItem():void{
			if(data == null) return;
			lab.text = data.label;
			this.lab.textField.width = this.lab.textField.textWidth + 4;
			this.lab.move((this.width - this.lab.width) >> 1,(this.height - this.lab.height) >>1);
		}
		
	}
}