package
{
	import cn.sftech.www.effect.base.SFEffectBase;
	import cn.sftech.www.effect.viewStackEffect.SFViewStackGradientEffect;
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.util.DataManager;
	import cn.sftech.www.util.FPSViewer;
	import cn.sftech.www.view.GamePage;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFLogo;
	import cn.sftech.www.view.SFViewStack;
	
	import com.greensock.data.TweenLiteVars;
	import com.qq.openapi.MttService;
	
	import flash.events.Event;
	import flash.utils.setTimeout;

	[SWF(width="800",height="480")]
	public class main extends SFApplication
	{
		private var vs : SFViewStack;
		
		private var gamePage : GamePage;
		
		private var initLock : Boolean = false;
		
		private var logo : SFLogo;
		
		public function main()
		{
			
		}
		
		override protected function init():void
		{
			if(initLock) {
				return;
			} else {
				initLock = true;
			}
			
			logo = new SFLogo();
			logo.width = this.width;
			logo.height = this.height;
			addChild(logo);
			
			MttService.initialize(root, "D5FE393C02DB836FFDE413B8794056ED","941");
			MttService.addEventListener(MttService.ETLOGOUT, onLogout);
			
			initData();
			
		}
		
		private function initData() : void
		{
			var dataManager : DataManager = new DataManager();
			SFApplication.application.addEventListener(SFInitializeDataEvent.INITIALIZE_DATA_EVENT,initializedData);
//			dataManager.initData();
			initializedData(new SFInitializeDataEvent());
		}
		
		private function initializedData(event : SFInitializeDataEvent) : void
		{
			SFApplication.application.removeEventListener(SFInitializeDataEvent.INITIALIZE_DATA_EVENT,initializedData);
			
			initUI();
			setTimeout(hideLogo,1000);
		}
		
		private function hideLogo() : void
		{
			var effect : SFEffectBase = new SFEffectBase();
			effect.target = logo;
			effect.duration = 0.5;
			effect.vars = new TweenLiteVars();
			effect.vars.prop("alpha",0);
			effect.vars.onComplete(
				function removeLogo() :void{
					removeChild(logo);
				});
			effect.play();
		}
		
		private function onLogout(e:Event):void
		{
			MttService.login();
		}
		
		private function initUI() : void
		{
			FPSViewer.showFPS();
			
			vs = new SFViewStack();
			vs.percentWidth = this.width;
			vs.percentHeight = this.height;
			vs.backgroundColor = 0x0000ff;
			vs.backgroundAlpha = 0;
			var vsEffect : SFViewStackGradientEffect = new SFViewStackGradientEffect();
			vsEffect.duration = 0.5;
			vs.effect = vsEffect;
			addChildAt(vs,0);
			
			gamePage = new GamePage();
			vs.addItem(gamePage);
			gamePage.init();
		}
	}
}