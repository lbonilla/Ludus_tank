package b2_ludus
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	/**
	 * @author Ludus Team
	 */
	public class b2_hinge
	{
		public function createHinge(world:b2World, bA:b2Body, bB:b2Body, pos:b2Vec2):void{
			var join_def:b2RevoluteJointDef = new b2RevoluteJointDef();
			join_def.Initialize(bA, bB, pos);
			//join_def.enableLimit = true;
			//join_def.lowerAngle = 0;
			//join_def.upperAngle = Math.PI * 2;
			world.CreateJoint(join_def);
		}
	}
}