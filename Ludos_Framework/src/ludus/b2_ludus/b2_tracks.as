package ludus.b2_ludus
{
	import ludus.Box2D.Collision.Shapes.b2PolygonShape;
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2BodyDef;
	import ludus.Box2D.Dynamics.b2FixtureDef;
	import ludus.Box2D.Dynamics.b2World;
	
	public class b2_tracks
	{
		private var xpos:Number;
		private var ypos:Number;
		private var width:Number;
		private var height:Number;
		private var radius:Number;
		private var cantTracks:Number;
		
		private var globals:b2_globals = new b2_globals();
		
		public function b2_tracks(world:b2World, 
								  tank:b2Body, 
								  width:Number, 
								  height:Number, 
								  radius:Number, 
								  cantTracks:Number, 
								  density:Number,
								  friction:Number,
								  restitution:Number,
								  track_xpos:Number,
								  track_ypos:Number)
		{

			this.width = width;
			this.height = height;
			this.radius = radius;
			this.cantTracks = cantTracks;
			
			//adjunt the track position on this two values
			//30 
			//60
			this.xpos = (tank.GetPosition().x * globals.WORLD_SCALE) + (track_xpos);
			this.ypos = (tank.GetPosition().y * globals.WORLD_SCALE) + (track_ypos);
			
			var tX:Number;
			var tY:Number;
			var angle:Number;
			
			//body definition
			var body_def:b2BodyDef = new b2BodyDef();
			body_def.position.Set(xpos / globals.WORLD_SCALE, ypos / globals.WORLD_SCALE);
			body_def.type = b2Body.b2_dynamicBody;
			
			//body shape
			var body_shape:b2PolygonShape = new b2PolygonShape();
			body_shape.SetAsBox(width / globals.WORLD_SCALE, height / globals.WORLD_SCALE);
			
			//body fixture
			var body_fix:b2FixtureDef = new b2FixtureDef();
			body_fix.shape = body_shape;
			body_fix.density = density;
			body_fix.friction = friction;
			body_fix.restitution = restitution;

			//frist body
			var tbody:b2Body;
			var first_body:b2Body;
			var body:b2Body;
			var anchor:b2Vec2 = new b2Vec2(0, 0);
			
			//join
			var join_def:b2RevoluteJointDef = new b2RevoluteJointDef();
			join_def.enableLimit = true;
			join_def.lowerAngle = -20 / (180 / Math.PI);
			join_def.upperAngle = 20 / (180 / Math.PI);
			
			
			for(var i:int = 0; i < cantTracks; i++){
				
				//create tracks
				angle = i / cantTracks * Math.PI * 2;
				
				//position of tracks
				tX = (xpos + Math.sin(angle) * (360 / cantTracks)) * (radius / globals.WORLD_SCALE);
				tY = (ypos + Math.cos(angle) * (360 / cantTracks)) * (radius / globals.WORLD_SCALE);
				body_def.position.Set(tX / globals.WORLD_SCALE, tY / globals.WORLD_SCALE);
				body_def.angle = -angle;
				//body_def.userData = i;
				body = world.CreateBody(body_def);
				body.CreateFixture(body_fix);
				//body.SetUserData(name);
				
				//add joins
				if(i != 0){
					anchor.x = body.GetPosition().x;
					anchor.y = body.GetPosition().y;
					join_def.Initialize(body, tbody, anchor);
					world.CreateJoint(join_def);
				}else{
					
					first_body = body;
				}
				
				tbody = body;
			}
			
			//create the first joint
			anchor.x = first_body.GetPosition().x - (3 / globals.WORLD_SCALE);
			anchor.y = first_body.GetPosition().y;
			join_def.Initialize(first_body, body, anchor);
			world.CreateJoint(join_def);
		}
	}
}