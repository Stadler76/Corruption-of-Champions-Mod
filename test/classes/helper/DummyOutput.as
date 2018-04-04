package classes.helper 
{
	import classes.internals.GuiOutput;
	
	/**
	 * A class to simulate a text output. Used for testing to see if the correct text has been printed.
	 */
	public class DummyOutput implements GuiOutput 
	{
		public const collectedOutput:Vector.<String> = new Vector.<String>();
		public function DummyOutput() 
		{
			
		}
		
		/**
		 * Pushes the given text into the collectedOutput Vector.
		 * @param	text to ouput / store
		 * @return this instance
		 */
		public function text(text:String):GuiOutput 
		{
			collectedOutput.push(text);
			return this;
		}
		
		/**
		 * Does nothing!
		 */
		public function flush():void 
		{
			// flush stub
		}
		
		/**
		 * Pushes the given text into the collectedOutput Vector.
		 * @param	headLine text to output / store
		 * @return this instance
		 */
		public function header(headLine:String):GuiOutput 
		{
			return this;
		}
		
		/**
		 * Clears the output, all elements in collectedOutput Vector
		 * will be removed.
		 * @param	hideMenuButtons does nothing
		 * @return this instance
		 */
		public function clear(hideMenuButtons:Boolean = false):GuiOutput 
		{
			// because Adobe...   ¯\(°_°)/¯
			collectedOutput.length = 0;
			return this;
		}
	}
}
