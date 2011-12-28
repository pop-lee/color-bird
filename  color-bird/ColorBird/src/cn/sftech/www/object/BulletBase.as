package cn.sftech.www.object
{
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class BulletBase extends SFMovieClip
	{
		
		protected var _body : MovieClip;
		
		/**
		 * 与中心点形成的角tan值
		 */		
		public var ctanValue : Number;
		
		/**
		 * 速度
		 */		
		private var _velocity : Number = 0;
		
		/**
		 * 角度
		 */		
		private var _angle : Number;
		
//		/**
//		 * 象限区域
//		 */		
//		private var _quadrant : Number = 0;
		
		public var moveX : Number;
		public var moveY : Number;
		
		public function BulletBase()
		{
			super();
		}
		
		public function set velocity(value : Number) : void
		{
			_velocity = value;
		}
		
		public function get velocity() : Number
		{
			return _velocity;
		}
		
		
		public function get angle() : Number
		{
			return _angle;
		}
		
		public function set angle(value : Number) : void
		{
			_angle = value;
			
			if(_angle > 90) { //第二象限
				moveX = -1;
				moveY = moveX*ctanValue;
				//				quadrant = 2;
			} else if(_angle > 0) { //第一象限
				moveX = -1;
				moveY = moveX*ctanValue;
				//				quadrant = 1;
			} else if(_angle > -90) { //第四象限
				moveX = 1;
				moveY = moveX*ctanValue;
				//				quadrant = 4;
			} else { //第三象限
				moveX = 1;
				moveY = moveX*ctanValue;
				//				quadrant = 3;
			}
			
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
	}
}