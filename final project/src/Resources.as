package  
{
	import flash.display.Bitmap;
	
	public class Resources 
	{
		[Embed(source = "../lib/icon_cranberry.png")]
		static public var cranberryIcon	 :Class;
		static public var cranberryImage :Bitmap; 
		
		[Embed(source = "../lib/icon_lemon.png")]
		static public var lemonIcon	 :Class;
		static public var lemonImage :Bitmap; 
		
		[Embed(source = "../lib/icon_vodka.png")]
		static public var vodkaIcon	 :Class;
		static public var vodkaImage :Bitmap; 
		
		[Embed(source = "../lib/icon_glass.png")]
		static public var glassIcon	 :Class;
		static public var glassImage :Bitmap; 
		
		[Embed(source="../lib/menu.png")]
		static public var menuIcon	:Class;
		static public var menuImage :Bitmap; 
		
		 
		static public function init():void
		{
			
		}
	}
}