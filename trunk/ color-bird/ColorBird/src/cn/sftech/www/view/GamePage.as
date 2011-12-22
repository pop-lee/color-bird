package cn.sftech.www.view
{
	public class GamePage extends SFMovieClip
	{
		private var gamePane : GamePane;
		
		public function GamePage()
		{
			super();
		}
		
		public function init() : void
		{
			gamePane = new GamePane();
			addChild(gamePane);
			gamePane.init();
		}
	}
}