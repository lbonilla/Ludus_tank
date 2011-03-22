package ludus.b2_ludus
{	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ludus.Actor;
	import ludus.Box2D.Collision.Shapes.b2PolygonShape;
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2BodyDef;
	import ludus.Box2D.Dynamics.b2FixtureDef;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.b2_ludus.Observers.LifeObserver;

	//this class is on charge of creating the tank.
	public class b2_tank extends Actor
	{
		private var world:b2_world;
		private var xpos:Number;
		private var ypos:Number;
		
		//bodies
		private var _tank:b2Body;
		private var _rightWheel:b2Body;
		private var _leftWheel:b2Body;
		
		//mcs
		private var tank_mc:Sprite;
		private var rightWheel_mc:Sprite;
		private var leftWheel_mc:Sprite;
		private var cannon_mc:Sprite;
		
		//shooting
		private var _shootRight:Boolean = false; 
		private var _shootLeft:Boolean = false;
		private var myTimer:Timer;
		
		private var bullet_ready:Boolean = true;
		private var cant_bullet_shoot:int = 0;
		private var force:b2Vec2;
		
		//Implements Sprite
		public function b2_tank(pstage:Stage,pworld:b2_world,pxpos:Number,pypos:Number ,ptank_mc:Sprite, pwheelRight:Sprite, pwheelLeft:Sprite, pcannon:Sprite){
			//super(pbodyDef,pworld);
			var messageObserver:LifeObserver = new LifeObserver();
			super(pstage,pworld,ptank_mc,messageObserver);
			tank_mc =ptank_mc;
			rightWheel_mc =  pwheelRight;
			leftWheel_mc = pwheelLeft;
			cannon_mc = pcannon;
			world = pworld;
			this.addChild(pcannon);
			this.addChild(pwheelRight);
			this.addChild(pwheelLeft);
			this.addChild(ptank_mc);
			createTank(pworld,pxpos,pypos);
		}
		
		public function createTank(world:b2_world, xpos:Number, ypos:Number):void{
			this.world = world;
			this.xpos = xpos;
			this.ypos = ypos;
			//create the tank body
			create_tankBody();
			//create the right wheel
			create_rightWheel();
			//create the left wheel
			create_leftWheel();
			//create the tracks
			create_Track();
		}
		
		//create the tank body
		private function create_tankBody():b2Body{
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
			_tank = world.CreateBody(body_def);
			_tank.CreateFixture(upperBody_fix);
			_tank.CreateFixture(bottonBody_fix);
			return _tank;
		}
		
		//create the right wheel
		private function create_rightWheel():void{
			_rightWheel = new b2_wheel().createWheel(world, tank,
													tank.GetPosition().x + (15 / globals.WORLD_SCALE), 
													tank.GetPosition().y + (20 / globals.WORLD_SCALE),
													(7.5 / globals.WORLD_SCALE));
		}
		
		//create the left wheel
		private function create_leftWheel():void{
			_leftWheel = new b2_wheel().createWheel(world, tank,
												   tank.GetPosition().x - (15 / globals.WORLD_SCALE), 
												   tank.GetPosition().y + (20 / globals.WORLD_SCALE),
												   (7.5 / globals.WORLD_SCALE));
		}
		
		//create the ta
		private function create_Track():void{
			var tracks:b2_tracks = new b2_tracks(world, tank, 5,  1.5, 25, 16, 1, 2, 0);
		}
		
	
		//rotate the tanks cannon
		public function rotateCannon_Left():void{
			if(cannon_mc.rotation >= -70){
				cannon_mc.rotationZ --;
				if(cannon_mc.rotation > -70 && cannon_mc.rotation <= 0){
					_shootLeft = true;
					_shootRight = false;
				}
			}
		}
		
		public function rotateCannon_Right():void{
			if(cannon_mc.rotation <= 70){
				cannon_mc.rotationZ ++;
				if(cannon_mc.rotation < 70 && cannon_mc.rotation > 0){
					_shootLeft = false;
					_shootRight = true;
				}
			}
		}
		
		//shooting bullet
		public function getCannonAngle():Number{
			return cannon_mc.rotation;
		}
		
		public function shoot():void{
			if(shootRight && bullet_ready){
				//add commnad to shoot cannon right
				if(cant_bullet_shoot < 1){
					force = new b2Vec2(0, -2.5);
					rightWheel.ApplyImpulse(force, rightWheel.GetWorldCenter());
					
					//get the correct pos to shoot the bullet
					//bodyDef.position.Set((bazooka.x+(bazooka.width+3)*Math.cos(bazooka_angle))/pixels_in_a_meter, (bazooka.y+(bazooka.width+3)*Math.sin(bazooka_angle))/pixels_in_a_meter);
					//tank.getShootingPos().x * Math.cos(tank.getCannonAngle()) / globals.WORLD_SCALE,
					//tank.getShootingPos().y * Math.cos(tank.getCannonAngle()) / globals.WORLD_SCALE
					//var bullet:b2Body = new b2_circle().createCircle(world, tank.getShootingPos().x * Math.cos(tank.getAngleRadians()) / globals.WORLD_SCALE, tank.getShootingPos().y * Math.cos(tank.getAngleRadians()) / globals.WORLD_SCALE, 5 / globals.WORLD_SCALE, true, 1, 0, 0);
					var bullet:b2Body = new b2_circle().createCircle(world,getShootingPos().x / globals.WORLD_SCALE, getShootingPos().y / globals.WORLD_SCALE, 5 / globals.WORLD_SCALE, true, 1, 0, 0);
					bullet.ApplyImpulse(new b2Vec2(0.35, -0.75), bullet.GetWorldCenter());
					cant_bullet_shoot++;
					time();
				}
				
				// resetting the power
			}else if(shootLeft && bullet_ready){
				//add command to shoot cannon left
				if(cant_bullet_shoot < 1){
					force = new b2Vec2(0, -2.5);
					leftWheel.ApplyImpulse(force,leftWheel.GetWorldCenter());
					
					var bullet:b2Body = new b2_circle().createCircle(world,getShootingPos().x / globals.WORLD_SCALE, getShootingPos().y / globals.WORLD_SCALE, 5 / globals.WORLD_SCALE, true, 1, 0, 0);
					bullet.ApplyImpulse(new b2Vec2(-0.35, -0.75), bullet.GetWorldCenter());
					cant_bullet_shoot++;
					time();
				}
			}
		}
		private function time():void{
			myTimer = new Timer(1000, 5);
			myTimer.addEventListener(TimerEvent.TIMER, timerListener);
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerDone);
			myTimer.start();
		}
		
		private function timerListener (e:TimerEvent):void{
			bullet_ready = false;
		}
		
		private function timerDone(e:TimerEvent):void{
			myTimer.stop();
			bullet_ready = true;
			cant_bullet_shoot = 0;
		}
		public function getShootingPos():b2Vec2{
			var shooting_Pos:b2Vec2 = new b2Vec2(cannon_mc.x + 30, cannon_mc.y - 30 );
			return shooting_Pos;
		}
		
		public function getAngleRadians():Number{
			var radiasAngle:Number = getCannonAngle() / (180 / Math.PI);
			return radiasAngle;
		}
		
		//Overrides Functions Actor
		
		public override function attack(){
			shoot();
		}
		
		public override function moveDown(){
			rotateCannon_Right();
		}
		public override function moveUp(){
			rotateCannon_Left();
		}
		public override function moveLeft(){
			leftWheel.ApplyTorque(-2);
			rightWheel.ApplyTorque(-2);
		}

		public override function moveRight(){
			leftWheel.ApplyTorque(2);
			rightWheel.ApplyTorque(2);
		}
		//update the tank, cannon and wheels movies clips
		public override  function update_mc(){
			tank_mc.x = tank.GetPosition().x * globals.WORLD_SCALE;
			tank_mc.y = tank.GetPosition().y * globals.WORLD_SCALE;
			tank_mc.rotationZ = (tank.GetAngle() / (Math.PI / 180));
			rightWheel_mc.x = rightWheel.GetPosition().x * globals.WORLD_SCALE;
			rightWheel_mc.y = rightWheel.GetPosition().y * globals.WORLD_SCALE;
			rightWheel_mc.rotationZ = (rightWheel.GetAngle() / (Math.PI / 180));
			leftWheel_mc.x = leftWheel.GetPosition().x * globals.WORLD_SCALE;
			leftWheel_mc.y = leftWheel.GetPosition().y * globals.WORLD_SCALE;
			leftWheel_mc.rotationZ = (leftWheel.GetAngle() / (Math.PI / 180));
			cannon_mc.x = tank_mc.x;
			cannon_mc.y = tank_mc.y + 5;
		}
		
		//getters
		public function get tank():b2Body{return _tank;}
		public function get rightWheel():b2Body{return _rightWheel;}
		public function get leftWheel():b2Body{return _leftWheel;}
		public function get shootRight(){return _shootRight;}
		public function get shootLeft():Boolean{return _shootLeft;}


	}
}