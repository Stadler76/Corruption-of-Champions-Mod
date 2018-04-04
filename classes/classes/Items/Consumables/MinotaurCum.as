package classes.Items.Consumables 
{
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.PerkLib;
	import classes.VaginaClass;

	/**
	 * @since March 30, 2018
	 * @author Stadler76
	 */
	public class MinotaurCum extends Consumable 
	{
		public static const STANDARD:int = 0;
		public static const PURIFIED:int = 1;

		private var purified:Boolean;

		public function MinotaurCum(type:int) 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			purified = type === PURIFIED;

			switch (type) {
				case STANDARD:
					id = "MinoCum";
					shortName = "MinoCum";
					longName = "a sealed bottle of minotaur cum";
					description = "This bottle of minotaur cum looks thick and viscous."
					             +" You know it has narcotic properties, but aside from that its effects are relatively unknown.";
					value = 60;
					break;

				case PURIFIED:
					id = "P.M.Cum";
					shortName = "P.MinoCum";
					longName = "a sealed bottle of purified minotaur cum";
					description = "This bottle of minotaur cum looks thick and viscous."
					             +" You know it has narcotic properties, but aside from that its effects are relatively unknown."
					             +" This bottle of cum has been purified to prevent corruption and addiction.";
					value = 30;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			//Minotaur cum addiction
			if (!purified) player.minoCumAddiction(7);
			else player.minoCumAddiction(-2);
			outputText("As soon as you crack the seal on the bottled white fluid, a ");
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0 && !player.hasPerk(PerkLib.MinotaurCumResistance)) outputText("potent musk washes over you.");
			else outputText("heavenly scent fills your nostrils.");
			if (!purified) {
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 50) outputText("  It makes you feel dizzy, ditzy, and placid.");
				else outputText("  It makes you feel euphoric, happy, and willing to do ANYTHING to keep feeling this way.");
			}
			else outputText("  You know that the bottle is purified and you're positive you won't get any addiction from this bottle.");
			outputText("  Unbidden, your hand brings the bottle to your lips, and the heady taste fills your mouth as you convulsively swallow the entire bottle.");
			//-Raises lust by 10.
			//-Raises sensitivity
			dynStats("sen", 1, "lus", 10);
			//-Raises corruption by 1 to 50, then by .5 to 75, then by .25 to 100.
			if (!purified) {
				if (player.cor < 50) dynStats("cor", 1);
 				else if (player.cor < 75) dynStats("cor", .5);
				else dynStats("cor", .25);
			}
			outputText("\n\nIntermittent waves of numbness wash through your body, turning into a warm tingling that makes you feel sensitive all over.  The warmth flows through you, converging in your loins and bubbling up into lust.");
			if (player.cocks.length > 0) {
				outputText("  ");
				if (player.cockTotal() == 1) outputText("Y");
				else outputText("Each of y");
				outputText("our " + player.multiCockDescriptLight() + " aches, flooding with blood until it's bloating and trembling.");
			}
			if (player.hasVagina()) {
				outputText("  Your " + player.clitDescript() + " engorges, ");
				if (player.getClitLength() < 3) outputText("parting your lips.");
				else outputText("bursting free of your lips and bobbing under its own weight.");
				if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_NORMAL) outputText("  Wetness builds inside you as your " + player.vaginaDescript(0) + " tingles and aches to be filled.");
				else if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_SLICK) outputText("  A trickle of wetness escapes your " + player.vaginaDescript(0) + " as your body reacts to the desire burning inside you.");
				else if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_DROOLING) outputText("  Wet fluids leak down your thighs as your body reacts to this new stimulus.");
				else outputText("  Slick fluids soak your thighs as your body reacts to this new stimulus.");
			}
			//(Minotaur fantasy)
			if (!kGAMECLASS.inCombat && rand(10) == 1 && (!purified && !player.hasPerk(PerkLib.MinotaurCumResistance))) {
				outputText("\n\nYour eyes flutter closed for a second as a fantasy violates your mind.  You're on your knees, prostrate before a minotaur.  Its narcotic scent fills the air around you, and you're swaying back and forth with your belly already sloshing and full of spunk.  Its equine-like member is rubbing over your face, and you submit to the beast, stretching your jaw wide to take its sweaty, glistening girth inside you.  Your tongue quivers happily as you begin sucking and slurping, swallowing each drop of pre-cum you entice from the beastly erection.  Gurgling happily, you give yourself to your inhuman master for a chance to swallow into unthinking bliss.");
				dynStats("lib", 1, "lus", rand(5) + player.cor / 20 + flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] / 5);
			}
			//(Healing – if hurt and uber-addicted (hasperk))
			if (player.HP < player.maxHP() && player.hasPerk(PerkLib.MinotaurCumAddict)) {
				outputText("\n\nThe fire of your arousal consumes your body, leaving vitality in its wake.  You feel much better!");
				player.HPChange(int(player.maxHP() / 4), false);
			}
			//Uber-addicted status!
			if (player.hasPerk(PerkLib.MinotaurCumAddict) && flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] <= 0 && !purified) {
				flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] = 3 + rand(2);
				outputText("\n\n<b>Your body feels so amazing and sensitive.  Experimentally you pinch yourself and discover that even pain is turning you on!</b>");
			}
			//Clear mind a bit
			if (purified && (player.hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 40)) {
				outputText("\n\nYour mind feels a bit clearer just from drinking the purified minotaur cum. Maybe if you drink more of these, you'll be able to rid yourself of your addiction?");
				if (player.hasPerk(PerkLib.MinotaurCumAddict) && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] <= 50) {
					outputText("  Suddenly, you black out and images flash in your mind about getting abducted by minotaurs and the abandonment of your quest that eventually leads to Lethice's success in taking over Mareth. No, it cannot be! You wake up and recover from the blackout, horrified to find out what would really happen if you spend the rest of your life with the Minotaurs! You shake your head and realize that you're no longer dependent on the cum.  ");
					outputText("\n<b>(Lost Perk: Minotaur Cum Addict!)</b>");
					player.removePerk(PerkLib.MinotaurCumAddict);
				}

			}
			player.refillHunger(25);

			return false;
		}
	}
}
