package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;

	public class RotateRight extends ActorCommand
	{
		public function RotateRight(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.rotateRight();	
		}
		public override function undo(){
			this.actor.rotateLeft();
		}
	}
}