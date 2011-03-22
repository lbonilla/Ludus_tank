package ludus.b2_ludus.Actors
{
	
	//Flash imports
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.b2_ludus.Observers.LifeObserver;
	import ludus.b2_ludus.b2_wheel;

	public class LandVehicle extends Vehicle
	{
		//----------Atributes
		
		//B2Body's
		private var _rightWheel:b2Body;
		private var _leftWheel:b2Body;
		
		//Mc's bodys
		private var _rightWheel_mc:Sprite;
		private var _leftWheel_mc:Sprite;
		
		//Constructor
		public function LandVehicle(pstage:Stage,pvirtualWorld:b2World, pbody:Sprite,
									pbodyInternalName:String,  px:Number, 
									py:Number, prightWheel_mc:Sprite,pleftWheel_mc:Sprite, pobserver:LifeObserver)
		{
			super(pstage,pvirtualWorld,pbody,pbodyInternalName,px,py,pobserver);
			_rightWheel_mc = prightWheel_mc;
			_leftWheel_mc = pleftWheel_mc;
			actorStage.addChild(_rightWheel_mc);
			actorStage.addChild(_leftWheel_mc);
		}
		public override function buildVirtualBody(){
			super.buildVirtualBody();
			create_leftWheel();
			create_rightWheel();
		}
		//Owm Methods
		//create the right wheel
		private function create_rightWheel():void{
			_rightWheel = new b2_wheel().createWheel(virtualWorld, virtualBody,
				this.virtualBody.GetPosition().x + (15 / globals.WORLD_SCALE), 
				this.virtualBody.GetPosition().y + (20 / globals.WORLD_SCALE),
				(7.5 / globals.WORLD_SCALE));
		}
		
		//create the left wheel
		private function create_leftWheel():void{
			
			_leftWheel = new b2_wheel().createWheel(virtualWorld, virtualBody,
				this.virtualBody.GetPosition().x - (15 / globals.WORLD_SCALE), 
				this.virtualBody.GetPosition().y + (20 / globals.WORLD_SCALE),
				(7.5 / globals.WORLD_SCALE));
		}
		
		//Inherit Method's
		public override function applyImpulseLeft(px:Number, py:Number)
		{
			_leftWheel.ApplyImpulse(new b2Vec2(px, py), _leftWheel.GetWorldCenter());
		}
		public override function applyImpulseRight(px:Number, py:Number)
		{
			_rightWheel.ApplyImpulse(new b2Vec2(px, py), _rightWheel.GetWorldCenter());
		}
		public override function moveLeft(){
			super.moveLeft();
			_leftWheel.ApplyTorque(-2);
			_rightWheel.ApplyTorque(-2);	
		}
		public override function moveRight(){
			super.moveRight();
			_leftWheel.ApplyTorque(2);
			_rightWheel.ApplyTorque(2);
		}
		public override function update_mc(){
			super.update_mc();
			rightWheel_mc.x = _rightWheel.GetPosition().x * globals.WORLD_SCALE;
			rightWheel_mc.y = _rightWheel.GetPosition().y * globals.WORLD_SCALE;
			rightWheel_mc.rotationZ = (_rightWheel.GetAngle() / (Math.PI / 180));
			leftWheel_mc.x = _leftWheel.GetPosition().x * globals.WORLD_SCALE;
			leftWheel_mc.y = _leftWheel.GetPosition().y * globals.WORLD_SCALE;
			leftWheel_mc.rotationZ = (_leftWheel.GetAngle() / (Math.PI / 180))
		}
		//Properties
		public function get rightWheel_mc():Sprite{return _rightWheel_mc;}
		public function set rightWheel_mc(value:Sprite):void{_rightWheel_mc = value;}
		
		public function get leftWheel_mc():Sprite{return _leftWheel_mc;}
		public function set leftWheel_mc(value:Sprite):void{_leftWheel_mc = value;}
	}
}