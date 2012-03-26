package cn.sftech.www.view
{
	import cn.sftech.www.effect.SFMoveEffect;
	import cn.sftech.www.effect.base.SFEffectBase;
	import cn.sftech.www.event.ChangePageEvent;
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
	import flash.media.SoundTransform;
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
		 * 暂停页
		 */		
		private var pausingPage : PausingPage;
		/**
		 * 遮罩在游戏场景上
		 */		
		private var gamePanel : SFContainer;
		/**
		 * 菜单按钮
		 */		
		private var menuBtn : Menu;
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
		/**
		 * 超级状态下剩余的关卡数据
		 */		
		private var superStatusLvArr : Vector.<Object>;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		/**
		 * 当前关子剩余子弹数
		 */		
		private var _currentBulletCount : int = 0;
		/**
		 * 当前子弹数组
		 */		
		private var _currentBulletArr : Vector.<BulletBase>;
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
		 * 出现子弹锁
		 */		
		private var bulletLock : Boolean = false;
		
		/**
		 * 第一创建的颜色
		 */		
		private var _lastBatchColor : uint = 0;
		/**
		 * 超级状态计时器
		 */		
		private var superTimer : Timer = new Timer(200,1);
		/**
		 * 是否以结束
		 */		
		private var isGameOver : Boolean = false;
		/**
		 * 当前是否在暂停状态
		 */		
		private var isPauseing : Boolean = false;
		
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
		 * 当前是否是疯狂状态
		 */		
		private var _isSuperStatus : Boolean = false;
		
		/**
		 * 当前界面上剩余未销毁子弹数
		 */
		private var _bulletCount : int = 0;
		/**
		 * 创建计时器
		 */		
//		private var _createTimer : Timer;
		
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
			
			gamePanel = new SFContainer();
			gamePanel.width = GameConfig.GAMEPANE_WIDTH;
			gamePanel.height = GameConfig.GAMEPANE_HEIGHT;
			gamePanel.backgroundAlpha = 0;
			addChild(gamePanel);
			
			bird = new Bird();
			bird.x = 400;
			bird.y = 240;
			bird.color = MathUtil.random(1,4);
			gamePanel.addChild(bird);
			
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
			
			angry = new Angry();
			angry.value = 0;
			angry.x = 400;
			angry.y = 440;
			angry.addEventListener(MouseEvent.CLICK,makeSuperBird);
			addChild(angry);
			
			pausingPage = new PausingPage();
			pausingPage.visible = false;
			addChild(pausingPage);
			
			menuBtn = new Menu();
			menuBtn.x = 725;
			menuBtn.y = 405;
			menuBtn.menuBtn.addEventListener(MouseEvent.CLICK,showMenuHandle);
			addChild(menuBtn);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownNimbusHandle);
			
			initData();
			
			this.dispatchEvent(new GameSuccessEvent());
		}
		
		private function initData() : void
		{
			isGameOver = false;
			_currentBulletCount = 0;
			_currentBulletArr = new Vector.<BulletBase>();
			bulletLock = false;
			blood.blood = GameConfig.TOTAL_BLOOD;
			currentScore = 0;
			_bulletCount = 0;
			angry.value = 0;
			_model.currentLv = 1;
			birdEffect.stop();
			_currentBatchQuadrant = MathUtil.random(1,5);
			_currentBatchColor = bird.color;
			_currentVelocity = 1;
		}
		
		private function initUI() : void
		{
			reel = new SFContainer();
			addChild(reel);
			var background : GamePaneBackground = new GamePaneBackground();
			reel.addChild(background);
			
//			var reel2 : SFMovieClip = new SFMovieClip();
//			reel.addChild(reel2);
			
//			var cloud2_1 : Cloud2 = new Cloud2();
//			var cloud2_2 : Cloud2 = new Cloud2();
//			cloud2_2.y = -cloud2_2.height;
//			reel2.addChild(cloud2_1);
//			reel2.addChild(cloud2_2);
			
//			cloud2_1.addEventListener(Event.ENTER_FRAME,could2EnterFrameHandle);
//			cloud2_2.addEventListener(Event.ENTER_FRAME,could2EnterFrameHandle);
			
//			var reel1 : SFMovieClip = new SFMovieClip();
//			reel.addChild(reel1);
//			
//			var cloud1_1 : Cloud1 = new Cloud1();
//			var cloud1_2 : Cloud1 = new Cloud1();
//			cloud1_2.y = -cloud1_2.height;
//			reel1.addChild(cloud1_1);
//			reel1.addChild(cloud1_2);
			
//			cloud1_1.addEventListener(Event.ENTER_FRAME,could1EnterFrameHandle);
//			cloud1_2.addEventListener(Event.ENTER_FRAME,could1EnterFrameHandle);
			
		}
		
