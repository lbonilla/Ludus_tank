package b2_ludus
{
	/**
	 * @author Ludus Team
	 * @version 1.0
	 * @created ‎Friday, ‎February ‎04, ‎2011 08:49:00 PM
	 */
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2PulleyJointDef;
	import Box2D.Dynamics.b2Body;
	
	public class b2_pulleyJoint
	{
		
		public function createPulley(world:b2_world,   //world 
									 bA:b2Body,        //body A
									 bB:b2Body,        //body B
									 anchorA:b2Vec2, //body A anchor
									 anchorB:b2Vec2, //body B anchor
									 bA_length:Number, //body A maximun length
									 bB_length:Number, //body B maximun length
									 gaA:b2Vec2, //ground A anchor point
									 gaB:b2Vec2, //ground B anchor point
									 ratio:Number):void{ //ratio
			var joint_def:b2PulleyJointDef = new b2PulleyJointDef();
			joint_def.Initialize(bA, bB, gaA, gaB, anchorA, anchorB, ratio);
			joint_def.maxLengthA = bA_length;
			joint_def.maxLengthB = bB_length;
			world.CreateJoint(joint_def);
		}
	}
}