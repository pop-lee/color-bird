package cn.sftech.www.model
{
	import flash.errors.IllegalOperationError;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		public var currentScore : uint;
		
		public var currentMaxScore : uint;
		
		public var currentLv : uint;
		
		
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
		
	}
}