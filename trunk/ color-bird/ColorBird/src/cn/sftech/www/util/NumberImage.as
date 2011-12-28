package cn.sftech.www.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class NumberImage
	{
		public var imageData : Class;
		
		public var charWidth : Number;
		public var charHeight : Number;
		
		private static var numArr : Vector.<int> = new Vector.<int>;
		
		public function NumberImage()
		{
		}
		
		public function getNumberImage(value : int) : Bitmap
		{
			var obj : Object = new imageData();
			var image : BitmapData;
			if(obj is BitmapData) {
				image = obj as BitmapData;
			} else if(obj is DisplayObject) {
				image = new BitmapData(obj.width,obj.height,true,0);
				image.draw(obj as DisplayObject);
			}
			var chars : String = value.toString();
			var disData : BitmapData = new BitmapData(charWidth*chars.length,charHeight);
			for(var i : int = 0;i < chars.length;i++) {
				var n : int = int(chars.substr(i,1));
				numArr.push(n);
				var rectDis : Rectangle = new Rectangle(charWidth*n, 0, charWidth, charHeight);
				disData.copyPixels(image, rectDis, new Point(charWidth*i,0));
			}
			return new Bitmap(disData);
		}
		
//		private function getCharImage(value : int) : void
//		{
//		}
	}
}