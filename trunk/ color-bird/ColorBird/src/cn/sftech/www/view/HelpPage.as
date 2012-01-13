package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class HelpPage extends SFMovieClip
	{
		private var _body : HelpPane;
		
		public var toPage : uint;
		
		private var timer : Timer = new Timer(2000,1);
		
		public function HelpPage()
		{
			super();
		}
		
		public function init() : void
		{
			if(toPage == ChangePageEvent.TO_GAME_PAGE) {
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerHandle);
				timer.start();
			}
			_body = new HelpPane();
			addChild(_body);
			_body.backBtn.addEventListener(MouseEvent.CLICK,leaveHandle);
		}
		
		private function timerHandle(event : TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerHandle);
			leaveHandle();
		};
		
		private function leaveHandle(event : MouseEvent=null) : void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerHandle);
			
			_body.backBtn.removeEventListener(MouseEvent.CLICK,leaveHandle);
			removeChild(_body);
			
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = toPage;
			this.dispatchEvent(changePageEvent);
		}
	}
}