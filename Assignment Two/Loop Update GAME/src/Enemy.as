package  
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.geom.Vector3D;
	import utils.Display;
	
	
	/**
	 * Tiny square that moves around, like the punk it is!
	 */
	public class Enemy 
	{
		public var x			: Number = 0;
		public var y			: Number = 0;
		public var halfWidth	: Number = 15;
		public var halfHeight	: Number = 15;
		public var color		: uint;
		
		private var dirx	: Number = 0;
		private var diry	: Number = 0;
		
		public var currTexture:Bitmap = new Resources.enemyBlueDown;
		
		public static var etextureL : Bitmap = new Resources.enemyRedLeft;
		public static var etextureR : Bitmap = new Resources.enemyRedRight;
		public static var etextureU : Bitmap = new Resources.enemyRedUp;
		public static var etextureD : Bitmap = new Resources.enemyRedDown;
		
		public static var etextureLBlue : Bitmap = new Resources.enemyBlueLeft;
		public static var etextureRBlue : Bitmap = new Resources.enemyBlueRight;
		public static var etextureUBlue : Bitmap = new Resources.enemyBlueUp;
		public static var etextureDBlue : Bitmap = new Resources.enemyBlueDown;
		
		private var direction: String;
			
		/// CTOR
		public function Enemy() 
		{
			//currTexture = new Resources.enemyBlueDown;
			// set random position on left side of the screen.
			x = Math.random() * (Display.width / 2);
			y = Math.random() * (Display.height / 2);
			
			// Pick # at random; if 1 set color to red, otherwise make it blue.
			color = int( Math.random() * 2 ) ? 0xff0000 : 0x0000ff;
			
			// Pick a random direction to move by first choosing an angle, and then
			// doing some slick (yet simple) trig to figure out the X, Y.
			var degrees:Number = Math.random() * 360;
			
			// First convert "degrees" to radians
			var radians:Number = degrees * 0.017453;
			
			dirx = Math.cos( radians );
			diry = Math.sin( radians );
			

			
			if (color == 0xff0000)
			{
				//Display.game.removeChild(currTexture);
				
				if (degrees >= 315 || degrees < 45) 
				{
					currTexture = new Resources.enemyRedRight;
				}
				else if (degrees >= 45 && degrees < 135 ) 
				{
					currTexture = new Resources.enemyRedDown;
				}
				else if (degrees >= 135 && degrees < 255) 
				{
					currTexture = new Resources.enemyRedLeft;
				}
				else
				{
					currTexture = new Resources.enemyRedUp;
				}
			}
			
			if (color == 0x0000ff)
			{
				//Display.game.removeChild(currTexture);
				
				if (degrees >= 315 || degrees < 45) 
				{
					currTexture = new Resources.enemyBlueRight;
				}
				else if (degrees >= 45 && degrees < 135 ) 
				{
					currTexture = new Resources.enemyBlueDown;
				}
				else if (degrees >= 135 && degrees < 255) 
				{
					currTexture = new Resources.enemyBlueLeft;
				}
				else
				{
					currTexture = new Resources.enemyBlueUp;
				}
				
				currTexture.x = x - halfWidth;
				currTexture.y = y - halfHeight;
			}
		}
		
		
		/// Called from somewhere else
		public function update():void
		{
			// Change location
			x += dirx;
			y += diry;
			
			currTexture.x = x - halfWidth;
			currTexture.y = y - halfHeight;
			
			// Check for screen wrapping
			if ( x < 0 )
				x += Display.width;
			
			if ( x > Display.width )
				x -= Display.width;
				
			if ( y < 0 )
				y += Display.height;
				
			if ( y > Display.height )
				y -= Display.height;
		}
	}

}