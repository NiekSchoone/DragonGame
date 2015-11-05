package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Beau Arthurs and Niek Schoone
	 */
	public class Ai extends MovieClip 
	{
		public var atWall			:	Boolean = false;
		public var damage			:	int;
		public var enemyLocation	:	Vector3D;
		public var targetLocation	:	Vector3D;
		public var velocity			:	Vector3D;
		private var speed			:	int = 2;
		public var shooting		:	Boolean = false;
		public var target:MovieClip;
		
		public function Ai() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event = null):void 
		{
			enemyLocation = new Vector3D(this.x, this.y);
			targetLocation = new Vector3D(target.x, target.y);
			
			
		}
		public function update():void
		{
			var rad:Number = Math.atan2(this.y - target.y, this.x - target.x);
			this.rotation = rad * (180/Math.PI) + 180;
			targetLocation = new Vector3D(target.x, target.y);
			if (atWall == false)
			{
			enemyLocation = new Vector3D(this.x, this.y);
			velocity = targetLocation.subtract(enemyLocation);
			velocity.normalize();
			velocity.scaleBy(speed);
			this.x += velocity.x;
			this.y += velocity.y;
			}
			damage = 1 * Levels.wave ;
		}
	}
}