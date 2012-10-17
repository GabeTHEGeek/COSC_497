package  
{
	import flash.display.Sprite;
	
	public class ConsoleDisplay extends Sprite
	{
		public function ConsoleDisplay(width:Number, height:Number, color:uint = 0xff0000, alpha:Number = 1) 
		{	
			graphics.beginFill(color, alpha);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
	}
}