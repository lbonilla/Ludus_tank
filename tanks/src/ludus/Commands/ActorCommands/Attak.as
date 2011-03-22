package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;

	public class Attak extends ActorCommand
	{
		public function Attak(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.attack();	
		}
		public override function undo(){
			this.actor.defend();
		}
	}
}