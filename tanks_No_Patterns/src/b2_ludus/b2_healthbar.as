package b2_ludus
{
	/**
	 Created by: Bluemagica
	 Date: 19/4/2009
	 site: blog.bluemagica.com
	 
	 usage:-
	 healthbar(type,current health,maximum health,width,height, automatic, rate, full color,empty color, sprite, frames, number of bubbles);
	*/
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	
	public class b2_healthbar extends Sprite
	{
		private var maxHp:Number = 100;
		private var curHp:Number = 100;
		private var type:Number = 0; //0=rect,1=circle,2=sprite,3=mc
		private var auto:Number = 0; //0=not activated, 1= decrease, 2=increase, 3=both;
		private var wid:Number = 200;
		private var hig:Number = 20;
		private var rate:Number = 5;
		private var fcolor;
		private var ecolor;
		private var alph:int;
		private var spr;
		private var frame;
		private var life;
		private var hasMC:Boolean = false;
		private var mcArr:Array = new Array();
		public var border = 0x000000;

		
		private var goto = 100;
		private var blink = false;
		private var blinkCol = false;
		private var timer:Timer;
		
		
		public function b2_healthbar(typ=0, chp=100, mhp=100, w=20, h=3, aut=0, rat=1, fcol=0x00cc00, ecol=0xff0000, spri=null, frm=1, lif=10)		
		{			
			maxHp = mhp;
			curHp = chp;
			type = typ;
			auto = aut;
			rate = rat;
			wid = w;
			hig = h;
			fcolor = fcol;
			ecolor = ecol;
			spr = spri;
			frame=frm;
			life=lif;
			goto = 0;
			timer = new Timer(100);
			blink=blinkCol=false;
			alph = 1;
			
			if(auto>3 || auto<0)
			{
				auto = 0; 
			}
			if(type>3 || type<0)
			{
				type = 0;
			}
			this.addEventListener(Event.ENTER_FRAME,eframe,false,0,true);
			timer.addEventListener(TimerEvent.TIMER,tick);
			this.update(curHp);
		}
		
		private function tick(e:TimerEvent)
		{
			if(blinkCol==true)
			{
				alph=0;
				blinkCol=false;
			}
			else if(blinkCol==false)
			{
				alph=1;
				blinkCol=true;
			}
			this.update(curHp);
		}
		
		private function eframe(e:Event)
		{
			if(auto>0)
			{
				if(auto==1)
				{
					if((curHp-rate)>=0)
					  curHp-=rate;
					else
					  curHp=0;
				}
				else if(auto==2)
				{
					if((curHp+rate)<=maxHp)
						curHp+=rate;
					else
						curHp = maxHp;
				}
				else if(auto==3)
				{
					if(goto==0 && (curHp-rate)>=0)
						curHp-=rate;
					else if(goto==0 && (curHp-rate)<0)
					{
						curHp=0;
						goto=maxHp;
					}
					if(goto==maxHp && (curHp+rate)<=maxHp)
						curHp+=rate;
					else if(goto==maxHp && (curHp+rate)>maxHp)
					{
						curHp=maxHp;
						goto=0;
					}
				}
				this.update(curHp);
			}
			else if((curHp/maxHp*100)<=30 && blink==false)
			{
				blink = true;
				timer.start()
			}
			else if((curHp/maxHp*100)>30 && blink==true)
			{
				blink = false;
				alph=1;
				timer.stop();
			}
		}
		
		
		
		public function update(currHp)
		{
			if(currHp<0)
			{
				currHp = 0;
			}
			else if(curHp>maxHp)
			{
				currHp = maxHp;
			}
			else
			{
				curHp = currHp;
			}
			if(type==0)
			{
				this.graphics.clear();
				this.graphics.beginFill(border, 0.5);
				if(wid<hig)
					this.graphics.drawRect(0,0,wid+4,-(hig+4));
				else
					this.graphics.drawRect(0,0,wid+4,hig+4);
				this.graphics.endFill();
				this.graphics.beginFill(newEcol(),alph);
				if(wid>=hig)
					this.graphics.drawRect(2,2,(wid/maxHp)*curHp,hig);
				else
					this.graphics.drawRect(2,-2,wid,-(hig/maxHp)*curHp);
				this.graphics.endFill();
			}
			else if(type==1)
			{
				var startAngle = 90;
				var arc = (360/maxHp)*curHp;
				var radius = wid/2;
				var yRadius = hig/2;
				var segAngle, theta, angle, angleMid, segs, ax, ay, bx, by, cx, cy;
				if(Math.abs(arc)>360)
					arc = 360;
				segs = Math.ceil(Math.abs(arc)/45);
				segAngle = arc/segs;
				theta = -(segAngle/180)*Math.PI;
				angle = -(startAngle/180)*Math.PI;
				if (segs>0 && currHp>0)
				{
					ax = Math.cos(startAngle/180*Math.PI)*radius;
					ay = Math.sin(-startAngle/180*Math.PI)*yRadius;
					this.graphics.clear();
					this.graphics.lineStyle(2,border);
					this.graphics.beginFill(newEcol(), alph);
					this.graphics.lineTo(ax, ay);
					for (var i = 0; i<segs; i++)
					{
						angle += theta;
						angleMid = angle-(theta/2);
						bx = Math.cos(angle)*radius;
						by = Math.sin(angle)*yRadius;
						cx = Math.cos(angleMid)*(radius/Math.cos(theta/2));
						cy = Math.sin(angleMid)*(yRadius/Math.cos(theta/2));
						this.graphics.curveTo(cx, cy, bx, by);
					}
				this.graphics.lineTo(0,0);
				this.graphics.endFill();
				}
			}
			else if(type==2)
			{
				if(hasMC==false)
				{
					for(var mi=0; mi<Math.round(life);mi++)
					{
					 	var tempSpr = new spr();
						tempSpr.x = mi*(wid/4)*5;
						tempSpr.y = 0;
						mcArr.push(tempSpr);
						addChild(tempSpr);
					}
					hasMC = true;
				}
				var tCount = Math.ceil((life*frame)/maxHp*curHp);
				for(var j=0; j<mcArr.length; j++)
				{
					if(tCount>=frame)
					{
						mcArr[j].gotoAndStop(frame);
						tCount-=frame;
					}
					else if(tCount>=1)
					{
						mcArr[j].gotoAndStop(tCount);
						tCount=0;
					}
					else
						mcArr[j].gotoAndStop(1);
				 	mcArr[j].alpha=alph;
				}
			}
		}
		
		private function newEcol()
		{
			var r1 = fcolor >> 16;
			var g1 = (fcolor-(r1 << 16)) >> 8;
			var b1 = (fcolor-(r1 << 16)-(g1 << 8));
			var r2 = ecolor >> 16;
			var g2 = (ecolor-(r2 << 16)) >> 8;
			var b2 = (ecolor-(r2 << 16)-(g2 << 8));
			var r3 = r2+(r1-r2)*((curHp/maxHp*100)/100);
			var g3 = g2+(g1-g2)*((curHp/maxHp*100)/100);
			var b3 = b2+(b1-b2)*((curHp/maxHp*100)/100);
			return('0x' + (r3 << 16 | g3 << 8 | b3).toString(16));			
		}
		
		public function getPower()
		{
			return curHp;
		}
		
	}
}