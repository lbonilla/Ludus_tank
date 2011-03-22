package ludus.b2_ludus.Actors
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	import ludus.b2_ludus.b2_box;
	import ludus.b2_ludus.b2_globals;
	import ludus.b2_ludus.b2_polybox;
	import ludus.b2_ludus.b2_rope;

	public class b2_stage implements IActor
	{
		//--------Atributes
		private var _body:Sprite;
		private var _virtualWorld:b2World;		
		private var _virtualBody:b2Body ;
		private var _stage:Stage;
		private var _life:Number;
		
		private var _strikeCapability:Number;
		private var _name:String;

		public var globals:b2_globals = new b2_globals();
		public function b2_stage()
		{
			 _virtualWorld = new b2World(globals.GRAVITY, true);
		}
		//IActor Implements Method's
		public 	function getMC():Sprite{
	 		return null;			
		}
		//This method build the B2Body
		//Warning this method has to call only One time in the life of object
		public function buildVirtualBody(){
			
		}
		public function update(){
			
		}
		public function notify(){
			
		}
		public function defend(){
			
		}
		public function moveLeft(){
			
		}
		public function moveRight(){
			
		}
		public function rotateLeft(){
			
		}
		public function rotateRight(){
			
		}
		public function attack(){
			
		}
		public  function moveDown(){
			
		}
		public function moveUp(){
			
		}
		public function update_mc(){}
		
		public  function applyImpulseLeft(x:Number, y:Number){
			
		}
		public function applyImpulseRight(x:Number, y:Number){
			
		}	
		
		public function applyImpulseDown(x:Number, y:Number){
			
		}
		public function applyImpulseUp(x:Number, y:Number){
			
		}
		public function reduceLife(pcantToReduce:Number){
		
		}
		//World Method's
		public function createHill(pposx:Number,pposy:Number, pvec1:Number,pvec2:Number, pvec3:Number, pvec4:Number){
			//hill 01
			var p1:b2Vec2 = new b2Vec2(pvec1 / globals.WORLD_SCALE, 0);
			var p2:b2Vec2 = new b2Vec2(pvec2 / globals.WORLD_SCALE, -40 / globals.WORLD_SCALE);
			var p3:b2Vec2 = new b2Vec2(pvec3 / globals.WORLD_SCALE, -40 / globals.WORLD_SCALE);
			var p4:b2Vec2 = new b2Vec2(pvec4 / globals.WORLD_SCALE, 0);
			var vertex:Array = [p1, p2, p3, p4];
			
			var body:b2Body = new b2_polybox().createPolyBox(virtualWorld, 
				pposx  / globals.WORLD_SCALE, 
				pposy / globals.WORLD_SCALE, 
				vertex,
				false,
				0, 1, 0);
			
		}
		public function createBridge(pcantBoxes:Number,pwidth:Number,pvec1_x:Number,pvec1_y:Number,pvec2_x:Number,pvec2_y:Number){
			var a_pos:b2Vec2 = new b2Vec2(pvec1_x,pvec1_y)
			var b_pos:b2Vec2 = new b2Vec2(pvec2_x, pvec2_y);
			var rope:b2_rope = new b2_rope();
			rope.createRope(virtualWorld, a_pos, b_pos, pcantBoxes, pwidth);
		}

		public function createGround(pxpos:Number, pypos:Number,pwidth:Number,pheight:Number,pdensity:Number, pfriction:Number, prestitution){
			var ground1:b2Body = new b2_box().createBox(_virtualWorld,
				pxpos / globals.WORLD_SCALE, 
				pypos / globals.WORLD_SCALE, 
				pwidth / globals.WORLD_SCALE / 2,
				pheight / globals.WORLD_SCALE / 2,
				false, pdensity, pfriction, prestitution);
			
		}
		//Properties
		
		//Properties
		public function get body():Sprite{return _body;}
		public function set body(value:Sprite):void{_body = value;}
		
		public function get virtualWorld():b2World{return _virtualWorld;}
		public function set virtualWorld(value:b2World):void{_virtualWorld = value;}
		
		public function get virtualBody():b2Body{return _virtualBody;}
		public function set virtualBody(value:b2Body):void{_virtualBody = value;}
		
		public  function get life():Number{return _life;}
		public  function set life(value:Number):void{_life = value;}
		
		public function get strikeCapability():Number{return _strikeCapability;}			
		public function set strikeCapability(value:Number):void{_strikeCapability = value;}
		
		public function get stage():Stage{return _stage};		
		public function set stage(value:Stage):void{_stage = value};
		
		public function get name():String{return _name};		
		public function set name(value:String):void{_name = value};
	}
}