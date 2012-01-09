package cn.sftech.www.object
{
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	
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
		
		private var _isSuper : Boolean = false;
		
		public function Bird()
		{
			super();
			init();
		}
		
		private function init() : void
		{
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
					_body = new RedBird();
				};break;
				case 2:{
					_body = new YellowBird();
				};break;
				case 3:{
					_body = new BlueBird();
				}
			}
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
		public function get core() : MovieClip
		{
			return _body.core;
		}
		
		public function makeSuper() : void
		{
//			var timer : Timer = new Timer(200,10);
			
		}
		
		public function hurt() : void
		{
			_body.gotoAndPlay(10);
			makeSuper();
		}
		
		//----------------Event Handle--------------------
		
	}
}