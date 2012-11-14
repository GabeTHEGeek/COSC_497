package  
{
	import engine.*;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	
	public class ShellState implements IState
	{
		/// CTOR
		public function ShellState() 
		{		
		}
		
		
		/// @see IState
		public function start():void
		{
			Global.totalScore = 0;
			
			var tf		:TextField;
			
			tf = maketf();
			tf.text = "Bartender";
			tf.y = 10;
			Display.ui.addChild( tf );
			center(tf, true);
			
			var button	:Sprite;	// temporary variable, re-used in composing buttons
						
			button = makeButton("Play", clickPlay );
			Display.ui.addChild( button );
			button.x = 5;
			button.y = 150;
			center(button, true);
			
			Global.level = 1;
		}
		
		/// @see IState
		public function update():void
		{
			
		}
		
		/// @see IState
		public function end():void
		{
			Display.clear();
		}
		
		public function clickPlay( button:ButtonPure ):void
		{
			trace("ShellState: play");
			State.current = new GameState();
			// WARNING: Be aware that end() was just called on this state!
		}
	}
}