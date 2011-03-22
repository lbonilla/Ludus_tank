package stats_ludus
{
	public class Theme
	{
		private var _bg:uint;
		private var _fps:uint; 
		private var _ms:uint; 
		private var _mem:uint; 
		private var _memmax:uint; 
		
		public function Theme()
		{
			bg = 0x000000;
			fps = 0xb3d9ff; 
			ms =  0x5aff49; 
			mem = 0xfcff0d;
			memmax = 0xff0000;
		}
		
		public function get bg():uint{return _bg;}
		public function get fps():uint{return _fps;}
		public function get ms():uint{return _ms;}
		public function get mem():uint{return _mem;}
		public function get memmax():uint{return _memmax;}

		public function set bg(value:uint):void{_bg = value;}
		public function set fps(value:uint):void{_fps = value;}
		public function set ms(value:uint):void{_ms = value;}
		public function set mem(value:uint):void{_mem = value;}
		public function set memmax(value:uint):void{_memmax = value;}
	}
}