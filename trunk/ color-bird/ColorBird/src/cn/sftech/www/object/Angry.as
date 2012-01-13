package cn.sftech.www.object
{
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	
	public class Angry extends SFMovieClip
	{
		private var _value : uint;
		
		private var _body : MovieClip;
		
		public function Angry()
		{
			super();
			_body = new AngryBtn();
			_body.body.height = 0;
			addChild(_body);
		}
		
		public function set value(value : uint) : void
		{
			_value = value;
			if(_value > GameConfig.TOTAL_ANGRY) {
				_value = GameConfig.TOTAL_ANGRY;
				return;
			} else if(_value == 0) {
				_body.gotoAndStop(1);
			}
			
			_body.body.height = _value/GameConfig.TOTAL_ANGRY*64;
			_body.body.y = 32 - _body.body.height;
		}
		
		public function get value() : uint
		{
			return _value;
		}
		
		public function makeAngry() : void{
			_body.gotoAndPlay(2);
		}
	}
}