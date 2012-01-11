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
			addChild(_body);
		}
		
		public function set value(value : uint) : void
		{
			_value = value;
//			trace(_body.body.y);
			if(_value > GameConfig.TOTAL_ANGRY) return;
			_body.body.y = _body.height*(1-_value/GameConfig.TOTAL_ANGRY) - _body.height/2;
			_body.body.scaleY = _value/GameConfig.TOTAL_ANGRY;
		}
		
		public function get value() : uint
		{
			return _value;
		}
	}
}