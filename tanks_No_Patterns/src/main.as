package
{
	/**
	 * @author Ludus Team
	 * @TODO _ CODE
	 * 1. create the control panel OK jan/30/2011
	 * 2. create the winner window
	 * 3. create the
	 * 4. make tracks take ths skin
	 * 
	 * @TODO - GRAPHICS 
	 * 1. create graphics for tanks
	 * 2. create the control panel graphics
	 * 3. create graphics for tracks
	 */
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import b2_ludus.*;

	import fl.motion.ITween;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.engine.EastAsianJustifier;
	import flash.utils.Timer;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Expo;
	import org.libspark.betweenas3.easing.Linear;
	import org.libspark.betweenas3.easing.Quint;
	import org.libspark.betweenas3.tweens.ITween;
	
	import stats_ludus.Stats;
	
	[SWF(backgroundColor = "0xdedede", width="1500", height="350", frameRate="50")]
	public class main extends Sprite
	{
		//stage mc
		private var sun:Sprite = new Sun();
		private var ground:Sprite = new Ground();
		private var back:Sprite = new Back_01();
		private var sky:Sprite = new Sky();
		private var cloud_01:Sprite = new Cloud_01();
		private var cloud_02:Sprite = new Cloud_02();
		private var cloud_03:Sprite = new Cloud_03();
		private var cloud_04:Sprite = new Cloud_04();
		private var endGame:Sprite = new endGame_mc();
		
		private var globals:b2_globals = new b2_globals();
		private var world:b2_world = new b2_world(globals.GRAVITY, true);
		
		private var tankA:b2_tank;
		private var tankB:b2_tank;
		
		private var leftA,rightA,upA,downA,shootBulA, shootMisA, rl_leftA, rl_rightA:Boolean = false;
		private var leftB,rightB,upB,downB,shootBulB, shootMisB, rl_leftB, rl_rightB:Boolean = false;
		
		private var _tween_01:org.libspark.betweenas3.tweens.ITween;
		private var _tween_02:org.libspark.betweenas3.tweens.ITween;
		private var _tween_03:org.libspark.betweenas3.tweens.ITween;
		private var _tween_04:org.libspark.betweenas3.tweens.ITween;
		
		//collision
		private var contact_listener:b2_contact = new b2_contact();
		
		public function main()
		{
			
			world.SetContactListener(contact_listener);
			addChild(sky);
			//sun.y = 100;
			//sun.x = 1200;
			//addChild(sun);
			addChild(back);
			drawDebug();
			addChild(ground);
			
			createGround();
			createHill();
			createTank();
			createBridge();
			
			for (var i:int = 1; i <= 40; i++) {
				//createCircle(Math.random() * 2000, 60, Math.random() * 5);
			}
			
			moveMcs();
			
			var stats:Stats = new Stats();
			stats.x = 5;
			stats.y = 5;
			addChild(stats);
			
			var logo:Sprite = new ludusLogo();
			logo.x = 80;
			logo.y = 5;
			addChild(logo);
		
			
			
			contact_listener.hit.add(tank_hit);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function tank_hit(action:String):void{
			if(action == "red"){
				//bullet hits the red tank
				tankA.reduce_life();
				if(tankA.life <= 0){
					addChild(endGame);
					remove_listeners();
				}
			}else if(action == "blue"){
				//bullet hits the blue tank
				tankB.reduce_life();
				if(tankB.life <= 0){
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
		
		public function createCircle(px:Number, py:Number, r:Number):void {
			var circle:b2Body = new b2_circle().createCircle(world, px / globals.WORLD_SCALE, py / globals.WORLD_SCALE, r/ globals.WORLD_SCALE, true, 1, 1, 0); 
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
		
		//create tank
		private function createTank():void
		{
			tankA = new b2_tank(1);
			tankA.createTank(world, 50, 150, 10, 60);
			addChild(tankA);

			tankB = new b2_tank(2);
			tankB.createTank(world, 1300, 150, 260, 60);
			addChild(tankB);
		
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
				tankA.moveLeft();
			}
			if(rightA){
				//add command to move right
				tankA.moveRight();
			}
			if(upA){
				//add command to move cannon left
				tankA.rotateCannon_Left();
			}
			if(downA){
				//add command to move cannon right
				tankA.rotateCannon_Right();	
			}
			if(shootBulA){
				//add command to shoot bullet
				tankA.shootBullet();
			}
			if(shootMisA){
				//add command to shoot missil
				tankA.shootMissil();
			}
			if(rl_leftA){
				tankA.rotateRL_Left();
			}
			if(rl_rightA){
				tankA.rotateRL_Right();
			}
			
			//tankB controls
			if(leftB){
				//add Command to move left
				tankB.moveLeft();
			}
			if(rightB){
				//add command to move right
				tankB.moveRight();
			}
			if(upB){
				//add command to move cannon left
				tankB.rotateCannon_Left();
			}
			if(downB){
				//add command to move cannon right
				tankB.rotateCannon_Right();	
			}
			if(shootBulB){
				//add command to shoot bullet
				tankB.shootBullet();
			}
			if(shootMisB){
				//add command to shoot missil
				tankB.shootMissil();
			}
			if(rl_leftB){
				tankB.rotateRL_Left();
			}
			if(rl_rightB){
				tankB.rotateRL_Right();
			}
			
			tankA.update_mc();
			tankB.update_mc();
			
			world.Step(globals.TIME_STEP, globals.ITERATIONS, globals.POSITION_ITERATIONS);
			world.ClearForces();
			world.DrawDebugData();
			
			for(var worldBody:b2Body = world.GetBodyList(); worldBody; worldBody = worldBody.GetNext()){
				if(worldBody.GetUserData() == "remove"){
					world.DestroyBody(worldBody);
				}
			}
		}
	}
}