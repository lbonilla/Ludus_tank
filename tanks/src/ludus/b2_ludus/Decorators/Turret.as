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
	import ludus.b2_ludus.b2_bullet;

	public class Turret extends Weapon
	{
		//Atributes
		private var _bullet:b2Body;
		//shooting variables
				
		private var _shootCannonRight:Boolean = true; 
		private var _shootCannonLeft:Boolean = false;
		private var bullet_on_stage:Boolean = false;
		
		private var launchPos:b2Vec2 = new b2Vec2(0, 0);
		private var launchForce:b2Vec2;
		//Bullet
		private var _bullet_mc:Sprite;
		private var _bullet_on_stage:Boolean = false;
		private var _bullet_damage:int = 25;
		private var bulletforce:b2Vec2;
		private var bulletSpeed:Number = 20;
		private var _cant_bullet:int = 10;
		
		
		///Constructor
		public function Turret(pstage:Stage,pactor:IActor,pvirtualWorld:b2World, pbody:Sprite, pxpos:Number,pypos:Number, pbodyInternalName:String, pbulletBody:Sprite )
		{
			super(pstage, pactor, pvirtualWorld,  pbody,pxpos,pypos,pbodyInternalName);
			_bullet_mc = pbulletBody;
			//pbodyInternalName = bodyInternalName;
		}
		public override function attack(){
			super.attack();
			shootBullet();
		}
		public override function update_mc(){
			super.update_mc();
			if(bullet_on_stage){
				_bullet_mc.x = _bullet.GetPosition().x * globals.WORLD_SCALE;
				_bullet_mc.y = _bullet.GetPosition().y * globals.WORLD_SCALE;
			}			
		}
		public override function moveDown(){
			super.moveUp();
			rotateCannon_Right();
		}
		public override function moveUp(){
			super.moveDown();
			rotateCannon_Left();
		}
		//Owm methods
		//Shooting bullets
		public function shootBullet():void{
			if(_shootCannonRight && bullet_ready){
				
				//add commnad to shoot cannon right
				if(cant_shoot == 0 && _cant_bullet != 0){
					
					actor.applyImpulseRight(0, -2);
					//create bullet
					
					_bullet = new b2_bullet().createBullet(virtualWorld, getShootingPos().x / globals.WORLD_SCALE, getShootingPos().y / globals.WORLD_SCALE, 4 / globals.WORLD_SCALE, true, true, false, 0.25, 0, 0);
					var vec:b2Vec2=_bullet.GetWorldCenter();
					var impulse:b2Vec2 =new b2Vec2(bulletSpeed,  getCannon_AntiGravity());
					_bullet.ApplyImpulse(impulse,vec);
					cant_shoot++;
					_cant_bullet --;
					
				  	stageActor.addChild(_bullet_mc);
					bullet_on_stage = true;
					time();
					
					//To do: controlPanel.setBullets(cant_bullet);
					//To do: controlPanel.turn_red();
					}
				}else if(_shootCannonLeft && bullet_ready){
					//add command to shoot cannon left
					if(cant_shoot == 0 && _cant_bullet != 0){
						
						actor.applyImpulseLeft(0, -2);
						//create bullet
						_bullet = new b2_bullet().createBullet(virtualWorld, getShootingPos().x / globals.WORLD_SCALE, getShootingPos().y / globals.WORLD_SCALE, 4 / globals.WORLD_SCALE, true, true, false, 0.25, 0, 0);
						_bullet.ApplyImpulse(new b2Vec2(-bulletSpeed,  getCannon_AntiGravity()), _bullet.GetWorldCenter());
						cant_shoot++;
						_cant_bullet --;
						stageActor.addChild(_bullet_mc);
						bullet_on_stage = true;
						time();
						//todo: controlPanel.setBullets(cant_bullet);
						//todo: controlPanel.turn_red();
					}
				}		
		}
		//this methods sets the anti-gravity for the bullet when shooting
		public function getCannon_AntiGravity():Number{
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
		
		//cannon shooting position
		public function getShootingPos():b2Vec2{
			var hip:Number= 30;
			var targetMc:DisplayObject = actor.body.getChildByName(bodyInternalName);
			var pt:Point = new Point(targetMc.x, targetMc.y);
			pt = targetMc.parent.localToGlobal(pt);
			launchPos.x = (Math.cos(getCannonRad()) * hip) + pt.x;
			launchPos.y = (Math.sin(getCannonRad()) * hip) + pt.y;
			return launchPos;
		}
		

		//rotate the tank cannon
		private function rotateCannon_Left():void{
			if(actor.body.getChildByName(bodyInternalName).rotation >= -170){
				actor.body.getChildByName(bodyInternalName).rotation --;
				if(actor.body.getChildByName(bodyInternalName).rotation < -90 && actor.body.getChildByName(bodyInternalName).rotation >= -170){
					_shootCannonLeft = true;
					_shootCannonRight = false;
				}
			}
		}
		
		private function rotateCannon_Right():void{
			if(actor.body.getChildByName(bodyInternalName).rotation <= -10){
				
				actor.body.getChildByName(bodyInternalName).rotation ++;
				if(actor.body.getChildByName(bodyInternalName).rotation > -90 && actor.body.getChildByName(bodyInternalName).rotation <= -10){
					_shootCannonLeft = false;
					_shootCannonRight = true;
				}
			}
		}
		//get the cannon angle on radians
		private function getCannonRad():Number{
			var rads:Number = getCannon360() * Math.PI / 180;
			return rads;
		}
		
		//get the cannon angle on 360 degrees
		private function getCannon360():Number{
			var num:Number;
			if( actor.body.getChildByName(bodyInternalName).rotation >= 0 &&  actor.body.getChildByName(bodyInternalName).rotation <= 180){
				num =  actor.body.getChildByName(bodyInternalName).rotation;
			}else if ( actor.body.getChildByName(bodyInternalName).rotation < 0){
				num = 360 +  actor.body.getChildByName(bodyInternalName).rotation;
			}
			return num;
		}
		
		//get the cannon rotation on angles
		private function getCannonDeg():Number{

			var num:Number = getCannonRad() * 180 / Math.PI;
			return num;
		}				
	}
}