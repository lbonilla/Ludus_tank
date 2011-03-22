package ludus.b2_ludus.Decorators
{
	
	
	
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	import ludus.b2_ludus.b2_rocket;
	public class RocketLauncher extends Weapon
	{
		//Atributes
		
		private var _shootRLRight:Boolean = true; 
		private var _shootRLLeft:Boolean = false;
		private var launchPos:b2Vec2 = new b2Vec2(0, 0);
		private var launchForce:b2Vec2;
		private var rocket_ready:Boolean = true;
		private var rocket_on_stage:Boolean = false;
		private var rocket_damage:int = 15;
		private var cant_rocket_shoot:int = 0;
		private var cant_rocket:int = 5;
		//Constructor
		
		public function RocketLauncher(pstage:Stage, pactor:IActor, pvirtualWorld:b2World, pbody:Sprite, pxpos:Number, pypos:Number, pbodyInternalName:String)
		{
			super(pstage, pactor, pvirtualWorld, pbody, pxpos, pypos, pbodyInternalName);
		}
		//Methods
		//-------------Inherits methods
		public override function attack(){
			super.attack();
			shootMissil();
		}
		
		public override function rotateLeft(){
			super.rotateLeft();
			rotateRL_Left();	
		}
		public override function rotateRight(){
			super.rotateRight();
			rotateRL_Right();
		}
		//------------Owm methods
		//rotate the tanks rocket launcher
		public function rotateRL_Left():void{
			if(actor.body.getChildByName(bodyInternalName).rotation >= -140){
				actor.body.getChildByName(bodyInternalName).rotation --;
				if(actor.body.getChildByName(bodyInternalName).rotation < -90 && actor.body.getChildByName(bodyInternalName).rotation >= -140){
					_shootRLLeft = true;
					_shootRLRight = false;
				}
			}
		}
		
		public function rotateRL_Right():void{
			if(actor.body.getChildByName(bodyInternalName).rotation <= -40){
				actor.body.getChildByName(bodyInternalName).rotation ++;
				if(actor.body.getChildByName(bodyInternalName).rotation > -90 && actor.body.getChildByName(bodyInternalName).rotation <= -40){
					_shootRLLeft = false;
					_shootRLRight = true;
				}
			}
		}
		
		//shooting missils
		public function shootMissil():void{
			if(_shootRLRight && rocket_ready){
				if(cant_rocket_shoot == 0 && cant_rocket != 0){
					actor.applyImpulseRight(0, -1);
					var box1:b2Body = new b2_rocket().createRocket(virtualWorld, getLaunchPos1().x / globals.WORLD_SCALE, getLaunchPos1().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box2:b2Body = new b2_rocket().createRocket(virtualWorld, getLaunchPos2().x / globals.WORLD_SCALE, getLaunchPos2().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box3:b2Body = new b2_rocket().createRocket(virtualWorld, getLaunchPos3().x / globals.WORLD_SCALE, getLaunchPos3().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					
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
					
					actor.applyImpulseRight(0, 1);
					var box1:b2Body = new b2_rocket().createRocket(virtualWorld, getLaunchPos1().x / globals.WORLD_SCALE, getLaunchPos1().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box2:b2Body = new b2_rocket().createRocket(virtualWorld, getLaunchPos2().x / globals.WORLD_SCALE, getLaunchPos2().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					var box3:b2Body = new b2_rocket().createRocket(virtualWorld, getLaunchPos3().x / globals.WORLD_SCALE, getLaunchPos3().y / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, 3 / globals.WORLD_SCALE, true, 1, 0, 0);
					
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
		
		//getting the launching position 1
		public function getLaunchPos1():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = actor.body.getChildByName(bodyInternalName);
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getRLRad() - 0.6) * hip) + pt.x;
			launchPos.y = (Math.sin(getRLRad() - 0.6) * hip) + pt.y;
			return launchPos;
		}
		
		//getting the launching position 2
		public function getLaunchPos2():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = actor.body.getChildByName(bodyInternalName);
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getRLRad() - 0.2) * hip) + pt.x;
			launchPos.y = (Math.sin(getRLRad() - 0.2) * hip) + pt.y;
			return launchPos;
		}
		
		//getting the launching position 3
		public function getLaunchPos3():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = actor.body.getChildByName(bodyInternalName);
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getRLRad() + 0.20) * hip) + pt.x;
			launchPos.y = (Math.sin(getRLRad() + 0.20) * hip) + pt.y;
			return launchPos;
		}
		//this methods sets the anti-gravity for the rocket
		public function getRL_AntiGravity():Number{
			var num:Number = 0.30;
			var force:Number;
			var angle:Number = actor.body.getChildByName(bodyInternalName).rotation + 180;
			force = (angle * -num);
			if(angle > 90){
				angle = actor.body.getChildByName(bodyInternalName).rotation;
				force = (angle * num);
			}
			return force;
		}
		
		//get the RL angle on radians
		private function getRLRad():Number{
			var rads:Number = getRL360() * Math.PI / 180;
			return rads;
		}
		
		//get the RL angle on 360 degrees
		private function getRL360():Number{
			var num:Number;
			if( actor.body.getChildByName(bodyInternalName).rotation >= 0 &&  actor.body.getChildByName(bodyInternalName).rotation <= 180){
				num =  actor.body.getChildByName(bodyInternalName).rotation;
			}else if ( actor.body.getChildByName(bodyInternalName).rotation < 0){
				num = 360 +  actor.body.getChildByName(bodyInternalName).rotation;
			}
			return num;
		}
		
		//get the RL rotation on angles
		private function getRLDeg():Number{
			var num:Number = getRLRad() * 180 / Math.PI;
			return num;
		}
	}
}