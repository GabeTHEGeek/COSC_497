package  
{
	import engine.Input;
	import engine.State;
	import engine.Time;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	public class Player extends Sprite
	{
		private const SPEED:int = 70;
		public var isDisposed:Boolean = false;
		private var target	:Sprite;
		
		
		/// CTOR
		public function Player() 
		{
			var g:Graphics = this.graphics;	
			g.beginFill( 0xddddee );
			g.drawRect(0, 0, 10, 14);
			g.endFill();
		}

		
		/// Per frame update
		public function update():void
		{			
			if ( Input.getKey( Keyboard.S ) || Input.getKey( Keyboard.DOWN ) )
				this.y += SPEED * Time.deltaTime;
				
			if ( Input.getKey( Keyboard.W ) || Input.getKey( Keyboard.UP ) )
				this.y -= SPEED * Time.deltaTime;
				
			if ( Input.getKey( Keyboard.D ) || Input.getKey( Keyboard.RIGHT ) )
				this.x += SPEED * Time.deltaTime;
				
			if ( Input.getKey( Keyboard.A ) || Input.getKey( Keyboard.LEFT) )
				this.x -= SPEED * Time.deltaTime;
				
			if ( Input.getKey( Keyboard.SPACE ) || Input.getMouseButton( 0 ) )
			{
				
			}	
		}
		
		public function dispose() :void
		{
			target = null;
			isDisposed = true;
		}	
	}
}