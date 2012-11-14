package  
{
	import engine.*;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class WinState implements IState
	{
		
		public function WinState() 
		{
			
		}
		
		public function start():void
		{
			var tf		:TextField;
			
			tf = maketf(40);
			tf.text = "FINAL SCORE: " + Global.totalScore;
			tf.y = 10;
			Display.ui.addChild( tf );
			center(tf, false);
			
			var button	:Sprite;	// temporary variable, re-used in composing buttons
						
			button = makeButton("Return to Menu", clickMenu );
			Display.ui.addChild( button );
			button.x = 5;
			button.y = 150;
			center(button, true);
			
		}
		
		public function clickMenu(button:ButtonPure):void 
		{
			end();
			State.current = new ShellState();
		}
		
		public function update():void
		{
			
		}
		
		public function end():void
		{
			Display.clear();
		}
	}
}