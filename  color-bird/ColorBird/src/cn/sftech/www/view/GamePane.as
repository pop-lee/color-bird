package cn.sftech.www.view
{
	import cn.sftech.www.event.KillBulletEvent;
	import cn.sftech.www.model.GameConfig;
	import cn.sftech.www.object.Bird;
	import cn.sftech.www.object.Blood;
	import cn.sftech.www.object.Bullet;
	import cn.sftech.www.object.BulletBase;
	import cn.sftech.www.object.Coin;
	import cn.sftech.www.object.Nimbus;
	import cn.sftech.www.util.MathUtil;
	import cn.sftech.www.util.NumberImage;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		/**
		 * 当前关子剩余子弹数
		 */		
		private var _currentBulletCount : uint = 0;
		/**
		 * 当前关数
		 */		
		private var _currentLv : uint = 0;
		
		/**
		 * 当前血量
		 */		
		private var _currentBlood : uint = 0;
		
		/**
		 * 当前分数
		 */		
		private var _currentScore : uint = 0;
		
		private var mouseDownFlag : Boolean = false;
		
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
			nimbus.x = this.width/2;
			nimbus.y = this.height/2;
			addChild(nimbus);
			
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
			
			_currentLv = 1;
			initLv();
		}
		
		private function initLv() : void
		{
			_currentBulletCount = GameConfig.BULLET_COUNT * _currentLv / 2;
			createBullet();
			createCoin();
		}
		
		private function set currentScore(value : uint) : void
		{
			_currentScore = value
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
			return _currentScore;
		}
		
		private function successLv() : void
		{
			
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
			bullet.ctanValue = (240 - bullet.y)/(400 - bullet.x);
			bullet.angle = getAngle(bullet.x,bullet.y);
			bullet.velocity = MathUtil.random(5,8);
			bullet.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killBullet);
			bullet.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			addChild(bullet);
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
			coin.velocity = Math.random()*10;
			coin.addEventListener(KillBulletEvent.KILL_BULLET_EVENT,killBullet);
			coin.addEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
			addChild(coin);
			setTimeout(createCoin,MathUtil.random(2,5)*1000);
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
				nimbus.rotation = getAngle(this.mouseX,this.mouseY) + 180;
			} else {
				trace("abc");
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
			
			if(bullet.hitTestObject(bird)) {
				if(bullet is Coin) {
					currentScore += GameConfig.COIN_SCORE;
				} else {
					bird.hurt();
					_currentBlood --;
				}
				bullet.removeEventListener(Event.ENTER_FRAME,bulletEnterFrameHandle);
				bullet.killMyself();
			} else if(bullet.hitTestObject(nimbus)) {
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
		
		private function killBullet(event : KillBulletEvent) : void
		{
			var bullet : BulletBase = event.target as BulletBase;
			removeChild(bullet);
			bullet = null;
			
			System.gc();
		}
		
	}
}