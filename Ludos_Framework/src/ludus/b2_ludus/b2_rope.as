package ludus.b2_ludus
{
	import ludus.Box2D.Common.Math.b2Vec2;
	import ludus.Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import ludus.Box2D.Dynamics.b2Body;
	import ludus.Box2D.Dynamics.b2World;

	/**
	 * First sentence of a multi-paragraph main
	 * <p>Second paragraph of the description.</p>
	 * @author Ludus Team
	 * this class is on charge of creating a rope horizontantly
	 * @langversion ActionScript 3.0
     * @playerversion Flash 8 - 10
	 * @param param2 Describe param2 here.
	 * @see someOtherFunction
	 * */
	public class b2_rope
	{
		private var globals:b2_globals = new b2_globals();
		
		public function createRope(world:b2World, a_pos:b2Vec2, b_pos:b2Vec2, cantBoxes:int, ropeWidth:Number):void{
			var x_dist:int = b_pos.x - a_pos.x;
			var body_width:Number = x_dist / cantBoxes;
			var space_between:Number = 0;
			var xpos:Number = a_pos.x;
			var ypos:Number = a_pos.y;
			
			//frist body
			var tbody:b2Body;
			var first_body:b2Body;
			var body:b2Body;
			var anchor:b2Vec2 = new b2Vec2(0, 0);
			
			
			//frist anchor body
			var first_anchor_body:b2Body = new b2_box().createBox(world, 
																  a_pos.x / globals.WORLD_SCALE  - body_width / globals.WORLD_SCALE,
																  a_pos.y / globals.WORLD_SCALE,
																  ropeWidth / globals.WORLD_SCALE,
																  ropeWidth / globals.WORLD_SCALE,
																  false,
																  0, 0, 0);
			
			
			//join definition
			var join_def:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			for(var i:int = 0; i <= cantBoxes; i++){
				body = new b2_box().createBox(world,
											  xpos / globals.WORLD_SCALE,
											  ypos / globals.WORLD_SCALE,
											  body_width / globals.WORLD_SCALE,
											  ropeWidth / globals.WORLD_SCALE,
											  true,
											  1,
											  1,
											  0);
				
				if(i != 0 && i < cantBoxes ){
					
					anchor.x = body.GetPosition().x - body_width / globals.WORLD_SCALE;
					anchor.y = body.GetPosition().y;
					join_def.Initialize(body, tbody, anchor);
					world.CreateJoint(join_def);
					
				}else if(i == cantBoxes){
					
					anchor.x = body.GetPosition().x - body_width / globals.WORLD_SCALE;
					anchor.y = body.GetPosition().y;
					join_def.Initialize(body, tbody, anchor);
					world.CreateJoint(join_def);
					
					
					//the position for the second anchor point is not correct
					//once the rope can be create on angle this position needs
					//to be set when the rope is create.
					var second_anchor_body:b2Body = new b2_box().createBox(world, 
																		   body.GetPosition().x  + body_width / globals.WORLD_SCALE,
																		   b_pos.y / globals.WORLD_SCALE,
																		   ropeWidth / globals.WORLD_SCALE,
																		   ropeWidth / globals.WORLD_SCALE,
																		   false,
																		   0, 0, 0);
					
					anchor.x = body.GetPosition().x;
					anchor.y = body.GetPosition().y;
					join_def.Initialize(body, second_anchor_body, anchor);
					world.CreateJoint(join_def);
					
				}else{
					first_body = body;
					join_def.Initialize(first_body, first_anchor_body, first_body.GetWorldCenter());
					world.CreateJoint(join_def);
				}
				
				tbody = body;
				xpos += body_width + body_width + space_between;
			}
		}
	}
}