package cn.sftech.www.object
{
	import cn.sftech.www.view.SFMovieClip;
	
	public class Bird extends SFMovieClip
	{
		/**
		 * 鸟的颜色
		 * 0代表 红色
		 * 1代表 黄色
		 * 2代表 蓝色
		 */		
		private var _color : uint = 0;
		
		private var _birdBody : BirdBody;
		
		public function Bird()
		{
			super();
			_birdBody = new BirdBody();
			addChild(_birdBody);
			color = 0;
		}
		
		public function set color(value : uint) : void
		{
			_color = value;
			switch(value) {
				case 0:{
					_birdBody.gotoAndStop(1);
					_birdBody.redBird.play();
				};break;
				case 1:{
					_birdBody.gotoAndStop(2);
					_birdBody.yellowBird.play();
				};break;
				case 2:{
					_birdBody.gotoAndStop(3);
					_birdBody.blueBird.play();
				}
			}
		}
		public function get color() : uint
		{
			return _color;
		}
	}
}