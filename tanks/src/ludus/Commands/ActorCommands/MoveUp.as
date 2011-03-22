package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;
	
	public class MoveUp extends ActorCommand
	{
		public function MoveUp(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.moveUp();	
		}
		public override function undo(){
			this.actor.moveDown();
		}
	}
}