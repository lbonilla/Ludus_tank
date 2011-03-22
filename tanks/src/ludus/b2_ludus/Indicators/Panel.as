package ludus.b2_ludus.Indicators 
{
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	
	public class Panel extends Indicator 
	{
		
		public function Panel((pstage:Stage, pactor:IActor, pvirtualWorld:b2World, pbody:Sprite)) 
		{
			super(pstage, pactor, pvirtualWorld, pbody);
		}
		
	}

}