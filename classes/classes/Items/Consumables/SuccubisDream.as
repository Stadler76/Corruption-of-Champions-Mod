package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	
	/**
	 * Balls and cum transformation item.
	 */
	public class SuccubisDream extends Consumable 
	{
		
		public function SuccubisDream() 
		{
			super("S.Dream","S.Dream", "a bottle of 'Succubus' Dream'", ConsumableLib.DEFAULT_VALUE, "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.");
		}
		
		override public function useItem():Boolean {
			player.slimeFeed();
			
			var temp:int = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			crit += rand(2) + 1;
			mutations.initTransformation([2, 2]);
			//Generic drinking text
			clearOutput();
			outputText("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (player.cor < 33) outputText("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (player.cor >= 66) outputText("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if (player.cor < 50 || rand(2)) {
				outputText("\n\nThe drink makes you feel... dirty.");
				temp = 1;
  				//Corrupts the uncorrupted faster
 				if (player.cor < 50) temp++;
 				if (player.cor < 40) temp++;
 				if (player.cor < 30) temp++;
  				//Corrupts the very corrupt slower
 				if (player.cor >= 90) temp = .5;
				dynStats("cor", temp + 2);
				changes++;
			}
			//NEW BALLZ
			if (player.balls < 4) {
				if (player.balls > 0) {
					player.balls = 4;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your " + player.armorName + ".  In shock, you barely register the sight before your eyes: <b>You have four balls.</b>");
				}
				if (player.balls === 0) {
					player.balls = 2;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your " + player.armorName + ".  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					player.ballSize = 1;
				}
				changes++;
			}
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(1.5) === 0 && changes < changeLimit && player.balls > 0 && player.cocks.length > 0) {
				player.ballSize++;
				//They grow slower as they get bigger...
				if (player.ballSize > 10) player.ballSize -= .5;
				//Texts
				if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
				if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ".  Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
				dynStats("lib", 1, "lus", 3);
			}
			//Boost cum multiplier
			if (changes < changeLimit && rand(2) === 0 && player.cocks.length > 0) {
				if (player.cumMultiplier < 6 && rand(2) === 0 && changes < changeLimit) {
					//Temp is the max it can be raised to
					temp = 3;
					//Lots of cum raises cum multiplier cap to 6 instead of 3
					if (player.findPerk(PerkLib.MessyOrgasms) >= 0) temp = 6;
					if (temp < player.cumMultiplier + .4 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .4 * crit;
						//Flavor text
						if (player.balls === 0) outputText("\n\nYou feel a churning inside your body as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ".  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.");
						dynStats("lib", 1);
					}
					changes++;
				}
			}
			//Fail-safe
			if (changes === 0) {
				outputText("\n\nYour groin tingles, making it feel as if you haven't cum in a long time.");
				player.hoursSinceCum += 100;
				changes++;
			}
			if (player.balls > 0 && rand(3) === 0) {
				outputText(player.modFem(12, 5));
			}
			player.refillHunger(15);
			
			return false;
		}
	}
}
