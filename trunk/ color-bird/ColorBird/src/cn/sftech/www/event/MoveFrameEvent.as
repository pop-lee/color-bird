package cn.sftech.www.event
{
	import cn.sftech.www.object.BulletBase;
	
	import flash.events.Event;
	
	public class MoveFrameEvent extends Event
	{
		public static const MOVE_FRAME_EVENT : String = "moveFrameEvent";
		
		public var moveTarget : BulletBase;
		
		public function MoveFrameEvent(_target : BulletBase)
		{
			moveTarget = _target;
			super(MOVE_FRAME_EVENT);
		}
	}
}