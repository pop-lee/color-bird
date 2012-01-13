package cn.sftech.www.object
{
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Coin extends BulletBase
	{
		public var _isGet : Boolean;
		
		public function Coin()
		{
			init();
		}
		
		private function init() : void
		{
			_body = new CoinBody();
			addChild(_body);
		}
		
		public function set isGet(value : Boolean) : void
		{
			_isGet = value;
			if(!value) {
				_body.gotoAndStop(7);
			}
		}
		
		override public function killMyself() : void
		{
			if(_body.hasEventListener(Event.ENTER_FRAME)) return;
			_body.addEventListener(Event.ENTER_FRAME,
				function bodyEnterFrame(event : Event) : void {
					if(_isGet) {
						if(_body.currentFrame == 6) {
							_body.removeEventListener(Event.ENTER_FRAME,bodyEnterFrame);
							_body.parent.dispatchEvent(new KillBulletEvent());
							return;
						}
					} else {
						if(_body.currentFrame == _body.totalFrames) {
							_body.removeEventListener(Event.ENTER_FRAME,bodyEnterFrame);
							_body.parent.dispatchEvent(new KillBulletEvent());
							return;
						}
					}
					_body.nextFrame();
				});
		}
	}
}