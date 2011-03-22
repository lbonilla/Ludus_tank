package ludus.b2_ludus
{
	import ludus.Box2D.Dynamics.b2DebugDraw;
	import ludus.Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	
	public class b2_render extends Sprite
	{
		public function create_BD(world:b2World, worldScale:int):Sprite{
			var debug_draw:b2DebugDraw = new b2DebugDraw();
			var debug_sprite:Sprite = new Sprite();
			debug_draw.SetSprite(debug_sprite);
			debug_draw.SetDrawScale(worldScale);
			debug_draw.SetLineThickness(1.0);
			debug_draw.SetAlpha(1);
			debug_draw.SetFillAlpha(0.5);
			debug_draw.SetFlags(b2DebugDraw.e_jointBit | b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(debug_draw);
			return debug_sprite
		}
	}
}