package ludus
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.b2_ludus.b2_globals;

	public class IDecActor implements IActor  
	{
		
		
		
		//--------Atributes
		private var _actor:IActor;
		private var _body:Sprite;
		private var _virtualWorld:b2World;		
		private var _virtualBody:b2Body ;
		private var _stage:Stage;
		private var _life:Number;
		private var _strikeCapability:Number;
		private var _name:String;
		//Atributs -- Utilities  
		public var globals:b2_globals = new b2_globals();
		
		public function IDecActor(pstage:Stage,pactor:IActor,pvirtualWorld:b2World, pbody:Sprite){
			name = "";
			virtualWorld = pvirtualWorld;
			body = pbody;
			actor = pactor;
			strikeCapability =0;
			_stage = pstage;
			life =0;
			
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
			actor.reduceLife(pcantToReduce);
			if(life>0){
				if(pcantToReduce >life){
					life =0;
				}else{
					life =life -pcantToReduce;
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
		
		public function get life():Number{return _life + actor.life;}
		public function set life(value:Number):void{_life = value;}
		
		public function get strikeCapability():Number{return _strikeCapability + actor.strikeCapability;}			
		public function set strikeCapability(value:Number):void{_strikeCapability = value ;}
		
		//Virtual Body
		public function get virtualBody():b2Body{
			if(_virtualBody != null){
			 return _virtualBody;;	
			}else
			{
				return actor.virtualBody;
			}
			 
			
			
		}		
		public function set virtualBody(value:b2Body):void{_virtualBody = value;}
		
		public function get stage():Stage{return _stage};		
		public function set stage(value:Stage):void{_stage = value};
		
		public function get name():String{return _name};		
		public function set name(value:String):void{_name = value};
	}
}