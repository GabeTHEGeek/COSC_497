package engine
{
	/**
	 * 2D array implemented by single vector of objects,
	 * 
	 * @example	var arr:Array2d = new Array2d( 2, 3);
	 * 			arr.fill( 0 );
	 *			arr.put(0, 2, "foo");
	 *			arr.put(1, 0, new Bar() );
	 *			trace( arr.at(0, 2) as String );
	 */	
	final public class Array2d
	{
		private var dimx	: int;
		private var dimy	: int;
		private var data	: Vector.< Object >;
		
		public function get cols()	:int { return dimx; }
		public function get rows()	:int { return dimy; }
		
		/**
		 * CTOR
		 * @param	dimX
		 * @param	dimY
		 */
		public function Array2d( dimX:int, dimY:int  ) 
		{
			this.dimx = dimX;
			this.dimy = dimY;

			allocate();
		}
		
		private function allocate():void {
			data = new Vector.< Object >( dimx * dimy );
		}
		
		public function fill( what:* ) :void {
			for ( var i:int, len:int = dimx * dimy; i < len; ++i )
				data[i] = what;
		}
		
		public function put(x:int, y:int, what:* ):void {
			data[ (y * dimx) + x ] = what;
		}
		
		public function at(x:int, y:int):* {
			return data[ (y * dimx) + x ];
		}
		
	}

}