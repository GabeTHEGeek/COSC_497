package engine 
{
	import flash.automation.ActionGenerator;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	
	public class Input 
	{
		static private const UP				: uint = 0;
		static private const PRESS			: uint = 1;
		static private const HELD			: uint = 2;		
		static private const DOUBLE_TAP		: uint = 3;
		
		static private const MOUSE_LEFT_BUTTON: uint = 0;
		static private var howManyTaps		:int = 0;
		
		static private var timeSinceLastPress:int = -1;

		static private const START_PRESS	 :uint = 9999;
		static private const END_PRESS_BEGIN :uint = 6666;
		static private const END_PRESS		 :uint = 3333;
		
		static private var keys		: Vector.<uint>;
		static private var active	: Vector.<KeyState>;
		static private var last		: Vector.<uint>;
		
		
		static public function init( stage:Stage ):void 
		{
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.removeEventListener( KeyboardEvent.KEY_UP,   onKeyUp );	
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp);

			keys 	= new Vector.<uint>(256);	// state of all keys
			active 	= new Vector.<KeyState>();	// only keys in a state other than up
			last 	= new Vector.<uint>(256);	// previous keys			
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, 	onKeyUp );	
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		
		static public function onMouseDown( e:MouseEvent ):void
		{
			keys[ MOUSE_LEFT_BUTTON ] = START_PRESS;			
			var keyState:KeyState = new KeyState( MOUSE_LEFT_BUTTON, Time.frameCount );
			active.push( keyState );
		}

		static public function onMouseUp( e:MouseEvent ):void 
		{
			keys[ MOUSE_LEFT_BUTTON ] = UP;
			
			var keyState:KeyState;
			for ( var i:int = active.length - 1; i > -1; i-- )
			{
				keyState = active[i];						// get next keystate in active list
				if ( keyState.code == MOUSE_LEFT_BUTTON )	// if the code matches
					active.splice( i, 1 );					// remove
			}
		}
		
		/// Flash Event: A key was just pressed
		static public function onKeyDown( e:KeyboardEvent ):void
		{
			if ( keys[ e.keyCode ] != UP )
				return;
			
			keys[ e.keyCode ] = START_PRESS;
			last[e.keyCode] = UP;
			
			if (howManyTaps == 1 && timeSinceLastPress > Time.frameCount - 3) 
			{
				howManyTaps++;				
			}
			
			var keyState:KeyState = new KeyState( e.keyCode, Time.frameCount );
			active.push( keyState );
		}
		
		/// Flash Event: A key was raised
		static public function onKeyUp( e:KeyboardEvent ):void
		{										
			last[ e.keyCode ] = END_PRESS_BEGIN;			
		}
		
		static public function getMouseButtonDown( button:uint ):Boolean
		{
			return keys[ button ] == PRESS;			
		}
		
		/// Is a mouse button being held down?
		static public function getMouseButton( button:uint ):Boolean
		{
			return keys[ button ] == HELD;			
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
				
				if (keys[code] == DOUBLE_TAP) 
				{
					keys[code] = HELD;
				}
				
				else if ( keys[code] == START_PRESS )
				{			
					if (howManyTaps == 2) 
					{
						keys[code] = DOUBLE_TAP;						
						howManyTaps = 0;
						break;
					}
					
					keys[code] = PRESS;		
					howManyTaps++;
					timeSinceLastPress = Time.frameCount;
					keyState.frame = Time.frameCount;
				}
				
				else if ( keys[code] == PRESS && last[code] == UP && keyState.frame < Time.frameCount)
				{
					keys[code] = HELD;	
					continue;
				}	
				
				else if (keys[code] == END_PRESS && keyState.frame < Time.frameCount) 
				{										
					keys[code] = UP;	
					last[code] = UP;
					
					for (var j:int = active.length - 1; j > - 1; j--) 
					{						
						if(keys[code] == UP && last[code] == UP)
						active.splice(i, 1);
					}								
				}
				
				else if (last[code] == END_PRESS_BEGIN) 
				{					
					keys[code] = END_PRESS;	
					keyState.frame = Time.frameCount;
				}				
			}
			trace(keys[code]);			
		}
		
		static public function getKeyDown( code:uint ):Boolean
		{
			return keys[ code ] == PRESS;
		}

		static public function getKeyHeld( code:uint ):Boolean
		{
			return keys[ code ] == HELD;
		}
		
		static public function getKeyUp( code:uint):Boolean 
		{
			return keys[ code ] == UP;
		}
		
		static public function getKeyReleased(code: uint):Boolean 
		{
			return keys[ code ] == END_PRESS;
		}
		
		static public function DoubleTap(code: uint):Boolean 
		{
			return keys[ code ] == DOUBLE_TAP;
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