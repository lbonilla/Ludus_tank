package ludus.b2_ludus.Actors
{	
	
	//Flash imports
	
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Actor;
	import ludus.Box2D.Collision.Shapes.b2PolygonShape;
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2BodyDef;
	import ludus.Box2D.Dynamics.b2FixtureDef;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.b2_ludus.Observers.LifeObserver;

	public  class Vehicle extends Actor
	{
		//----------Atributes
		//Information 		

		//Others
		private var  _bodyInternalName:String;
		private var _xpos:Number;
		private var _ypos:Number;
		
		//Deberia ser privado 
		public function Vehicle(pstage:Stage,pvirtualWorld:b2World, pbody:Sprite,pbodyInternalName:String, px:Number, py:Number, pobserver:LifeObserver)
		{ 
			//TODO: implement function
			super(pstage,pvirtualWorld,pbody,pobserver);
			body= pbody;
			bodyInternalName = pbodyInternalName;
			xpos = px;
			ypos = py;
			
		}
		public override function buildVirtualBody(){
			
			super.buildVirtualBody();
				//body definition
			
			var body_def:b2BodyDef = new b2BodyDef();
			
			body_def.position.Set(xpos / globals.WORLD_SCALE, ypos / globals.WORLD_SCALE);
			body_def.type = b2Body.b2_dynamicBody;
			
			//vertex upper body
			var p1:b2Vec2 = new b2Vec2(-16 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE);
			var p2:b2Vec2 = new b2Vec2(-13 / globals.WORLD_SCALE, -10 / globals.WORLD_SCALE);
			var p3:b2Vec2 = new b2Vec2(13 / globals.WORLD_SCALE, -10 / globals.WORLD_SCALE);
			var p4:b2Vec2 = new b2Vec2(16 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE);
			var vertices:Array = [p1, p2, p3, p4];
			
			//upper body shape
			var upperBody_shape:b2PolygonShape = new b2PolygonShape();
			upperBody_shape.SetAsArray(vertices);
			
			//upper body fixture
			var upperBody_fix:b2FixtureDef = new b2FixtureDef();
			upperBody_fix.shape = upperBody_shape;
			upperBody_fix.density = 1;
			
			//upper body shape coordinates
			var p5:b2Vec2 = new b2Vec2(-25 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE);
			var p6:b2Vec2 = new b2Vec2(25 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE);
			var p7:b2Vec2 = new b2Vec2(25 / globals.WORLD_SCALE, 6 / globals.WORLD_SCALE);
			var p8:b2Vec2 = new b2Vec2(-25 / globals.WORLD_SCALE, 6 / globals.WORLD_SCALE);
			var vertices2:Array = [p5, p6, p7, p8];
			
			//botton body shape
			var bottonBody_shape:b2PolygonShape = new b2PolygonShape();
			bottonBody_shape.SetAsArray(vertices2);
			
			//botton body fixture
			var bottonBody_fix:b2FixtureDef = new b2FixtureDef();
			bottonBody_fix.shape = bottonBody_shape;
			bottonBody_fix.density = 1;
			
			//finish tank body
			virtualBody = virtualWorld.CreateBody(body_def);
			virtualBody.CreateFixture(upperBody_fix);
			virtualBody.CreateFixture(bottonBody_fix);
			virtualBody.SetUserData(bodyInternalName);
			 
		}
		
		public override function update_mc()
		{
			super.update_mc();
			
			body.x = virtualBody.GetPosition().x * globals.WORLD_SCALE;
			body.y = virtualBody.GetPosition().y * globals.WORLD_SCALE;
			body.rotationZ = (virtualBody.GetAngle() / (Math.PI / 180));
		}
	
		//Properties
		public function get xpos():int{return _xpos;}
		public function set xpos(value:int):void{_xpos = value;}
	
		public function get ypos():int{ return _ypos;}
		public function set ypos(value:int):void{_ypos = value;}
		
		public function get bodyInternalName():String{	return _bodyInternalName;}
		public function set bodyInternalName(value:String):void{_bodyInternalName = value;}
	}
}