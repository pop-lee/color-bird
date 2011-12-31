package cn.sftech.www.util
{
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttScore;
	
	import flash.errors.EOFError;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class DataManager
	{
		
		private var loading : uint = 0;
		
		private var manageLock : Boolean = false;
		
		private static var isInitialized : Boolean = false;
		
		private static var manageFuncArr : Vector.<Function> = new Vector.<Function>();
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function DataManager()
		{
		}
		
		public function initData() : void
		{
			queryScore();
		}
		
		
		private function initFinished() : void
		{
			isInitialized = true;
			//			LogManager.print("初始化成功");
			
			manageLock = true;
			
			SFApplication.application.dispatchEvent(new SFInitializeDataEvent());
			LogManager.hideLog();
			
		}
		
		public function queryScore() : void
		{
			if(manageLock) {
				inList(queryScore);
			} else {
				manageLock = true;
				
				MttScore.query(queryScoreResult);
			}
		}
		
		public function saveScore() : void
		{
			if(manageLock) {
				inList(saveScore);
			} else {
				manageLock = true;
				
				MttScore.submit(_model.currentScore,submitScoreResult);
			}
		}
		
		private function queryScoreResult(result : Object) : void
		{
			if(result.code == 0) { // 保存成功
				outList();
				_model.currentMaxScore = result.score.score;
			} else {
				outList();
				trace(result.code + "     保存失败");
			}
		}
		
		private function submitScoreResult(result : Object) : void
		{
			if(result.code == 0) { // 保存成功
				outList();
			} else {
				outList();
				trace(result.code + "     保存失败");
			}
		}
		
		//---------------------------------------------------------------------------------------------
		
		private function inList(func : Function) : void
		{
			manageFuncArr.push(func);
		}
		
		private function outList() : void
		{
			if(!isInitialized) {
//				loading = loading>=100?100:loading += 10;
//				LogManager.print("正在加载用户数据..." + loading + " %");
				
				if(manageFuncArr.length == 0) {
//					loading = 100;
//					LogManager.print("正在加载用户数据..." + loading + " %");
					initFinished();
				}
			}
			
			manageLock = false;
			if(manageFuncArr.length == 0) return;
			
			var func : Function = manageFuncArr[0];
			manageFuncArr.splice(0,1);
			if(manageFuncArr.length>=0) {
				func.call();
			}
		}
	}
}