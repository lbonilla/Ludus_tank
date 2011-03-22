package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;

	public class MoveLeft extends ActorCommand
	{
		public function MoveLeft(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.moveLeft();	
		}
		public override function undo(){
			this.actor.moveRight();
		}
	}
}