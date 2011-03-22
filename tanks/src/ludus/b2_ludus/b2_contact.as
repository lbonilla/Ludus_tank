package ludus.b2_ludus
{
	import ludus.Box2D.Dynamics.*;
	import ludus.Box2D.Collision.*;
	import ludus.Box2D.Collision.Shapes.*;
	import ludus.Box2D.Dynamics.Joints.*;
	import ludus.Box2D.Dynamics.Contacts.*;
	import ludus.Box2D.Common.*;
	import ludus.Box2D.Common.Math.*;
	
	public class b2_contact extends b2ContactListener
	{
		
		public function beginContact(contact:b2Contact):void {
			
			// getting the fixtures that collided
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			// if the fixture is a sensor, mark the parent body to be removed
			
			if (fixtureB.IsSensor()) {
				fixtureB.GetBody().SetUserData("remove");
			}
			
			if (fixtureA.IsSensor()) {
				fixtureA.GetBody().SetUserData("remove");
			}
		}
	}
}