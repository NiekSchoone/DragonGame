package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Attack extends Sprite 
	{
		private var attack	:	MovieClip;
		private var stepX	:	Number;
		private var stepY	:	Number;
		private var speed	:	Number;
		public var toRemove	:	Boolean = false;
		
		public function Attack()
		{
			
			speed		=	20;
			
			attack		=	new FireBall();
			
			addChild(attack);
		}
		
		public function setDirection(angle : Number ) : void
		{
			var radian	:	Number	=	angle / (180 / Math.PI);
			stepX	=	Math.cos( radian ) * speed;
			stepY	=	Math.sin( radian ) * speed;
		}
	
		
		public function update() : void
		{
			this.x	+=	stepX;
			this.y	+=	stepY;
		}
	}
}