package classes.internals 
{
	/**
	 * Class that provides random numbers.
	 */
	public class RandomNumber implements IRandomNumber
	{
		/**
		 * Returns a number that is between 0 and max exclusive.
		 * @param	max the upper limit for the random number
		 * @return a value between 0 and max - 1
		 */
		public function random(max:int):int 
		{
			return Utils.rand(max);
		}
		
		/**
		 * Returns a number that is between 0 and max inclusive.
		 * @param	max the upper limit for the random number
		 * @return a value between 0 and max inclusive
		 */
		public function randomCorrected(max:int):int 
		{
			return Utils.rand(max + 1);
		}
	}
}
