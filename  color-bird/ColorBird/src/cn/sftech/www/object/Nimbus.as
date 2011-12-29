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
		
		public var bitmap : Bitmap;
		
		private var matrix : Matrix = new Matrix();
		
		public function Nimbus()
		{
			super();
			color = 0;
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;
			
			bitmap.x = value -bitmap.width/2;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
			
			bitmap.y = value -bitmap.height;
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value;
			
//			matrix.transformPoint(new Point(bitmap.width/2,
			var bitmapData : BitmapData = new BitmapData(_body.width, _body.height, true,0x00000000);
//			var bitmapData : BitmapData = bitmap.bitmapData;
			var transformPoint : Point = new Point(bitmap.x + bitmap.width/2 - 10,bitmap.y + bitmap.height - 10);
//			matrix = bitmap.transform.matrix;
//			matrix.transformPoint(transformPoint);
//			matrix.translate(-transformPoint.x,-transformPoint.y);
//			matrix.rotate(value);
//			matrix.translate(transformPoint.x,transformPoint.y);
//			bitmap.transform.matrix = matrix;
//			matrix.tx = bitmapData.width/2 + 10;
//			matrix.ty = bitmapData.height + 10;
//			bitmapData.draw(bitmapData);
////			bitmapData.draw(_body,matrix);
////			bitmap = new Bitmap(bitmapData);
//			bitmap.rotation = value;
			
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
			
			var bitmapData : BitmapData = new BitmapData(_body.width, _body.height, true,0x00000000);
			matrix.tx = bitmapData.width/2;
			matrix.ty = bitmapData.height;
			bitmapData.draw(_body,matrix);
			bitmap = new Bitmap(bitmapData);
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
	}
}