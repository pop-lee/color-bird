package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	
	import flash.events.MouseEvent;

	public class MainPage extends SFMovieClip
	{
		private var mainPane : MainPane;
		
		private var toPage : uint;
		
		public function MainPage()
		{
			super();
		}
		
		public function init() : void
		{
			mainPane = new MainPane();
			addChild(mainPane);
			
			mainPane.startGameBtn.addEventListener(MouseEvent.CLICK,startGame);
			mainPane.startGameBtn.addEventListener(MouseEvent.CLICK,helpGame);
			mainPane.startGameBtn.addEventListener(MouseEvent.CLICK,exitGame);
		}
		
		private function leave() : void
		{
			mainPane.startGameBtn.removeEventListener(MouseEvent.CLICK,startGame);
			mainPane.startGameBtn.removeEventListener(MouseEvent.CLICK,helpGame);
			mainPane.startGameBtn.removeEventListener(MouseEvent.CLICK,exitGame);
			
			removeChild(mainPane);
			mainPane = null;
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = toPage;
			this.dispatchEvent(changePageEvent);
		}
		
		private function startGame(event : MouseEvent) : void
		{
			toPage = ChangePageEvent.TO_GAME_PAGE;
			leave();
		}
		
		private function helpGame(event : MouseEvent) : void
		{
			toPage = ChangePageEvent.TO_HELP_PAGE;
			leave();
		}
		
		private function exitGame(event : MouseEvent) : void
		{
			toPage = ChangePageEvent.EXIT;
			leave();
		}
	}
}