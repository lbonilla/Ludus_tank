package ludus.b2_ludus.Decorators
{
	import flash.external.ExternalInterface;
	
	import ludus.Box2D.Collision.Shapes.b2PolygonShape;
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2BodyDef;
	import ludus.Box2D.Dynamics.b2FixtureDef;
	import ludus.IActor;
	import ludus.b2_ludus.b2_globals;
	import ludus.b2_ludus.b2_tracks;
	import ludus.b2_ludus.b2_world;
	
	public class Tracks extends Weapon
	{	
		
		public function Tracks(pactor:IActor, 
								  width:Number, 
								  height:Number, 
								  radius:Number, 
								  cantTracks:Number, 
								  density:Number,
								  friction:Number,
								  restitution:Number, xpos, ypos)
		{
		  super(pactor.stage,pactor,pactor.virtualWorld,pactor.body,xpos,ypos,"");	
		 new b2_tracks(pactor.virtualWorld,pactor.virtualBody,width,height,radius,cantTracks,density,friction,restitution,xpos,ypos);
		}
	}
}