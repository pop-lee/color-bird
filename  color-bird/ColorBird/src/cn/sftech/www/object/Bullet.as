package cn.sftech.www.object
{
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class Bullet extends BulletBase
	{
		/**
		 * 子弹的颜色
		 * 0代表 红色
		 * 1代表 黄色
		 * 2代表 蓝色
		 */		
		private var _color : uint = 0;
		
		public function Bullet()
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
			
			bitmap.y = value -bitmap.height/2;
		}
		
		public function set color(value : uint) : void
		{
			_color = value;
			if(_body) {
				removeChild(_body);
			}
			
			switch(value) {
				case 0:{
					_body = new RedBullet();
				};break;
				case 1:{
					_body = new YellowBullet();
				};break;
				case 2:{
					_body = new BlueBullet();
				}
			}
			
			var bitmapData : BitmapData = new BitmapData(_body.width, _body.height, true,0x00000000);
			bitmapData.draw(_body,new Matrix(1,0,0,1,bitmapData.width/2,bitmapData.height/2));
			bitmap.bitmapData = bitmapData;
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
	}
}