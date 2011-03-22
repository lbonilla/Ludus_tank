package ludus.b2_ludus.Indicators
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Common.b2internal;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	import ludus.b2_ludus.b2_healthbar;
	
	public class Healthbar extends Indicator
	{		
		private var healthbar: b2_healthbar;
		
		public function Healthbar(pactor:IActor)
		{
			super( pactor, pactor.body);
			healthbar = new b2_healthbar();
			pactor.body.addChild(healthbar);
			healthbar.x = this.actor.body.x - 30;
			healthbar.y = this.actor.body.y - 25;
			healthbar.update(actor.life);
		}
		
		public override function reduceLife(pcantToReduce:Number){
			super.reduceLife(pcantToReduce);
			healthbar.update(actor.life);
		}
	}
}