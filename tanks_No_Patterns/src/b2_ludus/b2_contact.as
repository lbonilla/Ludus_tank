package b2_ludus
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.Joints.*;
	
	import org.osflash.signals.Signal;
	/**
	 * @author Ludus Team
	 */
	public class b2_contact extends b2ContactListener 
	{
		public var hit:Signal = new Signal(String);
		public function hitTank(tank_name:String):void{
			hit.dispatch(tank_name);
		}
		
		public override function BeginContact(contact:b2Contact):void {
			
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();

			//tank blue
			if(fixtureB.GetBody().GetUserData() == "bullet" && fixtureA.GetBody().GetUserData() == "blue"){
				fixtureB.GetBody().SetUserData("remove");
				hitTank(fixtureA.GetBody().GetUserData());
				
			}else if(fixtureA.GetBody().GetUserData() == "bullet" && fixtureB.GetBody().GetUserData() == "blue"){
				fixtureA.GetBody().SetUserData("remove");
				hitTank(fixtureB.GetBody().GetUserData());
			}
			
			//tank red
			if(fixtureB.GetBody().GetUserData() == "bullet" && fixtureA.GetBody().GetUserData() == "red"){
				fixtureB.GetBody().SetUserData("remove");
				hitTank(fixtureA.GetBody().GetUserData());
				
			}else if(fixtureA.GetBody().GetUserData() == "bullet" && fixtureB.GetBody().GetUserData() == "red"){
				fixtureA.GetBody().SetUserData("remove");
				hitTank(fixtureB.GetBody().GetUserData());
			}
			
			//ground
			if (fixtureA.GetBody().GetUserData() == "bullet") {
				fixtureA.GetBody().SetUserData("remove");
				trace("hit ground");
			}
			
			if (fixtureB.GetBody().GetUserData() == "bullet") {
				fixtureB.GetBody().SetUserData("remove");
				trace("hit ground");
			}
		}
	}
}