package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	 /**
	  * ...
	  * @author Beau Arthurs and Niek Schoone
	  */
	public class Player extends MovieClip
	{
		public static var hero  : 	Dragon = new Dragon;
		private var directionX 	: 	int = 0;
		private var directionY 	:	int = 0;
		private var waitTimer	:	Timer;
		private var canShoot	:	Boolean = true;
		public function Player():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(hero);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		   
			waitTimer  = new Timer(500, 2);
			waitTimer.addEventListener(TimerEvent.TIMER, waitEvent);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, fire);
		  }
		  
		public function heroRotation() : Number
		{
			return hero.rotation;
		}
		  
		private function keyDown (e:KeyboardEvent):void
		{
			if (e.keyCode == 37) //left
			{
				directionX = -1;
			}
			if (e.keyCode ==  39) //right
			{
				directionX = +1;
			}
			if (e.keyCode ==  38) //up
			{
				directionY = -1;
			}
			if (e.keyCode ==  40) //down
			{
				directionY = +1;
			}
		  }
		  
		private function keyUp (e:KeyboardEvent):void
		{
			if (e.keyCode == 37 || e.keyCode == 39 )
			{
				directionX = 0;
			}
			if (e.keyCode == 38 || e.keyCode == 40 )
			{
				directionY = 0;
			}
		}
	
		public function update ():void
		{
			var xDifference : Number = mouseX - hero.x;
			var yDifference : Number = mouseY - hero.y;
		   	
			var rotationInRadians : Number = Math.atan2(yDifference, xDifference);
		    
			hero.rotation = rotationInRadians * (180 / Math.PI);
			
			this.y += 6 * directionY;
			this.x += 6 * directionX;
			
			while (Levels.castle.hitTestPoint(this.x , this.y -30, true))
			{
			this.y += 1;
			}
			
			while (Levels.castle.hitTestPoint(this.x, this.y +30, true))
			{
			this.y -= 1;
			}
			
			while (Levels.castle.hitTestPoint(this.x -30, this.y , true))
			{
			this.x += 1;
			}
			
			while (Levels.castle.hitTestPoint(this.x +30, this.y, true))
			{
			this.x -= 1;
			}
		}
		private function fire(e:MouseEvent):void 
		{
			if (canShoot)
			{
			dispatchEvent(new Event("FIRE"));
			canShoot = false;
			waitTimer.start();
			}
		}
		private function waitEvent(e:TimerEvent):void 
		 {
		  if (waitTimer.currentCount < 2)
		  {
			canShoot = true;
			waitTimer.reset();
		  }
		 }
	}
}