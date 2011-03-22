package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;

	public class RotateLeft extends ActorCommand
	{
		public function RotateLeft(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.rotateLeft();	
		}
		public override function undo(){
			this.actor.rotateRight();
		}
	}
}