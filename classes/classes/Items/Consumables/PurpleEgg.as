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
	public class PurpleEgg extends Consumable 
	{
		public static const SMALL:int = 0;
		public static const LARGE:int = 1;

		private var large:Boolean;

		public function PurpleEgg(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			large = type === LARGE;

			switch (type) {
				case SMALL:
					id = "PurplEg";
					shortName = "PurplEg";
					longName = "a purple and white mottled egg";
					description = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color)."
					             +" Something tells you it's more than just food.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case LARGE:
					id = "L.PrpEg";
					shortName = "L.PrpEg";
					longName = "a large purple and white mottled egg";
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
			if (!large || player.hips.rating > 20) {
				outputText("You stumble as you feel your [hips] widen, altering your gait slightly.");
				player.hips.rating++;
				player.refillHunger(20);
			} else {
				outputText("You stagger wildly as your hips spread apart, widening by inches."
				          +" When the transformation finishes you feel as if you have to learn to walk all over again.");
				player.hips.rating += 2 + rand(2);
				player.refillHunger(60);
			}
			if (rand(3) === 0) {
				if (large)
					outputText(player.modThickness(80, 8));
				else
					outputText(player.modThickness(80, 3));
			}

			return false;
		}
	}
}
