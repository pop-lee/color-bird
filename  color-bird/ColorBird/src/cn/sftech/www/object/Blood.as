package cn.sftech.www.object
{
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;
	
	public class Blood extends SFMovieClip
	{
		/**
		 * 颜色
		 * 0代表 红色
		 * 1代表 黄色
		 * 2代表 蓝色
		 */		
		private var _color : uint = 0;
		
		private var _body : MovieClip;
		
		private var _blood : uint;
		
		public function Blood()
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
					_body = new RedBlood;
				};break;
				case 2:{
					_body = new YellowBlood();
				};break;
				case 3:{
					_body = new BlueBlood();
				}
			}
			
			_body.body.scaleX = _blood / GameConfig.TOTAL_BLOOD;
			
			addChild(_body);
		}
		
		public function get color() : uint
		{
			return _color;
		}
		
		public function set blood(value : uint) : void
		{
			_blood = value;
			_body.body.scaleX = _blood / GameConfig.TOTAL_BLOOD;
		}
		
		public function get blood() : uint
		{
			return _blood;
		}
		
	}
}