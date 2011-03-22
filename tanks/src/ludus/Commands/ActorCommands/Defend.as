package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;

	public class Defend extends ActorCommand
	{
		public function Defend(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.defend();	
		}
		public override function undo(){
			this.actor.attack();
		}
	}
}