package ludus.b2_ludus.Indicators
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ludus.Box2D.Dynamics.b2World;
	import ludus.IActor;
	import ludus.b2_ludus.b2_controlPanel;

	public class ControlPanel extends Indicator
	{
		private var controlPanel:b2_controlPanel;
		private var pos_x:Number;
		private var pos_y:Number;
		private var _color:uint;
		public function ControlPanel( pactor:IActor,pposx:Number, pposy:Number, pcolor:uint)
		{
			super( pactor,  pactor.body);			
			controlPanel = new b2_controlPanel(pcolor);
			pactor.stage.addChild(controlPanel);
			pos_x =pposx;
			pos_y = pposy;
			controlPanel.x = pposx;
			controlPanel.y = pposy;
			
		}
		public override function update_mc(){
		 //controlPanel.setBullets(this.actor.
			super.update_mc();
			controlPanel.setHealth(actor.life);
			controlPanel.setBullets(actor.strikeCapability);
		}
		/*public override function shoot bullet
		controlPanel.setBullets(cant_bullet);
		controlPanel.turn_red();
		*/
		/*
		private function timerDone(e:TimerEvent):void{
		myTimer.stop();
		bullet_ready = true;
		controlPanel.turn_green();
		cant_bullet_shoot = 0;
		}
		
		public function reduce_life():void{
		_life = life - bullet_damage;
		controlPanel.setHealth(life);
		healthbar.update(_life);
		}
		*/
		
	}
}