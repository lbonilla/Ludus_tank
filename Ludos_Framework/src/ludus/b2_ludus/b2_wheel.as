package ludus.b2_ludus
{
	import ludus.Box2D.Collision.Shapes.b2CircleShape;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2BodyDef;
	import ludus.Box2D.Dynamics.b2FixtureDef;
	import ludus.Box2D.Dynamics.b2World;
	
	import ludus.b2_ludus.b2_hinge;
	
	public class b2_wheel
	{
		
		public function createWheel(world:b2World, 
									vehicle_body:b2Body, 
									xpos:Number, 
									ypos:Number, 
									radius:Number):b2Body
		{
			var globals:b2_globals = new b2_globals();
			//body definition
			var body_def:b2BodyDef = new b2BodyDef();
			body_def.position.Set(xpos, ypos);
			body_def.type = b2Body.b2_dynamicBody;
			//body shaoe
			var body_shape:b2CircleShape = new b2CircleShape(radius);
			//body fixture
			var body_fix:b2FixtureDef = new b2FixtureDef();
			body_fix.shape = body_shape;
			body_fix.friction = 5;
			body_fix.density = 1;
			//body
			var body:b2Body = world.CreateBody(body_def);
			body.CreateFixture(body_fix);
			//hinge / wheel axis
			var hinge:b2_hinge = new b2_hinge();
			hinge.createHinge(world, body, vehicle_body, body.GetWorldCenter());
			
			return body;
		}
	}
}