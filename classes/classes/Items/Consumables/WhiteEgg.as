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
	public class WhiteEgg extends Consumable 
	{
		public static const SMALL:int = 0;
		public static const LARGE:int = 1;

		private var large:Boolean;

		public function WhiteEgg(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			large = type === LARGE;

			switch (type) {
				case SMALL:
					id = "WhiteEg";
					shortName = "WhiteEg";
					longName = "a milky-white egg";
					description = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color)."
					             +" Something tells you it's more than just food.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case LARGE:
					id = "L.WhtEg";
					shortName = "L.WhtEg";
					longName = "a large white egg";
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
			var temp:int; // kGAMECLASS.temp was a great idea ... *cough, cough* ~Stadler76
			var temp2:Number = 0;
			outputText("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Grow nipples
				if (player.nippleLength < 3 && player.biggestTitSize() > 0) {
					outputText("\n\nYour nipples engorge, prodding hard against the inside of your [armor]."
					          +" Abruptly you realize they've gotten almost a quarter inch longer.");
					player.nippleLength += .2;
					dynStats("lus", 15);
				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//Grow nipples
				if (player.nippleLength < 3 && player.biggestTitSize() > 0) {
					outputText("\n\nYour nipples engorge, prodding hard against the inside of your [armor]."
					          +" Abruptly you realize they've grown more than an additional quarter-inch.");
					player.nippleLength += (rand(2) + 3) / 10;
					dynStats("lus", 15);
				}
				//NIPPLECUNTZZZ
				temp = player.breastRows.length;
				//Set nipplecunts on every row.
				while (temp > 0) {
					temp--;
					if (!player.breastRows[temp].fuckable && player.nippleLength >= 2) {
						player.breastRows[temp].fuckable = true;
						//Keep track of changes.
						temp2++;
					}
				}
				//Talk about if anything was changed.
				if (temp2 > 0) {
					outputText("\n\nYour [allbreasts] tingle with warmth that slowly migrates to your nipples, filling them with warmth."
					          +" You pant and moan, rubbing them with your fingers."
					          +" A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free."
					          +" <b>You now have fuckable nipples!</b>");
				}
				player.refillHunger(60);
			}

			return false;
		}
	}
}
