package ludus.b2_ludus.Actors
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.b2_ludus.Observers.LifeObserver;
	
	public class AerialVehicle extends Vehicle
	{
		
		public function AerialVehicle(pname:String,pstage:Stage, pvirtualWorld:b2World, pbody:Sprite, pbodyInternalName:String, px:Number, py:Number)
		{
			super(pname,pstage, pvirtualWorld, pbody, pbodyInternalName, px, py);
		}
		
		//Inherit Method's
		public override function applyImpulseLeft(px:Number, py:Number)
		{
			
			virtualBody.ApplyImpulse(new b2Vec2(px, py), virtualBody.GetWorldCenter());
		}
		public override function applyImpulseRight(px:Number, py:Number)
		{
			virtualBody.ApplyImpulse(new b2Vec2(px, py), virtualBody.GetWorldCenter());
		}
		public override function applyImpulseDown(px:Number, py:Number){
			virtualBody.ApplyImpulse(new b2Vec2(px, py), virtualBody.GetWorldCenter());
		}
		public override function applyImpulseUp(px:Number, py:Number){
			virtualBody.ApplyImpulse(new b2Vec2(px, py), virtualBody.GetWorldCenter());	
		}
		public override function moveDown(){
			applyImpulseDown(0,-0.1);
		}
		public override function moveUp(){
			applyImpulseUp(0,0.8);
		}
		public override function moveRight(){
			applyImpulseRight(0.1,0);	
		}
		public override function moveLeft(){
			applyImpulseLeft(-0.1,0);
		}
	}
}