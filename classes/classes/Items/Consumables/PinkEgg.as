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
	public class PinkEgg extends Consumable 
	{
		public static const SMALL:int = 0;
		public static const LARGE:int = 1;

		private var large:Boolean;

		public function PinkEgg(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			large = type === LARGE;

			switch (type) {
				case SMALL:
					id = "PinkEgg";
					shortName = "PinkEgg";
					longName = "a pink and white mottled egg";
					description = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color)."
					             +" Something tells you it's more than just food.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case LARGE:
					id = "L.PnkEg";
					shortName = "L.PnkEg";
					longName = "a large pink and white mottled egg";
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
				//Remove a dick
				if (player.cocks.length > 0) {
					player.killCocks(1);
					outputText("\n\n");
				}
				//remove balls
				if (player.balls > 0) {
					if (player.ballSize > 15) {
						player.ballSize -= 8;
						outputText("Your scrotum slowly shrinks, settling down at a MUCH smaller size.  <b>Your " + player.ballsDescriptLight() + " are much smaller.</b>\n\n");
					}
					else {
						player.balls = 0;
						player.ballSize = 1;
						outputText("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
					}
				}
				//Fertility boost
				if (player.vaginas.length > 0 && player.fertility < 40) {
					outputText("You feel a tingle deep inside your body, just above your " + player.vaginaDescript(0) + ", as if you were becoming more fertile.\n\n");
					player.fertility += 5;
				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//Remove a dick
				if (player.cocks.length > 0) {
					player.killCocks(-1);
					outputText("\n\n");
				}
				if (player.balls > 0) {
					player.balls = 0;
					player.ballSize = 1;
					outputText("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
				}
				//Fertility boost
				if (player.vaginas.length > 0 && player.fertility < 70) {
					outputText("You feel a powerful tingle deep inside your body, just above your " + player.vaginaDescript(0) + ". Instinctively you know you have become more fertile.\n\n");
					player.fertility += 10;
				}
				player.refillHunger(60);
			}
			if (rand(3) === 0) {
				if (large) outputText(player.modFem(100, 8));
				else outputText(player.modFem(95, 3));
			}

			return false;
		}
	}
}
