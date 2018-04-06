package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Player;
	import classes.StatusEffects;

	/**
	 * @since April 3, 2018
	 * @author Stadler76
	 */
	public class BlackCatBeer extends Consumable 
	{
		public function BlackCatBeer() 
		{
			super(
				"BC Beer",
				"BC Beer",
				"a mug of Black Cat Beer",
				1,
				"A capped mug containing an alcoholic drink secreted from the breasts of Niamh. It smells tasty."
			);
		}

		public function applyEffect(player:Player, clearScreen:Boolean = true, newLine:Boolean = false):Boolean
		{
			if (clearScreen) {
				clearOutput();
			}
			if (newLine) {
				outputText("\n\n");
			}
			outputText("Uncapping the mug, you swill the stuff down in a single swig, gasping as it burns a fiery trail into your belly."
			          +" It's rich and sweet, and damn, but it's strong stuff!");
			outputText("\n\nA wonderful warmth fills your body, making your pain fade away.  However, it also makes your crotch tingle"
			          +" - combined with the relaxation imparted already, you feel <b>very</b> turned-on.  A beautiful, warm,"
			          +" fuzzy sensation follows and fills your head, like your brain is being wrapped in cotton wool."
			          +" You don't feel quite as smart as before, but that's all right, it feels so nice...");
			outputText("\n\nYour balance suddenly feels off-kilter and you stumble, narrowly avoiding falling."
			          +" You just can't move as fast as you could, not with your head feeling so full of fluff and fuzz;"
			          +" your body prickles and tingles with the warmth once your head feels full,"
			          +" the sensation concentrating around your erogenous zones."
			          +" You just feel so fluffy... you want to hold somebody and share your warmth with them, too; it's just so wonderful.");
			//Regain 40 to 60 lost health, increase lust by 10 to 20 points, decrease Intelligence and Speed by 5, increase Libido by 5//
			player.HPChange(40 + rand(21), false);
			var lib:Number = 0;
			if (player.getMaxStats('lib') - player.lib >= 10) {
				lib = 10;
			} else {
				lib = player.getMaxStats('lib') - player.lib;
			}
			if (!player.hasStatusEffect(StatusEffects.BlackCatBeer)) {
				player.createStatusEffect(StatusEffects.BlackCatBeer, 8, lib, 0, 0);
				dynStats("spe", -5, "int", -5, "lib", lib, "lus", 20 + rand(player.lib / 4));
			} else {
				player.addStatusValue(StatusEffects.BlackCatBeer, 1, 4);
				player.addStatusValue(StatusEffects.BlackCatBeer, 2, lib);
				outputText("\n\nDamn, it's even better with every extra drink!");
				dynStats("spe", -1, "int", -1, "lib", lib, "lus", 30 + rand(player.lib / 4));
			}
			player.slimeFeed();
			return false;
		}

		//Black Cat Beer Wears Off: This message is displayed eight hours after the last drink.
		public function blackCatBeerExpires():void
		{
			dynStats("spe", 4.5, "int", 4.5, "lib", (-1 * player.statusEffectv2(StatusEffects.BlackCatBeer)));
			player.removeStatusEffect(StatusEffects.BlackCatBeer);
			outputText("\n<b>The warm, fuzzy feeling finally dissipates, leaving you thinking clearer, focusing better, and less horny."
			          +" It was nice while it lasted, but it's also good to be back to normal."
			          +" Still, a part of you kind of wants another beer.</b>\n");
		}

		override public function useItem():Boolean
		{
			return applyEffect(player);
		}
	}
}
