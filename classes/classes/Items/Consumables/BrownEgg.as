package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;

	/**
	 * @since March 31, 2018
	 * @author Stadler76
	 */
	public class BrownEgg extends Consumable 
	{
		public static const SMALL:int = 0;
		public static const LARGE:int = 1;

		private var large:Boolean;

		public function BrownEgg(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			large = type === LARGE;

			switch (type) {
				case SMALL:
					id = "BrownEg";
					shortName = "BrownEg";
					longName = "a brown and white mottled egg";
					description = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color)."
					             +" Something tells you it's more than just food.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case LARGE:
					id = "L.BrnEg";
					shortName = "L.BrnEg";
					longName = "a large brown and white mottled egg";
					description = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color)."
					             +" Something tells you it's more than just food.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large) {
				outputText("You feel a bit of additional weight on your backside as your [butt] gains a bit more padding.");
				player.butt.rating++;
				player.refillHunger(20);
			} else {
				outputText("Your [butt] wobbles, nearly throwing you off balance as it grows much bigger!");
				player.butt.rating += 2 + rand(3);
				player.refillHunger(60);
			}
			if (rand(3) === 0) {
				if (large)
					outputText(player.modThickness(100, 8));
				else
					outputText(player.modThickness(95, 3));
			}

			return false;
		}
	}
}
