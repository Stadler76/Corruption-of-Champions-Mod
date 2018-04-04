package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;

	/**
	 * @since March 31, 2018
	 * @author Stadler76
	 */
	public class IncubiDraft extends Consumable 
	{
		public static const TAINTED:int  = 0;
		public static const PURIFIED:int = 1;

		private var tainted:Boolean;

		public function IncubiDraft(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			tainted = type === TAINTED;

			switch (type) {
				case TAINTED:
					id = "IncubiD";
					shortName = "IncubiD";
					longName = "an Incubi draft";
					description = "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers."
					             +" A stylized picture of a humanoid with a huge penis is etched into the glass.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case PURIFIED:
					id = "P.Draft";
					shortName = "P.Draft";
					longName = "an untainted Incubi draft";
					description = "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers."
					             +" A stylized picture of a humanoid with a huge penis is etched into the glass."
					             +" Rathazul has purified this to prevent corruption upon use.";
					value = 20;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "incubiDraft";
			if (!tainted) tfSource += "-purified";
			var temp:int;
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = rand(100);
			if (player.hasPerk(PerkLib.HistoryAlchemist)) rando += 10;
			if (player.hasPerk(PerkLib.TransformationResistance)) rando -= 10;
			clearOutput();
			outputText("The draft is slick and sticky, ");
			if (player.cor <= 33) outputText("just swallowing it makes you feel unclean.");
			if (player.cor > 33 && player.cor <= 66) outputText("reminding you of something you just can't place.");
			if (player.cor > 66) outputText("deliciously sinful in all the right ways.");
			if (player.cor >= 90) outputText("  You're sure it must be distilled from the cum of an incubus.");
			//Lowlevel changes
			if (rando < 50) {
				if (player.cocks.length == 1) {
					if (player.cocks[0].cockType !== CockTypesEnum.DEMON) outputText("\n\nYour " + player.cockDescript(0) + " becomes shockingly hard.  It turns a shiny inhuman purple and spasms, dribbling hot demon-like cum as it begins to grow.");
					else outputText("\n\nYour " + player.cockDescript(0) + " becomes shockingly hard.  It dribbles hot demon-like cum as it begins to grow.");
					if (rand(4) === 0) temp = player.increaseCock(0, 3);
					else temp = player.increaseCock(0, 1);
					if (temp < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp >= .5 && temp < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp >= 1 && temp <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp > 2) outputText("  You smile and idly stroke your lengthening " + player.cockDescript(0) + " as a few more inches sprout.");
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					if (player.cocks[0].cockType !== CockTypesEnum.DEMON) outputText("  With the transformation complete, your " + player.cockDescript(0) + " returns to its normal coloration.");
					else outputText("  With the transformation complete, your " + player.cockDescript(0) + " throbs in an almost happy way as it goes flaccid once more.");
				}
				if (player.cocks.length > 1) {
					temp = player.cocks.length;
					temp2 = 0;
					//Find shortest cock
					while (temp > 0) {
						temp--;
						if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) {
							temp2 = temp;
						}
					}
					if (rand(4) === 0) temp3 = player.increaseCock(temp2, 3);
					else temp3 = player.increaseCock(temp2, 1);
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					//Grammar police for 2 cocks
					if (player.cockTotal() == 2) outputText("\n\nBoth of your " + player.multiCockDescriptLight() + " become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + player.cockDescript(temp2) + " begins to grow.");
					//For more than 2
					else outputText("\n\nAll of your " + player.multiCockDescriptLight() + " become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest " + player.cockDescript(temp2) + " begins to grow.");

					if (temp3 < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp3 >= .5 && temp3 < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp3 >= 1 && temp3 <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp3 > 2) outputText("  You smile and idly stroke your lengthening " + player.cockDescript(temp2) + " as a few more inches sprout.");
					outputText("  With the transformation complete, your " + player.multiCockDescriptLight() + " return to their normal coloration.");
				}
				//NO CAWKS?
				if (player.cocks.length == 0) {
					outputText("\n\n");
					mutations.growDemonCock(1);
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//TIT CHANGE 25% chance of shrinkage
				if (rand(4) === 0 && !flags[kFLAGS.HYPER_HAPPY])
				{
					player.shrinkTits();
				}
			}
			//Mid-level changes
			if (rando >= 50 && rando < 93) {
				if (player.cocks.length > 1) {
					outputText("\n\nYour cocks fill to full-size... and begin growing obscenely.  ");
					temp = player.cocks.length;
					while (temp > 0) {
						temp--;
						temp2 = player.increaseCock(temp, rand(3) + 2);
						temp3 = player.cocks[temp].thickenCock(1);
						if (temp3 < .1) player.cocks[temp].cockThickness += .05;
					}
					player.lengthChange(temp2, player.cocks.length);
					//Display the degree of thickness change.
					if (temp3 >= 1) {
						if (player.cocks.length == 1) outputText("\n\nYour cock spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
						else outputText("\n\nYour cocks spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
					}
					if (temp3 <= .5) {
						if (player.cocks.length > 1) outputText("\n\nYour cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
						else outputText("\n\nYour cock feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					}
					if (temp3 > .5 && temp2 < 1) {
						if (player.cocks.length == 1) outputText("\n\nYour cock seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
						if (player.cocks.length > 1) outputText("\n\nYour cocks seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.cocks.length == 1) {
					outputText("\n\nYour cock fills to its normal size and begins growing... ");
					temp3 = player.cocks[0].thickenCock(1);
					temp2 = player.increaseCock(0, rand(3) + 2);
					player.lengthChange(temp2, 1);
					//Display the degree of thickness change.
					if (temp3 >= 1) {
						if (player.cocks.length == 1) outputText("  Your cock spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
						else outputText("  Your cocks spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
					}
					if (temp3 <= .5) {
						if (player.cocks.length > 1) outputText("  Your cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
						else outputText("  Your cock feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
					}
					if (temp3 > .5 && temp2 < 1) {
						if (player.cocks.length == 1) outputText("  Your cock seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
						if (player.cocks.length > 1) outputText("  Your cocks seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (player.cocks.length == 0) {
					outputText("\n\n");
					mutations.growDemonCock(1);
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//Shrink breasts a more
				//TIT CHANGE 50% chance of shrinkage
				if (rand(2) === 0 && !flags[kFLAGS.HYPER_HAPPY])
				{
					player.shrinkTits();
				}
			}
			//High level change
			if (rando >= 93) {
				if (player.cockTotal() < 10) {
					if (rand(10) < int(player.cor / 25)) {
						outputText("\n\n");
						mutations.growDemonCock(rand(2) + 2);
						if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
						else dynStats("lib", 3, "sen", 5, "lus", 10);
					}
					else {
						mutations.growDemonCock(1);
					}
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				if (!flags[kFLAGS.HYPER_HAPPY])
				{
					player.shrinkTits();
					player.shrinkTits();
				}
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) {
				mutations.restoreNeck(tfSource);
			}
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) {
				mutations.restoreRearBody(tfSource);
			}
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + player.cor / 3 > 35 && tainted) {
				mutations.demonChanges(tfSource);
			}
			if (rand(4) === 0 && tainted) outputText(player.modFem(5, 2));
			if (rand(4) === 0 && tainted) outputText(player.modThickness(30, 2));
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
