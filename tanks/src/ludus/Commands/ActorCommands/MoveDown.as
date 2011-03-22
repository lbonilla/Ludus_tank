package ludus.Commands.ActorCommands
{
	import ludus.Commands.ActorCommand;
	import ludus.IActor;
	
	public class MoveDown extends ActorCommand
	{
		public function MoveDown(pactor:IActor)
		{
			super(pactor);
		}
		public override function execute(){
			this.actor.moveDown();	
		}
		public override function undo(){
			this.actor.moveUp();
		}
	}
}