package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author Beau Arthurs
	 */
	public class Main extends Sprite 
	{
		private var game	:	Game = new Game;
		private var menu	:	Menu = new Menu;
		private var level	:	Levels = new Levels;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(menu);
			menu.addEventListener("startGame", start);
		}
		
		private function start(e:Event):void 
		{
			menu.visible = false;
			addChild(level);
		}
	}
	
}