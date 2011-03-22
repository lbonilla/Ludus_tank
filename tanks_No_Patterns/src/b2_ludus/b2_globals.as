package b2_ludus
{
	import Box2D.Common.Math.b2Vec2;
	/**
	 * @author Ludus Team
	 */
	public class b2_globals
	{
		private var _WORLD_SCALE:int = 30;
		private var _GRAVITY:b2Vec2 = new b2Vec2(0, 9.8);
		private var _ANTI_GRAVITY:b2Vec2 = new b2Vec2(0, -9.8);
		
		// --- time step
		//Integrators simulate the physics equations at discrete points of time. 
		//This goes along with the traditional game loop where we essentially have 
		//a flip book of movement on the screen. So we need to pick a time step 
		//for Box2D. Generally physics engines for games like a time step at 
		//least as fast as 60Hz or 1/60 seconds. 
		private var _TIME_STEP:Number = 1.0 / 50.0;
		
		// --- iterations -- 
		//Box2D also uses a larger bit of code called a constraint solver. 
		//The constraint solver solves all the constraints in the simulation, 
		//one at a time. A single constraint can be solved perfectly. However, 
		//when we solve one constraint, we slightly disrupt other constraints. 
		//To get a good solution, we need to iterate over all constraints a number of times. 
		//The suggested iteration count for Box2D is 10.
		private var _ITERATIONS:int = 10;
		
		//position itarations
		private var _POSITION_ITERATIONS:int = 10;

		public function get WORLD_SCALE():int{return _WORLD_SCALE;}
		public function get GRAVITY():b2Vec2{return _GRAVITY;}
		public function get ANTI_GRAVITY():b2Vec2{return _ANTI_GRAVITY;}
		public function get TIME_STEP():Number{return _TIME_STEP;}
		public function get ITERATIONS():int{return _ITERATIONS;}
		public function get POSITION_ITERATIONS():int{return _ITERATIONS;}
		
		public function set WORLD_SCALE(value:int):void{_WORLD_SCALE = value;}
		public function set GRAVITY(value:b2Vec2):void{_GRAVITY = value;}
		public function set ANTI_GRAVITY(value:b2Vec2):void{ANTI_GRAVITY = value;}
		public function set TIME_STEP(value:Number):void{_TIME_STEP = value;}
		public function set ITERATIONS(value:int):void{_ITERATIONS = value;}
		public function set POSITION_ITERATIONS(value:int):void{_ITERATIONS = value;}
	}
}