package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.event.GameSuccessEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.NumberImage;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;

	public class GamePage extends SFMovieClip
	{
		private var gamePane : GamePane;
		
		private var gameOverPane : GameOverPane;
		
//		private var gameSuccessPane : GameSuccessPane;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function GamePage()
		{
			super();
		}
		
		public function init() : void
		{
			gamePane = new GamePane();
			gamePane.addEventListener(GameSuccessEvent.GAME_SUCCESS_EVENT,gameSuccessHandle);
			gamePane.addEventListener(GameOverEvent.GAME_OVER_EVENT,gameOverHandle);
			gamePane.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			addChild(gamePane);
			gamePane.init();
		}
		
		private function gameOverHandle(event : GameOverEvent) : void
		{
			gameOverPane = new GameOverPane();
			var numImage : NumberImage = new NumberImage();
			numImage.charWidth = numImage.charHeight = 20;
			numImage.imageData = ScoreNumber;
			var scoreImage : Bitmap = numImage.getNumberImage(_model.currentScore);
			scoreImage.x = 0;
			scoreImage.y = 5;
			gameOverPane.addChild(scoreImage);
			
			var maxScoreImage : Bitmap = numImage.getNumberImage(Math.max(_model.currentMaxScore,_model.currentScore));
			maxScoreImage.x = 0;
			maxScoreImage.y = -75;
			gameOverPane.addChild(maxScoreImage);
			
			gameOverPane.x = 400;
			gameOverPane.y = 240;
			gameOverPane.restartGameBtn.addEventListener(MouseEvent.CLICK,
				function restartHandle(event : MouseEvent) : void
				{
					gameOverPane.parent.removeChild(gameOverPane);
					gameOverPane.restartGameBtn.removeEventListener(MouseEvent.CLICK,restartHandle);
					gameOverPane = null;
					
					gamePane.restartGame();
				});
			gameOverPane.exitGameBtn.addEventListener(MouseEvent.CLICK,
				function exitHandle() : void
				{
					var changePageEvent : ChangePageEvent = new ChangePageEvent();
					changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
					changePageHandle(changePageEvent);
				});
			addChild(gameOverPane);
		}
		
		private function gameSuccessHandle(event : GameSuccessEvent) : void
		{
//			gameSuccessPane = new GameSuccessPane();
//			
//			gameSuccessPane.x = 400;
//			gameSuccessPane.y = 100;
//			this.addChild(gameSuccessPane);
//			
//			var numImage : NumberImage = new NumberImage();
//			numImage.charWidth = numImage.charHeight = 20;
//			numImage.imageData = ScoreNumber;
//			var lvImage : Bitmap = numImage.getNumberImage(_model.currentLv);
//			lvImage.x = -lvImage.width/2;
//			lvImage.y = -10;
//			gameSuccessPane.addChild(lvImage);
//			
//			var timer : Timer = new Timer(0,1);
//			timer.addEventListener(TimerEvent.TIMER_COMPLETE,
//				function timerHandle(event : TimerEvent) : void
//				{
//					timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerHandle);
//					gameSuccessPane.removeChild(lvImage);
//					lvImage = null;
//					
//					gameSuccessPane.parent.removeChild(gameSuccessPane);
//					gamePane.initLv();
//				});
//			timer.start();
			gamePane.initLv();
		}
		
		private function changePageHandle(event : ChangePageEvent) : void
		{
			removeChild(gamePane);
			gamePane = null;
			if(gameOverPane) {
				removeChild(gameOverPane);
				gameOverPane = null;
			}
			
			System.gc();
			
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = event.data;
			this.dispatchEvent(changePageEvent);
		}
	}
}