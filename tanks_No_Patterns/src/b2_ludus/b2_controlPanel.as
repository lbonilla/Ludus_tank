package b2_ludus
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * @author Ludus Team
	 */
	public class b2_controlPanel extends Sprite
	{
		private var background:Sprite = new Sprite();
		private var tittle:TextField = new TextField();
		
		private var health:TextField = new TextField();
		private var bullets:TextField = new TextField();
		
		private var green_light:Sprite = new Sprite();
		private var red_light:Sprite = new Sprite();
		
		public function b2_controlPanel(color:uint)
		{
			//background box
			background.graphics.beginFill(0x000000, 0.5);
			background.graphics.drawRoundRect(0, 0, 80, 40, 8, 8);
			background.graphics.endFill();
			addChild(background);
			
			//green_light
			green_light.graphics.beginFill(0x00ff18, 1);
			green_light.graphics.drawCircle(0, 0, 3);
			green_light.graphics.endFill();
			green_light.x = 73;
			green_light.y = 10;
			addChild(green_light);
			
			//red_light
			red_light.graphics.beginFill(0xff0000, 1);
			red_light.graphics.drawCircle(0, 0, 3);
			red_light.graphics.endFill();
			red_light.x = 73;
			red_light.y = 10;
			
			//health tittle
			tittle.text = "Health: ";
			tittle.textColor = color;
			tittle.x = 3;
			tittle.y = 3;
			addChild(tittle);
			
			//bullet tittle
			tittle = new TextField();
			tittle.text = "Bullets: ";
			tittle.textColor = color;
			tittle.x = 3;
			tittle.y = 17;
			addChild(tittle);
			
			//health txt
			health.text = "100";
			health.textColor = color;
			health.x = 43;
			health.y = 3;
			addChild(health);
			
			//bullets
			bullets.text = "10";
			bullets.textColor = color;
			bullets.x = 43;
			bullets.y = 17;
			addChild(bullets);
		}
		
		public function turn_red():void{
			addChild(red_light);
			removeChild(green_light);
		}
		
		public function turn_green():void{
			addChild(green_light);
			removeChild(red_light);
		}
		
		public function setHealth(health:Number):void{
			this.health.text = ""+health;
		}
		
		public function setBullets(bullets:Number):void{
			this.bullets.text = "" + bullets;
		}
	}
}