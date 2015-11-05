package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Beau Arthurs and Niek Schoone  
	 */
	public class Castle extends MovieClip
	{
		public var castleArt			:	Building = new Building;
		public static var castleHealth	:	int = 1000;
		
		public function Castle() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(castleArt);
			castleArt.gotoAndStop(1);
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
		}
	}
}