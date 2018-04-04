package classes.internals 
{
	
	/**
	 * Interface that provides methods for getting random numbers.
	 */
	public interface RandomNumberGenerator
	{
		/**
		 * Returns a number that is between 0 and max - 1 inclusive.
		 * @param	max the upper limit for the random number
		 * @return a value between 0 and max - 1
		 */
		function random(max:int):int;
		
		/**
		 * Returns a number that is between 0 and max inclusive.
		 * @param	max the upper limit for the random number
		 * @return a value between 0 and max inclusive
		 */
		function randomCorrected(max:int):int;
	}
}
