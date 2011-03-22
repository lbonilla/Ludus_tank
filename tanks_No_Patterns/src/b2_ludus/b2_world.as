package b2_ludus
{	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

	public class b2_world extends b2World
	{
		public function b2_world(gravity:b2Vec2, doSleep:Boolean){
			super(gravity, doSleep);
		}
	}
}