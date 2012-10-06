package engine 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/**
	 *	Input Manager
	 */
	public class Input 
	{
		static private const UP			: uint = 0;
		static private const PRESS		: uint = 1;
		static private const HELD		: uint = 2;
		static private const RELEASE	: uint = 3;

		static private const START_PRESS:uint = 9999;
		
		
		static private var keys		: Vector.<uint>;
		static private var active	: Vector.<KeyState>;
		
		
		
		static public function init( stage:Stage ):void 
		{
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.removeEventListener( KeyboardEvent.KEY_UP,   onKeyUp );	

			keys 	= new Vector.<uint>(255);	// state of all keys
			active 	= new Vector.<KeyState>();		// only keys in a state other than up
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, 	onKeyUp );
		}
		
		
		/// Flash Event: A key was just pressed
		static public function onKeyDown( e:KeyboardEvent ):void
		{
			// If the system is sending another key down event, but the key is marked
			// as being in some other state than down; ignore it.
			if ( keys[ e.keyCode ] != UP )
				return;
			
			keys[ e.keyCode ] = START_PRESS;
			
			var keyState:KeyState = new KeyState( e.keyCode, Time.frameCount );
			active.push( keyState );
		}
		
		/// Flash Event: A key was raised
		static public function onKeyUp( e:KeyboardEvent ):void
		{
			keys[ e.keyCode ] = UP;
			
			// Loop through all active keys; there is a slight chance that
			// more than one entry for a key being "down" snuck in due to
			// how Flash / OS handles input.
			var keyState:KeyState;
			for ( var i:int = active.length - 1; i > -1; i-- )
			{
				keyState = active[i];				// get next keystate in active list
				if ( keyState.code == e.keyCode )	// if the code matches
					active.splice( i, 1 );			// remove
			}
		}
		
		/// Call this once per frame
		static public function update():void
		{
			var code	:uint;
			var keyState:KeyState;
			
			// Go through all the inputs currently mark as being active...
			for ( var i:int = active.length - 1; i > -1; i-- )
			{
				keyState = active[i];
				code = keyState.code;
				
				// If a key is pressed and it's the frame after it was pressed,
				// change the state.
				if ( keys[code] == PRESS && keyState.frame < Time.frameCount )
				{
					keys[code] = HELD;
					continue;
				}
				
				// If a press is just starting, mark it as started and update
				// the frame for the press to be this frame.
				if ( keys[code] == START_PRESS )
				{
					keys[code] = PRESS;
					keyState.frame = Time.frameCount;
				}
			}
			
		}
		
		/// Has a key just been pressed in this frame?
		static public function getKeyDown( code:uint ):Boolean
		{
			return keys[ code ] == PRESS;
		}

		/// Is a key in state other than being "up"?
		static public function getKey( code:uint ):Boolean
		{
			return keys[ code ] == HELD;
		}
		
		static public function getKeyRelease( code:uint ):Boolean
		{
			return keys[ code ] == RELEASE;
		}
	}
}


internal class KeyState
{
	public var code	:uint;
	public var frame:uint;
	
	/// CTOR
	function KeyState( code:uint, frame:uint ) :void
	{
		this.code 	= code;
		this.frame 	= frame;
	}
}