package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	
	/**
	 * Taur transforamtive item?
	 */
	public class Taurinum extends Consumable 
	{
		public function Taurinum() 
		{
			super("Taurico","Taurinum", "a vial of Taurinum", ConsumableLib.DEFAULT_VALUE, "This is a long flared vial with a small label that reads, \"<i>Taurinum</i>\".  It is likely this potion is tied to centaurs in some way.");
		}
		
		override public function useItem():Boolean
		{
			changes = 0;
			changeLimit = 1;
			if (rand(3) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			player.slimeFeed();
			clearOutput();
			outputText("You down the potion, grimacing at the strong taste.");
			if (changes < changeLimit && rand(2) === 0 && player.spe100 < 80) {
				//[removed:1.4.10]//changes++;
				outputText("\n\nAfter drinking the potion, you feel a bit faster.");
				dynStats("spe", 1);
			}
			//classic horse-taur version
			if (changes < changeLimit && rand(2) === 0 && player.lowerBody === LOWER_BODY_TYPE_HOOFED && !player.isTaur()) {
				changes++;
				outputText("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a centaur</b>.");
				if (player.gender > 0) {
					outputText("  After taking a moment to get used to your new body, you notice that your genitals now reside between the back legs on your centaur body.");
				}
				dynStats("spe", 3);
				player.lowerBody = LOWER_BODY_TYPE_HOOFED;
				player.legCount = 4;
			}
			//generic version
			if (player.lowerBody !== LOWER_BODY_TYPE_HOOFED && !player.isTaur()) {
				if (changes < changeLimit && rand(3) === 0) {
					changes++;
					//else if (player.lowerBody === LOWER_BODY_TYPE_DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					if (player.lowerBody === LOWER_BODY_TYPE_NAGA) {
						outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
						player.lowerBody = LOWER_BODY_TYPE_HOOFED;
					}
					//Catch-all
					else {	
						if (player.lowerBody === LOWER_BODY_TYPE_HUMAN)
							player.lowerBody = LOWER_BODY_TYPE_HOOFED;
						outputText("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a feral beast!</b>");
					}
					if (player.gender > 0)
						outputText("  After taking a moment to get used to your new body, you notice that your genitals now reside between the hind legs of your body.");
					dynStats("spe", 3);
					//outputText("  A coat of beastial fur springs up below your waist, itching as it fills in.<b>  You now have hooves in place of your feet!</b>");
					player.legCount = 4;
					//dynStats("cor", 0);
					changes++;
				}
			}
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
