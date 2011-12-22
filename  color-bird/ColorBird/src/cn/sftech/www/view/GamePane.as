package cn.sftech.www.view
{
	import cn.sftech.www.object.Bird;

	public class GamePane extends SFMovieClip
	{
		private var bird : RedBird;
		
		private var nimbus : NimbusBody;
		
		public function GamePane()
		{
			super();
		}
		
		public function init() : void
		{
			this.backgroundImage = GamePaneBackground;
			
			bird = new RedBird();
			bird.x = this.width/2;
			bird.y = this.height/2;
			addChild(bird);
			
			nimbus = new NimbusBody();
			nimbus.x = this.width/2;
			nimbus.y = this.height/2;
			addChild(nimbus);
			
		}
	}
}