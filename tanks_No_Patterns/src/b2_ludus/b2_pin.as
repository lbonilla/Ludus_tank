package b2_ludus
{
	/**
	 * @author Ludus Team
	 * @version 1.0
	 * @created ‎Friday, ‎February ‎04, ‎2011 08:49:00 PM
	 */
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	import Box2D.Dynamics.b2Body;

	public class b2_pin
	{
		public function createPin(world:b2_world, bA:b2Body, bB:b2Body, pos:b2Vec2):void{
			var pin_def:b2WeldJointDef = new b2WeldJointDef();
			pin_def.Initialize(bA, bB, pos);
			world.CreateJoint(pin_def);
		}
	}
}