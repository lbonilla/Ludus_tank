package ludus.b2_ludus.Observers
{
	public class LifeObserver extends Observer
	{
		private var _life:Number;
		public function LifeObserver()
		{
			super();
		}
		// Gets or sets subject state		
		public function get life():Number{return _life;}
		public function set life(value:Number):void{_life = value;}
	}
}