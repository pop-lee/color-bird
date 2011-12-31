package cn.sftech.www.view
{
	import cn.sftech.www.effect.SFMoveEffect;
	import cn.sftech.www.effect.base.SFEffectBase;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.event.GameSuccessEvent;
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.model.ModelLocator;
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
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.setTimeout;

	public class GamePane extends SFMovieClip
	{
		private var bird : Bird;
		
		private var nimbus : Nimbus;
		
		private var scoreBar : ScoreBar;
		
		private var blood : Blood;
		
		private var menuBtn : MenuBtn;
		
		private var scoreNum : SFContainer;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		/**
		 * 当前关子剩余子弹数
		 */		
		private var _currentBulletCount : uint = 0;
		
		/**
		 * 当前血量
		 */		
		private var _currentBlood : int = 0;
		
		private var _currentNimbusAngle : int = 180;
		
		/**
		 * 当前界面上剩余未销毁子弹数
		 */		
		private var _bulletCount : int = 0;
		
		private var mouseDownFlag : Boolean = false;
		
		private var birdEffect : SFEffectBase = new SFEffectBase();;
		
		public function GamePane()
		{
			super();
		}
		
		public function init() : void
		{
			this.backgroundImage = GamePaneBackground;
			
			bird = new Bird();
			bird.x = this.width/2;
			bird.y = this.height/2;
			addChild(bird);
			
			nimbus = new Nimbus();
//			nimbus.x = this.width/2;
//			nimbus.y = this.height/2;
			bird.addChild(nimbus);
			
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
			
			blood = new Blood();
			blood.x = 55;
			blood.y = 425;
			blood.addEventListener(MouseEvent.CLICK,changeColorHandle);
			addChild(blood);
			
			menuBtn = new MenuBtn();
			menuBtn.x = 725;
			menuBtn.y = 405;
			addChild(menuBtn);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownNimbusHandle);
			
			currentBlood = 3;
			currentScore = 0;
			_model.currentLv = 1;
			
			this.dispatchEvent(new GameSuccessEvent());
		}
		
		public function initLv() : void
		{
			_currentBulletCount = GameConfig.BULLET_COUNT * _model.currentLv / 2;
			createBullet();
			createCoin();
		}
		
		public function restartGame() : void
		{
			_model.currentLv = 1;
			currentBlood = 3;
			currentScore = 0;
			blood.reBack();
			
			birdEffect.target = bird;
			birdEffect.duration = 1;
			birdEffect.vars = new TweenLiteVars();
			birdEffect.vars.prop("y",240);
			birdEffect.vars.prop("rotation",0);
			birdEffect.vars.ease(Expo.easeIn);
			birdEffect.play();
			
			initLv();
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
			_bulletCount = value;
			if(value == 0) {
				successLv();
			}
		}
		
		private function get bulletCount() : int
		{
			return _bulletCount;
		}
		
		private function gameOver() : void
		{
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
		
		private function createBullet() : void
		{
			if(_currentBulletCount == 0) return;
			//临时标记正负
			var tempFlag : uint = MathUtil.random(0,2);
			var bullet : Bullet = new Bullet();
			if(tempFlag == 0) {
				bullet.x = -bullet.width;
			} else {
				bullet.x = this.width + bullet.width;
			}
			bullet.y = MathUtil.random(0,this.height);
			bullet.color = MathUtil.random(0,3);
			bullet.ctanValue = (240 - bullet.y)/(400 - bullet.x);
			bullet.angle = getAngle(bullet.x,bullet.y);
			bullet.velocity = MathUtil.random(5,8);
			bullet.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killBullet);
			bullet.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			addChild(bullet);

			bulletCount ++;
			_currentBulletCount --;
			setTimeout(createBullet,GameConfig.BULLET_TIMER);
		}
		
		private function createCoin() : void
		{
			if(_currentBulletCount == 0) return;
			//临时标记正负
			var tempFlag : uint = MathUtil.random(0,2);
			var coin : Coin = new Coin();
			if(tempFlag == 0) {
				coin.x = -coin.width;
			} else {
				coin.x = this.width + coin.width;
			}
			coin.y = MathUtil.random(0,this.height);
			coin.ctanValue = (240 - coin.y)/(400 - coin.x);
			coin.angle = getAngle(coin.x,coin.y);
			coin.velocity = MathUtil.random(5,8);
			coin.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killBullet);
			coin.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			addChild(coin);
			bulletCount ++;
			setTimeout(createCoin,MathUtil.random(4,8)*1000);
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
			if(bird.hitTestPoint(this.mouseX,this.mouseY,true)) {
				mouseDownFlag = true;
			}
			this.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveNimbusHandle);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpNimbusHandle);
		}
		
		private function mouseMoveNimbusHandle(event : MouseEvent) : void
		{
			if(!bird.hitTestPoint(this.mouseX,this.mouseY,true)) {
				_currentNimbusAngle = getAngle(this.mouseX,this.mouseY);
				_currentNimbusAngle += _currentNimbusAngle>0?-180:180;
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
			if(color == 2) {
				color = 0;
			} else {
				color ++;
			}
			nimbus.color = blood.color = bird.color = color;
		}
		
		private function bulletEnterFrameHandle(event : Event) : void
		{
			var bullet : BulletBase = event.target as BulletBase;
			trace(bullet.moveX + "    " + bullet.moveY);
			bullet.x += bullet.moveX*bullet.velocity;
			bullet.y += bullet.moveY*bullet.velocity;
			
			if(bullet.hitTestObject(bird.core)) {
				if(bullet is Coin) {
					currentScore += GameConfig.COIN_SCORE;
				} else {
					bird.hurt();
					blood.hurt();
					currentBlood --;
				}
				bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
				bullet.killMyself();
			} else if(Point.distance(new Point(bullet.x ,bullet.y),new Point(bird.x,bird.y))<115) {
				trace(getAngle(bullet.x,bullet.y));
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
						}
					}
				} 
			}
			
			if(bullet.x<- 100 || bullet.x> this.width + 100 || bullet.y< 0 || bullet.y > this.height) {
				bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
				removeChild(bullet);
				bullet = null;
			}
			
		}
		
		private function killBullet(event : KillBulletEvent) : void
		{
			bulletCount --;
			var bullet : BulletBase = event.target as BulletBase;
			removeChild(bullet);
			bullet = null;
			
			System.gc();
		}
		
	}
}