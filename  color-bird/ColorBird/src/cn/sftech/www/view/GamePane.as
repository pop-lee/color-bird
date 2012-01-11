package cn.sftech.www.view
{
	import cn.sftech.www.effect.SFMoveEffect;
	import cn.sftech.www.effect.base.SFEffectBase;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.event.GameSuccessEvent;
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.model.LevelData;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.Angry;
	import cn.sftech.www.object.Bird;
	import cn.sftech.www.object.Blood;
	import cn.sftech.www.object.Bullet;
	import cn.sftech.www.object.BulletBase;
	import cn.sftech.www.object.Coin;
	import cn.sftech.www.object.Nimbus;
	import cn.sftech.www.util.DataManager;
	import cn.sftech.www.util.MathUtil;
	import cn.sftech.www.util.NumberImage;
	
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	public class GamePane extends SFMovieClip
	{
		//------------界面部分--------------------------
		/**
		 * 卷轴面板
		 */		
		private var reel : SFContainer;
		/**
		 * 鸟
		 */		
		private var bird : Bird;
		/**
		 * 保护罩
		 */		
		private var nimbus : Nimbus;
		/**
		 * 分数条
		 */		
		private var scoreBar : ScoreBar;
		/**
		 * 血量
		 */		
		private var blood : Blood;
		/**
		 * 菜单按钮
		 */		
		private var menuBtn : MenuBtn;
		/**
		 * 愤怒按钮
		 */		
		private var angry : Angry;
		/**
		 * 分数数字面板
		 */		
		private var scoreNum : SFContainer;
		///////////////////////////////////////////////////////////////////
		/**
		 * 当前关卡数据
		 */		
		private var currentLvArr : Vector.<Object>;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		/**
		 * 当前关子剩余子弹数
		 */		
		private var _currentBulletCount : uint = 0;
		/**
		 * 子弹方向
		 */		
		private var _currentBatchQuadrant : uint = 0;
		/**
		 * 当前批次的颜色
		 */		
		private var _currentBatchColor : uint = 0;
		/**
		 * 当前批次速度
		 */		
		private var _currentBatchVelocity : uint = 0;
		/**
		 * 当前批次与上一批间隔创建时间（单位：毫秒）
		 */		
		private var _currentBatchTimer : uint = 0;
		/**
		 * 当前批次类型
		 */		
		private var _currentBatchType : Class;
		
		/**
		 * 出现钱币锁
		 */		
		private var coinLock : Boolean = false;
		
		/**
		 * 第一创建的颜色
		 */		
		private var _lastBatchColor : uint = 0;
		/**
		 * 超级状态计时器
		 */		
		private var superTimer : Timer = new Timer(200,1);
		
		///////////////////////////////////////////////////////////////////////
		
		/**
		 * 当前血量
		 */		
		private var _currentBlood : int = 0;
		/**
		 * 当前全局速度
		 */		
		private var _currentVelocity : uint = 1;
		
		private var _currentNimbusAngle : int = 180;
		
		/**
		 * 当前界面上剩余未销毁子弹数
		 */
		private var _bulletCount : int = 0;
		// 标记鼠标是否按下
		private var mouseDownFlag : Boolean = false;
		// 游戏失败鸟的掉到屏幕下的效果
		private var birdEffect : SFEffectBase = new SFEffectBase();
		
		public function GamePane()
		{
			super();
		}
		
		public function init() : void
		{
			initUI();
			
			bird = new Bird();
			bird.x = 400;
			bird.y = 240;
			bird.color = MathUtil.random(1,4);
			addChild(bird);
			
			nimbus = new Nimbus();
//			nimbus.color = bird.color;
//			nimbus.x = this.width/2;
//			nimbus.y = this.height/2;
			bird.nimbus = nimbus;
			
			blood = new Blood();
			blood.x = 20;
			blood.y = 435;
			blood.color = bird.color;
			blood.addEventListener(MouseEvent.CLICK,changeColorHandle);
			addChild(blood);
			
			scoreBar = new ScoreBar();
			scoreBar.x = 570;
			scoreBar.y = 8;
			addChild(scoreBar);
			scoreNum = new SFContainer();
			scoreNum.backgroundAlpha = 0;
			scoreNum.width = 100;
			scoreNum.height = 20;
			scoreNum.x = 90;
			scoreNum.y = 15;
			scoreBar.addChild(scoreNum);
			
			menuBtn = new MenuBtn();
			menuBtn.x = 725;
			menuBtn.y = 405;
			addChild(menuBtn);
			
			angry = new Angry();
			angry.value = 0;
			angry.x = 400;
			angry.y = 440;
			angry.addEventListener(MouseEvent.CLICK,makeSuperBird);
			addChild(angry);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownNimbusHandle);
			
			initData();
			
			this.dispatchEvent(new GameSuccessEvent());
		}
		
		private function initData() : void
		{
			blood.blood = GameConfig.TOTAL_BLOOD;
			currentScore = 0;
			_model.currentLv = 1;
			_currentBatchQuadrant = MathUtil.random(1,5);
			_currentBatchColor = bird.color;
		}
		
		private function initUI() : void
		{
			reel = new SFContainer();
			addChild(reel);
			var background : GamePaneBackground = new GamePaneBackground();
			reel.addChild(background);
			
			var reel2 : SFMovieClip = new SFMovieClip();
			reel.addChild(reel2);
			
			var cloud2_1 : Cloud2 = new Cloud2();
			var cloud2_2 : Cloud2 = new Cloud2();
			cloud2_2.y = -cloud2_2.height;
			reel2.addChild(cloud2_1);
			reel2.addChild(cloud2_2);
			
//			cloud2_1.addEventListener(Event.ENTER_FRAME,could2EnterFrameHandle);
//			cloud2_2.addEventListener(Event.ENTER_FRAME,could2EnterFrameHandle);
			
			var reel1 : SFMovieClip = new SFMovieClip();
			reel.addChild(reel1);
			
			var cloud1_1 : Cloud1 = new Cloud1();
			var cloud1_2 : Cloud1 = new Cloud1();
			cloud1_2.y = -cloud1_2.height;
			reel1.addChild(cloud1_1);
			reel1.addChild(cloud1_2);
			
//			cloud1_1.addEventListener(Event.ENTER_FRAME,could1EnterFrameHandle);
//			cloud1_2.addEventListener(Event.ENTER_FRAME,could1EnterFrameHandle);
			
		}
		
		private function could2EnterFrameHandle(event : Event) : void
		{
			event.currentTarget.y ++;
			if(event.currentTarget.y == GameConfig.GAMEPANE_HEIGHT) {
				event.currentTarget.y = -GameConfig.GAMEPANE_HEIGHT;
			}
		}
		
		private function could1EnterFrameHandle(event : Event) : void
		{
			event.currentTarget.y ++;
			if(event.currentTarget.y == GameConfig.GAMEPANE_HEIGHT) {
				event.currentTarget.y = -GameConfig.GAMEPANE_HEIGHT;
			}
		}
		
		public function initLv() : void
		{
			var levelData : LevelData = new LevelData();
			
			if(_model.currentLv == GameConfig.SECTOR_LV_LINE) {
				nimbus.sector = 45;
			}
			
			if(levelData.lvData.length == _model.currentLv-1) {
				currentLvArr = null;
			} else {
				currentLvArr = Vector.<Object>(levelData.lvData[_model.currentLv-1]);
			}
			
			createBatch();
			if(!coinLock) {
				createCoin();
				coinLock = true;
			}
		}
		
		public function restartGame() : void
		{
			initData();
			blood.blood = GameConfig.TOTAL_BLOOD;
			
			birdEffect.target = bird;
			birdEffect.duration = 1;
			birdEffect.vars = new TweenLiteVars();
			birdEffect.vars.prop("y",240);
			birdEffect.vars.prop("rotation",0);
			birdEffect.vars.ease(Expo.easeIn);
			birdEffect.vars.onComplete(
				function createBirdHandle() : void
				{
					initLv();
				});
			birdEffect.play();
			
			
		}
		
		private function set currentScore(value : uint) : void
		{
			_model.currentScore = value
			while(scoreNum.numChildren>0) {
				scoreNum.removeChildAt(0);
			}
			
			var numImage : NumberImage = new NumberImage();
			numImage.charWidth = numImage.charHeight = 20;
			numImage.imageData = ScoreNumber;
			var scoreImage : Bitmap = numImage.getNumberImage(value);
			scoreImage.x = (scoreNum.width - scoreImage.width)/2;
			scoreNum.addChild(scoreImage);
		}
		private function get currentScore() : uint
		{
			return _model.currentScore;
		}
		
		private function set currentBlood(value : int) : void
		{
			_currentBlood = value;
			if(value == 0) {
				gameOver();
			}
		}
		
		private function get currentBlood() : int
		{
			return _currentBlood;
		}
		
		private function set bulletCount(value : int) : void
		{
			trace(value);
			_bulletCount = value;
			if(value == 0) {
				if(currentLvArr.length == 0) {
					successLv();
				}
			}
		}
		
		private function get bulletCount() : int
		{
			return _bulletCount;
		}
		
		private function gameOver() : void
		{
			coinLock = false;
			
			this.dispatchEvent(new GameOverEvent());
			
			birdEffect.target = bird;
			birdEffect.duration = 1;
			birdEffect.vars = new TweenLiteVars();
			birdEffect.vars.prop("y",this.height + 100);
			birdEffect.vars.prop("rotation",MathUtil.random(30,50));
			birdEffect.vars.ease(Expo.easeIn);
			birdEffect.play();
			
			var dataManager : DataManager = new DataManager();
			dataManager.saveScore();
			
			trace("gameOver");
		}
		
		private function successLv() : void
		{
			_model.currentLv ++;
			this.dispatchEvent(new GameSuccessEvent());
		}
		
		private function createBatch() : void
		{
			if(currentLvArr == null) {
//				_currentBatchType = Bullet;
//				_currentBulletCount = MathUtil.random(1,5);
//				_currentBatchVelocity = MathUtil.random(2,4);
//				_currentBatchColor = MathUtil.random(0,3);
//				_currentBatchQuadrant = MathUtil.random(1,5);
			} else {
				var currentBatch : Object = currentLvArr[0];
				
				_currentBulletCount = currentBatch.bulletCount;
				_currentBatchVelocity = currentBatch.bulletVelocity;
				_currentBatchTimer = currentBatch.batchTimer;
				_currentBatchQuadrant = LevelData.getQuadrantByLast(_currentBatchQuadrant,currentBatch.bulletQuadrant);
				
				if(currentBatch.bulletColorType == 3) { //类型为钱币
					_currentBatchType = Coin;
				} else {
					_currentBatchType = Bullet;
					if(currentBatch.bulletColorType == 4) {
						_currentBatchColor = MathUtil.random(1,4);
					} else {
						_currentBatchColor = LevelData.getColorByLast(_currentBatchColor,currentBatch.bulletColorType);
					}
					trace(_currentBatchColor  + " currentColor ");
				}
				
			}
			
			createBullet();
		}
		
		private function createBullet() : void
		{
			//临时标记正负
			var tempFlag : uint = MathUtil.random(0,2);
			
			var bullet : BulletBase = new _currentBatchType();
			
			//设置坐标位置
			switch(_currentBatchQuadrant) {
				case 1:{ //第一象限
					trace("第一象限");
					bullet.x = GameConfig.GAMEPANE_WIDTH + bullet.width;
					bullet.y = MathUtil.random(-GameConfig.GAMECENTER_Y,GameConfig.GAMECENTER_Y);
				};break;
				case 2:{ //第二象限
					trace("第二象限");
					bullet.x = GameConfig.GAMEPANE_WIDTH + bullet.width;
					bullet.y = MathUtil.random(GameConfig.GAMECENTER_Y,GameConfig.GAMEPANE_HEIGHT + GameConfig.GAMECENTER_Y);
				};break;
				case 3:{ //第三象限
					trace("第三象限");
					bullet.x = -bullet.width;
					bullet.y = MathUtil.random(GameConfig.GAMECENTER_Y,GameConfig.GAMEPANE_HEIGHT + GameConfig.GAMECENTER_Y);
				};break;
				case 4:{ //第四象限
					trace("第四象限");
					bullet.x = -bullet.width;
					bullet.y = MathUtil.random(-GameConfig.GAMECENTER_Y,GameConfig.GAMECENTER_Y);
				};break;
			} 
			//设置颜色
			if(bullet is Bullet) {
				(bullet as Bullet).color = _currentBatchColor;
			}
			bullet.ctanValue = (bird.y - bullet.y)/(bird.x - bullet.x);
			bullet.angle = getAngle(bullet.x,bullet.y);
			bullet.velocity = _currentBatchVelocity;
			bullet.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killBullet);
			bullet.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			addChild(bullet);

			bulletCount ++;
			_currentBulletCount --;
			
			if(_currentBulletCount == 0) {
				if(currentLvArr) {
					currentLvArr.splice(0,1);
				}
				if(currentLvArr.length == 0) {
					return;
				} else {
					setTimeout(createBatch,_currentBatchTimer);
				}
			} else {
				setTimeout(createBullet,GameConfig.BULLET_TIMER);
			}
		}
		
		private function createCoin() : void
		{
			//临时标记正负
			var tempFlag : uint = MathUtil.random(0,2);
			var coin : Coin = new Coin();
			if(tempFlag == 0) {
				coin.x = -coin.width;
			} else {
				coin.x = this.width + coin.width;
			}
			coin.y = MathUtil.random(0,this.height);
			coin.ctanValue = (GameConfig.GAMECENTER_Y - coin.y)/(GameConfig.GAMECENTER_X - coin.x);
			coin.angle = getAngle(coin.x,coin.y);
			coin.velocity = MathUtil.random(1,3);
			coin.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killCoin);
			coin.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			addChild(coin);
			setTimeout(createCoin,MathUtil.random(6,10)*1000);
		}
		
		private function getAngle(valueX : Number,valueY : Number) : Number
		{
			var tempX : Number = valueX - 400;
			var tempY : Number = 240 - valueY;
			var angle : Number = Math.atan(tempX/tempY)*180/Math.PI;
			if(tempX >= 0) { //在第一 或第二象限，取正角度
				if(angle >= 0) {
					angle;
				} else {
					angle = 180 + angle;
				}
			} else { //在 第三 或第四象限 ，取负角度
				if(angle >= 0) {
					angle = angle - 180;
				} else {
					angle;
				}
			}
			return angle;
		}
		
		//-----------------mouse event ---------------------
		private function mouseDownNimbusHandle(event : MouseEvent) : void
		{
			if(bird.body.hitTestPoint(this.mouseX,this.mouseY,true)) {
				mouseDownFlag = true;
			} else if(blood.hitTestPoint(this.mouseX,this.mouseY)) {
				mouseDownFlag = true;
			}
			
			this.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveNimbusHandle);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpNimbusHandle);
		}
		
		private function mouseMoveNimbusHandle(event : MouseEvent) : void
		{
			if(Point.distance(new Point(this.mouseX,this.mouseY),new Point(GameConfig.GAMECENTER_X,GameConfig.GAMECENTER_Y))>90
				&& !blood.hitTestPoint(this.mouseX,this.mouseY)) {
				_currentNimbusAngle = getAngle(this.mouseX,this.mouseY);
//				_currentNimbusAngle += _currentNimbusAngle>0?-180:180;
				nimbus.rotation = _currentNimbusAngle;
			}
		}
		
		private function mouseUpNimbusHandle(event : MouseEvent) : void
		{
			if(mouseDownFlag) {
				changeColorHandle();
				mouseDownFlag = false;
			}
			this.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveNimbusHandle);
		}
		/**
		 * 变换颜色的操作
		 * 
		 */		
		private function changeColorHandle(event : MouseEvent = null) : void
		{
			var color : uint = bird.color;
			if(color == 3) {
				color = 1;
			} else {
				color ++;
			}
			nimbus.color = blood.color = bird.color = color;
		}
		
		private var temp : uint = 0;
		private function makeSuperBird(event : MouseEvent) : void
		{
			temp ++;
			if(temp == 2) {
				trace(2);
			}
			bird.makeSuper();
			if(!superTimer.hasEventListener(TimerEvent.TIMER_COMPLETE)) {
				superTimer.addEventListener(TimerEvent.TIMER_COMPLETE,
					function timerHandle(event : TimerEvent) : void
					{
						superTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerHandle);
						superTimer.stop();
						bird.recoverNormal();
					});
				superTimer.start();
			}
		}
			
		
		private function bulletEnterFrameHandle(event : Event) : void
		{
			var bullet : BulletBase = event.target as BulletBase;
//			trace(bullet.moveX + "    " + bullet.moveY);
			bullet.x += bullet.moveX*bullet.velocity;
			bullet.y += bullet.moveY*bullet.velocity;
			
			if(bullet.hitTestObject(bird.body)) {
				if(bullet is Coin) {
					currentScore += GameConfig.COIN_SCORE;
				} else {
					bird.hurt();
					blood.blood--;
				}
				bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
				bullet.killMyself();
			} else if(Point.distance(new Point(bullet.x ,bullet.y),new Point(bird.x,bird.y))<115) {
//				trace(getAngle(bullet.x,bullet.y));
				if(getAngle(bullet.x,bullet.y) > _currentNimbusAngle - nimbus.sector/2 - 10 &&
					getAngle(bullet.x,bullet.y) < _currentNimbusAngle + nimbus.sector/2 + 10) {
					if(bullet is Coin) {
						bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
						bullet.killMyself();
					} else {
						var _bullet : Bullet = bullet as Bullet;
						if(_bullet.color == nimbus.color) {
							currentScore += GameConfig.BULLET_SCORE;
							bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
							bullet.killMyself();
							
							angry.value ++;
						}
					}
				} 
			}
			
			var canDel : Boolean = false;
			if(bullet.quadrant == 1 || bullet.quadrant == 2) {
				if(bullet.x < -100) {
					canDel = true;
				}
			} else {
				if(bullet.x > this.width + 100) {
					canDel = true;
				}
			}
			
			if(canDel) {
				bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
				removeChild(bullet);
				bullet = null;
			}
			
		}
		
		private function killBullet(event : KillBulletEvent) : void
		{
			var bullet : BulletBase = event.target as BulletBase;
			bulletCount --;
			killBulletBase(bullet);
		}
		private function killCoin(event : KillBulletEvent) : void
		{
			var bullet : BulletBase = event.target as BulletBase;
			killBulletBase(bullet);
		}
		
		private function killBulletBase(bullet : BulletBase) : void
		{
			removeChild(bullet);
			bullet = null;
			
			System.gc();
		}
		
	}
}