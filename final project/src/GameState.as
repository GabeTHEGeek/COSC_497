package  
{	
	import engine.*;
	import engine.center;
	import engine.Display;
	import engine.IState;
	import engine.Time;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.text.TextFormatAlign;

	
	public class GameState implements IState
	{
		private var tf					:TextField;
		private var score				:int = 0;
		private var console				:Console;
		private var ConsoleActive   	:Boolean = true;
		private var cd					:ConsoleDisplay;
		
		private var lemon				:Bitmap;
		private var vodka				:Bitmap;
		private var glass				:Bitmap;
		private var cranberry			:Bitmap;
		private var menu				:Bitmap;
		
		private var drinkCV				:Array = [lemon, vodka, glass, cranberry];
		private var inventory			:Array = [];
		
		
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
			tf.x = 350;
			tf.y = 5;
			Display.ui.addChild( tf );
			
			lemon 		= new Resources.lemonIcon();
			vodka 		= new Resources.vodkaIcon();
			glass     	= new Resources.glassIcon();
			cranberry 	= new Resources.cranberryIcon();
			menu 		= new Resources.menuIcon();
			
			Display.ui.addChild(lemon);
			lemon.x = 250;
			lemon.y = 425;
			
			Display.ui.addChild(vodka);
			vodka.x = 310;
			vodka.y = 425;
			
			Display.ui.addChild(glass);
			glass.x = 370;
			glass.y = 425;
			
			Display.ui.addChild(cranberry);
			cranberry.x = 430;
			cranberry.y = 425;
			
			Display.ui.addChild(menu);
			menu.x = 0;
			menu.y = 185;
			
			console = Console.getInstance();
			console.clear();
			cd = new ConsoleDisplay(320, 100, 0xff00ff, 0.3);
			Display.console.addChild(cd);
			cd.y = 0;
			cd.x = 0;
			
			out("Customer wants Cranberry Vodka");
		}
		
		
		/// @see IState
		public function update():void
		{
			addRemoveConsole();
			//var delta:Number = Time.deltaTime;	// cache delta value, used frequently
		}
		
		public function addScore():void
		{
			//Global.totalScore += POINTS_PER_KILL;
			//tf.text = "Score: " + Global.totalScore + " Level: "+ Global.level;
		}
		
		
		
		public function addRemoveConsole():void
		{
			if ( Input.getKeyDown(Keyboard.BACKQUOTE) && ConsoleActive == true)
			{
				Display.console.addChild(cd);
				//Systems.console.add("");
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
			tf.text = "Score: " + Global.totalScore + " Level: "+ Global.level;
		}
	}
}