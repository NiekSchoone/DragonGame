package  
{
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.events.Event;
	/**
	 * ...
	 * @author Beau Arthurs and Niek Schoone
	 */
	public class EnemyTwo extends Ai 
	{
		private var enemy		:	Archer = new Archer;
		private var enemyAttack	:	ArcherShoot  = new ArcherShoot;
		private var distance 	:	Number;
		public function EnemyTwo() 
		{
			super();
			addChild(enemy);
			addChild(enemyAttack);
			//addChild(enemyAttack);
			enemyAttack.visible = false;
			target = Levels.dragon;
		}
		public override function update():void
		{
			super.update();
			distance  = enemyLocation.subtract(targetLocation).length;
			while (Levels.castle.hitTestPoint(this.x  , this.y -10, true))
			{
				this.y += 1;
			}
			
			while (Levels.castle.hitTestPoint(this.x, this.y +10, true))
			{
				this.y -= 1;
			}
			
			while (Levels.castle.hitTestPoint(this.x -10, this.y , true))
			{
				this.x += 1;
			}
			
			while (Levels.castle.hitTestPoint(this.x +10, this.y, true))
			{
				this.x -= 1;
			}
			if (distance < 300 && Levels.dragon.alpha == 1)
			{
				enemy.visible = false;
				enemyAttack.visible = true;
				if (enemyAttack.currentFrame == 10)
				{
					shooting = true;
					enemyAttack.gotoAndPlay(11);
				} 
				else 
				{
					shooting = false;
				}
			}
			else
			{
				enemy.visible = true;
				enemyAttack.visible = false;
			}
		}
	}
}