package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Beau Arthurs
	 */
	public class BackGround extends MovieClip 
	{
		private var mapOne		:	BackgroundOne = new BackgroundOne;
		private var mapTwo		:	BackgroundTwo = new BackgroundTwo;
		private var mapThree	:	BackgroundThree = new BackgroundThree;
		private var mapFore		:	BackgroundFore = new BackgroundFore;
		private var backGround	:	int;
		public function BackGround() 
		{
			addChild(mapOne);
			addChild(mapTwo);
			addChild(mapThree);
			addChild(mapFore);
			swicth();
		}
		public function swicth():void
		{
			backGround = Math.random() * 4
			if (backGround == 0)
			{
				mapOne.visible = true;
				mapTwo.visible = false;
				mapThree.visible = false;
				mapFore.visible = false;
			}
			if (backGround == 1)
			{
				mapOne.visible = false;
				mapTwo.visible = true;
				mapThree.visible = false;
				mapFore.visible = false;
			}
			if (backGround == 2)
			{
				mapOne.visible = false;
				mapTwo.visible = false;
				mapThree.visible = true;
				mapFore.visible = false;
			}
			if (backGround == 3)
			{
				mapOne.visible = false;
				mapTwo.visible = false;
				mapThree.visible = false;
				mapFore.visible = true;
			}
		}
		
	}

}