package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * An egg from Ember.
	 * Boosts the special effect of Dragonbreath by 20% for 1 use. ie: if Tainted's breath weapon has a 80% chance to stun on hit, +20% equals 100% chance to stun.
	 */
	public class EmberEgg extends Consumable 
	{
		public function EmberEgg() 
		{
			super("DrgnEgg","DrgnEgg","an unfertilized dragon egg", ConsumableLib.DEFAULT_VALUE,"A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You crack the shell easily and swallow the large yolk and the copious amounts of albumen - the yolk is blue, while the rest is crimson-tinted.  It tastes like... well, it tastes mostly of spiced mint, you think.");
			//FIXME Clean up this if / else statement
			if (player.findPerk(PerkLib.Dragonfire) >= 0) {
				if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown)) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
				else {
					if (!player.hasStatusEffect(StatusEffects.DragonBreathBoost)) player.createStatusEffect(StatusEffects.DragonBreathBoost, 0, 0, 0, 0);
				}
				//(if PC has breath weapon)
				outputText("\n\nA sudden surge of energy fills your being and you feel like you could blast anything to atoms with a single breath, like the mighty dragons of legends.");
			}
			player.changeFatigue( -20);
			player.refillHunger(50);
			
			return false;
		}
		
		override public function getMaxStackSize():int {
			return 5;
		}
	}
}
