package
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import ludus.*;
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Commands.ActorCommandsManager;
	import ludus.b2_ludus.Actors.LandVehicle;
	import ludus.b2_ludus.Actors.Vehicle;
	import ludus.b2_ludus.Decorators.RocketLauncher;
	import ludus.b2_ludus.Decorators.Turret;
	import ludus.b2_ludus.Indicators.Indicator;
	import ludus.b2_ludus.Observers.LifeObserver;
	import ludus.b2_ludus.b2_box;
	import ludus.b2_ludus.b2_contact;
	import ludus.b2_ludus.b2_globals;
	import ludus.b2_ludus.b2_polybox;
	import ludus.b2_ludus.b2_render;
	import ludus.b2_ludus.b2_rope;
	import ludus.b2_ludus.b2_tank;
	import ludus.b2_ludus.b2_world;
	import ludus.org.libspark.betweenas3.BetweenAS3;
	import ludus.org.libspark.betweenas3.easing.Quint;
	import ludus.org.libspark.betweenas3.tweens.ITween;

	[SWF(backgroundColor = "0xdedede", width="1500", height="350", frameRate="50")]
	public class Main extends Sprite
	{
		//Mc's
		private var sun:Sprite = new Sun();
		private var ground:Sprite = new Ground();
		private var back:Sprite = new Back_01();
		private var sky:Sprite = new Sky();
		private var cloud_01:Sprite = new Cloud_01();
		private var cloud_02:Sprite = new Cloud_02();
		private var cloud_03:Sprite = new Cloud_03();
		private var cloud_04:Sprite = new Cloud_04();
		private var endGame:Sprite = new endGame_mc();
		
		private var _tween_01:ITween;
		private var _tween_02:ITween;
		private var _tween_03:ITween;
		private var _tween_04:ITween;
	
		/* Atributs */
		private var globals:b2_globals = new b2_globals();
		private var gestorComandos:ActorCommandsManager;
		private var left,right,up,down,shoot:Boolean = false;
		private var actor:IActor;
		private var actor2:IActor;
		private var world:b2_world = new b2_world(globals.GRAVITY, true);
		
		//collision
		private var contact_listener:b2_contact = new b2_contact();
		
		public function Main()
		{	
			init();	
		}
		private function init(){
			
			//Metodos
		
			createGround();
			world.SetContactListener(contact_listener);
			addChild(sky);
			addChild(back);
			addChild(ground);
			createGround();
			createHill();			
			createBridge();
			moveMcs();			
			drawDebug();	
			var messageObserver:LifeObserver = new LifeObserver();
			
			//actor = new b2_tank(world,150, 200, new blueTank_mc(),new blueWheel_mc(),new blueWheel_mc(),new blueCannon_mc());
			actor = new LandVehicle(stage,world, new redTank_mc(),"tank",150, 200,new blueWheel_mc(),new blueWheel_mc(),messageObserver);
			actor.buildVirtualBody();
			actor = new Turret(stage,actor,world,actor.body,0,0,"cannon_mc", new redBullet_mc());			
			actor = new RocketLauncher(stage,actor,world,actor.body,0,0,"rl_mc");
			
			actor2 = new LandVehicle(stage,world, new redTank_mc(),"tank",200, 200,new blueWheel_mc(),new blueWheel_mc(),messageObserver);
			actor2.buildVirtualBody();
			messageObserver.Attach(actor);
			gestorComandos = new ActorCommandsManager();
			
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
			var ground1:b2Body = new b2_box().createBox(world,
				250 / globals.WORLD_SCALE, 
				312 / globals.WORLD_SCALE, 
				500 / globals.WORLD_SCALE / 2,
				10 / globals.WORLD_SCALE / 2,
				false, 1, 1, 0);
			
			var ground2:b2Body = new b2_box().createBox(world,
				1300 / globals.WORLD_SCALE, 
				312 / globals.WORLD_SCALE, 
				500 / globals.WORLD_SCALE / 2,
				10 / globals.WORLD_SCALE / 2,
				false, 1, 1, 0);
		}
		//create clouds
		private function moveMcs():void {
			
			
			cloud_01.x = 1700;
			cloud_01.y = 25;
			addChild(cloud_01);
			_tween_01 = BetweenAS3.tween(cloud_01, { x:-100 }, null, 650.0, Quint.easeOut);
			_tween_01.play();
			
			cloud_02.x = -100;
			cloud_02.y = 75;
			addChild(cloud_02);
			_tween_02 = BetweenAS3.tween(cloud_02, { x:1700 }, null, 720.0, Quint.easeOut);
			_tween_02.play();
			
			cloud_03.x = 500;
			cloud_03.y = 100;
			addChild(cloud_03);
			_tween_03 = BetweenAS3.tween(cloud_03, { x:1700 }, null, 650.0, Quint.easeOut);
			_tween_03.play();
			
			cloud_04.x = 1200;
			cloud_04.y = 125;
			addChild(cloud_04);
			_tween_04 = BetweenAS3.tween(cloud_04, { x:-100 }, null, 820.0, Quint.easeOut);
			_tween_04.play();
		}
		
		private function createHill():void{
			//hill 01
			var p1:b2Vec2 = new b2Vec2(-150 / globals.WORLD_SCALE, 0);
			var p2:b2Vec2 = new b2Vec2(15 / globals.WORLD_SCALE, -40 / globals.WORLD_SCALE);
			var p3:b2Vec2 = new b2Vec2(150 / globals.WORLD_SCALE, -40 / globals.WORLD_SCALE);
			var p4:b2Vec2 = new b2Vec2(150 / globals.WORLD_SCALE, 0);
			var vertex:Array = [p1, p2, p3, p4];
			
			var body:b2Body = new b2_polybox().createPolyBox(world, 
				550  / globals.WORLD_SCALE, 
				311 / globals.WORLD_SCALE, 
				vertex,
				false,
				0, 1, 0);
			//hill 2
			var p5:b2Vec2 = new b2Vec2(-150 / globals.WORLD_SCALE, 0);
			var p6:b2Vec2 = new b2Vec2(-150 / globals.WORLD_SCALE, -40 / globals.WORLD_SCALE);
			var p7:b2Vec2 = new b2Vec2(-15 / globals.WORLD_SCALE, -40 / globals.WORLD_SCALE);
			var p8:b2Vec2 = new b2Vec2(150 / globals.WORLD_SCALE, 0);
			var vertex2:Array = [p5, p6, p7, p8];
			
			
			var body2:b2Body = new b2_polybox().createPolyBox(world, 
				978  / globals.WORLD_SCALE, 
				311 / globals.WORLD_SCALE, 
				vertex2,
				false,
				0, 1, 0);
		}
		
		//create bridge
		public function createBridge():void
		{
			var a_pos:b2Vec2 = new b2Vec2(705, 273)
			var b_pos:b2Vec2 = new b2Vec2(763, 273);
			var rope:b2_rope = new b2_rope();
			rope.createRope(world, a_pos, b_pos, 10, 2);
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
			actor2.update_mc();
			world.Step(globals.TIME_STEP, globals.ITERATIONS, globals.POSITION_ITERATIONS);
			world.ClearForces();
			world.DrawDebugData();
		}
	}
	
}