//		private function could2EnterFrameHandle(event : Event) : void
//		{
//			event.currentTarget.y ++;
//			if(event.currentTarget.y == GameConfig.GAMEPANE_HEIGHT) {
//				event.currentTarget.y = -GameConfig.GAMEPANE_HEIGHT;
//			}
//		}
//		
//		private function could1EnterFrameHandle(event : Event) : void
//		{
//			event.currentTarget.y ++;
//			if(event.currentTarget.y == GameConfig.GAMEPANE_HEIGHT) {
//				event.currentTarget.y = -GameConfig.GAMEPANE_HEIGHT;
//			}
//		}
		
		public function initLv() : void
		{
			var levelData : LevelData = new LevelData();
			
			if(_model.currentLv-1 < levelData.lvData.length) {
				currentLvArr = Vector.<Object>(levelData.lvData[_model.currentLv-1]);
			} else if(_model.currentLv-1 < levelData.lvData.length*2) {
				nimbus.sector = 45;
				currentLvArr = Vector.<Object>(levelData.lvData[(_model.currentLv-1)%levelData.lvData.length]);
			} else {
				currentLvArr = Vector.<Object>(levelData.lvData[MathUtil.random(levelData.lvData.length-6,levelData.lvData.length-1)]);
			}
			
			createBatch();
			if(!coinLock) {
				createCoin();
				coinLock = true;
			}
		}
		
		public function restartGame() : void
		{
			clearAllBulletBase();
			initData();
			
			bird.y = 240;
			bird.rotation = 0;
			initLv();
			
//			birdEffect.target = bird;
//			birdEffect.duration = 1;
//			birdEffect.vars = new TweenLiteVars();
//			birdEffect.vars.prop("y",240);
//			birdEffect.vars.prop("rotation",0);
//			birdEffect.vars.ease(Expo.easeIn);
//			birdEffect.vars.onComplete(
//				function createBirdHandle() : void
//				{
//					initLv();
//				});
//			birdEffect.play();
			
		}
		
		private function set currentScore(value : uint) : void
		{
			if(isGameOver) return;
			
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
		}
		
		private function get currentBlood() : int
		{
			return _currentBlood;
		}
		
		private function set bulletCount(value : int) : void
		{
			_bulletCount = value;
			checkSuccess();
		}
		
		private function get bulletCount() : int
		{
			return _bulletCount;
		}
		
		private function gameOver() : void
		{
			isGameOver = true;
			coinLock = false;
			angry.value = 0;
//			_createTimer.stop();
//			_createTimer = null;
			
			ModelLocator.playAudioSound(new DeadBirdSound());
			
			this.dispatchEvent(new GameOverEvent());
			
			birdEffect.target = bird;
			birdEffect.duration = 1;
			birdEffect.vars = new TweenLiteVars();
			birdEffect.vars.prop("y",this.height + 100);
			birdEffect.vars.prop("rotation",MathUtil.random(30,50));
			birdEffect.vars.ease(Expo.easeIn);
			birdEffect.vars.onComplete(function effectComplete() : void
			{
				_currentVelocity = 10;
			});
			birdEffect.play();
			
			var dataManager : DataManager = new DataManager();
			dataManager.saveScore();
			
		}
		
		private function checkSuccess() : void
		{
			if(bulletCount == 0) {
				if(currentLvArr.length == 0) {
					if(superStatusLvArr) {
						recoverNoramlBird();
					} else {
						successLv();
					}
				}
			}
		}
		
		private function successLv() : void
		{
			_model.currentLv ++;
			this.dispatchEvent(new GameSuccessEvent());
		}
		
		private function createBatch() : void
		{
			if(!bulletLock) {
				bulletLock = true;
			
				if(currentLvArr != null) {
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
					}
					
				}
				
				createBullet();
			}
		}
		
		private function createBullet() : void
		{
			//如果游戏结束，直接返回
			if(isGameOver) return;
			
			if(!isPauseing) {
				//临时标记正负
				var tempFlag : uint = MathUtil.random(0,2);
				
				var bullet : BulletBase = new _currentBatchType();
				
				//设置坐标位置
				switch(_currentBatchQuadrant) {
					case 1:{ //第一象限
						bullet.x = GameConfig.GAMEPANE_WIDTH + bullet.width;
						bullet.y = MathUtil.random(-GameConfig.GAMECENTER_Y,GameConfig.GAMECENTER_Y);
					};break;
					case 2:{ //第二象限
						bullet.x = GameConfig.GAMEPANE_WIDTH + bullet.width;
						bullet.y = MathUtil.random(GameConfig.GAMECENTER_Y,GameConfig.GAMEPANE_HEIGHT + GameConfig.GAMECENTER_Y);
					};break;
					case 3:{ //第三象限
						bullet.x = -bullet.width;
						bullet.y = MathUtil.random(GameConfig.GAMECENTER_Y,GameConfig.GAMEPANE_HEIGHT + GameConfig.GAMECENTER_Y);
					};break;
					case 4:{ //第四象限
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
				gamePanel.addChild(bullet);
				_currentBulletArr.push(bullet);
				
				bulletCount ++;
				_currentBulletCount --;
			}
			
			if(_currentBulletCount <= 0) {
				if(currentLvArr) {
					currentLvArr.splice(0,1);
				}
				bulletLock = false;
				
				if(currentLvArr.length == 0) {
					return;
				} else {
//					_createTimer = new Timer(_currentBatchTimer,1);
//					_createTimer.addEventListener(TimerEvent.TIMER_COMPLETE,
//						function timerHandle(event : TimerEvent) : void
//						{
//							createBatch();
//						});
//					_createTimer.start();
					setTimeout(createBatch,_currentBatchTimer);
				}
			} else {
//				_createTimer = new Timer(GameConfig.BULLET_TIMER,1);
//				_createTimer.addEventListener(TimerEvent.TIMER_COMPLETE,
//					function timerHandle(event : TimerEvent) : void
//					{
//						createBullet();
//					});
//				_createTimer.start();
				setTimeout(createBullet,GameConfig.BULLET_TIMER);
			}
		}
		
		private function createCoin() : void
		{
			if(isGameOver) return;
			
			//临时标记正负
			var tempFlag : uint = MathUtil.random(0,2);
			if(!isPauseing) {
				var coin : Coin = new Coin();
				if(tempFlag == 0) {
					coin.x = -coin.width;
				} else {
					coin.x = this.width + coin.width;
				}
				coin.y = MathUtil.random(0,this.height);
				coin.ctanValue = (GameConfig.GAMECENTER_Y - coin.y)/(GameConfig.GAMECENTER_X - coin.x);
				coin.angle = getAngle(coin.x,coin.y);
				coin.velocity = MathUtil.random(2,4);
				coin.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killCoin);
				coin.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
				gamePanel.addChild(coin);
				_currentBulletArr.push(coin);
			}
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
		
		private function clearAllBulletBase() : void
		{
			while(_currentBulletArr.length>0) {
				killBulletBase(_currentBulletArr[0]);
			}
			
		}
		
		//-----------------mouse event ---------------------
		private function mouseDownNimbusHandle(event : MouseEvent) : void
		{
			if(isPauseing) return; //如果当期未暂停状态，则直接返回
			
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
			if(_isSuperStatus) return;
			
			var color : uint = bird.color;
			if(color == 3) {
				color = 1;
			} else {
				color ++;
			}
			nimbus.color = blood.color = bird.color = color;
		}
		
		private function showMenuHandle(event : MouseEvent = null) : void
		{
			if(isPauseing) {
				isPauseing = false;
				pausingPage.visible = false;
				if(_isSuperStatus) {
					_currentVelocity = 5;
				} else {
					_currentVelocity = 1;
				}
				
				menuBtn.exitGameBtn.removeEventListener(MouseEvent.CLICK,exitGame);
				menuBtn.soundBtn.removeEventListener(MouseEvent.CLICK,soundHandle);
				menuBtn.gotoAndStop(1);
				
				if(isGameOver) {
					clearAllBulletBase();
				}
			} else {
				isPauseing = true;
				pausingPage.visible = true;
				_currentVelocity = 0;
				
				menuBtn.gotoAndStop(2);
				if(_model.isMute) {
					menuBtn.soundBtn.gotoAndStop(2);
				} else {
					menuBtn.soundBtn.gotoAndStop(1);
				}
				
				menuBtn.exitGameBtn.addEventListener(MouseEvent.CLICK,exitGame);
				menuBtn.soundBtn.addEventListener(MouseEvent.CLICK,soundHandle);
			}
		}
		
		private function soundHandle(event : MouseEvent) : void
		{
			var soundTransform1 : SoundTransform = _model.audioChannel.soundTransform;
			var soundTransform2 : SoundTransform = _model.musicChannel.soundTransform;
			if(_model.isMute) {
				soundTransform1.volume = 1;
				soundTransform2.volume = 1;
				_model.isMute = false;
				menuBtn.soundBtn.gotoAndStop(1);
			} else {
				soundTransform1.volume = 0;
				soundTransform2.volume = 0;
				_model.isMute = true;
				menuBtn.soundBtn.gotoAndStop(2);
			}
			_model.audioChannel.soundTransform = soundTransform1;
			_model.musicChannel.soundTransform = soundTransform2;
		}
		
		private function makeSuperBird(event : MouseEvent) : void
		{
			if(angry.value == GameConfig.TOTAL_ANGRY && !isGameOver) {
				ModelLocator.playAudioSound(new SuperBirdSound());
				angry.value = 0;
				_isSuperStatus = true;
				
				bird.makeSuper();
				superStatusLvArr = currentLvArr;
				var levelData : LevelData = new LevelData();
				currentLvArr = Vector.<Object>(levelData.crazeData);
				_currentVelocity = 5;
				
				createBatch();
			}
		}
		
		private function recoverNoramlBird() : void
		{
			currentLvArr = superStatusLvArr;
			superStatusLvArr = null;
			_isSuperStatus = false;
			_currentVelocity = 1;
			bird.recoverNormal();
			
			if(currentLvArr.length == 0) {
				checkSuccess();
			} else {
				createBatch();
			}
		}
			
		
		private function bulletEnterFrameHandle(event : Event) : void
		{
//			if(isGameOver) return;
			var bullet : BulletBase = event.target as BulletBase;
//			trace(bullet.moveX + "    " + bullet.moveY);
			bullet.x += bullet.moveX*bullet.velocity*_currentVelocity;
			bullet.y += bullet.moveY*bullet.velocity*_currentVelocity;
			
			if(Point.distance(new Point(bullet.x ,bullet.y),new Point(bird.x,bird.y))<115) {
				if(_isSuperStatus) {
					bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
					bullet.killMyself();
					if(bullet is Coin) {
						(bullet as Coin).isGet = false;
					} else {
						currentScore += GameConfig.BULLET_SCORE;
						ModelLocator.playAudioSound(new KillBulletSound());
					}
				} else
//				trace(getAngle(bullet.x,bullet.y));
				if(bullet.hitTestObject(bird.body)) {
					if(bullet is Coin) {
						(bullet as Coin).isGet = true;
						currentScore += GameConfig.COIN_SCORE;
						ModelLocator.playAudioSound(new GetCoinSound());
					} else {
						bird.hurt();
						blood.blood--;
						ModelLocator.playAudioSound(new HurtSound());
						if(blood.blood == 0) {
							gameOver();
						}
					}
					bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
					bullet.killMyself();
				} else
				if(getAngle(bullet.x,bullet.y) > _currentNimbusAngle - nimbus.sector/2 - 10 &&
					getAngle(bullet.x,bullet.y) < _currentNimbusAngle + nimbus.sector/2 + 10) {
					if(bullet is Coin) {
						(bullet as Coin).isGet = false;
						bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
						bullet.killMyself();
					} else {
						var _bullet : Bullet = bullet as Bullet;
						if(_bullet.color == nimbus.color) {
							currentScore += GameConfig.BULLET_SCORE;
							ModelLocator.playAudioSound(new KillBulletSound());
							bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
							bullet.killMyself();
							
							//变化怒气槽
							if(angry.value != GameConfig.TOTAL_ANGRY) {
								angry.value ++;
								if(angry.value == GameConfig.TOTAL_ANGRY) {
									angry.makeAngry();
								}
							}
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
				killBulletBase(bullet);
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
			bullet.removeEventListener(KillBulletEvent.KILL_BULLET_EVENT,killBullet);
			bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			gamePanel.removeChild(bullet);
			_currentBulletArr.splice(_currentBulletArr.indexOf(bullet),1);
			bullet = null;
			
			System.gc();
		}
		
		private function exitGame(event : MouseEvent) : void
		{
			isGameOver = true;
			clearAllBulletBase();
			showMenuHandle();
			
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
	}
}