package b2_ludus
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	/**
	 * @author Ludus Team
	 */
	public class b2_bullet
	{
		public function createBullet(world:b2World,
									 xpos:Number,
									 ypos:Number,
									 radius:Number,
									 isDynamic:Boolean,
									 isBullet:Boolean,
									 isSensor:Boolean,
									 density:Number,
									 friction:Number,
									 restitution:Number):b2Body
		{
			//body definition
			var body_def:b2BodyDef = new b2BodyDef();
			body_def.position.Set(xpos, ypos);
			
			if(isDynamic){
				body_def.type = b2Body.b2_dynamicBody;
			}else{
				body_def.type = b2Body.b2_staticBody;
			}
				
			//body shape
			var body_shape:b2CircleShape = new b2CircleShape();
			
			//body fixture definition
			var body_fix:b2FixtureDef = new b2FixtureDef();
			body_fix.shape = body_shape;
			body_fix.density = density;
			body_fix.friction = friction;
			body_fix.restitution = restitution;
			if(isSensor){
				body_fix.isSensor = true;
			}
			
			//body
			var body:b2Body = world.CreateBody(body_def);
			body.CreateFixture(body_fix);
			body.SetUserData("bullet");
			if(isBullet){
				body.IsBullet();
			}
			return body;
		}
	}
}