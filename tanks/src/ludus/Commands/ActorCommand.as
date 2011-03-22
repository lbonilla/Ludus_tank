package ludus.Commands
{
	import ludus.IActor;

	public class ActorCommand
	{
		//Propiedades
		public function get actor():IActor
		{
			return _actor;
		}
		
		public function set actor(value:IActor):void
		{
			_actor = value;
		}
		
		//Atributos
		private var _actor :IActor;
		
		public function ActorCommand(pactor:IActor){
				_actor= pactor;
		}
		public function  execute(){}
		public function undo(){}
	}
}