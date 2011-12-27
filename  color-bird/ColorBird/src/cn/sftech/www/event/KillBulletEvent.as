package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class KillBulletEvent extends Event
	{
		public static const KILL_BULLET_EVENT : String = "killBulletEvent";
		
		public function KillBulletEvent()
		{
			super(KILL_BULLET_EVENT);
		}
	}
}