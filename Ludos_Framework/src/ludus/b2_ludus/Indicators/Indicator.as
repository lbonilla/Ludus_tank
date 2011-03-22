package ludus.b2_ludus.Indicators
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	import ludus.IDecActor;
	
	public class Indicator extends IDecActor
	{
		public function Indicator( pactor:IActor, pbody:Sprite)
		{
			super(pactor.stage, pactor, pactor.virtualWorld, pbody);
		
		}
	}
}