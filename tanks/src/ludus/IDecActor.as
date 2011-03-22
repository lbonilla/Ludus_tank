package ludus
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.b2_ludus.b2_globals;

	public class IDecActor extends Sprite  implements IActor  
	{
		
		
		
		//--------Atributes
		private var _actor:IActor;
		private var _body:Sprite;
		private var _virtualWorld:b2World;		
		private var _virtualBody:b2Body ;
		private var _stageActor:Stage;
		private var _life;
		//Atributs -- Utilities  
		public var globals:b2_globals = new b2_globals();
		
		public function IDecActor(pstage:Stage,pactor:IActor,pvirtualWorld:b2World, pbody:Sprite){
			virtualWorld = pvirtualWorld;
			body = pbody;
			actor = pactor;
			stageActor = pstage;
		}
		public  function getMC():Sprite{
			 return body;
		}
		public  function update(){
			actor.update();
		}
		public  function notify(){
			actor.notify();
		}
		public  function defend(){
			actor.defend();
		}
		
		public  function moveLeft(){
			actor.moveLeft();
		}
		
		public  function moveRight(){
			actor.moveRight();
		}
		public  function rotateLeft(){
			actor.rotateLeft();
		}
		public  function rotateRight(){
			actor.rotateRight();
		}
		public  function attack(){
			actor.attack();	
		}
		public function moveDown(){
			actor.moveDown();	
		}
		public function moveUp(){
			actor.moveUp();
		}
		public function update_mc(){
			actor.update_mc();
		}
		public  function applyImpulseLeft(x:Number, y:Number){
			
		}
		public function applyImpulseRight(x:Number, y:Number){
			
		}	
		
		public function applyImpulseDown(x:Number, y:Number){
			
		}
		public function applyImpulseUp(x:Number, y:Number){
			
		}
		
		public function buildVirtualBody(){
			
		}
		public function reduceLife(pcantToReduce:Number){
			if(life>0){
				if(pcantToReduce >life){
					life =0;
				}else{
					life -pcantToReduce;
				}
			}	
		}
		//Properties
		
		public function get body():Sprite{return _body;}
		public function set body(value:Sprite):void{_body = value;}
		
		public function get virtualWorld():b2World{return _virtualWorld;}
		public function set virtualWorld(value:b2World):void{_virtualWorld = value;}

		public function get actor():IActor{return _actor;}
		public function set actor(value:IActor):void{_actor = value;}
		
		public function get stageActor():Stage{return _stageActor;}
		public function set stageActor(value:Stage):void{_stageActor = value;}
		
		public function get life():Number{return _life;}
		public function set life(value:Number):void{_life = value;}
	}
}