package ludus.Commands
{
	import ludus.Commands.ActorCommands.Attak;
	import ludus.Commands.ActorCommands.Defend;
	import ludus.Commands.ActorCommands.MoveDown;
	import ludus.Commands.ActorCommands.MoveLeft;
	import ludus.Commands.ActorCommands.MoveRight;
	import ludus.Commands.ActorCommands.MoveUp;
	import ludus.Commands.ActorCommands.RotateLeft;
	import ludus.Commands.ActorCommands.RotateRight;
	import ludus.IActor;

	public class ActorCommandsManager
	{
		//Constantes
		public static const ATACK:String = "atack";
		public static const DEFEND:String = "defend";
		public static const MOVEUP:String = "moveup";
		public static const MOVEDOWM:String = "movedown";
		public static const MOVELEFT:String = "moveleft";
		public static const MOVERIGHT:String = "moveright";
		public static const ROTATELEFT:String = "rotateleft";
		public static const ROTATERIGHT:String = "rotateright";
		
		//Constructor
		public function ActorCommandsManager();
		//Metodos
		public function executeCommands(paccion:String, pobjeto:IActor){
			var comando:ActorCommand;  
			switch(paccion){
				case ATACK:
					
					
					comando=new Attak(pobjeto);
					break;
				
				case DEFEND:
					comando=new Defend(pobjeto);
					break;
				
				case MOVEDOWM:
					comando=new MoveDown(pobjeto);
					break;
				
				case MOVEUP:
					comando=new MoveUp(pobjeto);
					break;
				
				case MOVERIGHT:
					comando=new MoveRight(pobjeto);
					break;
				
				case MOVELEFT:
					comando=new MoveLeft(pobjeto)
					break;
				
				case ROTATERIGHT:
					comando=new RotateRight(pobjeto)
					break;
				
				case ROTATELEFT:
					comando=new RotateLeft(pobjeto)
					break;
				
			}
			if(comando != null){
				comando.execute();		
			}
			
		} 
	}
}