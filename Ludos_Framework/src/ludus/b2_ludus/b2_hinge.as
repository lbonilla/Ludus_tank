package ludus.b2_ludus
{
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.Joints.b2RevoluteJoint;
	import ludus.Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	
	public class b2_hinge
	{
		public function createHinge(world:b2World, bA:b2Body, bB:b2Body, pos:b2Vec2):void{
			var join_def:b2RevoluteJointDef = new b2RevoluteJointDef();
			join_def.Initialize(bA, bB, pos);
			world.CreateJoint(join_def);
		}
	}
}