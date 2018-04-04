package classes.Items.Consumables 
{
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;

	/**
	 * @since March 30, 2018
	 * @author Stadler76
	 */
	public class SuccubisDelight extends Consumable 
	{
		public static const TAINTED:int  = 0;
		public static const PURIFIED:int = 1;

		private var tainted:Boolean;

		public function SuccubisDelight(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			tainted = type === TAINTED;

			switch (type) {
				case TAINTED:
					id = "SDelite";
					shortName = "S.Delite";
					longName = 'a bottle of "Succubi\'s Delight"';
					description = "This precious fluid is often given to men a succubus intends to play with for a long time.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case PURIFIED:
					id = "PSDelit";
					shortName = "PSDelit";
					longName = 'an untainted bottle of "Succubi\'s Delight"';
					description = "This precious fluid is often given to men a succubus intends to play with for a long time."
					             +" It has been partially purified by Rathazul to prevent corruption.";
					value = 20;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			player.slimeFeed();
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			if (rand(4) === 0) crit += rand(2) + 1;
			mutations.initTransformation([2, 2]);
			//Generic drinking text
			clearOutput();
			outputText("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (player.cor < 33) outputText("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (player.cor >= 66) outputText("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if ((player.cor < 50 || rand(2)) && tainted) {
				outputText("\n\nThe drink makes you feel... dirty.");
				var temp:Number = 1;
				//Corrupts the uncorrupted faster
 				if (player.cor < 50) temp++;
 				if (player.cor < 40) temp++;
 				if (player.cor < 30) temp++;
				//Corrupts the very corrupt slower
				if (player.cor >= 90) temp = .5;
				if (tainted) dynStats("cor", temp);
				else dynStats("cor", 0);
				changes++;
			}
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(1.5) === 0 && changes < changeLimit && player.balls > 0) {
				player.ballSize++;
				//They grow slower as they get bigger...
				if (player.ballSize > 10) player.ballSize -= .5;
				//Texts
				if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
				if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ".  Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
				dynStats("lib", 1, "lus", 3);
				changes++;
			}
			//Grow new balls!
			if (player.balls < 2 && changes < changeLimit && rand(4) === 0) {
				if (player.balls == 0) {
					player.balls = 2;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your " + player.armorName + ".  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					player.ballSize = 1;
				}
				changes++;
			}
			//Boost cum multiplier
			if (changes < changeLimit && rand(2) === 0 && player.cocks.length > 0) {
				if (player.cumMultiplier < 6 && rand(2) === 0 && changes < changeLimit) {
					//Temp is the max it can be raised to
					temp = 3;
					//Lots of cum raises cum multiplier cap to 6 instead of 3
					if (player.hasPerk(PerkLib.MessyOrgasms)) temp = 6;
					if (temp < player.cumMultiplier + .4 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .4 * crit;
						//Flavor text
						if (player.balls == 0) outputText("\n\nYou feel a churning inside your body as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ".  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.");
						dynStats("lib", 1);
					}
					changes++;
				}
			}
			//Fail-safe
			if (changes == 0) {
				outputText("\n\nYour groin tingles, making it feel as if you haven't cum in a long time.");
				player.hoursSinceCum += 100;
			}
			if (player.balls > 0 && rand(3) === 0) {
				outputText(player.modFem(12, 3));
			}
			player.refillHunger(10);

			return false;
		}
	}
}
