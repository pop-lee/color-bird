package cn.sftech.www.model
{
	public class GameConfig
	{
//		//-------------------8个区域----------------
//		//----A区----
//		public static const SPACE_1 : uint = 1;
//		public static const SPACE_2 : uint = 2;
//		public static const SPACE_3 : uint = 3;
//		public static const SPACE_4 : uint = 4;
//		//----B区----
//		public static const SPACE_5 : uint = 5;
//		public static const SPACE_6 : uint = 6;
//		//----C区----
//		public static const SPACE_7 : uint = 7;
//		public static const SPACE_8 : uint = 8;
		
		/**
		 * 游戏面板中心点X坐标 
		 */		
		public static const GAMECENTER_X : uint = 400;
		/**
		 * 游戏面板中心点Y坐标
		 */		
		public static const GAMECENTER_Y : uint = 240;
		
		/**
		 * 游戏面板中心点X坐标 
		 */		
		public static const GAMEPANE_WIDTH : uint = 800;
		/**
		 * 游戏面板中心点Y坐标
		 */		
		public static const GAMEPANE_HEIGHT : uint = 480;
		
		//----------------------------------------------
		
		
		/**
		 * 子弹每关数量基数
		 */		
		public static const BULLET_COUNT : uint = 10;
		/**
		 * 子弹速度
		 */		
		public static const VELOCITY : uint = 10;
		/**
		 * 保护光圈在指定关卡后变短
		 */		
		public static const NIMBUS_LINE : uint = 5;
		
		/**
		 * 每相隔毫秒数创建子弹
		 */		
		public static const BULLET_TIMER : uint = 500;
		
		/**
		 * 每相隔毫秒数创建子弹
		 */		
		public static const BATCH_TIMER : uint = 500;
		
		/**
		 * 挡掉子弹得分
		 */		
		public static const BULLET_SCORE : uint = 100;
		/**
		 * 挡掉钱币得分
		 */		
		public static const COIN_SCORE : uint = 500;
		
		public static const SECTOR_LV_LINE : uint = 8;
		/**
		 * 血量总数
		 */		
		public static const TOTAL_BLOOD : uint = 10;
		/**
		 * 愤怒值满
		 */		
		public static const TOTAL_ANGRY : uint = 2;
		
		public function GameConfig()
		{
		}
	}
}