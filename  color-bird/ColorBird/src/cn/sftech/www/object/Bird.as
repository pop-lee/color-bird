package cn.sftech.www.object
{
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bird extends SFMovieClip
	{
		/**
		 * 鸟的颜色
		 * 0代表 红色
		 * 1代表 黄色
		 * 2代表 蓝色
		 */		
		private var _color : uint = 0;
		
		private var _body : MovieClip;
		
		public function Bird()
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
					_body = new RedBird();
				};break;
				case 1:{
					_body = new YellowBird();
				};break;
				case 2:{
					_body = new BlueBird();
				}
			}
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
		public function hurt() : void
		{
			_body.gotoAndPlay(4);
		}
		
		//----------------Event Handle--------------------
		
	}
}