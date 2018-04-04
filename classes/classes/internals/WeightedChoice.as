package classes.internals
{
	/**
	 * Class for returning weighted random choices derived from WeightedDrop by aimozg
	 * @since March 7, 2018
	 * @author Stadler76
	 */
	public class WeightedChoice implements RandomChoice
	{
		private var choices:Array = [];
		private var sum:Number = 0;

		public function WeightedChoice(first:* = null, firstWeight:Number = 0)
		{
			if (first != null) {
				choices.push([first, firstWeight]);
				sum += firstWeight;
			}
		}

		public function add(choice:*, weight:Number = 1):WeightedChoice
		{
			choices.push([choice, weight]);
			sum += weight;
			return this;
		}

		public function addMany(weight:Number, ..._choices):WeightedChoice
		{
			for each (var choice:* in _choices){
				choices.push([choice, weight]);
				sum += weight;
			}
			return this;
		}

		public function choose():*
		{
			var random:Number = Math.random() * sum;
			var choice:* = null;
			var choices:Array = this.choices.slice();
			while (random > 0 && choices.length > 0) {
				var pair:Array = choices.shift();
				choice = pair[0];
				random -= pair[1];
			}
			return choice;
		}

		public function clone():WeightedChoice
		{
			var other:WeightedChoice = new WeightedChoice();
			other.choices = choices.slice();
			other.sum = sum;
			return other;
		}
	}
}