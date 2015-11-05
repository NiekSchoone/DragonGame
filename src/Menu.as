package  
{
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.system.fscommand;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Beau Arthurs and Niek Schoone
	 */
	public class Menu extends MovieClip 
	{
		private var startButton		:	PlayButton = new PlayButton;
		private var optionsButton	:	OptionsButton = new OptionsButton;
		private var controlsButton	:	ControlsButton = new ControlsButton;
		private var quitButton		:	QuitButton = new QuitButton;
		private var music			:	Sound;// = new Sound();
		private var channel			:	SoundChannel;// = new SoundChannel();
		private var backGround		:	MenuBackground = new MenuBackground;
		private var back			:	backButton = new backButton;
		private var controls		:	controlSheet = new controlSheet;
		
		public function Menu() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			music = new Sound();
			channel  = new SoundChannel;
			music.load(new URLRequest("audio/Startmenu_audio.mp3"));
			music.addEventListener(Event.COMPLETE, onComplete, false);
			
			function onComplete(evt:Event):void 
			{
				channel = music.play(0, 999999);
				startupMenu();
			}
			
			addChild(backGround);
		}
		private function startupMenu():void 
		{
			var buttonHolder:MovieClip = new MovieClip();
			
			addChild(startButton);
			startButton.x = stage.stageWidth/2 - 100//<- change to size of button;
			startButton.y = 220;
			
			addChild(optionsButton);
			optionsButton.x = startButton.x;
			optionsButton.y = startButton.y + 65;
			
			addChild(controlsButton);
			controlsButton.x = optionsButton.x;
			controlsButton.y = optionsButton.y + 65;
			
			addChild(quitButton);
			quitButton.x = controlsButton.x;
			quitButton.y = controlsButton.y + 65;
			
			addChild(back);
			back.x = 25;
			back.y = quitButton.y + 250;
			back.visible = false;
			
			addChild(buttonHolder);
			buttonHolder.addChild(startButton);
			buttonHolder.addChild(optionsButton);
			buttonHolder.addChild(controlsButton);
			buttonHolder.addChild(quitButton);
			buttonHolder.addChild(back);
			buttonHolder.addEventListener(MouseEvent.CLICK, click);
		}
		private function click(e:MouseEvent):void 
		{
			if (e.target == startButton)
			{
				dispatchEvent( new Event("startGame"));
			}
			if (e.target == optionsButton)
			{
				
			}
			if (e.target == controlsButton)
			{
				startButton.visible = false;
				optionsButton.visible = false;
				controlsButton.visible = false;
				quitButton.visible = false;
				back.visible = true;
				addChild(controls);
				controls.x = (stage.stageWidth / 2);
				controls.y = (stage.stageHeight / 2);
			}
			if (e.target == quitButton)
			{
				fscommand("quit")
			}
			if (e.target == back)
			{
				controls.visible = false;
				startButton.visible = true;
				optionsButton.visible = true;
				controlsButton.visible = true;
				quitButton.visible = true;
				back.visible = false;
				
			}
		}
		
	}

}