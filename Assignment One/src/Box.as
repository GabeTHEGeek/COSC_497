package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Box extends Sprite
	{
		
		private var main	:Main;
		private var frame:	int;
		
		public function Box( main:Main ) 
		{
			this.main = main;
			addEventListener( Event.ENTER_FRAME, onFrame );
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		public function onFrame( e:Event ):void
		{
			frame++;
			if (frame == 60 )
				destroy();
			
			graphics.clear();
			graphics.beginFill(0x0000FF, (60 - frame) / 60 );
			graphics.drawRect( -frame * 1.5, -frame * 1.5, frame * 3, frame * 3);
			graphics.endFill();
		}
		
		
		private function destroy():void
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
			removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			parent.removeChild( this );
		}
		
		
		private function onMouseDown( e:MouseEvent ):void 
		{
			main.addToScore();
			destroy();
		}
	}
}