package
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import ludus.*;
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.Commands.ActorCommandsManager;
	import ludus.b2_ludus.Actors.AerialVehicle;
	import ludus.b2_ludus.Actors.LandVehicle;
	import ludus.b2_ludus.Actors.Vehicle;
	import ludus.b2_ludus.Actors.b2_stage;
	import ludus.b2_ludus.Decorators.RocketLauncher;
	import ludus.b2_ludus.Decorators.Tracks;
	import ludus.b2_ludus.Decorators.Turret;
	import ludus.b2_ludus.Indicators.ControlPanel;
	import ludus.b2_ludus.Indicators.Healthbar;
	import ludus.b2_ludus.Indicators.Indicator;
	import ludus.b2_ludus.Observers.LifeObserver;
	import ludus.b2_ludus.b2_box;
	import ludus.b2_ludus.b2_contact;
	import ludus.b2_ludus.b2_globals;
	import ludus.b2_ludus.b2_polybox;
	import ludus.b2_ludus.b2_render;
	import ludus.b2_ludus.b2_rope;
	import ludus.b2_ludus.b2_world;
	import ludus.org.libspark.betweenas3.BetweenAS3;
	import ludus.org.libspark.betweenas3.easing.Quint;
	import ludus.org.libspark.betweenas3.tweens.ITween;

	[SWF(backgroundColor = "0xdedede", width="1500", height="350", frameRate="50")]
	public class main extends Sprite
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
		private var leftA,rightA,upA,downA,shootBulA, shootMisA, rl_leftA, rl_rightA:Boolean = false;
		private var leftB,rightB,upB,downB,shootBulB, shootMisB, rl_leftB, rl_rightB:Boolean = false;
		
		private var actor:IActor;
		private var actor2:IActor;
		var stage1: b2_stage ; 
		//collision
		private var contact_listener:b2_contact = new b2_contact();
		
		public function main()
		{	
			init();	
		}
		private function init(){
			
			//Metodos		
			createGround();
			 
			addChild(sky);
			addChild(back);
			addChild(ground);
			createGround();
			createHill();			
			createBridge();
			moveMcs();			
			drawDebug();					
			buildActors();			
			//messageObserver.Attach(actor);
			gestorComandos = new ActorCommandsManager();
			
			//Enventos
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		private function buildActors(){
			//Tank 1
			//actor = new b2_tank(world,150, 200, new blueTank_mc(),new blueWheel_mc(),new blueWheel_mc(),new blueCannon_mc());
			//actor = new Aer
			actor = new LandVehicle("blue",stage,stage1.virtualWorld, new blueTank_mc(),"tank",1200, 200,new blueWheel_mc(),new blueWheel_mc());		
			//actor = new AerialVehicle("blue",stage,stage1.virtualWorld,new blueTank_mc(),"tank",1200,200);
			actor.buildVirtualBody();			
			actor = new ControlPanel(actor,1200,5,0x36bfff);
			actor = new Turret(actor,actor.body,0,0,"cannon_mc", new blueBullet_mc());			
			actor = new RocketLauncher(actor,actor.body,0,0,"rl_mc");			
			//actor = new Tracks(actor,5,  1.5, 25, 16, 1, 2, 0,240, 60);
			//actor = new Tracks(actor,5,  1.5, 45, 40, 1, 2, 0,5, 2);
			actor = new Healthbar(actor) ;
			//Tank2	
			actor2 = new LandVehicle("red",stage,stage1.virtualWorld, new redTank_mc(),"tank",150,200,new redWheel_mc(),new redWheel_mc());
			actor2.buildVirtualBody();
			actor2 = new ControlPanel(actor2,200,5,0xff3636);
			actor2 = new Turret(actor2,actor2.body,0,0,"cannon_mc", new redBullet_mc());
			actor2 = new RocketLauncher(actor2,actor2.body,0,0,"rl_mc");
			actor2 = new Tracks(actor2,5,  1.5, 25, 16, 1, 2, 0,30, 60);//
			actor2 = new Healthbar(actor2) ;

			
		}
		private function drawDebug():void{
			var draw:b2_render = new b2_render();
			addChild(draw.create_BD(stage1.virtualWorld, globals.WORLD_SCALE));
		}
		public function tank_hit(action:String):void{
			if(action == "blue"){
				//bullet hits the red tank
				actor.reduceLife(20);
				if(actor.life <= 0){
					addChild(endGame);
					remove_listeners();
				}
			}else if(action == "red"){
				//bullet hits the blue tank
				actor2.reduceLife(20);
				if(actor2.life <= 0){
					addChild(endGame);
					remove_listeners();
				}
			}
		}
		private function remove_listeners():void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			removeEventListener(Event.ENTER_FRAME, update);
		}
		private function createGround():void{
			stage1 = new b2_stage();
			stage1.createGround(250,312,500,10,1,1,0);
			stage1.createGround(1300,312,500,10,1,1,0);
			stage1.virtualWorld.SetContactListener(contact_listener);
			contact_listener.hit.add(tank_hit);	
		}
		//create clouds
		private function moveMcs():void{
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
			stage1.createHill(550,308,-150,15,150,150);
			
			//hill 2
			stage1.createHill(978,311,-150,-150,-15,150);
			
		}
		
		//create bridge
		public function createBridge():void
		{
			stage1.createBridge(10,2,705,273,763,273);
		}
		
		//Eventos
		public function onKeyUp(e:KeyboardEvent):void{
			switch(e.keyCode){
				//tank A
				case 65:
					leftA = false;
					break;
				case 68:
					rightA = false;
					break;
				case 87:
					upA = false;
					break;
				case 83:
					downA = false;
					break;
				case 69:
					shootBulA = false;
					break;
				case 82:
					shootMisA = false;
					break;
				case 90:
					rl_leftA = false;
					break;
				case 88:
					rl_rightA = false;
					break;
				
				//tank B
				case 37:
					leftB = false;
					break;
				case 39:
					rightB = false;
					break;
				case 38:
					upB = false;
					break;
				case 40:
					downB = false;
					break;
				case 78:
					shootBulB = false;
					break;
				case 77:
					shootMisB = false;
					break;
				case 75:
					rl_leftB = false;
					break;
				case 76:
					rl_rightB = false;
					break;
			}
		}
		public function onKeyDown(e:KeyboardEvent):void{
			switch(e.keyCode){
				//tank A
				case 65:
					leftA = true;
					break;
				case 68:
					rightA = true;
					break;
				case 87:
					upA = true;
					break;
				case 83:
					downA = true;
					break;
				case 69:
					shootBulA = true;
					break;
				case 82:
					shootMisA = true;
					break;
				case 90:
					rl_leftA = true;
					break;
				case 88:
					rl_rightA = true;
					break;
				//tank B
				case 37:
					leftB = true;
					break;
				case 39:
					rightB = true;
					break;
				case 38:
					upB = true;
					break;
				case 40:
					downB = true;
					break;
				case 78:
					shootBulB = true;
					break;
				case 77:
					shootMisB = true;
					break;
				case 75:
					rl_leftB = true;
					break;
				case 76:
					rl_rightB = true;
					break;
			}
		}		

		private function update(e:Event):void{
			//tankA controls
			if(leftA){
				//add Command to move left
				gestorComandos.executeCommands(ActorCommandsManager.MOVELEFT,actor2);
			}
			if(rightA){
				//add command to move right
				gestorComandos.executeCommands(ActorCommandsManager.MOVERIGHT,actor2);
			}
			if(upA){
				//add command to move cannon left
				gestorComandos.executeCommands(ActorCommandsManager.MOVEUP,actor2);
			}
			if(downA){
				//add command to move cannon right
				gestorComandos.executeCommands(ActorCommandsManager.MOVEDOWM,actor2);	
			}
			if(shootBulA){
				//add command to shoot bullet
				gestorComandos.executeCommands(ActorCommandsManager.ATACK,actor2);
			}
				
			//tankB controls
			if(leftB){
				//add Command to move left
				gestorComandos.executeCommands(ActorCommandsManager.MOVELEFT,actor)
			}
			if(rightB){
				//add command to move right
				gestorComandos.executeCommands(ActorCommandsManager.MOVERIGHT,actor)
			}
			if(upB){
				//add command to move cannon left
				gestorComandos.executeCommands(ActorCommandsManager.MOVEUP,actor)
			}
			if(downB){
				//add command to move cannon right
				gestorComandos.executeCommands(ActorCommandsManager.MOVEDOWM,actor)	
			}
			if(shootBulB){
				//add command to shoot bullet
				gestorComandos.executeCommands(ActorCommandsManager.ATACK,actor)
			}
						
			actor.update_mc();
			actor2.update_mc();
			
			stage1.virtualWorld.Step(globals.TIME_STEP, globals.ITERATIONS, globals.POSITION_ITERATIONS);
			stage1.virtualWorld.ClearForces();
			stage1.virtualWorld.DrawDebugData();
			
			for(var worldBody:b2Body = stage1.virtualWorld.GetBodyList(); worldBody; worldBody = worldBody.GetNext()){
				if(worldBody.GetUserData() == "remove"){
					stage1.virtualWorld.DestroyBody(worldBody);
				}
			}
 		}
	}
	
}