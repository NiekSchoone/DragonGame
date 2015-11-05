package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Beau Arthurs and Niek Schoone
	 */
	public class Levels extends MovieClip 
	{
		public static var wave		:	int = 1;
		public static var dragon	:	Player = new Player;
		public static var castle	:	Castle = new Castle;
		private var BG				:	BackGround = new BackGround;
		private var waitTimer		:	Timer;
		private var levelTimer		:	Timer;
		private var scoreTime		:	Timer;
		private var deadTime		:	Timer;
		private var maxSpawn		:	int = 5;
		private var enemysA			:	Array = new Array;
		private var attackA			:	Array = new Array;
		private var attackB			:	Array = new Array;
		private var spawnSide		:	int;
		private var spawnLocation	:	Vector3D;
		private var shootSound		:	Sound = new Sound();
		private var channel			:	SoundChannel = new SoundChannel();
		private var spwanSpeed		:	int = 3000;
		private var hit				:	FireHit = new FireHit;
		private var hitRemove		:	Timer;
		private var hitSound		:	Sound = new Sound();
		private var restartB		:	restartButton = new restartButton();
		private var buttonHolder	:	MovieClip = new MovieClip();
		private var scoreText		:	TextField = new TextField();
		private var myScore			:	int = 0;
		private var gameOverBG		:	DeathBackground = new DeathBackground;
		private var healthBar		:	HpBar = new HpBar;
		public static var barhealth	:	int = 0;
		private var scoreBoard		:	ScoreBoard = new ScoreBoard();
		private var archerInt		:	int;
		
		public function Levels()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(BG);
			
			
			
			addChild(castle);
			addChild(dragon);
			dragon.x = 100;
			dragon.y = 400;
			addChild(healthBar);
			addChild(scoreBoard);
			scoreBoard.x = 1;
			scoreBoard.y = 1;
			
			healthBar.gotoAndStop(1);
			healthBar.x = stage.stageWidth - 250;
			healthBar.y = 5;
			waitTimer  = new Timer(500, 5);
			waitTimer.addEventListener(TimerEvent.TIMER, waitEvent);
			waitTimer.start();
			
			hitRemove  = new Timer(200, 2);
			hitRemove.addEventListener(TimerEvent.TIMER, hitEvent);
			
			scoreTime = new Timer(100, 0);
			scoreTime.addEventListener(TimerEvent.TIMER, scoreEvent)
			scoreTime.start();  
			
			deadTime = new Timer(1000 , 2);
			deadTime.addEventListener(TimerEvent.TIMER, deadEvent) 
			
			shootSound.load(new URLRequest("audio/Shooting_the_fireball.mp3"));
			hitSound.load(new URLRequest("audio/explosie.mp3"));
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
			dragon.addEventListener("FIRE", attack);
			
		}
		private function waitEvent(e:TimerEvent):void 
		{
			if (waitTimer.currentCount == 5)
			{
				maxSpawn = maxSpawn +3;
				levelTimer  = new Timer(spwanSpeed, maxSpawn);
				levelTimer.addEventListener(TimerEvent.TIMER, levelEvent);
				levelTimer.start();
				waitTimer.reset();
			}
		}
		private function levelEvent(e:TimerEvent):void 
		{
			pickSide();
			enemysA.push(new EnemyOne());
			enemysA[enemysA.length - 1].x = spawnLocation.x
			enemysA[enemysA.length - 1].y = spawnLocation.y
			
			addChild(enemysA[enemysA.length - 1]);
			var archerSpawn:int = Math.random() * 2;
			if (archerSpawn == 1)
			{
			pickSide();
			enemysA.push(new EnemyTwo());
			enemysA[enemysA.length - 1].x = spawnLocation.x
			enemysA[enemysA.length - 1].y = spawnLocation.y
			
			addChild(enemysA[enemysA.length - 1]);
			}
			addChild(dragon);
			addChild(healthBar);
			addChild(scoreBoard);
			if (levelTimer.currentCount == maxSpawn)
			{
				spwanSpeed -= 250;
				wave++;
				waitTimer.start();
				levelTimer.reset();
				BG.swicth();
			}
		}
		private function pickSide():void
		{
			spawnSide = Math.random() * 4;
			if (spawnSide == 0)spawnLocation = new Vector3D(Math.random() * 800, 0);
			if (spawnSide == 1)spawnLocation = new Vector3D(0, Math.random() * 800);
			if (spawnSide == 2)spawnLocation = new Vector3D(Math.random() * 800, 800);
			if (spawnSide == 3) spawnLocation = new Vector3D(800, Math.random() * 800);
		}
		public function attackArray():Array
		{
			return attackA;
		}
		private function mainLoop(e:Event):void 
		{
			dragon.update();
			
			if (Castle.castleHealth < 0)
			{
			endGame();
			}
			
			
			var enemy:int = -1;
			for (var i:int = 0; i < enemysA.length; i++)
			{
				if(enemysA[i].shooting == true)
				{
					archerAttack(i);
				}
				for (var j:int = 0; j < attackA.length; j++)
				{
					if (enemysA[i].hitTestObject(attackA[j]))
					{
						enemy = i;
						attackA[j].toRemove = true;
						channel.stop();
					}
				}
			}
			if (enemy != -1)
			{
				Hit(enemy);
			}
			for (var x : int = 0 ; x < enemysA.length; x++)
			{
				enemysA[x].update();
			}
			for (var l : int = 0 ; l < attackA.length ; l++ )
			{
				attackA[l].update();
			}
			for (var k : int = 0 ; k < attackA.length ; k++ )
			{
				if (castle.hitTestPoint(attackA[k].x,attackA[k].y, false))
				{
					attackA[k].toRemove = true;
					HitC(attackA[k].x, attackA[k].y);
					Castle.castleHealth -= 20;
					barhealth -= 20;
				}
				if (attackA[k].x > 900 || attackA[k].x < - 100 || attackA[k].y > 900 || attackA[k].y < - 100)
				{
					attackA[k].toRemove = true;
				}
				if (attackA[k].toRemove)
				{
					stage.removeChild(attackA[k]);
					attackA.splice(k, 1);
					
				}
			}
			for (var p : int = 0 ; p < attackB.length ; p++ )
			{
				attackB[p].update();
				if (dragon.hitTestPoint(attackB[p].x,attackB[p].y, false))
				{                  
					attackB[p].toRemove = true;
					dragon.removeEventListener("FIRE", attack);
					dragon.alpha = 0.5;
					deadTime.start();
				}
				if (attackB[p].x > 900 || attackB[p].x < - 100 || attackB[p].y > 900 || attackB[p].y < - 100)
				{
					attackB[p].toRemove = true;
				}
				if (attackB[p].toRemove)
				{
					stage.removeChild(attackB[p]);
					attackB.splice(p, 1);
					
				}
			}
			if (barhealth <= -100)
			{
				healthBar.gotoAndStop(healthBar.currentFrame + 1);
				barhealth = 0;
			}
		}
		private function archerAttack(b:int):void 
		{
			var newAttack:Arrow = new Arrow();	
			newAttack.setDirection(enemysA[b].rotation);
			newAttack.rotation = enemysA[b].rotation;
			
			stage.addChild(newAttack);
			
			attackB.push(newAttack);
			newAttack.x	=	enemysA[b].x;
			newAttack.y	=	enemysA[b].y;
			
			var radian:Number = enemysA[b].rotation * (Math.PI / 180);
			newAttack.x	=	enemysA[b].x + Math.cos( radian ) * 5;
			newAttack.y	=	enemysA[b].y + Math.sin( radian ) * 5;
		}
		private function deadEvent(e:TimerEvent):void 
		{
			if (deadTime.currentCount == 2)
			{
				dragon.addEventListener("FIRE", attack);
				dragon.alpha = 1;
				deadTime.reset();
			}
		}
		private function scoreEvent (e:TimerEvent):void
		{
			myScore += 1;
			displayScore(myScore);
		}
		private function displayScore(myScore:int):void
		{
			scoreText.text = " " + String(myScore);
			var sTF:TextFormat = new TextFormat("arial", 20, 0x000000, true);
			
			addChild(scoreText);
			
			scoreText.x = 125;
			scoreText.y = 18;
			
			scoreText.setTextFormat(sTF);
			scoreText.width = 100;
			
		}
		private function attack(e:Event):void 
		{
			var newAttack:Attack = new Attack();	
			newAttack.setDirection(dragon.heroRotation());
			newAttack.rotation = Player.hero.rotation;
			
			stage.addChild(newAttack);
			
			attackA.push(newAttack);
			newAttack.x	=	dragon.x;
			newAttack.y	=	dragon.y;
			
			var radian:Number = Player.hero.rotation * (Math.PI / 180);
			newAttack.x	=	dragon.x + Math.cos( radian ) * 70;
			newAttack.y	=	dragon.y + Math.sin( radian ) * 70;
			channel = shootSound.play(400);
		}
		private function Hit(x:int):void
		{
			hit = new FireHit;
			addChild(hit);
			hit.x = enemysA[x].x;
			hit.y = enemysA[x].y;
			removeChild(enemysA[x]);
			enemysA.splice(x, 1);
			hitRemove.start();
			channel = hitSound.play();
		}
		private function HitC(x:int,y:int):void
		{
			hit = new FireHit;
			addChild(hit);
			hit.x = x;
			hit.y = y;
			hitRemove.start();
			channel = hitSound.play();
		}
		private function hitEvent(e:TimerEvent):void 
		{
			if (hitRemove.currentCount > 1)
			{
				removeChild(hit);
				hitRemove.reset();
			}
		}
		private function endGame():void 
		{
			
			scoreTime.stop();
			
			var sTF:TextFormat = new TextFormat("arial", 40, 0x000000, true);
			scoreText.x = (stage.stageWidth / 2) - 60;
			scoreText.y = (stage.stageHeight / 2);
			
			scoreText.setTextFormat(sTF);
			for (var i:int = enemysA.length - 1; i >= 0; i--)
			{
				removeChild(enemysA[i]);
				enemysA.splice(i, 1);
			}
			
			for (var j:int = attackA.length - 1; j >= 0; j--)
			{
				attackA[j].toRemove = true;
				
				if (attackA[j].toRemove)
				{
					stage.removeChild(attackA[j]);
					attackA.splice(j, 1);
					
				}
			}
			
			removeEventListener(Event.ENTER_FRAME, mainLoop);
			dragon.removeEventListener("FIRE", attack);
			
			waitTimer.stop();
			levelTimer.stop();
			removeChild(dragon);
			addChild(gameOverBG);
			
			castle.castleArt.gotoAndStop(2);
			
			addChild(restartB);
			restartB.x = (stage.stageWidth / 2.1);
			restartB.y = (stage.stageHeight / 1.5);
			
			addChild(buttonHolder);
			buttonHolder.addChild(restartB);
			buttonHolder.addEventListener(MouseEvent.CLICK, restart);
		}
		private function restart (e:MouseEvent):void
		{
			removeChild(gameOverBG);
			myScore = 0;
			scoreTime.start();
			healthBar.gotoAndStop(1);
			barhealth = 0;
			BG.swicth();
			scoreText.x = 1;
			scoreText.y = 1;
			if (e.target == restartB)
			{
				
				buttonHolder.removeEventListener(MouseEvent.CLICK, restart);
				buttonHolder.removeChild(restartB);
				removeChild(buttonHolder);
				
				Castle.castleHealth = 1000;
				
				addEventListener(Event.ENTER_FRAME, mainLoop);
				
				waitTimer.start();
				
				addChild(dragon);
				dragon.addEventListener("FIRE", attack);
				
				castle.castleArt.gotoAndStop(1);
				wave = 1;
			}
		}
	}
}