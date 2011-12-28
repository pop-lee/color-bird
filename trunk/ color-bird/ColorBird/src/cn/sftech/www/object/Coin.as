package cn.sftech.www.object
{
	import cn.sftech.www.view.SFMovieClip;
	
	import flash.display.MovieClip;

	public class Coin extends BulletBase
	{
		public function Coin()
		{
			init();
		}
		
		private function init() : void
		{
			_body = new CoinBody();
			addChild(_body);
		}
	}
}