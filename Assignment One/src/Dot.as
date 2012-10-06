package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/// Grow a dot, if clicked tell main to score it
	public class Dot extends Sprite
	{
		private var main	:Main;
		private var frame:	int;
		
		public function Dot( main:Main ) 
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
			graphics.beginFill( 0xcc00ee, (60-frame) / 60 );
			graphics.drawCircle( 0, 0, frame*3 );
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
			
			if(hitTestPoint(mouseX, mouseY, true))
			{
				trace("HIT");
				stage.removeEventListener( MouseEvent.MOUSE_DOWN, main.onStageClick );
			}
		}
	}
}