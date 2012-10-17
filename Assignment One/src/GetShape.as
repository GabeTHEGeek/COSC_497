package  
{
	public class GetShape
	{
		
		public function GetShape() 
		{
		
		}
		
		public function random(min:int, max:int):int
		{
			return min + Math.random() * (max - min);
		}
	}
}