package cn.sftech.www.model
{
	import cn.sftech.www.util.MathUtil;

	public class LevelData
	{
		/**
		 * 每关数据结构
		 * 分别代表
		 * 第一维数组代表批次
		 * 第二维数组分别代表如下
		 * 1.子弹数量 （单位/个）
		 * 2.子弹速度 （单位/像素）0代表随机 非0代表每秒移动像素值
		 * 3.颜色标记 （1、与前一批同色，2、与前一批不同色，3、金币，4、随机）
		 * 4.象限位置 （1、与上一批象限相同，2、与上一批象限相邻，3、与上一批象限相对）
		 * 5.批次与下一批创建间隔时间（单位：毫秒）
		 */		
		public var lvData : Array = [
			//第一关（只会遇到一种颜色）
			[
//				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 10000000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 3000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 3000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 2000},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 3000},
			],
			//第二关（难度提升点：同时遇到两种颜色）
			[
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 3,batchTimer : 2000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 2000},
				{bulletCount : 4,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 3000},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 2000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 2000},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				{bulletCount : 4,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 3000},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 2000},
			],
			//第三关(难度提升点：突然来自四个方向出现同色的球 打破操作常规）
			[
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
			],
			//第四关(难度提升点：三个方向、两种颜色）
			[
				{bulletCount : 4,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 2000},
				
				{bulletCount : 4,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 2000},
				
				{bulletCount : 4,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 2000},
				
				{bulletCount : 4,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 2000},
			],
			//第五关(难度提升点：突然来自四个方向出现同色的球 打破操作常规）
			[
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
			],
			//第六关(难度提升点：第一次在同屏内出现三种颜色）
			[
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 2500},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 2500},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 0},
			],
			//第七关(难度提升点：突然来自四个方向出现同色的球 打破操作常规）
			[
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 2000},
			],
			//第八关(难度提升点：突然来自四个方向出现不同色的球 打破操作常规）
			[
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
			],
			//第九关(难度提升点：记忆型欺骗）
			[
				{bulletCount : 2,bulletVelocity : 5,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 0},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
				{bulletCount : 5,bulletVelocity : 10,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 1000},
				
				{bulletCount : 2,bulletVelocity : 5,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 0},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
				{bulletCount : 5,bulletVelocity : 10,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 1000},
				
				{bulletCount : 2,bulletVelocity : 5,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 0},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 3000},
				{bulletCount : 5,bulletVelocity : 10,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 2000},
			],
			//第十关(难度提升点：两种颜色四个方向）
			[
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 1000},
				
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 3,bulletVelocity : 4,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1000},
			],
			//第十一关(难度提升点：打破节奏 数量增加  同色12个球）
			[
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 500},
				{bulletCount : 3,bulletVelocity : 5,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
			],
			//第十二关(难度提升点：后刷新的球先到)
			[
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 1000},
			],
			//第十三关(难度提升点：干扰项增多)
			[
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 7,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 2,bulletVelocity : 7,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
			],
			//第十四关(难度提升点：三种颜色三个方向)
			[
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
			],
			//第十五关(难度提升点：你想反应+变色)
			[
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 3,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1000},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
			],
			//第十六关(难度提升点：四个方向两种颜色的球 后刷新的先到 数量增多)
			[
				{bulletCount : 4,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 7,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
				
				{bulletCount : 4,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 7,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
				
				{bulletCount : 4,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 7,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
				
				{bulletCount : 4,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1500},
				{bulletCount : 2,bulletVelocity : 7,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 3000},
			],
			//第十七关(难度提升点：欺骗关卡的变种)
			[
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
				
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 3,batchTimer : 500},
				{bulletCount : 2,bulletVelocity : 2,bulletColorType : 1,bulletQuadrant : 2,batchTimer : 1500},
				{bulletCount : 1,bulletVelocity : 6,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 3000},
			],
			//第十八关(难度提升点：三种颜色四个方向)
			[
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 1,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 2,batchTimer : 800},
				{bulletCount : 4,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 1000},
				//temp
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 300000000},
				{bulletCount : 1,bulletVelocity : 4,bulletColorType : 2,bulletQuadrant : 3,batchTimer : 300000000},
				
			],
			
		];
		
		public var crazeData : Array = [
			{bulletCount : 3,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 1,batchTimer : 0},
			{bulletCount : 3,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 3,batchTimer : 0},
			{bulletCount : 3,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 2,batchTimer : 0},
			{bulletCount : 3,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 3,batchTimer : 1000},
			
			{bulletCount : 3,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 1,batchTimer : 0},
			{bulletCount : 3,bulletVelocity : 4,bulletColorType : 4,bulletQuadrant : 3,batchTimer : 0},
		]
		
		public function LevelData()
		{
		}
		
		/**
		 * 根据上一批次的象限值获取当前批次值得规律方法
		 * @param lastQuadrant 上一批次象限值
		 * @param type 与上一批次的关系类型
		 * @return 返回想要的象限值
		 */		
		public static function getQuadrantByLast(lastQuadrant : uint,type : uint) : uint
		{
			var tempFlag : int = lastQuadrant;
			
			switch(type) {
				case 1:{tempFlag};break; //和前一批相同
				case 2:{tempFlag += int((0.5 - MathUtil.random(0,2))*2)};break; //和前一批相邻
				case 3:{tempFlag += 2};break; //和前一批相对
			}
			
			if(tempFlag < 1) {
				tempFlag += 4;
			} else if(tempFlag > 4) {
				tempFlag -= 4;
			}
			
			return tempFlag;
		}
		
		/**
		 * 根据上一批次的颜色值获取当前批次颜色
		 * @param lastColor 上一批次颜色
		 * @param type 与上一批次的关系类型
		 * @return 返回想要的颜色
		 * 
		 */		
		public static function getColorByLast(lastColor : uint,type : uint) : uint
		{
			var tempFlag : int = lastColor;
			
			switch(type) {
				case 1:{tempFlag};break;
				case 2:{tempFlag += int((0.5 - MathUtil.random(0,2))*2)};break;
			}
			
			if(tempFlag < 1) {
				tempFlag += 3;
			} else if(tempFlag > 3) {
				tempFlag -= 3;
			}
			
			return tempFlag;
		}
	}
}