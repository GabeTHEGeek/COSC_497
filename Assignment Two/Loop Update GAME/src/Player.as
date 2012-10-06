package  
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.ui.Keyboard;
	import utils.Display;
	import utils.Input;
	
	public class Player
	{
		public var x			: Number = 0;
		public var y			: Number = 0;		
		public var halfWidth	: Number = 30;
		public var halfHeight	: Number = 30;
		public var color		: uint;
		
		public var currTexture	: Bitmap;
		
		public var textureL		: Bitmap;
		public var textureR		: Bitmap;
		public var textureU		: Bitmap;
		public var textureD		: Bitmap;
		
		public var btextureL	: Bitmap;
		public var btextureR	: Bitmap;
		public var btextureU	: Bitmap;
		public var btextureD	: Bitmap;
		
		public var  direction	:String = "Right";
		
		public const RED		: uint = 0xff0000;
		public const BLUE		: uint = 0x0000ff;
		
		
		/// CTOR
		public function Player() 
		{
			// Start player 75% of the way across the screen and
			// half way (50%) down the screen.
			
			
			textureL = new Resources.redLeft();
			textureR = new Resources.redRight();
			textureU = new Resources.redUp();
			textureD = new Resources.redDown();
			
			btextureL = new Resources.blueLeft
			btextureR = new Resources.blueRight();
			btextureU = new Resources.blueUp();
			btextureD = new Resources.blueDown();
			
			//direction = Direction.RIGHT;
						
			x = Display.width * 0.75;
			y = Display.height * 0.5;
			
			currTexture = textureR;
			Display.game.addChild(textureR);
			textureR.x = x - halfWidth;//Display.width * 0.75;
			textureR.y = y - halfHeight;//Display.height * 0.5;
			color = RED;
		}
		
		
		
		public function update():void
		{		
			
			// Check input if movement should occur.
			if ( Input.isDown( Keyboard.DOWN ) ) 
			{
				Display.game.removeChild(currTexture);
				if (color == RED)
				{
					currTexture = textureD;
				}
				else if (color == BLUE) 
				{
					currTexture = btextureD;
					trace("I AM BLUE");
				}
				
				Display.game.addChild(currTexture);
				currTexture.x = x - halfWidth;//Display.width * 0.75;
				currTexture.y = y - halfHeight;//Display.height * 0.5;
				direction = "Down";
				y += 10;
			}
			
			if ( Input.isDown( Keyboard.UP ) ) 	
			{
				Display.game.removeChild(currTexture);
				if (color == RED)
				{
					currTexture = textureU;
				}
				else
				{
					currTexture = btextureU;
				}
				Display.game.addChild(currTexture);
				currTexture.x = x - halfWidth;//Display.width * 0.75;
				currTexture.y = y - halfHeight;//Display.height * 0.5;
				y -= 10;
				direction = "Up";
			}
			
			
			if ( Input.isDown( Keyboard.LEFT ) )
			{
				Display.game.removeChild(currTexture);
				if (color == RED)
				{
					currTexture = textureL;
				}
				else
				{
					currTexture = btextureL;
				}
				Display.game.addChild(currTexture);
				currTexture.x = x - halfWidth;//Display.width * 0.75;
				currTexture.y = y - halfHeight;//Display.height * 0.5;
				x -= 10;
				direction = "Left";
			}	
			
			if ( Input.isDown( Keyboard.RIGHT ) ) 
			{ 
				Display.game.removeChild(currTexture);
				if (color == RED)
				{
					currTexture = textureR;
				}
				else
				{
					currTexture = btextureR;
				}
				Display.game.addChild(currTexture);
				currTexture.x = x - halfWidth;//Display.width * 0.75;
				currTexture.y = y - halfHeight;//Display.height * 0.5;
				x += 10;
				direction = "Right";
			}	
			
			// Change color
			if ( Input.isDown( Keyboard.Z ) )
			{
				Display.game.removeChild(currTexture)
				color = BLUE;
				
				if (color == BLUE && direction == "Down")
				{
					currTexture = btextureD;
				}
				
				if (color == BLUE && direction == "Up")
				{
					currTexture = btextureU;
				}
				
				if (color == BLUE && direction == "Right")
				{
					currTexture = btextureR;
				}
				
				if (color == BLUE && direction == "Left")
				{
					currTexture = btextureL;
				}
				Display.game.addChild(currTexture);
				currTexture.x = x - halfWidth;//Display.width * 0.75;
				currTexture.y = y - halfHeight;//Display.height * 0.5;
			}
			
			if ( Input.isDown( Keyboard.X ) )		
			{
				color = RED;
				Display.game.removeChild(currTexture);
				
				if (color == RED && direction == "Down")
				{
					currTexture = textureD;
				}
				
				if (color == RED && direction == "Up")
				{
					currTexture = textureU;
				}
				
				if (color == RED && direction == "Right")
				{
					currTexture = textureR;
				}
				
				if (color == RED && direction == "Left")
				{
					currTexture = textureL;
				}
				Display.game.addChild(currTexture);
				currTexture.x = x - halfWidth;//Display.width * 0.75;
				currTexture.y = y - halfHeight;//Display.height * 0.5;
			}
		}
		
		
		/// Simple AABB collision 
		public function isColliding( enemy:Enemy ) :Boolean
		{			
			// First check horizontal...
			var length	: Number = halfWidth + enemy.halfWidth;	// minimum distance between centers before collision
			var diff	: Number = Math.abs( x - enemy.x);		// actual distance between centers
			
			if ( diff < length )
			{
				// Horizon is overlapping, now check vertical.
				
				length 	= halfHeight + enemy.halfHeight;
				diff	= Math.abs( y - enemy.y );
				
				// If vertically shorter, there is collision
				if ( diff < length )
					return true;
			}
			
			return false;
		}
		
	}

}