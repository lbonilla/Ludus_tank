package
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import ludus.*;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Commands.ActorCommandsManager;
	import ludus.b2_ludus.b2_box;
	import ludus.b2_ludus.b2_globals;
	import ludus.b2_ludus.b2_render;
	import ludus.b2_ludus.b2_tank;
	import ludus.b2_ludus.b2_world;
	
	[SWF(backgroundColor = "0xdedede", width="500", height="300", frameRate="50")]
	public class Tank extends Sprite
	{
		/* Atributs */
		private var globals:b2_globals = new b2_globals();
		private var gestorComandos:ActorCommandsManager;
		private var left,right,up,down,shoot:Boolean = false;
		private var actor:Actor;
		private var world:b2_world = new b2_world(globals.GRAVITY, true);
		
		public function Tank(){
			init();							
		}
		
		private function init(){
			//Metodos
			drawDebug();
			createGround();
			actor = new b2_tank(world,150, 200, new Tank_mc(),new Wheel_mc(),new Wheel_mc(),new Cannon_mc()); 
			//(Tank_mc,Wheel_mc,Cannon_mc);
			gestorComandos = new ActorCommandsManager();
			
			this.addChild(actor);
			//Enventos
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function drawDebug():void{
			var draw:b2_render = new b2_render();
			addChild(draw.create_BD(world, globals.WORLD_SCALE));
		}
		private function createGround():void{
			var ground:b2Body = new b2_box().createBox(world, 
				150 / globals.WORLD_SCALE, 
				285 / globals.WORLD_SCALE,
				stage.stageWidth / globals.WORLD_SCALE,
				20 / globals.WORLD_SCALE / 2,
				false, 1, 1, 0);	  
		}
		
		//Eventos
		public function onKeyUp(e:KeyboardEvent):void{
			switch(e.keyCode){
				case 37://left
					left = false;
					break;
				case 39://right
					right = false;
					break;
				case 38:
					up = false;
					break;
				case 40:
					down = false;
					break;
				case 77:
					shoot = false;
					break;
			}
		}
		
		public function onKeyDown(e:KeyboardEvent):void{
			switch(e.keyCode){
				case 37:
					left = true;
					break;
				case 39:
					right = true;
					break;
				case 38:
					up = true;
					break;
				case 40:
					down = true;
					break;
				case 77:
					shoot = true;
					break;
			}
		}
		
		private function update(e:Event):void{
			
			if (left) {
				gestorComandos.executeCommands(ActorCommandsManager.MOVELEFT,actor)
			}
			if (right) {
				
				gestorComandos.executeCommands(ActorCommandsManager.MOVERIGHT,actor)
			}
			if (up) {
				
				gestorComandos.executeCommands(ActorCommandsManager.MOVEUP,actor)
			}
			if (down) {
				gestorComandos.executeCommands(ActorCommandsManager.MOVEDOWM,actor)
				
			}
			if(shoot){
				gestorComandos.executeCommands(ActorCommandsManager.ATACK,actor)	
			}
			
			actor.update_mc();
			world.Step(globals.TIME_STEP, globals.ITERATIONS, globals.POSITION_ITERATIONS);
			world.ClearForces();
			world.DrawDebugData();
	}
}
}