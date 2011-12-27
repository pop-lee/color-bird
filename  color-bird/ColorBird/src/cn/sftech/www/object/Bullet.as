package cn.sftech.www.object
{
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends SFMovieClip
	{
		/**
		 * 子弹的颜色
		 * 0代表 红色
		 * 1代表 黄色
		 * 2代表 蓝色
		 */		
		private var _color : uint = 0;
		
		/**
		 * 象限区域
		 */		
		private var _quadrant : Number = 0;
		
		private var _body : MovieClip;
		/**
		 * 速度
		 */		
		private var _velocity : Number = 0;
		/**
		 * 角度
		 */		
		private var _angle : Number;
		/**
		 * 与中心点形成的角tan值
		 */		
		public var tanValue : Number;
		
		public var moveX : Number;
		public var moveY : Number;
		
		public function Bullet()
		{
			super();
			color = 0;
		}
		
		public function set color(value : uint) : void
		{
			_color = value;
			if(_body) {
				removeChild(_body);
			}
			
			switch(value) {
				case 0:{
					_body = new RedBullet;
				};break;
				case 1:{
					_body = new YellowBullet();
				};break;
				case 2:{
					_body = new BlueBullet();
				}
			}
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
		public function set angle(value : Number) : void
		{
			_angle = value;
			
			if(_angle > 90) { //第二象限
				moveY = -1;
				moveX = moveY*tanValue;
//				quadrant = 2;
			} else if(_angle > 0) { //第一象限
				moveY = 1;
				moveX = moveY*tanValue;
//				quadrant = 1;
			} else if(_angle > -90) { //第四象限
				moveY = 1;
				moveX = moveY*tanValue;
//				quadrant = 4;
			} else { //第三象限
				moveY = -1;
				moveX = moveY*tanValue;
//				quadrant = 3;
			}
			
		}
		
		public function get angle() : Number
		{
			return _angle;
		}
		
		public function set velocity(value : Number) : void
		{
			_velocity = value;
		}
		
		public function get velocity() : Number
		{
			return _velocity;
		}
		
		public function killMyself() : void
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
		
//		public function set quadrant(value : uint) : void
//		{
//			_quadrant = value;
//		}
//		
//		public function get quadrant() : uint
//		{
//			return _quadrant;
//		}
//		
	}
}