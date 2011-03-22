package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;

	public class MoveRight extends ActorCommand
	{
		public function MoveRight(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.moveRight();	
		}
		public override function undo(){
			this.actor.moveLeft();
		}
	}
}