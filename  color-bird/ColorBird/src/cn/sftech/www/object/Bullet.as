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
			color = 1;
		}
		
		public function set color(value : uint) : void
		{
			_color = value;
			if(_body) {
				removeChild(_body);
			}
			
			switch(value) {
				case 1:{
					_body = new RedBullet();
				};break;
				case 2:{
					_body = new YellowBullet();
				};break;
				case 3:{
					_body = new BlueBullet();
				}
			}
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
		override public function killMyself() : void
		{
			if(_body.hasEventListener(Event.ENTER_FRAME)) return;
			_body.addEventListener(Event.ENTER_FRAME,
				function bodyEnterFrame(event : Event) : void {
					if(_body.currentFrame == _body.totalFrames) {
						_body.removeEventListener(Event.ENTER_FRAME,bodyEnterFrame);
						_body.parent.dispatchEvent(new KillBulletEvent());
						return;
					}
					_body.nextFrame();
				});
		}
		
	}
}