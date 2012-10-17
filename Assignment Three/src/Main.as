package 
{
	import engine.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	

	public class Main extends Sprite 
	{
		private const MAX_LINES	:int = 24;
		private var outLines	:Vector.<TextField>;

		/// CTOR
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			Time.init( stage );
			Input.init( stage );
			Display.init( stage );
			
			/// Make screen output lines
			outLines = new Vector.<TextField>();
			var tf:TextField;
			for (var i:int = 0; i < MAX_LINES; i++)
			{
				tf = maketf( 16 );
				Display.ui.addChild( tf );
				tf.y = i * 20;
				outLines.push( tf );
				tf.text = "Default!";
			}
			
			addEventListener( Event.ENTER_FRAME, update );
		}
		
		/// Main update loop
		private function update( e:Event ):void
		{
			// Update sub-systems
			Time.update();
			Input.update();

			// Generate a string based on the input state of Spacebar
			var out:String =
				String( Time.frameCount ) + ": " +
				"getKeyDown: " + Input.getKeyDown( Keyboard.SPACE ) + 
				"    getKey: " + Input.getKey( Keyboard.SPACE ) +
								 Input.getKeyRelease( Keyboard.SPACE );

			// Populate a textfield on the screen based on the frame
			var tf:TextField = outLines[ Time.frameCount % MAX_LINES ];
			tf.text = out;
			
			// Change the color of the text field based on the Spacebar's state
			if ( Input.getKeyDown( Keyboard.SPACE ) )
				tf.textColor = 0xff0000;
			else if ( Input.getKey( Keyboard.SPACE ) )
				tf.textColor = 0xccff00;
			else if ( Input.getKeyRelease( Keyboard.SPACE ) )
				tf.textColor = 0x00CCff;
			else
				tf.textColor = 0x000000;
			
			trace( out );
		}
	}
}
