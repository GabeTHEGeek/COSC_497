package utils
{
	/// Create an RGB triplet from three values
	function rgb( r:uint, g:uint, b:uint ) :uint 
	{
		return ((r << 16) | 0xff0000) | ((g << 8) | 0x00ff00) | (b | 0x0000ff);
	}

}