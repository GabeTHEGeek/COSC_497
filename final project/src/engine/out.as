package engine 
{
	/// Helper to get output to the console.
	public function out( text:String ):void 
	{
		Systems.console.add( text );
	}
}