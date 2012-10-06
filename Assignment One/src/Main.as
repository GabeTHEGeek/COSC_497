package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;
	
	/// Game to whack a dot
	public class Main extends Sprite 
	{	
		private const FLASH_FRAMES		:int = 5;	// # of frames flashing a color when successfully clicking
		private const POINTS_PER_CLICK	:int = 10;	// # of points per successful click
		
		private var score		:int = 0;
		private var nextAppear	:int = 0;
		private var threshold	:int = 2000;
		private var bgFlash		:int = 0;
		private var tf			:TextField = new TextField();
		private var getShape	:int = 0;
		private var dot			:Dot;
		private var box			:Box;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			nextAppear = threshold * 2;
			addEventListener( Event.ENTER_FRAME, onFrame );
			
			
			tf.defaultTextFormat = new TextFormat( "Arial", 64 );
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.text = "Score: " + score;
			addChild(tf);
			tf.x = 30;
			tf.y = 20;
		}
		
		/// Called once every frame
		/// Use conditionals for a street-light start, flashing and dot spawning logic
		private function onFrame( e:Event ):void
		{
			var now:int = getTimer();
			
			graphics.clear();
			if ( now < 2000 )
			{
				graphics.beginFill( 0xff0000 );
				graphics.drawCircle( stage.stageWidth * 0.5, stage.stageHeight * 0.5, 100 );
				graphics.endFill();
			}
			else if ( now < 3000 )
			{
				graphics.beginFill( 0xffff00 );
				graphics.drawCircle( stage.stageWidth * 0.5, stage.stageHeight * 0.5, 100 );
				graphics.endFill();
			}
			else if ( now < 4000 )
			{
				graphics.beginFill( 0x00ff00 );
				graphics.drawCircle( stage.stageWidth * 0.5, stage.stageHeight * 0.5, 100 );
				graphics.endFill();
			}
			else
			{
				trace(getShape);
				stage.addEventListener( MouseEvent.MOUSE_DOWN, onStageClick );
				
				if ( getShape <= 1 && now > nextAppear )
				{
					threshold -= 50;
					if ( threshold < 500)
					{
						// Make sure last dot is gone before showing game over
						if ( numChildren >= 0)
						{
							removeEventListener( Event.ENTER_FRAME, onFrame );
							gameOver();
							return;
						}
					}
					else
					{
						// Make new dot to click...
						dot = new Dot( this );
						addChild( dot );
						dot.x = Math.random() * stage.stageWidth;
						dot.y = Math.random() * stage.stageHeight;
						dot.addEventListener(Event.ENTER_FRAME, checkIfHit);
						nextAppear = now + threshold;
					}
				}
				
				if (getShape >= 2 && now > nextAppear )
				{
					threshold -= 50;
					if ( threshold < 500 )
					{
						// Make sure last dot is gone before showing game over
						if ( numChildren == 0 )
						{
							removeEventListener( Event.ENTER_FRAME, onFrame );
							gameOver();
							return;
						}
					}
					else
					{
						box = new Box( this );
						addChild( box );
						box.x = Math.random() * stage.stageWidth;
						box.y = Math.random() * stage.stageHeight;
						nextAppear = now + threshold;
					}
				}
				getShape = random(1, 3);
			}
			
			if ( bgFlash > 0 ) 
			{
				bgFlash--;
				graphics.beginFill( 0xFF0000 );
				graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight );
				graphics.endFill();
			}
		}
		
		private function gameOver():void
		{
			tf.x = (stage.stageWidth * 0.5) - (tf.textWidth * 0.5);
			tf.y = (stage.stageHeight * 0.5) - (tf.textHeight * 0.5);
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, onStageClick );
		}
		
		/// Add to score, setup a flash to occur
		public function addToScore():void 
		{
			score += POINTS_PER_CLICK;
			tf.text = "Score: " + score;
			bgFlash = FLASH_FRAMES;
		}
		
		public function onStageClick(e:MouseEvent):void
		{
			tf.text = "Score: " + score--;
		}
		
		public function random(min:int, max:int):int
		{
			return min + Math.random() * (max - min);
		}
		
		public function checkIfHit(e:Event):void 
		{
			if(dot.hitTestPoint(mouseX, mouseY, true))
			{
				trace("HIT");
				stage.removeEventListener( MouseEvent.MOUSE_DOWN, onStageClick );
			}
			
			//else(box.hitTestPoint(mouseX, mouseY, true))
			//{
			//	trace("HIT");
			//	stage.removeEventListener( MouseEvent.MOUSE_DOWN, onStageClick );
			//}
		}
	}
}