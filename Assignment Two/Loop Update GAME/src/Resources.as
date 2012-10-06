package  
{
	import flash.display.Bitmap;
	
	public class Resources 
	{
		[Embed(source = "../lib/redRight.png")]
		static public var redRight	 :Class;
		static public var rightImage :Bitmap;
		
		[Embed(source = "../lib/redLeft.png")]
		static public var redLeft	 :Class;
		static public var leftImage :Bitmap;
		
		[Embed(source = "../lib/redUp.png")]
		static public var redUp	 :Class;
		static public var upImage :Bitmap;
		
		[Embed(source="../lib/redDown.png")]
		static public var redDown	 :Class;
		static public var downImage :Bitmap;
		
		[Embed(source = "../lib/blueDown.png")]
		static public var blueDown	    :Class;
		static public var bluedownImage :Bitmap;
		
		[Embed(source = "../lib/blueLeft.png")]
		static public var blueLeft	    :Class;
		static public var blueLeftImage :Bitmap;
		
		[Embed(source = "../lib/blueRight.png")]
		static public var blueRight	 	 :Class;
		static public var blueRightImage :Bitmap;
		
		[Embed(source = "../lib/blueUp.png")] 
		static public var blueUp:Class; 
		static public var blueUpImage :Bitmap;
		
		/*
		 * Enemy Images----------------------->
		 */
		
		[Embed(source = "../lib/enemyBlueUp.png")] 
		static public var enemyBlueUp:Class; 
		static public var enemyBlueUpImage :Bitmap;
		
		[Embed(source = "../lib/enemyBlueDown.png")] 
		static public var enemyBlueDown:Class; 
		static public var enemyBlueDownImage :Bitmap;
		
		[Embed(source = "../lib/enemyBlueLeft.png")] 
		static public var enemyBlueLeft:Class; 
		static public var enemyBlueLeftImage :Bitmap;
		
		[Embed(source = "../lib/enemyBlueRight.png")] 
		static public var enemyBlueRight:Class; 
		static public var enemyBlueRightImage :Bitmap;
		
		//ENEMY RED HERE----------------------->
		
		[Embed(source = "../lib/enemyRedUp.png")] 
		static public var enemyRedUp:Class; 
		static public var enemyRedUpImage :Bitmap;
		
		[Embed(source = "../lib/enemyRedDown.png")] 
		static public var enemyRedDown:Class; 
		static public var enemyRedDownImage :Bitmap;
		
		[Embed(source = "../lib/enemyRedLeft.png")] 
		static public var enemyRedLeft:Class; 
		static public var enemyRedLeftImage :Bitmap;
		
		[Embed(source = "../lib/enemyRedRight.png")] 
		static public var enemyRedRight:Class; 
		static public var enemyRedRightImage :Bitmap;
		 
		static public function init():void
		{
			
		}
	}
}