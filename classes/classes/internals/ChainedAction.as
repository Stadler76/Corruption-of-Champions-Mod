package classes.internals 
{
	import classes.CoC_Settings;

	/**
	 * Class for performing chained random actions (function/method calls) derived from ChainedDrop by aimozg 
	 * @since May 7, 2017
	 * @author Stadler76
	 */
	public class ChainedAction implements RandomAction 
	{
		private var actions:Array = [];
		private var probs:Array = [];
		private var defaultAction:Function;

		public function ChainedAction(defaultAction:Function = null) 
		{
			this.defaultAction = defaultAction;
		}

		public function add(action:Function, prob:Number):ChainedAction
		{
			if (prob < 0 || prob > 1) {
				CoC_Settings.error("Invalid probability value " + prob);
			}
			actions.push(action);
			probs.push(prob);
			return this;
		}

		public function elseAction(action:Function):ChainedAction
		{
			this.defaultAction = action;
			return this;
		}

		public function exec():void 
		{
			for (var i:int = 0; i < actions.length; i++) {
				if (Math.random() < probs[i]) {
					actions[i]();
					return;
				}
			}

			if (defaultAction != null)
				defaultAction();
		}
	}
}
