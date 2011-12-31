package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class GameSuccessEvent extends Event
	{
		public static const GAME_SUCCESS_EVENT : String = "gameSuccessEvent";
		
		public function GameSuccessEvent()
		{
			super(GAME_SUCCESS_EVENT);
		}
	}
}