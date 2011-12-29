package cn.sftech.www.object
{
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	
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
		
		public function set color(value : uint) : void
		{
			_color = value;
			if(bitmap) {
				removeChild(bitmap);
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
			bitmapData.draw(_body);
			bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);
		}
		public function get color() : uint
		{
			return _color;
		}
		
	}
}