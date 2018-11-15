package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;

	/**
	 * Spider eyes transformative item
	 */
	public class OculumArachnae extends Consumable 
	{
		public function OculumArachnae() 
		{
			super(
				"Oculum",
				"Oculum A.",
				"a jar of Oculum Arachnae",
				ConsumableLib.DEFAULT_VALUE,
				"This is a small glass jar containing a viscous light-orange fluid with a small label that reads, \"<i>Oculum Arachnae</i>\"." +
				" It is likely this potion is tied to arachnids in some way."
			);
		}

		override public function useItem():Boolean
		{
			mutations.initTransformation([3]);
			player.slimeFeed();
			clearOutput();
			outputText("You eat the fluid and lick the rest from your fingers. It tastes a bit like roasted cheese with blueberry marmalade.");
			if (changeLimit > 0 && rand(3) === 0 && player.eyes.count < 4) {
				outputText("\n\nYou suddenly get the strangest case of double vision; you stumble and blink around, clutching your face,"
				          +" but you draw your hands back when you poke yourself in the eye. Wait, those fingers were on your forehead!"
				          +" You tentatively run your fingertips across your forehead, not quite believing what you felt."
				          +" <b>There's now a pair of eyes on your forehead, positioned just above your normal ones!</b>"
				          +" This will take some getting used to!");
				player.eyes.count = 4;
				game.flags[kFLAGS.TIMES_TRANSFORMED]++;
				return false;
			}
			// If we got here, then no changes happened
			outputText("\n\nThe cheesy sweetness energizes you, leaving you feeling refreshed.");
			player.changeFatigue(-33);
			return false;
		}
	}
}
