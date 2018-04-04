package classes.Items.Consumables 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Milk with restorative and addictive properties.
	 */
	public class MarbleMilk extends Consumable 
	{
		public function MarbleMilk() 
		{
			super("M. Milk","M. Milk", "a clear bottle of milk from Marble", ConsumableLib.DEFAULT_VALUE, "A clear bottle of milk from Marble's breasts. It smells delicious.");
		}
		
		override public function useItem():Boolean
		{
			player.slimeFeed();
			//Bottle of Marble's milk - item
			//Description: "A clear bottle of milk from Marble's breasts.  It smells delicious.  "
			clearOutput();
			//Text for when the player uses the bottle:
			//[before the player is addicted, Addiction < 30]
			if (player.statusEffectv2(StatusEffects.Marble) < 30 && player.statusEffectv3(StatusEffects.Marble) === 0) outputText("You gulp down the bottle's contents; Marble makes some good tasting milk.\n\n");
			//[before the player is addicted, Addiction < 50]
			else if (player.statusEffectv3(StatusEffects.Marble) <= 0) outputText("You gulp down the bottle's contents; Marble makes some really good tasting milk.\n\n");
			else if (player.statusEffectv3(StatusEffects.Marble) > 0) {
				//[player is completely addicted]
				if (player.findPerk(PerkLib.MarblesMilk) >= 0) outputText("You gulp down the bottle's contents; it's no substitute for the real thing, but it's a nice pick me up.\n\n");
				else {
					//[player is no longer addicted]
					if (player.findPerk(PerkLib.MarbleResistant) >= 0) outputText("You gulp down the bottle's contents; you're careful not to get too attached to the taste.\n\n");
					//[player is addicted]
					else outputText("You gulp down the bottle's contents; you really needed that.\n\n");
				}
			}
			//Increases addiction by 5, up to a max of 50 before the player becomes addicted, no max after the player is addicted.
			kGAMECLASS.marbleScene.marbleStatusChange(0, 5);
			//Does not apply the 'Marble's Milk' effect
			//Purge withdrawl
			if (player.hasStatusEffect(StatusEffects.MarbleWithdrawl)) {
				player.removeStatusEffect(StatusEffects.MarbleWithdrawl);
				game.dynStats("tou", 5, "int", 5);
				outputText("You no longer feel the symptoms of withdrawal.\n\n");
			}
			//Heals the player 70-100 health
			player.HPChange(70 + rand(31), true);
			//Restores a portion of fatigue (once implemented)
			player.changeFatigue(-25);
			//If the player is addicted, this item negates the withdrawal effects for a few hours (suggest 6), there will need to be a check here to make sure the withdrawal effect doesn't reactivate while the player is under the effect of 'Marble's Milk'.
			if (player.hasStatusEffect(StatusEffects.BottledMilk)) {
				player.addStatusValue(StatusEffects.BottledMilk, 1, (6 + rand(6)));
			}
			else player.createStatusEffect(StatusEffects.BottledMilk, 12, 0, 0, 0);
			player.refillHunger(20);
			
			return false;
		}
	}
}
