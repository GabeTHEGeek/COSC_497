package  
{	
	import engine.*;
	import engine.center;
	import engine.Display;
	import engine.IState;
	import engine.Time;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.text.TextFormatAlign;

	
	public class GameState implements IState
	{
		private const ZOMBIE_BASE		:int = 50;	// guaranteed # of zombies
		private const ZOMBIE_MULTIPLIER	:int = 10;	// how many more zombies per level
		
		private var player			:Player;
		private var zombies			:Vector.<Zombie>;
		private var bullets			:Vector.<Bullet>;
		
		private var tf				:TextField;
		private var POINTS_PER_KILL	:int = 20;
		private var score			:int = 0;
		private var console			:Console;
		private var ConsoleActive   :Boolean = true;
		private var cd				:ConsoleDisplay;
		
		
		
		/// CTOR - minimize putting any code in here!
		public function GameState() 
		{
			
		}

		
		/// @see IState
		public function start():void
		{	
			tf = maketf(40);
			tf.textColor = 0xff00ff;
			tf.alpha = .5;
			tf.text = "Score: " + Global.totalScore + " Level: "+ Global.level;
			tf.x = 250;
			tf.y = 5;
			Display.ui.addChild( tf );
			
			player = new Player();
			Display.main.addChild( player );
			onLoad();
			
			console = Console.getInstance();
			console.clear();
			cd = new ConsoleDisplay(200, 100, 0xff00ff, 0.3);
			Display.console.addChild(cd);
			cd.y = 0;
			cd.x = 0;
		}
		
		
		/// @see IState
		public function update():void
		{
			addRemoveConsole();
			var delta:Number = Time.deltaTime;	// cache delta value, used frequently
			
			player.update();
			
			var len:int = zombies.length;
			for ( var i:int = len - 1; i >= 0; i-- )
			{
				if ( zombies[i].isDisposed )
				{
					// Remove object from both vector and display list
					Systems.console.add("Removed " + zombies[i].zombieName);
					Display.main.removeChild( zombies.splice( i, 1 )[0] );
					addScore();
					addRemoveConsole();
					if (zombies.length == 0)
					{
						Global.level++;
						if (Global.level == 4)
						{
							//end();
							State.current = new WinState();
						}
						else {
							onLoad();
						}
					}
				}
				else {
					zombies[i].update( delta );
					tf.text = "Score: " + Global.totalScore + " Level: "+ Global.level;
				}
			}
			
			len = bullets.length;
			for ( i = len - 1; i >= 0; i-- )
			{
				if ( bullets[i].update( zombies ) )
					bullets.splice( i, 1 );
			}
		}
		
		
		public function addBullet( bullet:Bullet ):void
		{
			bullets.push( bullet );
			Display.main.addChild( bullet );
		}
		
		public function addScore():void
		{
			Global.totalScore += POINTS_PER_KILL;
			tf.text = "Score: " + Global.totalScore + " Level: "+ Global.level;
		}
		
		private function onLoad():void
		{
			center(player);
			Global.totalScore = Global.totalScore;
				
			if (bullets != null)
			{
				for ( var j:int = bullets.length -1; j >= 0; j-- )
				{
					Display.main.removeChild( bullets[j] );
				}
			}
			
			bullets = new Vector.<Bullet>();
			zombies = new Vector.<Zombie>();
			var zombie:Zombie;
			var point:Point;
								
			for ( var i:int = 0; i < (ZOMBIE_BASE + (Global.level * ZOMBIE_MULTIPLIER) ); i++ )
			{
				zombie = new Zombie( player, i.toString() );
				zombies.push( zombie );			// track all zombies outselves
										
				// Layout zombie on the screen
				point = getRandomPointOnRect( Display.width, Display.height );
				Display.main.addChild( zombie );
				zombie.x = point.x;
				zombie.y = point.y;
			}
		}
		
		public function addRemoveConsole():void
		{
			if ( Input.getKeyDown(Keyboard.BACKQUOTE) && ConsoleActive == true)
			{
				Display.console.addChild(cd);
				Systems.console.add("");
				Display.stage.removeChildAt(2);
				ConsoleActive = false;
			}
			else if (Input.getKeyDown(Keyboard.BACKQUOTE) && ConsoleActive == false) 
			{
				//Display.console.removeChild(cd);
				Display.stage.addChildAt(Display.console, 2);
				ConsoleActive = true;
			}
		}
		
		
		/// @see IState
		public function end():void
		{
			Display.main.removeChild(player);
			Display.ui.removeChild(tf);
			
			for ( var i:int = bullets.length -1; i >= 0; i-- )
			{
				Display.main.removeChild( bullets[i] );
			}
			
			for ( var i:int = zombies.length -1; i >= 0; i-- )
			{
				Display.main.removeChild( zombies[i] );
			}
			tf.text = "Score: " + Global.totalScore + " Level: "+ Global.level;
		}
	}
}