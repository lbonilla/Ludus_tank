package ludus.b2_ludus.Observers
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Actor;
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	
	public class Observer
	{
		private var _observers:Vector.<IActor>;
		public function Observer()
		{
			_observers = new Vector.<IActor>();
		}
		public function Attach(pactor:IActor )
		{ 
			_observers.push(pactor);
			
		}
		public function Detach(pactor:IActor )
		{
			
		}
		public function Notify():void {
			
			for (var i:uint =0; i < _observers.length; i++) {
				_observers[i].update();
			}
		}
	}
}