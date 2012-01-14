package cn.sftech.www.model
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		public var currentScore : uint;
		
		public var currentMaxScore : uint;
		
		public var currentLv : uint;
		
		//是否静音
		public var isMute : Boolean = false;
		
		public var audioChannel : SoundChannel = new SoundChannel();
		
		public var musicChannel : SoundChannel = new SoundChannel();
		
		
		public function ModelLocator()
		{
			if(_model != null) {
				throw new IllegalOperationError("这是一个单例类，请使用getInstance方法来获取对象");
			}
		}
		
		public static function getInstance() : ModelLocator
		{
			return _model;
		}
		
		public static function playAudioSound(obj : Sound) : void
		{
			_model.audioChannel = obj.play(0,0,_model.audioChannel.soundTransform);
		}
		
		public static function playBGSound(event : Event=null) : void
		{
			_model.musicChannel.stop();
			_model.musicChannel = (new BGSound()).play(0,0,_model.musicChannel.soundTransform);
			if(!_model.musicChannel.hasEventListener(Event.SOUND_COMPLETE)) {
				_model.musicChannel.addEventListener(Event.SOUND_COMPLETE,playBGSound);
			}
		}
		
	}
}