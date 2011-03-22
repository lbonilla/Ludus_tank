package ludus.b2_ludus.Decorators
{
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ludus.Actor;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	import ludus.IDecActor;
	
	public class Weapon extends IDecActor
	{

		//Atributes
		private var _xpos:Number;
		private var _ypos:Number;		
		private var _myTimer:Timer;
		private var _bodyInternalName:String;
	//	private var _actorStage:Stage;
		private var _actor:Actor;
		//Shoot Atributes
		private var _cant_shoot:int = 0;
		private var _charingTime:int = 5;		
		private var _bullet_ready:Boolean = true;
		
		//Comstructor
		public function Weapon(pstage:Stage,pactor:IActor,pvirtualWorld:b2World, pbody:Sprite, pxpos:Number,pypos:Number, pbodyInternalName:String )
		{
			super(pstage,pactor,pvirtualWorld,pbody);
			
			_xpos = pxpos;
			_ypos = pypos;
			_bodyInternalName = pbodyInternalName;
//			_actorStage = pactorStage;
		}
				
		//charging timer
		internal function time():void{
			_myTimer = new Timer(1000, _charingTime);			
			_myTimer.addEventListener(TimerEvent.TIMER, timerListener);
			_myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerDone);
			_myTimer.start();
		}
		
		private function timerListener (e:TimerEvent):void{
			_bullet_ready = false;
		}
		
		private function timerDone(e:TimerEvent):void{
			_myTimer.stop();
			_bullet_ready = true;
			//controlPanel.turn_green();
			_cant_shoot = 0;
		}
		
		//Properties
		public function get bullet_ready():Boolean{return _bullet_ready;}
		public function set bullet_ready(value:Boolean):void{_bullet_ready = value;}
		
		public function get cant_shoot():int{return _cant_shoot;}
		public function set cant_shoot(value:int):void{_cant_shoot = value;}
		 
		public function get decActor():Actor{return _actor;}
		public function set decActor(value:Actor):void{_actor = value;}
		
		public function get bodyInternalName():String{return _bodyInternalName;}
		
		public function set bodyInternalName(value:String):void{bodyInternalName = value;}
	}
}