package
{
	import cn.sftech.www.effect.viewStackEffect.SFViewStackGradientEffect;
	import cn.sftech.www.view.GamePage;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFViewStack;

	[SWF(width="800",height="480")]
	public class main extends SFApplication
	{
		private var vs : SFViewStack;
		
		private var gamePage : GamePage;
		
		public function main()
		{
			
		}
		
		override protected function init():void
		{
			initUI();
		}
		
		private function initUI() : void
		{
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