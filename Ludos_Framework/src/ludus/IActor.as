package ludus  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;

	public interface IActor
	{	
		function getMC():Sprite;
		function update();
		function notify();
		function defend();
		function moveLeft();
		function moveRight();
		function rotateLeft();
		function rotateRight();
		function attack();
		function moveDown();
		function moveUp();
		function update_mc();
		function applyImpulseLeft(x:Number, y:Number);
		function applyImpulseRight(x:Number, y:Number);
		function applyImpulseDown(x:Number, y:Number);
		function applyImpulseUp(x:Number, y:Number);
		//Builds Virtual Body
		function buildVirtualBody();
		function reduceLife(pcantToReduce:Number); 
		//Properties
		function get body():Sprite;
		function set body(value:Sprite):void;
		//
		function get life():Number;
		function set life(value:Number):void;
		
		//
		function get strikeCapability():Number;		
		function set strikeCapability(value:Number):void;
		
		//Virtual World
		function get virtualWorld():b2World;		
		function set virtualWorld(value:b2World):void;
		
		//Virtual Body
		function get virtualBody():b2Body;		
		function set virtualBody(value:b2Body):void;
		
		//Stage
		function get stage():Stage;		
		function set stage(value:Stage):void;
		
		//Name
		function get name():String;		
		function set name(value:String):void;
		
		
	}
}