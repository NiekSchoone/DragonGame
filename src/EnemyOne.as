package  
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Beau Arthurs and Niek Schoone
	 */
	public class EnemyOne extends Ai 
	{
		private var enemy		:	SwordEnemy = new SwordEnemy;
		private var enemyAttack	: 	SwordAttack = new SwordAttack;
		private var c			:	int;
		
		public function EnemyOne() 
		{
			super();
			addChild(enemy);
			target = Levels.castle;
			c = Math.random() * 2 +1;
			enemy.gotoAndStop(c);
			
		}
		public override function update():void
		{
			super.update();
			if (this.hitTestObject(Levels.castle))
			{
				atWall = true;
			}
			if (atWall == true)
			{
				Castle.castleHealth -= damage;
				Levels.barhealth -= damage;
				addChild(enemyAttack);
				enemyAttack.gotoAndStop(c);
				enemy.visible = false;
			}
		}
	}
}