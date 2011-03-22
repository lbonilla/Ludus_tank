package b2_ludus
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * @author Ludus Team
	 */
	//this class is on charge of creating the tank.
	public class b2_tank extends Sprite
	{
		private var globals:b2_globals = new b2_globals();
		private var world:b2_world;
		private var xpos:Number;
		private var ypos:Number;
		private var track_xpos:Number;
      	private var track_ypos:Number;
		
		//bodies
		private var _tank:b2Body;
		private var _rightWheel:b2Body;
		private var _leftWheel:b2Body;
		private var _bullet:b2Body;
		
		//mcs
		private var _tank_mc:MovieClip;
		private var _rightWheel_mc:Sprite;
		private var _leftWheel_mc:Sprite;
		private var _bullet_mc:Sprite;
		
		//shooting variables
		private var _shootCannonRight:Boolean = true; 
		private var _shootCannonLeft:Boolean = false;
		private var bullet_ready:Boolean = true;
		private var bullet_on_stage:Boolean = false;
		private var bullet_damage:int = 25;
		private var cant_bullet_shoot:int = 0;
		
		private var myTimer:Timer;
		private var bulletforce:b2Vec2;
		private var bulletSpeed:Number = 20;
		private var charingTime:int = 5;
		private var _cant_bullet:int = 10;
		
		private var _shootRLRight:Boolean = true; 
		private var _shootRLLeft:Boolean = false;
		private var launchPos:b2Vec2 = new b2Vec2(0, 0);
		private var launchForce:b2Vec2;
		private var rocket_ready:Boolean = true;
		private var rocket_on_stage:Boolean = false;
		private var rocket_damage:int = 15;
		private var cant_rocket_shoot:int = 0;
		private var cant_rocket:int = 5;
		
		//tank information
		private var controlPanel:b2_controlPanel;
		private var healthbar:b2_healthbar;
		private var type:String;
		private var _life:int = 100;
		
		public function b2_tank(type:int = 0){
			//hit_tank = new b2_contact();

			if(type == 1){
				//red tank
				this.type = "red";
				_tank_mc = new redTank_mc();
				_rightWheel_mc = new redWheel_mc();
				_leftWheel_mc = new redWheel_mc();
				_bullet_mc = new redBullet_mc();
				
				controlPanel = new b2_controlPanel(0xff3636);
				controlPanel.x = 200;
				controlPanel.y = 5;
				healthbar  = new b2_healthbar();
				
			}else if(type == 2){
				//blue tank
				this.type = "blue";
				_tank_mc = new blueTank_mc();
				_rightWheel_mc = new blueWheel_mc();
				_leftWheel_mc = new blueWheel_mc();
				_bullet_mc = new blueBullet_mc();
				
				controlPanel = new b2_controlPanel(0x36bfff);
				controlPanel.x = 285;
				controlPanel.y = 5;
				healthbar  = new b2_healthbar();
			}
			
			//drop shadow
			/*
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.distance = 20;
			dropShadow.angle = 10;
			dropShadow.color = 0x000000;
			dropShadow.alpha = 1;
			dropShadow.blurX = 1.75;
			dropShadow.blurY = 1.75;
			dropShadow.strength = 0.35;
			dropShadow.quality = 15;
			dropShadow.inner = false;
			dropShadow.knockout = false;
			dropShadow.hideObject = false;
			tank_mc.filters = new Array(dropShadow);
			*/
			//addChild(cannon_mc);
			//addChild(rl_mc);
			addChild(rightWheel_mc);
			addChild(leftWheel_mc);
			addChild(tank_mc);
			addChild(controlPanel);
			addChild(healthbar);
	
		}
		
		public function createTank(world:b2_world, xpos:Number, ypos:Number, track_xpos:Number, track_ypos:Number):void{
			this.world = world;
			this.xpos = xpos;
			this.ypos = ypos;
			this.track_xpos = track_xpos;
			this.track_ypos = track_ypos;
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
		private function create_tankBody():void{
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
			_tank.SetUserData(type);
		}
		
		//create the right wheel
		private function create_rightWheel():void{
			_rightWheel = new b2_wheel().createWheel(world, tank,
													tank.GetPosition().x + (15 / globals.WORLD_SCALE), 
													tank.GetPosition().y + (20 / globals.WORLD_SCALE),
													(7.5 / globals.WORLD_SCALE), type);
		}
		
		//create the left wheel
		private function create_leftWheel():void{
			_leftWheel = new b2_wheel().createWheel(world, tank,
												   tank.GetPosition().x - (15 / globals.WORLD_SCALE), 
												   tank.GetPosition().y + (20 / globals.WORLD_SCALE),
												   (7.5 / globals.WORLD_SCALE), type);
		}
		
		//create the tracks
		private function create_Track():void{ 
			var tracks:b2_tracks = new b2_tracks(world, tank, 5,  1.5, 25, 16, 1, 2, 0, track_xpos, track_ypos, type);
		}
		
		//update the tank, cannon and wheels movies clips
		public function update_mc():void{
			tank_mc.x = tank.GetPosition().x * globals.WORLD_SCALE;
			tank_mc.y = tank.GetPosition().y * globals.WORLD_SCALE;
			tank_mc.rotationZ = (tank.GetAngle() / (Math.PI / 180));
			rightWheel_mc.x = rightWheel.GetPosition().x * globals.WORLD_SCALE;
			rightWheel_mc.y = rightWheel.GetPosition().y * globals.WORLD_SCALE;
			rightWheel_mc.rotationZ = (rightWheel.GetAngle() / (Math.PI / 180));
			leftWheel_mc.x = leftWheel.GetPosition().x * globals.WORLD_SCALE;
			leftWheel_mc.y = leftWheel.GetPosition().y * globals.WORLD_SCALE;
			leftWheel_mc.rotationZ = (leftWheel.GetAngle() / (Math.PI / 180));
			healthbar.x = tank_mc.x - 30;
			healthbar.y = tank_mc.y - 25;
			
			if(bullet_on_stage){
				_bullet_mc.x = _bullet.GetPosition().x * globals.WORLD_SCALE;
				_bullet_mc.y = _bullet.GetPosition().y * globals.WORLD_SCALE;
			}
		}
		
		//rotate the tank cannon
		public function rotateCannon_Left():void{
			if(tank_mc.getChildByName("cannon_mc").rotation >= -170){
				tank_mc.getChildByName("cannon_mc").rotation --;
				if(tank_mc.getChildByName("cannon_mc").rotation < -90 && tank_mc.getChildByName("cannon_mc").rotation >= -170){
					_shootCannonLeft = true;
					_shootCannonRight = false;
				}
			}
		}
		
		public function rotateCannon_Right():void{
			if(tank_mc.getChildByName("cannon_mc").rotation <= -10){
				tank_mc.getChildByName("cannon_mc").rotation ++;
				if(tank_mc.getChildByName("cannon_mc").rotation > -90 && tank_mc.getChildByName("cannon_mc").rotation <= -10){
					_shootCannonLeft = false;
					_shootCannonRight = true;
				}
			}
		}
		
		//rotate the tanks rocket launcher
		public function rotateRL_Left():void{
			if(tank_mc.getChildByName("rl_mc").rotation >= -140){
				tank_mc.getChildByName("rl_mc").rotation --;
				if(tank_mc.getChildByName("rl_mc").rotation < -90 && tank_mc.getChildByName("rl_mc").rotation >= -140){
					_shootRLLeft = true;
					_shootRLRight = false;
				}
			}
		}
		
		public function rotateRL_Right():void{
			if(tank_mc.getChildByName("rl_mc").rotation <= -40){
				tank_mc.getChildByName("rl_mc").rotation ++;
				if(tank_mc.getChildByName("rl_mc").rotation > -90 && tank_mc.getChildByName("rl_mc").rotation <= -40){
					_shootRLLeft = false;
					_shootRLRight = true;
				}
			}
		}
		
		//moving tank
		public function moveRight():void{
			leftWheel.ApplyTorque(5);
			rightWheel.ApplyTorque(5);
		}
		
		public function moveLeft():void{
			leftWheel.ApplyTorque(-5);
			rightWheel.ApplyTorque(-5);
		}
		
		//Shooting bullets
		public function shootBullet():void{
			if(_shootCannonRight && bullet_ready){
				//add commnad to shoot cannon right
				if(cant_bullet_shoot == 0 && cant_bullet != 0){
					rightWheel.ApplyImpulse(new b2Vec2(0, -2), rightWheel.GetWorldCenter());
					
					//create bullet
					_bullet = new b2_bullet().createBullet(world, getShootingPos().x / globals.WORLD_SCALE, getShootingPos().y / globals.WORLD_SCALE, 4 / globals.WORLD_SCALE, true, true, false, 0.25, 0, 0);
					_bullet.ApplyImpulse(new b2Vec2(bulletSpeed,  getCannon_AntiGravity()), _bullet.GetWorldCenter());
					cant_bullet_shoot++;
					cant_bullet --;
					addChild(_bullet_mc);
					bullet_on_stage = true;
					time();
					controlPanel.setBullets(cant_bullet);
					controlPanel.turn_red();
				}
			}else if(_shootCannonLeft && bullet_ready){
				//add command to shoot cannon left
				if(cant_bullet_shoot == 0 && cant_bullet != 0){
					leftWheel.ApplyImpulse(new b2Vec2(0, -2), leftWheel.GetWorldCenter());
					
					//create bullet
					_bullet = new b2_bullet().createBullet(world, getShootingPos().x / globals.WORLD_SCALE, getShootingPos().y / globals.WORLD_SCALE, 4 / globals.WORLD_SCALE, true, true, false, 0.25, 0, 0);
					_bullet.ApplyImpulse(new b2Vec2(-bulletSpeed,  getCannon_AntiGravity()), _bullet.GetWorldCenter());
					cant_bullet_shoot++;
					cant_bullet --;
					addChild(_bullet_mc);
					bullet_on_stage = true;
					time();
					controlPanel.setBullets(cant_bullet);
					controlPanel.turn_red();
				}
			}
		}
		
		//shooting missils
		public function shootMissil():void{
			if(_shootRLRight && rocket_ready){
				if(cant_rocket_shoot == 0 && cant_rocket != 0){
					rightWheel.ApplyImpulse(new b2Vec2(0, -1), rightWheel.GetWorldCenter());
					
					var box1:b2Body = new b2_rocket().createRocket(world, getLaunchPos1().x / globals.WORLD_SCALE, getLaunchPos1().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box2:b2Body = new b2_rocket().createRocket(world, getLaunchPos2().x / globals.WORLD_SCALE, getLaunchPos2().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box3:b2Body = new b2_rocket().createRocket(world, getLaunchPos3().x / globals.WORLD_SCALE, getLaunchPos3().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					
					//first number = rocket force ,, second number antigravity
					launchForce = new b2Vec2(20, (getRL_AntiGravity() - 5));
					box1.ApplyForce(launchForce, box1.GetWorldCenter());
					launchForce = new b2Vec2(19, (getRL_AntiGravity() - 3));
					box2.ApplyForce(launchForce, box2.GetWorldCenter());
					launchForce = new b2Vec2(18, (getRL_AntiGravity() - 1));
					box3.ApplyForce(launchForce, box3.GetWorldCenter());
				}
			}else if(_shootRLLeft && rocket_ready){
				if(cant_rocket_shoot == 0 && cant_rocket != 0){
					rightWheel.ApplyImpulse(new b2Vec2(0, 1), rightWheel.GetWorldCenter());
					
					var box1:b2Body = new b2_rocket().createRocket(world, getLaunchPos1().x / globals.WORLD_SCALE, getLaunchPos1().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box2:b2Body = new b2_rocket().createRocket(world, getLaunchPos2().x / globals.WORLD_SCALE, getLaunchPos2().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box3:b2Body = new b2_rocket().createRocket(world, getLaunchPos3().x / globals.WORLD_SCALE, getLaunchPos3().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					
					//first number = rocket force ,, second number antigravity
					launchForce = new b2Vec2(-18, (getRL_AntiGravity() - 1));
					box1.ApplyForce(launchForce, box1.GetWorldCenter());
					launchForce = new b2Vec2(-19, (getRL_AntiGravity() - 3));
					box2.ApplyForce(launchForce, box2.GetWorldCenter());
					launchForce = new b2Vec2(-20, (getRL_AntiGravity() - 5));
					box3.ApplyForce(launchForce, box3.GetWorldCenter());
				}
			}
		}
		
		//add damage to tank
		public function reduce_life():void{
			_life = life - bullet_damage;
			controlPanel.setHealth(life);
			healthbar.update(_life);
		}
		
		//charging timer
		private function time():void{
			myTimer = new Timer(1000, charingTime);
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
			controlPanel.turn_green();
			cant_bullet_shoot = 0;
		}
		
		//this methods sets the anti-gravity for the bullet when shooting
		public function getCannon_AntiGravity():Number{
			var num:Number = 0.30;
			var force:Number;
			var angle:Number = tank_mc.getChildByName("cannon_mc").rotation + 180;
			force = (angle * -num);
			if(angle > 90){
				angle = tank_mc.getChildByName("cannon_mc").rotation;
				force = (angle * num);
			}
			return force;
		}
		
		//cannon shooting position
		public function getShootingPos():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = tank_mc.getChildByName("cannon_mc");
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getCannonRad()) * hip) + pt.x;
			launchPos.y = (Math.sin(getCannonRad()) * hip) + pt.y;
			return launchPos;
		}
		
		//this methods sets the anti-gravity for the rocket
		public function getRL_AntiGravity():Number{
			var num:Number = 0.30;
			var force:Number;
			var angle:Number = tank_mc.getChildByName("rl_mc").rotation + 180;
			force = (angle * -num);
			if(angle > 90){
				angle = tank_mc.getChildByName("rl_mc").rotation;
				force = (angle * num);
			}
			return force;
		}
		
		//getting the launching position 1
		public function getLaunchPos1():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = tank_mc.getChildByName("rl_mc");
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getRLRad() - 0.6) * hip) + pt.x;
			launchPos.y = (Math.sin(getRLRad() - 0.6) * hip) + pt.y;
			return launchPos;
		}
		
		//getting the launching position 2
		public function getLaunchPos2():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = tank_mc.getChildByName("rl_mc");
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getRLRad() - 0.2) * hip) + pt.x;
			launchPos.y = (Math.sin(getRLRad() - 0.2) * hip) + pt.y;
			return launchPos;
		}
		
		//getting the launching position 3
		public function getLaunchPos3():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = tank_mc.getChildByName("rl_mc");
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getRLRad() + 0.20) * hip) + pt.x;
			launchPos.y = (Math.sin(getRLRad() + 0.20) * hip) + pt.y;
			return launchPos;
		}
		
		//get the cannon angle on radians
		private function getCannonRad():Number{
			var rads:Number = getCannon360() * Math.PI / 180;
			return rads;
		}
		
		//get the cannon angle on 360 degrees
		private function getCannon360():Number{
			var num:Number;
			if( tank_mc.getChildByName("cannon_mc").rotation >= 0 &&  tank_mc.getChildByName("cannon_mc").rotation <= 180){
				num =  tank_mc.getChildByName("cannon_mc").rotation;
			}else if ( tank_mc.getChildByName("cannon_mc").rotation < 0){
				num = 360 +  tank_mc.getChildByName("cannon_mc").rotation;
			}
			return num;
		}

		//get the cannon rotation on angles
		private function getCannonDeg():Number{
			var num:Number = getCannonRad() * 180 / Math.PI;
			return num;
		}
		
		//get the RL angle on radians
		private function getRLRad():Number{
			var rads:Number = getRL360() * Math.PI / 180;
			return rads;
		}
		
		//get the RL angle on 360 degrees
		private function getRL360():Number{
			var num:Number;
			if( tank_mc.getChildByName("rl_mc").rotation >= 0 &&  tank_mc.getChildByName("rl_mc").rotation <= 180){
				num =  tank_mc.getChildByName("rl_mc").rotation;
			}else if ( tank_mc.getChildByName("rl_mc").rotation < 0){
				num = 360 +  tank_mc.getChildByName("rl_mc").rotation;
			}
			return num;
		}
		
		//get the RL rotation on angles
		private function getRLDeg():Number{
			var num:Number = getRLRad() * 180 / Math.PI;
			return num;
		}
		
		//getters b2bodies
		public function get tank():b2Body{return _tank;}
		public function get rightWheel():b2Body{return _rightWheel;}
		public function get leftWheel():b2Body{return _leftWheel;}
		public function get shootCannonRight():Boolean{return _shootCannonRight;}
		public function get shootCannonLeft():Boolean{return _shootCannonLeft;}
		
		//getters mcs
		public function get tank_mc():MovieClip{return _tank_mc;}
		public function get rightWheel_mc():Sprite{return _rightWheel_mc;}
		public function get leftWheel_mc():Sprite{return _leftWheel_mc;}

		//getters properties
		public function get life():int{return _life;}
		public function get cant_bullet():int{return _cant_bullet;}

		//setter properties
		public function set life(value:int):void{_life = value;}
		public function set cant_bullet(value:int):void{_cant_bullet = value;}
	}
}