package classes.Items.Consumables
{
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.StatusEffects;
	
	/**
	 * Alcoholic beverage.
	 */
	public class FrothyBeer extends Consumable
	{
		public function FrothyBeer()
		{
			super("Fr Beer", "Fr Beer", "a mug of frothy beer", ConsumableLib.DEFAULT_VALUE, "A bottle of beer from The Black Cock.");
		}
		
		override public function useItem():Boolean
		{
			outputText("Feeling parched, you twist the metal cap from the clear green bottle and chug it down. ");
			dynStats("lus", 15);
			player.refillHunger(10, false);
			if (!player.hasStatusEffect(StatusEffects.Drunk)) {
				player.createStatusEffect(StatusEffects.Drunk, 2, 1, 1, 0);
				dynStats("str", 0.1);
				dynStats("inte", -0.5);
				dynStats("lib", 0.25);
			}
			else {
				player.addStatusValue(StatusEffects.Drunk, 2, 1);
				if (player.statusEffectv1(StatusEffects.Drunk) < 2) player.addStatusValue(StatusEffects.Drunk, 1, 1);
				if (player.statusEffectv2(StatusEffects.Drunk) === 2) {
					outputText("\n\n<b>You feel a bit drunk. Maybe you should cut back on the beers?</b>");
				}
				//Get so drunk you end up peeing! Genderless can still urinate.
				if (player.statusEffectv2(StatusEffects.Drunk) >= 3) {
					outputText("\n\nYou feel so drunk; your vision is blurry and you realize something's not feeling right. Gasp! You have to piss like a racehorse! You stumble toward the nearest bush");
					if (player.hasVagina() && !player.hasCock()) outputText(player.clothedOrNakedLower(", open up your [armor]") + " and release your pressure onto the ground. ");
					else outputText(player.clothedOrNakedLower(", open up your [armor]") + " and release your pressure onto the wall. ");
					outputText("It's like as if the floodgate has opened! ");
					game.awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true, false);
					game.awardAchievement("Smashed", kACHIEVEMENTS.GENERAL_SMASHED, true, true, false);
					outputText("\n\nIt seems to take forever but it eventually stops. You look down to see that your urine has been absorbed into the ground.");
					player.removeStatusEffect(StatusEffects.Drunk);
					game.cheatTime(1/12);
				}
			}
			
			if (player.tone < 70) player.modTone(70, rand(3));
			if (player.femininity > 30) player.modFem(30, rand(3));
			return false;
		}
	}
}
