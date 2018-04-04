package classes.internals
{
	import classes.CoC_Settings;

	/**
	 * Class for returning chained random choices derived from ChainedDrop by aimozg 
	 * @since March 7, 2018
	 * @author Stadler76
	 */
	public class ChainedChoice implements RandomChoice
	{
		private var choices:Array = [];
		private var probs:Array = [];
		private var defaultChoice:*;

		public function ChainedChoice(defaultChoice:* = null)
		{
			this.defaultChoice = defaultChoice;
		}

		public function add(item:*, prob:Number):ChainedChoice
		{
			if (prob < 0 || prob > 1) {
				CoC_Settings.error("Invalid probability value "+prob);
			}
			choices.push(item);
			probs.push(prob);
			return this;
		}

		public function elseChoice(item:*):ChainedChoice
		{
			this.defaultChoice = item;
			return this;
		}

		public function choose():*
		{
			for (var i:int = 0; i < choices.length; i++) {
				if (Math.random() < probs[i]) {
					return choices[i];
				}
			}

			return defaultChoice;
		}
	}
}
