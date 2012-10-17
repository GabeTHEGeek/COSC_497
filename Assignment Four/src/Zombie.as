package  
{
	import engine.*;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	import engine.IDisposable;
	import engine.Display;

	/**
	 * Enemy
	 */
	public class Zombie extends Sprite implements IDisposable
	{
		private const SPEED:Number = 50;
		
		private var target	:Sprite;
		private var speed	:Number;
		public var zombieName:String;
		public var isDisposed:Boolean = false;
		
		
		/// CTOR
		public function Zombie( target:Sprite, name:String ) 
		{
			var g:Graphics = this.graphics;	
			g.beginFill( 0x33ee22 );
			g.drawRect(0, 0, 10, 14);
			g.endFill();
			
			speed = SPEED + (Math.random() * 2);
			this.zombieName = "Zombie " + name;
			
			this.target = target;
		}
		
		
		/// psuedo destructor
		public function dispose() :void
		{
			target = null;
			isDisposed = true;
		}
		
		public function update( delta:Number ) :void
		{
			var v:Vector3D = new Vector3D();
			v.x = (this.x - target.x);
			v.y = (this.y - target.y);
			v.normalize();
			v.scaleBy( speed * delta );
			this.x -= v.x;
			this.y -= v.y;
			
			if (this.hitTestObject(target))
			{
				State.current = new LoseState();
			}
		}
	}
}