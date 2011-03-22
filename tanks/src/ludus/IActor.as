package ludus  
{
	import flash.display.Sprite;

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
		
		function get life():Number;
		function set life(value:Number):void;
	}
}