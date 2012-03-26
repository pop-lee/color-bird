package cn.sftech.www.object
{
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
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
		
		private var _oldColor : uint = 0;
		
		private var _body : MovieClip;
		
		private var _nimbus : Nimbus;
		
		private var _isSuper : Boolean = false;
		
		public var isSuperStatus : Boolean = false;
		
		public function Bird()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			color = 1;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
		}
		
		public function set color(value : uint) : void
		{
			if(_color != 4) {
				_oldColor = _color;
			}
			_color = value;
			if(_body) {
				removeChild(_body);
			}
			if(_nimbus) {
				_nimbus.color = _color;
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
				};break;
				case 4:{
					_body = new SuperBird();
				};break;
			}
			
			addChild(_body);
		}
		public function get color() : uint
		{
			return _color;
		}
		
		public function set nimbus(nimbus : Nimbus) : void
		{
			_nimbus = nimbus;
			_nimbus.color = _color;
			addChild(_nimbus);
		}
		
		public function get body() : MovieClip
		{
			return _body.body;
		}
		
		public function makeSuper() : void
		{
			color = 4;
		}
		
		public function recoverNormal() : void
		{
			color = _oldColor;
		}
		
		public function hurt() : void
		{
			_body.gotoAndPlay(9);
//			makeSuper();
		}
		
		//----------------Event Handle--------------------
		
	}
}