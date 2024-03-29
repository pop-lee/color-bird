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
		
		public var _sector : uint = 90;
		
		private var _oldSector : uint;
		
		public function Nimbus()
		{
			super();
			color = 1;
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value;
			
		}
		
		public function set sector(value : uint) : void
		{
			if(value == 45) {
				_body.gotoAndStop(2);
			}
			_sector = value;
		}
		
		public function get sector() : uint
		{
			return _sector;
		}
		
		public function set color(value : uint) : void
		{
			if(_color != 4) {
				_oldSector = _sector;
			}
			_color = value;
			
			
			if(_body) {
				removeChild(_body);
			}
			
			switch(value) {
				case 1:{
					_body = new RedNimbus();
				};break;
				case 2:{
					_body = new YellowNimbus();
				};break;
				case 3:{
					_body = new BlueNimbus();
				};break;
				case 4:{
					_body = new SuperNimbus();
				}
			}
			
			sector = _oldSector;
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
	}
}