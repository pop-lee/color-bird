package cn.sftech.www.object
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Nimbus extends MovieClip
	{
		/**
		 * 保护圈的颜色
		 * 0代表 红色
		 * 1代表 黄色
		 * 2代表 蓝色
		 */		
		private var _color : uint = 0;
		
		private var _body : MovieClip;
		
		public var sector : uint = 90;
		
		public function Nimbus()
		{
			super();
			color = 0;
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value;
			
		}
		
		public function set color(value : uint) : void
		{
			_color = value;
			if(_body) {
				removeChild(_body);
			}
			
			switch(value) {
				case 0:{
					_body = new RedNimbus();
				};break;
				case 1:{
					_body = new YellowNimbus();
				};break;
				case 2:{
					_body = new BlueNimbus();
				}
			}
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
	}
}