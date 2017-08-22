package classes.Items
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.Forest.KitsuneScene;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;

	/**
	 * This class performs the various mutations on the player, transforming one or more
	 * aspects of their appearance.
	 */
	public final class Mutations extends MutationsHelper
	{
		private static var _instance:Mutations = new Mutations();

		public function Mutations()
		{
			if (_instance != null)
			{
				throw new Error("Mutations can only be accessed through Mutations.init()");
			}
		}

		public static function init():Mutations { return _instance; }

		public function incubiDraft(tainted:Boolean,player:Player):void
		{
			var tfSource:String = "incubiDraft";
			if (!tainted) tfSource += "-purified";
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = rand(100);
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) rando += 10;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) rando -= 10;
			clearOutput();
			outputText("The draft is slick and sticky, ");
			if (player.cor <= 33) outputText("just swallowing it makes you feel unclean.");
			if (player.cor > 33 && player.cor <= 66) outputText("reminding you of something you just can't place.");
			if (player.cor > 66) outputText("deliciously sinful in all the right ways.");
			if (player.cor >= 90) outputText("  You're sure it must be distilled from the cum of an incubus.");
			//Lowlevel changes
			if (rando < 50) {
				if (player.cocks.length == 1) {
					if (player.cocks[0].cockType != CockTypesEnum.DEMON) outputText("\n\nYour " + player.cockDescript(0) + " becomes shockingly hard.  It turns a shiny inhuman purple and spasms, dribbling hot demon-like cum as it begins to grow.");
					else outputText("\n\nYour " + player.cockDescript(0) + " becomes shockingly hard.  It dribbles hot demon-like cum as it begins to grow.");
					if (rand(4) == 0) temp = player.increaseCock(0, 3);
					else temp = player.increaseCock(0, 1);
					dynStats("int", 1, "lib", 2, "sen", 1, "lust", 5 + temp * 3, "cor", tainted ? 1 : 0);
					if (temp < .5) outputText("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp >= .5 && temp < 1) outputText("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp >= 1 && temp <= 2) outputText("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp > 2) outputText("  You smile and idly stroke your lengthening " + player.cockDescript(0) + " as a few more inches sprout.");
					if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					if (player.cocks[0].cockType != CockTypesEnum.DEMON) outputText("  With the transformation complete, your " + player.cockDescript(0) + " returns to its normal coloration.");
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
					if (int(Math.random() * 4) == 0) temp3 = player.increaseCock(temp2, 3);
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
					player.createCock();
					player.cocks[0].cockLength = rand(3) + 4;
					player.cocks[0].cockThickness = 1;
					outputText("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
					outputText("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  Eventually the orgasm ends as your " + player.cockDescript(0) + " fades to a more normal " + player.skinTone + " tone.");
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//TIT CHANGE 25% chance of shrinkage
				if (rand(4) == 0)
				{
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						player.shrinkTits();
					}
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
					player.createCock();
					player.cocks[0].cockLength = rand(3) + 4;
					player.cocks[0].cockThickness = 1;
					outputText("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
					outputText("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  Eventually the orgasm ends as your " + player.cockDescript(0) + " fades to a more normal " + player.skinTone + " tone.");
					if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
					else dynStats("lib", 3, "sen", 5, "lus", 10);
				}
				//Shrink breasts a more
				//TIT CHANGE 50% chance of shrinkage
				if (rand(2) == 0)
				{
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						player.shrinkTits();
					}
				}
			}
			//High level change
			if (rando >= 93) {
				if (player.cockTotal() < 10) {
					if (int(Math.random() * 10) < int(player.cor / 25)) {
						outputText("\n\n");
						growDemonCock(rand(2) + 2);
						if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
						else dynStats("lib", 3, "sen", 5, "lus", 10);
					}
					else {
						growDemonCock(1);
					}
				}
				if (!flags[kFLAGS.HYPER_HAPPY])
				{
					player.shrinkTits();
					player.shrinkTits();
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + player.cor / 3 > 35 && tainted) demonChanges(player);
			if (rand(4) == 0 && tainted) outputText(player.modFem(5, 2));
			if (rand(4) == 0 && tainted) outputText(player.modThickness(30, 2));
			player.refillHunger(10);
		}

		public function growDemonCock(growCocks:Number):void
		{
			temp = 0;
			while (growCocks > 0) {
				player.createCock();
				trace("COCK LENGTH: " + player.cocks[length - 1].cockLength);
				player.cocks[player.cocks.length - 1].cockLength = rand(3) + 4;
				player.cocks[player.cocks.length - 1].cockThickness = .75;
				trace("COCK LENGTH: " + player.cocks[length - 1].cockLength);
				growCocks--;
				temp++;
			}
			outputText("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
			if (temp == 1) {
				outputText("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  In time it fades to a more normal coloration and human-like texture.  ");
			}
			else {
				outputText("The skin bulges obscenely, darkening and splitting around " + num2Text(temp) + " of your new dicks.  For an instant they turn a demonic purple and dribble in thick spasms of scalding demon-cum.  After, they return to a more humanoid coloration.  ");
			}
			if (temp > 4) outputText("Your tender bundle of new cocks feels deliciously sensitive, and you cannot stop yourself from wrapping your hands around the slick demonic bundle and pleasuring them.\n\nNearly an hour later, you finally pull your slick body away from the puddle you left on the ground.  When you look back, you notice it has already been devoured by the hungry earth.");
			player.orgasm('Dick');
		}

		public function minotaurCum(purified:Boolean, player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			//Minotaur cum addiction
			if (!purified) player.minoCumAddiction(7);
			else player.minoCumAddiction(-2);
			outputText("As soon as you crack the seal on the bottled white fluid, a ");
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0 && player.findPerk(PerkLib.MinotaurCumResistance) < 0) outputText("potent musk washes over you.");
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
				if (player.cor < (50 + player.corruptionTolerance())) dynStats("cor", 1);
 				else if (player.cor < (75 + player.corruptionTolerance())) dynStats("cor", .5);
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
				if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_NORMAL) outputText("  Wetness builds inside you as your " + player.vaginaDescript(0) + " tingles and aches to be filled.");
				else if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_SLICK) outputText("  A trickle of wetness escapes your " + player.vaginaDescript(0) + " as your body reacts to the desire burning inside you.");
				else if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_DROOLING) outputText("  Wet fluids leak down your thighs as your body reacts to this new stimulus.");
				else outputText("  Slick fluids soak your thighs as your body reacts to this new stimulus.");
			}
			//(Minotaur fantasy)
			if (!kGAMECLASS.inCombat && rand(10) == 1 && (!purified && player.findPerk(PerkLib.MinotaurCumResistance) < 0)) {
				outputText("\n\nYour eyes flutter closed for a second as a fantasy violates your mind.  You're on your knees, prostrate before a minotaur.  Its narcotic scent fills the air around you, and you're swaying back and forth with your belly already sloshing and full of spunk.  Its equine-like member is rubbing over your face, and you submit to the beast, stretching your jaw wide to take its sweaty, glistening girth inside you.  Your tongue quivers happily as you begin sucking and slurping, swallowing each drop of pre-cum you entice from the beastly erection.  Gurgling happily, you give yourself to your inhuman master for a chance to swallow into unthinking bliss.");
				dynStats("lib", 1, "lus", rand(5) + player.cor / 20 + flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] / 5);
			}
			//(Healing – if hurt and uber-addicted (hasperk))
			if (player.HP < player.maxHP() && player.findPerk(PerkLib.MinotaurCumAddict) >= 0) {
				outputText("\n\nThe fire of your arousal consumes your body, leaving vitality in its wake.  You feel much better!");
				HPChange(int(player.maxHP() / 4), false);
			}
			//Uber-addicted status!
			if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 && flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] <= 0 && !purified) {
				flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] = 3 + rand(2);
				outputText("\n\n<b>Your body feels so amazing and sensitive.  Experimentally you pinch yourself and discover that even pain is turning you on!</b>");
			}
			//Clear mind a bit
			if (purified && (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 40)) {
				outputText("\n\nYour mind feels a bit clearer just from drinking the purified minotaur cum. Maybe if you drink more of these, you'll be able to rid yourself of your addiction?");
				if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] <= 50) {
					outputText("  Suddenly, you black out and images flash in your mind about getting abducted by minotaurs and the abandonment of your quest that eventually leads to Lethice's success in taking over Mareth. No, it cannot be! You wake up and recover from the blackout, horrified to find out what would really happen if you spend the rest of your life with the Minotaurs! You shake your head and realize that you're no longer dependent on the cum.  ");
					outputText("\n<b>(Lost Perk: Minotaur Cum Addict!)</b>");
					player.removePerk(PerkLib.MinotaurCumAddict);
				}
				
			}
			player.refillHunger(25);
		}

		public function succubiMilk(tainted:Boolean,player:Player):void
		{
			var tfSource:String = "succubiMilk";
			if (!tainted) tfSource += "-purified";
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = Math.random() * 100;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) rando += 10;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) rando -= 10;
			if (rando >= 90 && !tainted) rando -= 10;
			clearOutput();
			if (player.cor < 35) outputText("You wonder why in the gods' names you would drink such a thing, but you have to admit, it is the best thing you have ever tasted.");
			if (player.cor >= 35 && player.cor < 70) {
				outputText("You savor the incredible flavor as you greedily gulp it down.");
				if (player.gender == 2 || player.gender == 3) {
					outputText("  The taste alone makes your " + player.vaginaDescript(0) + " feel ");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) outputText("tingly.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText("wet.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText("sloppy and wet.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText("sopping and juicy.");
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("dripping wet.");
				}
				else if (player.hasCock()) outputText("  You feel a building arousal, but it doesn't affect your cock.");
			}
			if (player.cor >= 70) {
				outputText("You pour the milk down your throat, chugging the stuff as fast as you can.  You want more.");
				if (player.gender == 2 || player.gender == 3) {
					outputText("  Your " + player.vaginaDescript(0));
					if (player.vaginas.length > 1) outputText(" quiver in orgasm, ");
					if (player.vaginas.length == 1) outputText(" quivers in orgasm, ");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) outputText("becoming slightly sticky.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText("leaving your undergarments sticky.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText("wet with girlcum.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText("staining your undergarments with cum.");
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("leaving cunt-juice trickling down your leg.");
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText("spraying your undergarments liberally with slick girl-cum.");
					player.orgasm('Vaginal');
				}
				else if (player.gender != 0) {
					if (player.cocks.length == 1) outputText("  You feel a strange sexual pleasure, but your " + player.multiCockDescript() + " remains unaffected.");
					else outputText("  You feel a strange sexual pleasure, but your " + player.multiCockDescript() + " remain unaffected.");
				}
			}
			if (tainted) dynStats("spe", 1, "lus", 3, "cor", 1);
			else dynStats("spe", 1, "lus", 3);
			//Breast growth (maybe cock reduction!)
			if (rando <= 75) {
				//Temp stores the level of growth...
				temp = 1 + rand(3);
				if (player.breastRows.length > 0) {
					if (player.breastRows[0].breastRating < 2 && rand(3) == 0) temp++;
					if (player.breastRows[0].breastRating < 5 && rand(4) == 0) temp++;
					if (player.breastRows[0].breastRating < 6 && rand(5) == 0) temp++;
				}
				outputText("\n\n");
				player.growTits(temp, player.breastRows.length, true, 3);
				if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
				if (!flags[kFLAGS.HYPER_HAPPY])
				{
					// Shrink cocks if you have them.
					if (player.cocks.length > 0) {
						temp = 0;
						temp2 = player.cocks.length;
						temp3 = 0;
						//Find biggest cock
						while (temp2 > 0) {
							temp2--;
							if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) temp = temp2;
						}
						//Shrink said cock
						if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
							player.cocks[temp].cockLength -= .5;
							temp3 -= .5;
							if (player.cocks[temp].cockThickness * 6 > player.cocks[temp].cockLength) player.cocks[temp].cockThickness -= .2;
							if (player.cocks[temp].cockThickness * 8 > player.cocks[temp].cockLength) player.cocks[temp].cockThickness -= .2;
							if (player.cocks[temp].cockThickness < .5) player.cocks[temp].cockThickness = .5;
						}
						temp3 += player.increaseCock(temp, (rand(3) + 1) * -1);
						outputText("\n\n");
						player.lengthChange(temp3, 1);
						if (player.cocks[temp].cockLength < 2) {
							outputText("  ");
							player.killCocks(1);
						}
					}
				}
			}
			if (player.vaginas.length == 0 && (rand(3) == 0 || (rando > 75 && rando < 90))) {
				player.createVagina();
				player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_TIGHT;
				player.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
				player.vaginas[0].virgin = true;
				player.setClitLength(.25);
				if (player.fertility <= 5) player.fertility = 6;
				outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!");
			}
			//Increase pussy wetness or grow one!!
			else if (rando > 75 && rando < 90) {
				//Shrink cawk
				if (player.cocks.length > 0 && !flags[kFLAGS.HYPER_HAPPY]) {
					outputText("\n\n");
					temp = 0;
					temp2 = player.cocks.length;
					//Find biggest cock
					while (temp2 > 0) {
						temp2--;
						if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) temp = temp2;
					}
					//Shrink said cock
					if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
						player.cocks[temp].cockLength -= .5;
					}
					temp3 = player.increaseCock(temp, -1 * (rand(3) + 1));
					player.lengthChange(temp3, 1);
					if (player.cocks[temp].cockLength < 3) {
						outputText("  ");
						player.killCocks(1);
					}
				}
				if (player.vaginas.length > 0) {
					outputText("\n\n");
					//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) {
						if (player.vaginas.length == 1) outputText("Your " + player.vaginaDescript(0) + " gushes fluids down your leg as you spontaneously orgasm.");
						else outputText("Your " + player.vaginaDescript(0) + "s gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
						player.orgasm('Vaginal');
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) {
						if (player.vaginas.length == 1) outputText("Your pussy feels hot and juicy, aroused and tender.  You cannot resist as your hands dive into your " + player.vaginaDescript(0) + ".  You quickly orgasm, squirting fluids everywhere.  <b>You are now a squirter</b>.");
						if (player.vaginas.length > 1) outputText("Your pussies feel hot and juicy, aroused and tender.  You cannot resist plunging your hands inside your " + player.vaginaDescript(0) + "s.  You quiver around your fingers, squirting copious fluids over yourself and the ground.  The fluids quickly disappear into the dirt.");
						player.orgasm('Vaginal');
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) {
						if (player.vaginas.length == 1) outputText("You feel a sudden trickle of fluid down your leg.  You smell it and realize it's your pussy-juice.  Your " + player.vaginaDescript(0) + " now drools lubricant constantly down your leg.");
						if (player.vaginas.length > 1) outputText("You feel sudden trickles of fluids down your leg.  You smell the stuff and realize it's your pussies-juices.  They seem to drool lubricant constantly down your legs.");
					}
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) {
						outputText("You flush in sexual arousal as you realize how moist your cunt-lips have become.  Once you've calmed down a bit you realize they're still slick and ready to fuck, and always will be.");
					}
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) {
						if (player.vaginas.length == 1) outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your " + player.vaginaDescript(0) + " felt much wetter than normal.");
						else outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your " + player.vaginaDescript(0) + " were much wetter than normal.");
					}
					if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) {
						outputText("You feel a tingling in your crotch, but cannot identify it.");
					}
					temp = player.vaginas.length;
					while (temp > 0) {
						temp--;
						if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) player.vaginas[temp].vaginalWetness++;
					}
				}
			}
			if (rando >= 90) {
				if (player.skinTone == "blue" || player.skinTone == "purple" || player.skinTone == "indigo" || player.skinTone == "shiny black") {
					if (player.vaginas.length > 0) {
						outputText("\n\nYour heart begins beating harder and harder as heat floods to your groin.  You feel your clit peeking out from under its hood, growing larger and longer as it takes in more and more blood.");
						if (player.getClitLength() > 3 && player.findPerk(PerkLib.BigClit) < 0) outputText("  After some time it shrinks, returning to its normal aroused size.  You guess it can't get any bigger.");
						if (player.getClitLength() > 5 && player.findPerk(PerkLib.BigClit) >= 0) outputText("  Eventually it shrinks back down to its normal (but still HUGE) size.  You guess it can't get any bigger.");
						if (((player.findPerk(PerkLib.BigClit) >= 0) && player.getClitLength() < 6)
								|| player.getClitLength() < 3) {
							temp += 2;
							player.changeClitLength((rand(4) + 2) / 10);
						}
						dynStats("sen", 3, "lus", 8);
					}
					else {
						player.createVagina();
						player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_TIGHT;
						player.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
						player.vaginas[0].virgin = true;
						player.setClitLength(.25);
						outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!");
					}
				}
				else {
					temp = rand(10);
					if (temp == 0) player.skinTone = "shiny black";
					if (temp == 1 || temp == 2) player.skinTone = "indigo";
					if (temp == 3 || temp == 4 || temp == 5) player.skinTone = "purple";
					if (temp > 5) player.skinTone = "blue";
					outputText("\n\nA tingling sensation runs across your skin in waves, growing stronger as <b>your skin's tone slowly shifts, darkening to become " + player.skinTone + " in color.</b>");
					updateClaws(player.clawType);
					if (tainted) dynStats("cor", 1);
					else dynStats("cor", 0);
					kGAMECLASS.rathazul.addMixologyXP(20);
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + player.cor / 3 > 35 && tainted) demonChanges(player);
			if (tainted) {
				outputText(player.modFem(100, 2));
				if (rand(3) == 0) outputText(player.modTone(15, 2));
			}
			else {
				outputText(player.modFem(90, 1));
				if (rand(3) == 0) outputText(player.modTone(20, 2));
			}
			player.refillHunger(20);
		}
		
//1-Oversized Pepper (+size, thickness)
//2-Double Pepper (+grows second cock or changes two cocks to dogcocks)
//3-Black Pepper (Dark Fur, +corruption/libido)
//4-Knotty Pepper (+Knot + Cum Multiplier)
//5-Bulbous Pepper (+ball size or fresh balls)
		public function caninePepper(type:Number,player:Player):void
		{
			var tfSource:String = "caninePepper";
			if (player.findPerk(PerkLib.Hellfire)) tfSource += "-hellfire";
			switch (type) {
				case 5:  tfSource += "-bulbous";   break;
				case 4:  tfSource += "-knotty";    break;
				case 3:  tfSource += "-black";     break;
				case 2:  tfSource += "-double";    break;
				case 1:  tfSource += "-oversized"; break;
				default: // type == 0 --> Canine Pepper
			}
			var temp2:Number = 0;
			var temp3:Number = 0;
			var crit:Number = 1;
			//Set up changes and changeLimit
			changes = 0;
			changeLimit = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Initial outputs & crit level
			clearOutput();
			if (type == 0) {
				if (rand(100) < 15) {
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("The pepper tastes particularly potent, searingly hot and spicy.");
				}
				else outputText("The pepper is strangely spicy but very tasty.");
			}
			//Oversized pepper
			if (type == 1) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("The pepper is so large and thick that you have to eat it in several large bites.  It is not as spicy as the normal ones, but is delicious and flavorful.");
			}
			//Double Pepper
			if (type == 2) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("The double-pepper is strange, looking like it was formed when two peppers grew together near their bases.");
			}
			//Black Pepper
			if (type == 3) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("This black pepper tastes sweet, but has a bit of a tangy aftertaste.");
			}
			//Knotty Pepper
			if (type == 4) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("The pepper is a bit tough to eat due to the swollen bulge near the base, but you manage to cram it down and munch on it.  It's extra spicy!");
			}
			//Bulbous Pepper
			if (type == 5) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText("You eat the pepper, even the two orb-like growths that have grown out from the base.  It's delicious!");
			}
			//OVERDOSE Bad End!
			if (type <= 0 && crit > 1 && player.hasFur() && player.faceType == FACE_DOG && player.earType == EARS_DOG && player.lowerBody == LOWER_BODY_TYPE_DOG && player.tailType == TAIL_TYPE_DOG && rand(2) == 0 && player.hasStatusEffect(StatusEffects.DogWarning) && player.findPerk(PerkLib.TransformationResistance) < 0) {
				temp = rand(2);
				if (temp == 0) {
					outputText("\n\nAs you swallow the pepper, you note that the spicy hotness on your tongue seems to be spreading. Your entire body seems to tingle and burn, making you feel far warmer than normal, feverish even. Unable to stand it any longer you tear away your clothes, hoping to cool down a little. Sadly, this does nothing to aid you with your problem. On the bright side, the sudden feeling of vertigo you've developed is more than enough to take your mind off your temperature issues. You fall forward onto your hands and knees, well not really hands and knees to be honest. More like paws and knees. That can't be good, you think for a moment, before the sensation of your bones shifting into a quadrupedal configuration robs you of your concentration. After that, it is only a short time before your form is remade completely into that of a large dog, or perhaps a wolf. The distinction would mean little to you now, even if you were capable of comprehending it. ");
					if (player.findPerk(PerkLib.MarblesMilk) >= 0) outputText("All you know is that there is a scent on the wind, it is time to hunt, and at the end of the day you need to come home for your milk.");
					else outputText("All you know is that there is a scent on the wind, and it is time to hunt.");
				}
				if (temp == 1) outputText("\n\nYou devour the sweet pepper, carefully licking your fingers for all the succulent juices of the fruit, and are about to go on your way when suddenly a tightness begins to build in your chest and stomach, horrid cramps working their way first through your chest, then slowly flowing out to your extremities, the feeling soon joined by horrible, blood-curdling cracks as your bones begin to reform, twisting and shifting, your mind exploding with pain. You fall to the ground, reaching one hand forward. No... A paw, you realize in horror, as you try to push yourself back up. You watch in horror, looking down your foreleg as thicker fur erupts from your skin, a " + player.hairColor + " coat slowly creeping from your bare flesh to cover your body. Suddenly, you feel yourself slipping away, as if into a dream, your mind warping and twisting, your body finally settling into its new form. With one last crack of bone you let out a yelp, kicking free of the cloth that binds you, wresting yourself from its grasp and fleeing into the now setting sun, eager to find prey to dine on tonight.");
				getGame().gameOver();
				return;
			}
			//WARNING, overdose VERY close!
			if (type <= 0 && player.hasFur() && player.faceType == FACE_DOG && player.tailType == TAIL_TYPE_DOG && player.earType == EARS_DOG && player.lowerBody == LOWER_BODY_TYPE_DOG && player.hasStatusEffect(StatusEffects.DogWarning) && rand(3) == 0) {
				outputText("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			//WARNING, overdose is close!
			if (type <= 0 && player.hasFur() && player.faceType == FACE_DOG && player.tailType == TAIL_TYPE_DOG && player.earType == EARS_DOG && player.lowerBody == LOWER_BODY_TYPE_DOG && !player.hasStatusEffect(StatusEffects.DogWarning)) {
				player.createStatusEffect(StatusEffects.DogWarning, 0, 0, 0, 0);
				outputText("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			if (type == 3) {
				dynStats("lib", 2 + rand(4), "lus", 5 + rand(5), "cor", 2 + rand(4));
				outputText("\n\nYou feel yourself relaxing as gentle warmth spreads through your body.  Honestly you don't think you'd mind running into a demon or monster right now, they'd make for good entertainment.");
				if (player.cor < 50) outputText("  You shake your head, blushing hotly.  Where did that thought come from?");
			}
			if (player.str100 < 50 && rand(3) == 0) {
				dynStats("str", (crit));
				if (crit > 1) outputText("\n\nYour muscles ripple and grow, bulging outwards.");
				else outputText("\n\nYour muscles feel more toned.");
				changes++;
			}
			if (player.spe100 < 30 && rand(3) == 0 && changes < changeLimit) {
				dynStats("spe", (crit));
				if (crit > 1) outputText("\n\nYou find your muscles responding quicker, faster, and you feel an odd desire to go for a walk.");
				else outputText("\n\nYou feel quicker.");
				changes++;
			}
			if (player.inte100 > 30 && rand(3) == 0 && changes < changeLimit && type != 3) {
				dynStats("int", (-1 * crit));
				outputText("\n\nYou feel ");
				if (crit > 1) outputText("MUCH ");
				outputText("dumber.");
				changes++;
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//Restore arms to become human arms again
			if (rand(4) == 0) restoreArms(tfSource);
			//Remove feathery hair
			removeFeatheryHair();
			//if (type != 2 && type != 4 && type != 5) outputText("\n");
			//Double Pepper!
			//Xforms/grows dicks to make you have two dogcocks
			if (type == 2) {
				//If already doubled up, GROWTH
				if (player.dogCocks() >= 2) {
					type = 1;
				}
				//If player doesnt have 2 dogdicks
				else {
					//If player has NO dogdicks
					if (player.dogCocks() == 0) {
						//Dickless - grow two dogpeckers
						if (player.cockTotal() == 0) {
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							outputText("\n\nA painful lump forms on your groin, nearly doubling you over as it presses against your " + player.armorName + ".  You rip open your gear and watch, horrified as the discolored skin splits apart, revealing a pair of red-tipped points.  A feeling of relief, and surprising lust grows as they push forward, glistening red and thickening.  The skin bunches up into an animal-like sheath, while a pair of fat bulges pop free.  You now have two nice thick dog-cocks, with decent sized knots.  Both pulse and dribble animal-pre, arousing you in spite of your attempts at self-control.");
							player.cocks[0].knotMultiplier = 1.7;
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[1].knotMultiplier = 1.7;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							dynStats("lus", 50);
						}
						//1 dick - grow 1 and convert 1
						else if (player.cockTotal() == 1) {
							outputText("\n\nYour " + player.cockDescript(0) + " vibrates, the veins clearly visible as it reddens and distorts.  The head narrows into a pointed tip while a gradually widening bulge forms around the base.  Where it meets your crotch, the skin bunches up around it, forming a canine-like sheath.  ");
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[0].knotMultiplier = 1.5;
							outputText("You feel something slippery wiggling inside the new sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.cocks[1].knotMultiplier = 1.7;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							dynStats("lib", 2, "lus", 50);
						}
						//2 dicks+ - convert first 2 to doggie-dom
						else {
							outputText("\n\nYour crotch twitches, and you pull open your " + player.armorName + " to get a better look.  You watch in horror and arousal as your " + player.cockDescript(0) + " and " + player.cockDescript(1) + " both warp and twist, becoming red and pointed, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							player.cocks[0].knotMultiplier = 1.4;
							player.cocks[1].knotMultiplier = 1.4;
							dynStats("lib", 2, "lus", 50);
						}
					}
					//If player has 1 dogdicks
					else {
						//if player has 1 total
						if (player.cockTotal() == 1) {
							outputText("\n\nYou feel something slippery wiggling inside your sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.cocks[1].cockType = CockTypesEnum.DOG;
							player.cocks[1].knotMultiplier = 1.4;
							dynStats("lib", 2, "lus", 50);
						}
						//if player has more
						if (player.cockTotal() >= 1) {
							//if first dick is already doggi'ed
							if (player.cocks[0].cockType == CockTypesEnum.DOG) {
								outputText("\n\nYour crotch twitches, and you pull open your " + player.armorName + " to get a better look.  You watch in horror and arousal as your " + player.cockDescript(1) + " warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
								player.cocks[1].cockType = CockTypesEnum.DOG;
								player.cocks[1].knotMultiplier = 1.4;
							}
							//first dick is not dog
							else {
								outputText("\n\nYour crotch twitches, and you pull open your " + player.armorName + " to get a better look.  You watch in horror and arousal as your " + player.cockDescript(0) + " warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
								player.cocks[0].cockType = CockTypesEnum.DOG;
								player.cocks[0].knotMultiplier = 1.4;
							}
							dynStats("lib", 2, "lus", 50);
						}
					}
				}
			}
			//Knotty knot pepper!
			if (type == 4) {
				//Cocks only!
				if (player.cockTotal() > 0) {
					//biggify knots
					if (player.dogCocks() > 0) {
						temp = 0;
						//set temp2 to first dogdick for initialization
						while (temp < player.cocks.length) {
							if (player.cocks[temp].cockType == CockTypesEnum.DOG) {
								temp2 = temp;
								break;
							}
							else temp++;
						}
						//Reset temp for nex tcheck
						temp = player.cocks.length;
						//Find smallest knot
						while (temp > 0) {
							temp--;
							if (player.cocks[temp].cockType == CockTypesEnum.DOG && player.cocks[temp].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = temp;
						}
						//Have smallest knotted cock selected.
						temp3 = (rand(2) + 5) / 20 * crit;
						if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
						if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
						if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
						player.cocks[temp2].knotMultiplier += (temp3);
						outputText("\n\n");
						if (temp3 < .06) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " feels unusually tight in your sheath as your knot grows.");
						if (temp3 >= .06 && temp3 <= .12) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " pops free of your sheath, thickening nicely into a bigger knot.");
						if (temp3 > .12) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
						dynStats("sen", .5, "lus", 5 * crit);
					}
					//Grow dogdick with big knot
					else {
						outputText("\n\nYour " + player.cockDescript(0) + " twitches, reshaping itself.  The crown tapers down to a point while the base begins swelling.  It isn't painful in the slightest, actually kind of pleasant.  Your dog-like knot slowly fills up like a balloon, eventually stopping when it's nearly twice as thick as the rest.  You touch and shiver with pleasure, oozing pre-cum.");
						player.cocks[0].cockType = CockTypesEnum.DOG;
						player.cocks[0].knotMultiplier = 2.1;
					}
				}
				//You wasted knot pepper!
				else outputText("\n\nA slight wave of nausea passes through you.  It seems this pepper does not quite agree with your body.");
			}
			//GROW BALLS
			if (type == 5) {
				if (player.balls <= 1) {
					outputText("\n\nA spike of pain doubles you up, nearly making you vomit.  You stay like that, nearly crying, as a palpable sense of relief suddenly washes over you.  You look down and realize you now have a small sack, complete with two relatively small balls.");
					player.balls = 2;
					player.ballSize = 1;
					dynStats("lib", 2, "lus", -10);
				}
				else {
					//Makes your balls biggah!
					player.ballSize++;
					//They grow slower as they get bigger...
					if (player.ballSize > 10) player.ballSize -= .5;
					//Texts
					if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
					if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ".  Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
					dynStats("lib", 1, "lus", 3);
				}
			}
			//Sexual Stuff Now
			//------------------
			//Man-Parts
			//3 Changes,
			//1. Cock Xform
			//2. Knot Size++
			//3. cumMultiplier++ (to max of 1.5)
			if (player.cocks.length > 0) {
				//Grow knot on smallest knotted dog cock
				if (type != 4 && player.dogCocks() > 0 && ((changes < changeLimit && rand(1.4) == 0) || type == 1)) {
					temp = 0;
					//set temp2 to first dogdick for initialization
					while (temp < player.cocks.length) {
						if (player.cocks[temp].cockType == CockTypesEnum.DOG) {
							temp2 = temp;
							break;
						}
						else temp++;
					}
					//Reset temp for nex tcheck
					temp = player.cocks.length;
					//Find smallest knot
					while (temp > 0) {
						temp--;
						if (player.cocks[temp].cockType == CockTypesEnum.DOG && player.cocks[temp].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = temp;
					}
					//Have smallest knotted cock selected.
					temp3 = (rand(2) + 1) / 20 * crit;
					if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
					player.cocks[temp2].knotMultiplier += (temp3);
					if (temp3 < .06) outputText("\n\nYour " + player.cockDescript(temp2) + " feels unusually tight in your sheath as your knot grows.");
					if (temp3 >= .06 && temp3 <= .12) outputText("\n\nYour " + player.cockDescript(temp2) + " pops free of your sheath, thickening nicely into a bigger knot.");
					if (temp3 > .12) outputText("\n\nYour " + player.cockDescript(temp2) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
					dynStats("sen", .5, "lus", 5 * crit);
					changes++;
				}
				//Cock Xform if player has free cocks.
				if (player.dogCocks() < player.cocks.length && ((changes < changeLimit && rand(1.6)) || type == 1) == 0) {
					//Select first human cock
					temp = player.cocks.length;
					temp2 = 0;
					while (temp > 0 && temp2 == 0) {
						temp--;
						//Store cock index if not a dogCock and exit loop.
						if (player.cocks[temp].cockType != CockTypesEnum.DOG) {
							temp3 = temp;
							//kicking out of tah loop!
							temp2 = 1000;
						}
					}
					//Talk about it
					//Hooooman
					if (player.cocks[temp3].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " clenches painfully, becoming achingly, throbbingly erect.  A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath.  You shudder as the crown of your " + player.cockDescript(temp3) + " reshapes into a point, the sensations nearly too much for you.  You throw back your head as the transformation completes, your " + Appearance.cockNoun(CockTypesEnum.DOG) + " much thicker than it ever was before.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 10, "lus", 5 * crit);
					}
					//Horse
					if (player.cocks[temp3].cockType == CockTypesEnum.HORSE) {
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes into a more pointed form, a thick knotted bulge forming just above your sheath.  <b>You now have a dog-cock.</b>");
						//Tweak length/thickness.
						if (player.cocks[temp3].cockLength > 6) player.cocks[temp3].cockLength -= 2;
						else player.cocks[temp3].cockLength -= .5;
						player.cocks[temp3].cockThickness += .5;

						dynStats("sen", 4, "lus", 5 * crit);
					}
					//Tentacular Tuesday!
					if (player.cocks[temp3].cockType == CockTypesEnum.TENTACLE) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " coils in on itself, reshaping and losing its plant-like coloration as it thickens near the base, bulging out in a very canine-looking knot.  Your skin bunches painfully around the base, forming into a sheath.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 5 * crit);
					}
					//Misc
					if (player.cocks[temp3].cockType.Index > 4) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " trembles, reshaping itself into a shiny red doggie-dick with a fat knot at the base.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 5 * crit);
					}
					temp = 0;
					//Demon
					if (player.cocks[temp3].cockType == CockTypesEnum.DEMON) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " color shifts red for a moment and begins to swell at the base, but within moments it smooths out, retaining its distinctive demonic shape, only perhaps a bit thicker.");
						dynStats("sen", 1, "lus", 2 * crit);
						temp = 1;
					}
					//Xform it!
					player.cocks[temp3].cockType = CockTypesEnum.DOG;
					player.cocks[temp3].knotMultiplier = 1.1;
					player.cocks[temp3].thickenCock(2);
					if (temp == 1) {
						player.cocks[temp3].cockType = CockTypesEnum.DEMON;
					}
					changes++;

				}
				//Cum Multiplier Xform
				if (player.cumMultiplier < 2 && rand(2) == 0 && changes < changeLimit) {
					temp = 1.5;
					//Lots of cum raises cum multiplier cap to 2 instead of 1.5
					if (player.findPerk(PerkLib.MessyOrgasms) >= 0) temp = 2;
					if (temp < player.cumMultiplier + .05 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .05 * crit;
						//Flavor text
						if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ".  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.");
					}
					changes++;
				}
				//Oversized pepper
				if (type == 1) {
					//GET LONGER
					//single cock
					if (player.cocks.length == 1) {
						temp2 = player.increaseCock(0, rand(4) + 3);
						temp = 0;
						dynStats("sen", 1, "lus", 10);
					}
					//Multicock
					else {
						//Find smallest cock
						//Temp2 = smallness size
						//temp = current smallest
						temp3 = player.cocks.length;
						temp = 0;
						while (temp3 > 0) {
							temp3--;
							//If current cock is smaller than saved, switch values.
							if (player.cocks[temp].cockLength > player.cocks[temp3].cockLength) {
								temp2 = player.cocks[temp3].cockLength;
								temp = temp3;
							}
						}
						//Grow smallest cock!
						//temp2 changes to growth amount
						temp2 = player.increaseCock(temp, rand(4) + 3);
						dynStats("sen", 1, "lus", 10);
						if (player.cocks[temp].cockThickness <= 2) player.cocks[temp].thickenCock(1);
					}
					if (temp2 > 2) outputText("\n\nYour " + player.cockDescript(temp) + " tightens painfully, inches of bulging dick-flesh pouring out from your crotch as it grows longer.  Thick pre forms at the pointed tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) outputText("\n\nAching pressure builds within your crotch, suddenly releasing as an inch or more of extra dick-flesh spills out.  A dollop of pre beads on the head of your enlarged " + player.cockDescript(temp) + " from the pleasure of the growth.");
					if (temp2 <= 1) outputText("\n\nA slight pressure builds and releases as your " + player.cockDescript(temp) + " pushes a bit further out of your crotch.");
				}
			}
			//Female Stuff
			//Multiboobages
			if (player.breastRows.length > 0) {
				//if bigger than A cup
				if (player.breastRows[0].breastRating > 0 && player.vaginas.length > 0) {
					//Doggies only get 3 rows of tits! FENOXO HAS SPOKEN
					if (player.breastRows.length < 3 && rand(2) == 0 && changes < changeLimit) {
						player.createBreastRow();
						//Store temp to the index of the newest row
						temp = player.breastRows.length - 1;
						//Breasts are too small to grow a new row, so they get bigger first
						//But ONLY if player has a vagina (dont want dudes weirded out)
						if (player.vaginas.length > 0 && player.breastRows[0].breastRating <= player.breastRows.length) {
							outputText("\n\nYour " + player.breastDescript(0) + " feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach ");
							player.breastRows[0].breastRating += 2;
							outputText(player.breastCup(0) + " size.  But it doesn't stop there, you feel a tightness beginning lower on your torso...");
							changes++;
						}
						//Had 1 row to start
						if (player.breastRows.length == 2) {
							//1 size below primary breast row!
							player.breastRows[temp].breastRating = player.breastRows[0].breastRating - 1;
							if (player.breastRows[0].breastRating - 1 == 0) outputText("\n\nA second set of breasts forms under your current pair, stopping while they are still fairly flat and masculine looking.");
							else outputText("\n\nA second set of breasts bulges forth under your current pair, stopping as they reach " + player.breastCup(temp) + "s.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							dynStats("sen", 6, "lus", 5);
							changes++;
						}
						//Many breast Rows - requires larger primary tits...
						if (player.breastRows.length > 2 && player.breastRows[0].breastRating > player.breastRows.length) {
							dynStats("sen", 6, "lus", 5);
							//New row's size = the size of the row above -1
							player.breastRows[temp].breastRating = player.breastRows[temp - 1].breastRating - 1;
							//If second row are super small but primary row is huge it could go negative.
							//This corrects that problem.
							if (player.breastRows[temp].breastRating < 0) player.breastRows[temp].breastRating = 0;
							if (player.breastRows[temp - 1].breastRating < 0) player.breastRows[temp - 1].breastRating = 0;
							if (player.breastRows[temp].breastRating == 0) outputText("\n\nYour abdomen tingles and twitches as a new row of breasts sprouts below the others.  Your new breasts stay flat and masculine, not growing any larger.");
							else outputText("\n\nYour abdomen tingles and twitches as a new row of " + player.breastCup(temp) + " " + player.breastDescript(temp) + " sprouts below your others.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							changes++;
						}
						//Extra sensitive if crit
						if (crit > 1) {
							if (crit > 2) {
								outputText("  You heft your new chest experimentally, exploring the new flesh with tender touches.  Your eyes nearly roll back in your head from the intense feelings.");
								dynStats("sen", 6, "lus", 15, "cor", 0)
							}
							else {
								outputText("  You touch your new nipples with a mixture of awe and desire, the experience arousing beyond measure.  You squeal in delight, nearly orgasming, but in time finding the willpower to stop yourself.");
								dynStats("sen", 3, "lus", 10);
							}
						}

					}
					//If already has max doggie breasts!
					else if (rand(2) == 0) {
						//Check for size mismatches, and move closer to spec!
						temp = player.breastRows.length;
						temp2 = 0;
						var evened:Boolean = false;
						//Check each row, and if the row above or below it is
						while (temp > 1 && temp2 == 0) {
							temp--;
							//Gimme a sec
							if (player.breastRows[temp].breastRating + 1 < player.breastRows[temp - 1].breastRating) {
								if (!evened) {
									evened = true;
									outputText("\n");
								}
								outputText("\nYour ");
								if (temp == 0) outputText("first ");
								if (temp == 1) outputText("second ");
								if (temp == 2) outputText("third ");
								if (temp == 3) outputText("fourth ");
								if (temp == 4) outputText("fifth ");
								if (temp > 4) outputText("");
								outputText("row of " + player.breastDescript(temp) + " grows larger, as if jealous of the jiggling flesh above.");
								temp2 = (player.breastRows[temp - 1].breastRating) - player.breastRows[temp].breastRating - 1;
								if (temp2 > 5) temp2 = 5;
								if (temp2 < 1) temp2 = 1;
								player.breastRows[temp].breastRating += temp2;
							}
						}
					}
				}
			}
			//Grow tits if have NO breasts/nipples AT ALL
			else if (rand(2) == 0 && changes < changeLimit) {
				outputText("\n\nYour chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of B-cup breasts.</b>");
				outputText("  A sensitive nub grows on the summit of each tit, becoming a new nipple.");
				player.createBreastRow();
				player.breastRows[0].breastRating = 2;
				player.breastRows[0].breasts = 2;
				dynStats("sen", 4, "lus", 6);
				changes++;
			}
			//Go into heat
			if (rand(2) == 0 && changes < changeLimit) {
        if (player.goIntoHeat(true)) {
          changes++;
        }
			}
			if (changes < changeLimit && player.dogScore() >= 3 && rand(4) == 0) {
				changes++;
				outputText("\n\n");
				outputText("Images and thoughts come unbidden to your mind, overwhelming your control as you rapidly lose yourself in them, daydreaming of... ");
				//cawk fantasies
				if (player.gender <= 1 || (player.gender == 3 && rand(2) == 0)) {
					outputText("bounding through the woods, hunting with your master.  Feeling the wind in your fur and the thrill of the hunt coursing through your veins intoxicates you.  You have your nose to the ground, tracking your quarry as you run, until a heavenly scent stops you in your tracks.");
					dynStats("lus", 5 + player.lib / 20);
					//break1
					if (player.cor < 33 || !player.hasCock()) outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					else {
						outputText("  Heart pounding, your shaft pops free of its sheath on instinct, as you take off after the new scent.  Caught firmly in the grip of a female's heat, you ignore your master's cry as you disappear into the wild, " + Appearance.cockNoun(CockTypesEnum.DOG) + " growing harder as you near your quarry.  You burst through a bush, spotting a white-furred female.  She drops, exposing her dripping fem-sex to you, the musky scent of her sex channeling straight through your nose and sliding into your " + Appearance.cockNoun(CockTypesEnum.DOG) + ".");
						dynStats("lus", 5 + player.lib / 20);
						//Break 2
						if (player.cor < 66) outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						else {
							outputText("  Unable to wait any longer, you mount her, pressing your bulging knot against her vulva as she yips in pleasure. The heat of her sex is unreal, the tight passage gripping you like a vice as you jackhammer against her, biting her neck gently in spite of the violent pounding.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								if (player.vaginas.length > 0) outputText("\nYou reluctantly pry your hand from your aching " + player.vaginaDescript(0) + " as you drag yourself out of your fantasy.");
								else outputText("\nYou reluctantly pry your hand from your aching " + player.cockDescript(0) + " as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  At last your knot pops into her juicy snatch, splattering her groin with a smattering of her arousal.  The scents of your mating reach a peak as the velvet vice around your " + Appearance.cockNoun(CockTypesEnum.DOG) + " quivers in the most indescribably pleasant way.  You clamp down on her hide as your whole body tenses, unleashing a torrent of cum into her sex.  Each blast is accompanied by a squeeze of her hot passage, milking you of the last of your spooge.  Your " + player.legs() + " give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				//Pure female fantasies
				else if (player.hasVagina()) {
					outputText("wagging your dripping " + player.vaginaDescript(0) + " before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at your fertile scent.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled snatch and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to breed you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching " + player.vaginaDescript(0) + " as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused wetness, stretching you tightly, every beat of his heart vibrating through your nethers.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				else {
					outputText("wagging your [asshole] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at you after going so long without a female in the pack.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled ass and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to spend his lust on you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching asshole as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused, wet hole, stretching you tightly, every beat of his heart vibrating through your hindquarters.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyeType > EYES_HUMAN) {
				if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType == EYES_FOUR_SPIDER_EYES || player.eyeType == EYES_SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//Master Furry Appearance Order:
			//Tail -> Ears -> Paws -> Fur -> Face
			//Dog-face requires fur & paws  Should be last morph to take place
			if (rand(5) == 0 && changes < changeLimit &&
					player.faceType != FACE_DOG && player.hasFur() &&
					player.lowerBody == LOWER_BODY_TYPE_DOG) {
				if (player.faceType == FACE_HORSE) outputText("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else.  <b>Your horse-like features rearrange to take on many canine aspects.</b>");
				else outputText("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different.  You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>");
				player.faceType = FACE_DOG;
				changes++;
			}

			// break things, so it'll be fixed below ;-)
			if (type == 3 && !player.hasFur() && player.furColor == "midnight black") player.furColor = "no";

			if (type == 3 && (player.hairColor != "midnight black" || player.furColor != "midnight black")) {
				var furHairText:String;
				if (!player.hasFur())
					outputText("<b>\n\nYour " + player.skinDesc + " itches like crazy as fur grows out from it, coating your body.  It's incredibly dense and black as the middle of a moonless night.</b>");
				else {
					if (player.hairColor != "midnight black" && player.furColor != "midnight black")
						furHairText = "fur and hair";
					else 
						furHairText = (player.furColor != "midnight black") ? "fur" : "hair";
					outputText("<b>\n\nYour " + furHairText + " tingles, growing in thicker than ever as darkness begins to spread from the roots, turning it midnight black.</b>");
				}
				player.skinType = SKIN_TYPE_FUR;
				player.skinAdj = "thick";
				player.skinDesc = "fur";
				player.hairColor = "midnight black";
				player.furColor = player.hairColor;
				player.underBody.restore(); // Restore the underbody for now
			}
			//Become furred - requires paws and tail
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody == LOWER_BODY_TYPE_DOG && player.tailType == TAIL_TYPE_DOG && !player.hasFur()) {
				player.setFurColor(["brown", "chocolate", "auburn", "caramel", "orange", "black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white"]);
				if (player.hasPlainSkin()) outputText("\n\nYour skin itches intensely.  You gaze down as more and more hairs break forth from your skin, quickly transforming into a soft coat of fur.  <b>You are now covered in " + player.furColor + " fur from head to toe.</b>");
				if (player.hasScales()) outputText("\n\nYour scales itch incessantly.  You scratch, feeling them flake off to reveal a coat of " + player.furColor + " fur growing out from below!  <b>You are now covered in " + player.furColor + " fur from head to toe.</b>");
				player.skinType = SKIN_TYPE_FUR;
				player.skinDesc = "fur";
				player.underBody.restore(); // Restore the underbody for now
				changes++;
			}
			//Change to paws - requires tail and ears
			if (rand(3) == 0 && player.lowerBody != LOWER_BODY_TYPE_DOG && player.tailType == TAIL_TYPE_DOG && player.earType == EARS_DOG && changes < changeLimit) {
				//Feet -> paws
				if (player.lowerBody == LOWER_BODY_TYPE_HUMAN) outputText("\n\nYou scream in agony as you feel the bones in your feet break and begin to rearrange. <b>You now have paws</b>.");
				//Hooves -> Paws
				else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) outputText("\n\nYou feel your hooves suddenly splinter, growing into five unique digits.  Their flesh softens as your hooves reshape into furred paws.");
				else outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on fur-covered paws!  <b>You now have paws</b>.");
				player.lowerBody = LOWER_BODY_TYPE_DOG;
				player.legCount = 2;
				changes++;
			}
			//Change to dog-ears!  Requires dog-tail
			if (rand(2) == 0 && player.earType != EARS_DOG && player.tailType == TAIL_TYPE_DOG && changes < changeLimit) {
				if (player.earType == -1) outputText("\n\nTwo painful nubs begin sprouting from your head, growing and opening into canine ears.  ");
				if (player.earType == EARS_HUMAN) outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head.  They shift and elongate, becoming canine in nature.  ");
				if (player.earType == EARS_HORSE) outputText("\n\nYour equine ears twist as they transform into canine versions.  ");
				if (player.earType > EARS_DOG) outputText("\n\nYour ears transform, becoming more canine in appearance.  ");
				player.earType = EARS_DOG;
				player.earValue = 2;
				outputText("<b>You now have dog ears.</b>");
				changes++;
			}
			//Grow tail if not dog-tailed
			if (rand(3) == 0 && changes < changeLimit && player.tailType != TAIL_TYPE_DOG) {
				if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nA pressure builds on your backside.  You feel under your clothes and discover an odd bump that seems to be growing larger by the moment.  In seconds it passes between your fingers, bursts out the back of your clothes, and grows most of the way to the ground.  A thick coat of fur springs up to cover your new tail.  ");
				if (player.tailType == TAIL_TYPE_HORSE) outputText("\n\nYou feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur.  ");
				if (player.tailType == TAIL_TYPE_DEMONIC) outputText("\n\nThe tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail.  ");
				//Generic message for now
				if (player.tailType >= TAIL_TYPE_COW) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a long puffy tail!  ");
				changes++;
				player.tailType = TAIL_TYPE_DOG;
				outputText("<b>You now have a dog-tail.</b>");
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			if (player.hasFur() && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou become more... solid.  Sinewy.  A memory comes unbidden from your youth of a grizzled wolf you encountered while hunting, covered in scars, yet still moving with an easy grace.  You imagine that must have felt something like this.");
				dynStats("tou", 4, "sen", -3);
				changes++;
			}
			//If no changes yay
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				HPChange(20, true);
				dynStats("lus", 3);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
	
		public function succubisDelight(tainted:Boolean,player:Player):void
		{
			player.slimeFeed();
			changes = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			if (rand(4) == 0) crit += rand(2) + 1;
			changeLimit = 1;
			//Chances to up the max number of changes
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Generic drinking text
			clearOutput();
			outputText("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (player.cor < 33) outputText("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (player.cor >= 66) outputText("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if ((player.cor < (50 + player.corruptionTolerance()) || rand(2)) && tainted) {
				outputText("\n\nThe drink makes you feel... dirty.");
				temp = 1;
				//Corrupts the uncorrupted faster
 				if (player.cor < (50 + player.corruptionTolerance())) temp++;
 				if (player.cor < (40 + player.corruptionTolerance())) temp++;
 				if (player.cor < (30 + player.corruptionTolerance())) temp++;
				//Corrupts the very corrupt slower
				if (player.cor >= (90 + player.corruptionTolerance())) temp = .5;
				if (tainted) dynStats("cor", temp);
				else dynStats("cor", 0);
				changes++;
			}
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(1.5) == 0 && changes < changeLimit && player.balls > 0) {
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
			if (player.balls < 2 && changes < changeLimit && rand(4) == 0) {
				if (player.balls == 0) {
					player.balls = 2;
					outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your " + player.armorName + ".  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					player.ballSize = 1;
				}
				changes++;
			}
			//Boost cum multiplier
			if (changes < changeLimit && rand(2) == 0 && player.cocks.length > 0) {
				if (player.cumMultiplier < 6 && rand(2) == 0 && changes < changeLimit) {
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
				changes++;
			}
			if (player.balls > 0 && rand(3) == 0) {
				outputText(player.modFem(12, 3));
			}
			player.refillHunger(10);
		}

//butt expansion
		public function brownEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large) {
				outputText("You feel a bit of additional weight on your backside as your " + player.buttDescript() + " gains a bit more padding.");
				player.buttRating++;
				player.refillHunger(20);
			}
			else {
				outputText("Your " + player.buttDescript() + " wobbles, nearly throwing you off balance as it grows much bigger!");
				player.buttRating += 2 + rand(3);
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modThickness(100, 8));
				else outputText(player.modThickness(95, 3));
			}
			
		}

//hip expansion
		public function purpleEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large || player.hipRating > 20) {
				outputText("You stumble as you feel your " + player.hipDescript() + " widen, altering your gait slightly.");
				player.hipRating++;
				player.refillHunger(20);
			}
			else {
				outputText("You stagger wildly as your hips spread apart, widening by inches.  When the transformation finishes you feel as if you have to learn to walk all over again.");
				player.hipRating += 2 + rand(2);
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modThickness(80, 8));
				else outputText(player.modThickness(80, 3));
			}
		}

//Femminess
		public function pinkEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.\n\n");
			if (!large) {
				//Remove a dick
				if (player.cocks.length > 0) {
					player.killCocks(1);
					outputText("\n\n");
				}
				//remove balls
				if (player.balls > 0) {
					if (player.ballSize > 15) {
						player.ballSize -= 8;
						outputText("Your scrotum slowly shrinks, settling down at a MUCH smaller size.  <b>Your " + player.ballsDescriptLight() + " are much smaller.</b>\n\n");
					}
					else {
						player.balls = 0;
						player.ballSize = 1;
						outputText("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
					}
				}
				//Fertility boost
				if (player.vaginas.length > 0 && player.fertility < 40) {
					outputText("You feel a tingle deep inside your body, just above your " + player.vaginaDescript(0) + ", as if you were becoming more fertile.\n\n");
					player.fertility += 5;
				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//Remove a dick
				if (player.cocks.length > 0) {
					player.killCocks(-1);
					outputText("\n\n");
				}
				if (player.balls > 0) {
					player.balls = 0;
					player.ballSize = 1;
					outputText("Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>\n\n");
				}
				//Fertility boost
				if (player.vaginas.length > 0 && player.fertility < 70) {
					outputText("You feel a powerful tingle deep inside your body, just above your " + player.vaginaDescript(0) + ". Instinctively you know you have become more fertile.\n\n");
					player.fertility += 10;
				}
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modFem(100, 8));
				else outputText(player.modFem(95, 3));
			}
		}

//Maleness
		public function blueEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			var temp2:Number = 0;
			var temp3:Number = 0;
			outputText("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Kill pussies!
				if (player.vaginas.length > 0) {
					outputText("\n\nYour vagina clenches in pain, doubling you over.  You slip a hand down to check on it, only to feel the slit growing smaller and smaller until it disappears, taking your clit with it! <b> Your vagina is gone!</b>");
					player.setClitLength(.5);
					player.removeVagina(0, 1);
				}
				//Dickz
				if (player.cocks.length > 0) {
					//Multiz
					if (player.cocks.length > 1) {
						outputText("\n\nYour " + player.multiCockDescript() + " fill to full-size... and begin growing obscenely.");
						temp = player.cocks.length;
						while (temp > 0) {
							temp--;
							temp2 = player.increaseCock(temp, rand(3) + 2);
							temp3 = player.cocks[temp].thickenCock(1);
						}
						player.lengthChange(temp2, player.cocks.length);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("\n\nYour " + player.multiCockDescriptLight() + " spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("\n\nYour " + player.multiCockDescriptLight() + " feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}
					//SINGLEZ
					if (player.cocks.length == 1) {
						outputText("\n\nYour " + player.multiCockDescriptLight() + " fills to its normal size... and begins growing... ");
						temp3 = player.cocks[0].thickenCock(1);
						temp2 = player.increaseCock(0, rand(3) + 2);
						player.lengthChange(temp2, 1);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("  Your " + player.multiCockDescriptLight() + " spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("  Your " + player.multiCockDescriptLight() + " spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("  Your " + player.multiCockDescriptLight() + " feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("  Your " + player.multiCockDescriptLight() + " feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("  Your " + player.multiCockDescriptLight() + " seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("  Your " + player.multiCockDescriptLight() + " seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}

				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//New lines if changes
				if (player.bRows() > 1 || player.buttRating > 5 || player.hipRating > 5 || player.hasVagina()) outputText("\n\n");
				//Kill pussies!
				if (player.vaginas.length > 0) {
					outputText("Your vagina clenches in pain, doubling you over.  You slip a hand down to check on it, only to feel the slit growing smaller and smaller until it disappears, taking your clit with it!\n\n");
					if (player.bRows() > 1 || player.buttRating > 5 || player.hipRating > 5) outputText("  ");
					player.setClitLength(.5);
					player.removeVagina(0, 1);
				}
				//Kill extra boobages
				if (player.bRows() > 1) {
					outputText("Your back relaxes as extra weight vanishes from your chest.  <b>Your lowest " + player.breastDescript(player.bRows() - 1) + " have vanished.</b>");
					if (player.buttRating > 5 || player.hipRating > 5) outputText("  ");
					//Remove lowest row.
					player.removeBreastRow((player.bRows() - 1), 1);
				}
				//Ass/hips shrinkage!
				if (player.buttRating > 5) {
					outputText("Muscles firm and tone as you feel your " + player.buttDescript() + " become smaller and tighter.");
					if (player.hipRating > 5) outputText("  ");
					player.buttRating -= 2;
				}
				if (player.hipRating > 5) {
					outputText("Feeling the sudden burning of lactic acid in your " + player.hipDescript() + ", you realize they have slimmed down and firmed up some.");
					player.hipRating -= 2;
				}
				//Shrink tits!
				if (player.biggestTitSize() > 0)
				{
					player.shrinkTits();
				}
				if (player.cocks.length > 0) {
					//Multiz
					if (player.cocks.length > 1) {
						outputText("\n\nYour " + player.multiCockDescript() + " fill to full-size... and begin growing obscenely.  ");
						temp = player.cocks.length;
						while (temp > 0) {
							temp--;
							temp2 = player.increaseCock(temp, rand(3) + 5);
							temp3 = player.cocks[temp].thickenCock(1.5);
						}
						player.lengthChange(temp2, player.cocks.length);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("\n\nYour " + player.multiCockDescriptLight() + " spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("\n\nYour " + player.multiCockDescriptLight() + " feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("\n\nYour " + player.multiCockDescriptLight() + " seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}
					//SINGLEZ
					if (player.cocks.length == 1) {
						outputText("\n\nYour " + player.multiCockDescriptLight() + " fills to its normal size... and begins growing...");
						temp3 = player.cocks[0].thickenCock(1.5);
						temp2 = player.increaseCock(0, rand(3) + 5);
						player.lengthChange(temp2, 1);
						//Display the degree of thickness change.
						if (temp3 >= 1) {
							if (player.cocks.length == 1) outputText("  Your " + player.multiCockDescriptLight() + " spreads rapidly, swelling an inch or more in girth, making it feel fat and floppy.");
							else outputText("  Your " + player.multiCockDescriptLight() + " spread rapidly, swelling as they grow an inch or more in girth, making them feel fat and floppy.");
						}
						if (temp3 <= .5) {
							if (player.cocks.length > 1) outputText("  Your " + player.multiCockDescriptLight() + " feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
							else outputText("  Your " + player.multiCockDescriptLight() + " feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
						}
						if (temp3 > .5 && temp2 < 1) {
							if (player.cocks.length == 1) outputText("  Your " + player.multiCockDescriptLight() + " seems to swell up, feeling heavier. You look down and watch it growing fatter as it thickens.");
							if (player.cocks.length > 1) outputText("  Your " + player.multiCockDescriptLight() + " seem to swell up, feeling heavier. You look down and watch them growing fatter as they thicken.");
						}
						dynStats("lib", 1, "sen", 1, "lus", 20);
					}
				}
				player.refillHunger(60);
			}
			if (rand(3) == 0) {
				if (large) outputText(player.modFem(0, 8));
				else outputText(player.modFem(5, 3));
			}
		}

//Nipplezzzzz
		public function whiteEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			var temp2:Number = 0;
			outputText("You devour the egg, momentarily sating your hunger.");
			if (!large) {
				//Grow nipples
				if (player.nippleLength < 3 && player.biggestTitSize() > 0) {
					outputText("\n\nYour nipples engorge, prodding hard against the inside of your " + player.armorName + ".  Abruptly you realize they've gotten almost a quarter inch longer.");
					player.nippleLength += .2;
					dynStats("lus", 15);
				}
				player.refillHunger(20);
			}
			//LARGE
			else {
				//Grow nipples
				if (player.nippleLength < 3 && player.biggestTitSize() > 0) {
					outputText("\n\nYour nipples engorge, prodding hard against the inside of your " + player.armorName + ".  Abruptly you realize they've grown more than an additional quarter-inch.");
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
				if (temp2 > 0) outputText("\n\nYour " + player.allBreastsDescript() + " tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>");
				player.refillHunger(60);
			}
		}

		public function blackRubberEgg(large:Boolean,player:Player):void
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.");
			//Small
			if (!large) {
				//Change skin to normal if not flawless!
				if ((player.skinAdj != "smooth" && player.skinAdj != "latex" && player.skinAdj != "rubber") || player.skinDesc != "skin") {
					outputText("\n\nYour " + player.skinDesc + " tingles delightfully as it ");
					if (player.hasPlainSkin()) outputText(" loses its blemishes, becoming flawless smooth skin.");
					if (player.hasFur()) outputText(" falls out in clumps, revealing smooth skin underneath.");
					if (player.hasScales()) outputText(" begins dropping to the ground in a pile around you, revealing smooth skin underneath.");
					if (player.hasGooSkin()) outputText(" shifts and changes into flawless smooth skin.");
					player.skinDesc = "skin";
					player.skinAdj = "smooth";
					if (player.skinTone == "rough gray") player.skinTone = "gray";
					player.skinType = SKIN_TYPE_PLAIN;
					player.underBody.restore();
					updateClaws(player.clawType);
				}
				//chance of hair change
				else {
					//If hair isn't rubbery/latex yet
					if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") && player.hairLength != 0) {
						//if skin is already one...
						if (player.skinDesc == "skin" && player.skinAdj == "rubber") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" thick rubbery hair.");
							player.hairColor = "rubbery " + player.hairColor;
							dynStats("cor", 2);
						}
						if (player.skinDesc == "skin" && player.skinAdj == "latex") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" shiny latex hair.");
							player.hairColor = "latex-textured " + player.hairColor;
							dynStats("cor", 2);
						}
					}
				}
				player.refillHunger(20);
			}
			//Large
			if (large) {
				//Change skin to latex if smooth.
				if (player.skinDesc == "skin" && player.skinAdj == "smooth") {
					outputText("\n\nYour already flawless smooth skin begins to tingle as it changes again.  It becomes shinier as its texture changes subtly.  You gasp as you touch yourself and realize your skin has become ");
					if (rand(2) == 0) {
						player.skinDesc = "skin";
						player.skinAdj = "latex";
						outputText("a layer of pure latex.  ");
					}
					else {
						player.skinDesc = "skin";
						player.skinAdj = "rubber";
						outputText("a layer of sensitive rubber.  ");
					}
					flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] = 1;
					if (player.cor < 66) outputText("You feel like some kind of freak.");
					else outputText("You feel like some kind of sexy " + player.skinDesc + " love-doll.");
					dynStats("spe", -3, "sen", 8, "lus", 10, "cor", 2);
				}
				//Change skin to normal if not flawless!
				if ((player.skinAdj != "smooth" && player.skinAdj != "latex" && player.skinAdj != "rubber") || player.skinDesc != "skin") {
					outputText("\n\nYour " + player.skinDesc + " tingles delightfully as it ");
					if (player.hasPlainSkin()) outputText(" loses its blemishes, becoming flawless smooth skin.");
					if (player.hasFur()) outputText(" falls out in clumps, revealing smooth skin underneath.");
					if (player.hasScales()) outputText(" begins dropping to the ground in a pile around you, revealing smooth skin underneath.");
					if (player.hasGooSkin()) outputText(" shifts and changes into flawless smooth skin.");
					player.skinDesc = "skin";
					player.skinAdj = "smooth";
					if (player.skinTone == "rough gray") player.skinTone = "gray";
					player.skinType = SKIN_TYPE_PLAIN;
					player.underBody.restore();
					updateClaws(player.clawType);
				}
				//chance of hair change
				else {
					//If hair isn't rubbery/latex yet
					if (player.hairColor.indexOf("rubbery") == -1 && player.hairColor.indexOf("latex-textured") && player.hairLength != 0) {
						//if skin is already one...
						if (player.skinAdj == "rubber" && player.skinDesc == "skin") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" thick rubbery hair.");
							player.hairColor = "rubbery " + player.hairColor;
							dynStats("cor", 2);
						}
						if (player.skinAdj == "latex" && player.skinDesc == "skin") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" shiny latex hair.");
							player.hairColor = "latex-textured " + player.hairColor;
							dynStats("cor", 2);
						}
					}
				}
				player.refillHunger(60);
			}
		}

		/*Purified LaBova:
		 This will be one of the items that the player will have to give Marble to purify her, but there is a limit on how much she can be purified in this way.
		 Effects on the player:
		 Mostly the same, but without animal transforms, corruption, and lower limits on body changes
		 Hips and ass cap at half the value for LaBova
		 Nipple growth caps at 1 inch
		 Breasts cap at E or DD cup
		 Raises lactation to a relatively low level, reduces high levels: \"Your breasts suddenly feel less full, it seems you aren't lactating at quite the level you where.\"  OR  \"The insides of your breasts suddenly feel bloated.  There is a spray of milk from them, and they settle closer to a more natural level of lactation.\"
		 Does not apply the addictive quality
		 If the player has the addictive quality, this item can remove that effect

		 Enhanced LaBova:
		 Something that the player can either make or find later; put it in whenever you want, or make your own item.  This is just a possible suggestion.  If it is given to Marble, she only gains the quad nipples.
		 Effects on the player
		 Mostly the same, but some of the effects can be more pronounced.  Ie, more str gain from one dose, or more breast growth.
		 If the player's nipples are larger than 1 inch in length, this item is guaranteed to give them quad nipples.  This applies to all their breasts; seems like it ould be a good compromise on whether or not cowgirls should have 4 breasts.
		 Very small chance to increase fertility (normally this increase would only happen when the player forces a creature to drink their milk).
		 */
		public function laBova(tainted:Boolean,enhanced:Boolean,player:Player):void
		{
			var tfSource:String = "laBova";
			player.slimeFeed();
			//Changes done
			changes = 0;
			//Change limit
			changeLimit = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			if (enhanced) changeLimit += 2;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//LaBova:
			//ItemDesc: "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.  "
			//ItemUseText:
			clearOutput();
			outputText("You drink the ");
			if (enhanced) outputText("Pro Bova");
			else outputText("La Bova");
			outputText(".  The drink has an odd texture, but is very sweet.  It has a slight aftertaste of milk.");
			//Possible Item Effects:
			//STATS
			//Increase player str:
			if (changes < changeLimit && rand(3) == 0) {
				temp = 60 - player.str;
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) == 0) outputText("\n\nThere is a slight pain as you feel your muscles shift somewhat.  Their appearance does not change much, but you feel much stronger.");
					else outputText("\n\nYou feel your muscles tighten and clench as they become slightly more pronounced.");
					dynStats("str", temp / 10);
					changes++;
				}
			}
			//Increase player tou:
			if (changes < changeLimit && rand(3) == 0) {
				temp = 60 - player.tou;
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) == 0) outputText("\n\nYou feel your insides toughening up; it feels like you could stand up to almost any blow.");
					else outputText("\n\nYour bones and joints feel sore for a moment, and before long you realize they've gotten more durable.");
					dynStats("tou", temp / 10);
					changes++;

				}
			}
			//Decrease player spd if it is over 30:
			if (changes < changeLimit && rand(3) == 0) {
				if (player.spe100 > 30) {
					outputText("\n\nThe body mass you've gained is making your movements more sluggish.");
					changes++;
					temp = (player.spe - 30) / 10;
					dynStats("spe", -temp);
				}
			}
			//Increase Corr, up to a max of 50.
			if (tainted) {
				temp = 50 - player.cor;
				if (temp < 0) temp = 0;
				dynStats("cor", temp / 10);
			}
			//Sex bits - Duderiffic
			if (player.cocks.length > 0 && rand(2) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				//If the player has at least one dick, decrease the size of each slightly,
				outputText("\n\n");
				temp = 0;
				temp2 = player.cocks.length;
				temp3 = 0;
				//Find biggest cock
				while (temp2 > 0) {
					temp2--;
					if (player.cocks[temp].cockLength <= player.cocks[temp2].cockLength) temp = temp2;
				}
				//Shrink said cock
				if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
					player.cocks[temp].cockLength -= .5;
					temp3 -= .5;
				}
				temp3 += player.increaseCock(temp, (rand(3) + 1) * -1);
				player.lengthChange(temp3, 1);
				if (player.cocks[temp].cockLength < 2) {
					outputText("  ");
					if (player.cockTotal() == 1 && !player.hasVagina()) {
						outputText("Your " + player.cockDescript(0) + " suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.");
						if (player.balls > 0) outputText("  At the same time, your " + player.ballsDescriptLight() + " fall victim to the same sensation; eagerly swallowed whole by your crotch.");
						outputText("  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>");
						player.balls = 0;
						player.ballSize = 1;
						player.createVagina();
						player.setClitLength(.25);
						player.removeCock(0, 1);
					}
					else {
						player.killCocks(1);
					}
				}
				//if the last of the player's dicks are eliminated this way, they gain a virgin vagina;
				if (player.cocks.length == 0 && !player.hasVagina()) {
					player.createVagina();
					player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
					player.vaginas[0].virgin = true;
					player.setClitLength(.25);
					outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!");

					changes++;
					dynStats("lus", 10);
				}
			}
			//Sex bits - girly
			var boobsGrew:Boolean = false;
			//Increase player's breast size, if they are HH or bigger
			//do not increase size, but do the other actions:
			if (((tainted && player.biggestTitSize() <= 11) || (!tainted && player.biggestTitSize() <= 5)) && changes < changeLimit && (rand(3) == 0 || enhanced)) {
				if (rand(2) == 0) outputText("\n\nYour " + player.breastDescript(0) + " tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your " + player.breastDescript(0) + " seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				dynStats("sen", .5);
				boobsGrew = true;
			}
			//Remove feathery hair
			removeFeatheryHair();
			//If breasts are D or bigger and are not lactating, they also start lactating:
			if (player.biggestTitSize() >= 4 && player.breastRows[0].lactationMultiplier < 1 && changes < changeLimit && (rand(3) == 0 || boobsGrew || enhanced)) {
				outputText("\n\nYou gasp as your " + player.breastDescript(0) + " feel like they are filling up with something.  Within moments, a drop of milk leaks from your " + player.breastDescript(0) + "; <b> you are now lactating</b>.");
				player.breastRows[0].lactationMultiplier = 1.25;
				changes++;
				dynStats("sen", .5);
			}
			//Quad nipples and other 'special enhanced things.
			if (enhanced) {
				//QUAD DAMAGE!
				if (player.breastRows[0].nipplesPerBreast == 1) {
					changes++;
					player.breastRows[0].nipplesPerBreast = 4;
					outputText("\n\nYour " + player.nippleDescript(0) + "s tingle and itch.  You pull back your " + player.armorName + " and watch in shock as they split into four distinct nipples!  <b>You now have four nipples on each side of your chest!</b>");
					if (player.breastRows.length >= 2 && player.breastRows[1].nipplesPerBreast == 1) {
						outputText("A moment later your second row of " + player.breastDescript(1) + " does the same.  <b>You have sixteen nipples now!</b>");
						player.breastRows[1].nipplesPerBreast = 4;
					}
					if (player.breastRows.length >= 3 && player.breastRows[2].nipplesPerBreast == 1) {
						outputText("Finally, your ");
						if (player.bRows() == 3) outputText("third row of " + player.breastDescript(2) + " mutates along with its sisters, sprouting into a wonderland of nipples.");
						else if (player.bRows() >= 4) {
							outputText("everything from the third row down mutates, sprouting into a wonderland of nipples.");
							player.breastRows[3].nipplesPerBreast = 4;
							if (player.bRows() >= 5) player.breastRows[4].nipplesPerBreast = 4;
							if (player.bRows() >= 6) player.breastRows[5].nipplesPerBreast = 4;
							if (player.bRows() >= 7) player.breastRows[6].nipplesPerBreast = 4;
							if (player.bRows() >= 8) player.breastRows[7].nipplesPerBreast = 4;
							if (player.bRows() >= 9) player.breastRows[8].nipplesPerBreast = 4;
						}
						player.breastRows[2].nipplesPerBreast = 4;
						outputText("  <b>You have a total of " + num2Text(player.totalNipples()) + " nipples.</b>");
					}
				}
				//QUAD DAMAGE IF WEIRD SHIT BROKE BEFORE
				else if (player.breastRows.length > 1 && player.breastRows[1].nipplesPerBreast == 1) {
					if (player.breastRows[1].nipplesPerBreast == 1) {
						outputText("\n\nYour second row of " + player.breastDescript(1) + " tingle and itch.  You pull back your " + player.armorName + " and watch in shock as your " + player.nippleDescript(1) + " split into four distinct nipples!  <b>You now have four nipples on each breast in your second row of breasts</b>.");
						player.breastRows[1].nipplesPerBreast = 4;
					}
				}
				else if (player.breastRows.length > 2 && player.breastRows[2].nipplesPerBreast == 1) {
					if (player.breastRows[2].nipplesPerBreast == 1) {
						outputText("\n\nYour third row of " + player.breastDescript(2) + " tingle and itch.  You pull back your " + player.armorName + " and watch in shock as your " + player.nippleDescript(2) + " split into four distinct nipples!  <b>You now have four nipples on each breast in your third row of breasts</b>.");
						player.breastRows[2].nipplesPerBreast = 4;
					}
				}
				else if (player.breastRows.length > 3 && player.breastRows[3].nipplesPerBreast == 1) {
					if (player.breastRows[3].nipplesPerBreast == 1) {
						outputText("\n\nYour fourth row of " + player.breastDescript(3) + " tingle and itch.  You pull back your " + player.armorName + " and watch in shock as your " + player.nippleDescript(3) + " split into four distinct nipples!  <b>You now have four nipples on each breast in your fourth row of breasts</b>.");
						player.breastRows[3].nipplesPerBreast = 4;
					}
				}
				else if (player.biggestLactation() > 1) {
					if (rand(2) == 0) outputText("\n\nA wave of pleasure passes through your chest as your " + player.breastDescript(0) + " start leaking milk from a massive jump in production.");
					else outputText("\n\nSomething shifts inside your " + player.breastDescript(0) + " and they feel MUCH fuller and riper.  You know that you've started producing much more milk.");
					player.boostLactation(2.5);
					if ((player.nippleLength < 1.5 && tainted) || (!tainted && player.nippleLength < 1)) {
						outputText("  Your " + player.nippleDescript(0) + "s swell up, growing larger to accommodate your increased milk flow.");
						player.nippleLength += .25;
						dynStats("sen", .5);
					}
					changes++;
				}
			}
			//If breasts are already lactating and the player is not lactating beyond a reasonable level, they start lactating more:
			else {
				if (tainted && player.breastRows[0].lactationMultiplier > 1 && player.breastRows[0].lactationMultiplier < 5 && changes < changeLimit && (rand(3) == 0 || enhanced)) {
					if (rand(2) == 0) outputText("\n\nA wave of pleasure passes through your chest as your " + player.breastDescript(0) + " start producing more milk.");
					else outputText("\n\nSomething shifts inside your " + player.breastDescript(0) + " and they feel fuller and riper.  You know that you've started producing more milk.");
					player.boostLactation(0.75);
					if ((player.nippleLength < 1.5 && tainted) || (!tainted && player.nippleLength < 1)) {
						outputText("  Your " + player.nippleDescript(0) + "s swell up, growing larger to accommodate your increased milk flow.");
						player.nippleLength += .25;
						dynStats("sen", .5);
					}
					changes++;
				}
				if (!tainted) {
					if (player.breastRows[0].lactationMultiplier > 1 && player.breastRows[0].lactationMultiplier < 3.2 && changes < changeLimit && rand(3) == 0) {
						if (rand(2) == 0) outputText("\n\nA wave of pleasure passes through your chest as your " + player.breastDescript(0) + " start producing more milk.");
						else outputText("\n\nSomething shifts inside your " + player.breastDescript(0) + " and they feel fuller and riper.  You know that you've started producing more milk.");
						player.boostLactation(0.75);
						if ((player.nippleLength < 1.5 && tainted) || (!tainted && player.nippleLength < 1)) {
							outputText("  Your " + player.nippleDescript(0) + "s swell up, growing larger to accommodate your increased milk flow.");
							player.nippleLength += .25;
							dynStats("sen", .5);
						}
						changes++;
					}
					if ((player.breastRows[0].lactationMultiplier > 2 && player.hasStatusEffect(StatusEffects.Feeder)) || player.breastRows[0].lactationMultiplier > 5) {
						if (rand(2) == 0) outputText("\n\nYour breasts suddenly feel less full, it seems you aren't lactating at quite the level you were.");
						else outputText("\n\nThe insides of your breasts suddenly feel bloated.  There is a spray of milk from them, and they settle closer to a more natural level of lactation.");
						changes++;
						dynStats("sen", .5);
						player.boostLactation(-1);
					}
				}
			}
			//If breasts are lactating at a fair level
			//and the player has not received this status,
			//apply an effect where the player really wants
			//to give their milk to other creatures
			//(capable of getting them addicted):
			if (!player.hasStatusEffect(StatusEffects.Feeder) && player.biggestLactation() >= 3 && rand(2) == 0 && player.biggestTitSize() >= 5 && player.cor >= (35 - player.corruptionTolerance())) {
				outputText("\n\nYou start to feel a strange desire to give your milk to other creatures.  For some reason, you know it will be very satisfying.\n\n<b>(You have gained the 'Feeder' perk!)</b>");
				player.createStatusEffect(StatusEffects.Feeder, 0, 0, 0, 0);
				player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
				changes++;
			}
			//UNFINISHED
			//If player has addictive quality and drinks pure version, removes addictive quality.
			//if the player has a vagina and it is tight, it loosens.
			if (player.hasVagina()) {
				if (player.vaginas[0].vaginalLooseness < VAGINA_LOOSENESS_LOOSE && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYou feel a relaxing sensation in your groin.  On further inspection you discover your " + player.vaginaDescript(0) + " has somehow relaxed, permanently loosening.");
					player.vaginas[0].vaginalLooseness++;
					player.vaginas[0].resetRecoveryProgress();
					player.vaginas[0].vaginalLooseness++;
					changes++;
					dynStats("lus", 10);
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (tainted && rand(5) == 0) updateOvipositionPerk(tfSource);
			//General Appearance (Tail -> Ears -> Paws(fur stripper) -> Face -> Horns
			//Give the player a bovine tail, same as the minotaur
			if (tainted && player.tailType != TAIL_TYPE_COW && changes < changeLimit && rand(3) == 0) {
				if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nYou feel the flesh above your " + player.buttDescript() + " knotting and growing.  It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				else {
					if (player.tailType < TAIL_TYPE_SPIDER_ADBOMEN || player.tailType > TAIL_TYPE_BEE_ABDOMEN) {
						outputText("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
					}
					//insect
					if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.tailType == TAIL_TYPE_BEE_ABDOMEN) {
						outputText("\n\nYour insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.");
					}
				}
				player.tailType = TAIL_TYPE_COW;
				changes++;
			}
			//Give the player bovine ears, same as the minotaur
			if (tainted && player.earType != EARS_COW && changes < changeLimit && rand(4) == 0 && player.tailType == TAIL_TYPE_COW) {
				outputText("\n\nYou feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like.  <b>You now have cow ears.</b>");
				player.earType = EARS_COW;
				changes++;
			}
			//If the player is under 7 feet in height, increase their height, similar to the minotaur
			if (((enhanced && player.tallness < 96) || player.tallness < 84) && changes < changeLimit && rand(2) == 0) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 74) temp = Math.floor(temp / 2);
				//Never 0
				if (temp == 0) temp = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			//Give the player hoofs, if the player already has hoofs STRIP FUR
			if (tainted && player.lowerBody != LOWER_BODY_TYPE_HOOFED && player.earType == EARS_COW) {
				if (changes < changeLimit && rand(3) == 0) {
					changes++;
					if (player.lowerBody == LOWER_BODY_TYPE_HUMAN) outputText("\n\nYou stagger as your feet change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					else if (player.lowerBody == LOWER_BODY_TYPE_DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					else if (player.lowerBody == LOWER_BODY_TYPE_NAGA) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
					//Catch-all
					else if (player.lowerBody > LOWER_BODY_TYPE_NAGA) outputText("\n\nYou stagger as your " + player.feet() + " change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					outputText("  A coat of beastial fur springs up below your waist, itching as it fills in.<b>  You now have hooves in place of your feet!</b>");
					player.lowerBody = LOWER_BODY_TYPE_HOOFED;
					player.legCount = 2;
					dynStats("cor", 0);
					changes++;
				}
			}
			//If the player's face is non-human, they gain a human face
			if (!enhanced && player.lowerBody == LOWER_BODY_TYPE_HOOFED && player.faceType != FACE_HUMAN && changes < changeLimit && rand(4) == 0) {
				//Remove face before fur!
				outputText("\n\nYour visage twists painfully, returning to a normal human shape.  <b>Your face is human again!</b>");
				player.faceType = FACE_HUMAN;
				changes++;
			}
			//enhanced get shitty fur
			if (enhanced && (player.skinDesc != "fur" || player.furColor != "black and white spotted")) {
				if (player.skinDesc != "fur") outputText("\n\nYour " + player.skinDesc + " itches intensely.  You scratch and scratch, but it doesn't bring any relief.  Fur erupts between your fingers, and you watch open-mouthed as it fills in over your whole body.  The fur is patterned in black and white, like that of a cow.  The color of it even spreads to your hair!  <b>You have cow fur!</b>");
				else outputText("\n\nA ripple spreads through your fur as some patches darken and others lighten.  After a few moments you're left with a black and white spotted pattern that goes the whole way up to the hair on your head!  <b>You've got cow fur!</b>");
				player.skinDesc = "fur";
				player.skinAdj = "";
				player.skinType = SKIN_TYPE_FUR;
				player.hairColor = "black and white spotted";
				player.furColor = player.hairColor;
				player.underBody.restore(); // Restore the underbody for now
			}
			//if enhanced to probova give a shitty cow face
			else if (enhanced && player.faceType != FACE_COW_MINOTAUR) {
				outputText("\n\nYour visage twists painfully, warping and crackling as your bones are molded into a new shape.  Once it finishes, you reach up to touch it, and you discover that <b>your face is like that of a cow!</b>");
				player.faceType = FACE_COW_MINOTAUR;
				changes++;
			}
			//Give the player bovine horns, or increase their size, same as the minotaur
			//New horns or expanding mino horns
			if (tainted && changes < changeLimit && rand(3) == 0 && player.faceType == FACE_HUMAN) {
				//Get bigger or change horns
				if (player.hornType == HORNS_COW_MINOTAUR || player.hornType == HORNS_NONE) {
					//Get bigger if player has horns
					if (player.hornType == HORNS_COW_MINOTAUR) {
						if (player.horns < 5) {
							//Fems horns don't get bigger.
							outputText("\n\nYour small horns get a bit bigger, stopping as medium sized nubs.");
							player.horns += 1 + rand(2);
							changes++;
						}
					}
					//If no horns yet..
					if (player.hornType == HORNS_NONE || player.horns == 0) {
						outputText("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.");
						player.hornType = HORNS_COW_MINOTAUR;
						player.horns = 1;
						changes++;
					}
					//TF other horns
					if (player.hornType != HORNS_NONE && player.hornType != HORNS_COW_MINOTAUR && player.horns > 0) {
						outputText("\n\nYour horns twist, filling your skull with agonizing pain for a moment as they transform into cow-horns.");
						player.hornType = HORNS_COW_MINOTAUR;
					}
				}
				//Not mino horns, change to cow-horns
				if (player.hornType == HORNS_DEMON || player.hornType > HORNS_COW_MINOTAUR) {
					outputText("\n\nYour horns vibrate and shift as if made of clay, reforming into two small bovine nubs.");
					player.hornType = HORNS_COW_MINOTAUR;
					player.horns = 2;
					changes++;
				}
			}
			//Increase the size of the player's hips, if they are not already childbearing or larger
			if (rand(2) == 0 && player.hipRating < 15 && changes < changeLimit) {
				if (!tainted && player.hipRating < 8 || tainted) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hipRating += 1 + rand(4);
					changes++;
				}
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			//Increase the size of the player's ass (less likely then hips), if it is not already somewhat big
			if (rand(2) == 0 && player.buttRating < 13 && changes < changeLimit) {
				if (!tainted && player.buttRating < 8 || tainted) {
					outputText("\n\nA sensation of being unbalanced makes it difficult to walk.  You pause, paying careful attention to your new center of gravity before understanding dawns on you - your ass has grown!");
					player.buttRating += 1 + rand(2);
					changes++;
				}
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + player.nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && player.vaginaType() == 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (rand(3) == 0) outputText(player.modFem(79, 3));
			if (rand(3) == 0) outputText(player.modThickness(70, 4));
			if (rand(5) == 0) outputText(player.modTone(10, 5));
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function lustDraft(fuck:Boolean,player:Player):void
		{
			player.slimeFeed();
			clearOutput();
			outputText("You drink the ");
			if (fuck) outputText("red");
			else outputText("pink");
			outputText(" potion, and its unnatural warmth immediately flows to your groin.");
			dynStats("lus", (30 + rand(player.lib / 10)), "resisted", false);

			//Heat/Rut for those that can have them if "fuck draft"
			if (fuck) {
				//Try to go into intense heat.
				player.goIntoHeat(true, 2);
				//Males go into rut
				player.goIntoRut(true);
			}
			//ORGAZMO
			if (player.lust >= player.maxLust() && !kGAMECLASS.inCombat) {
				outputText("\n\nThe arousal from the potion overwhelms your senses and causes you to spontaneously orgasm.  You rip off your " + player.armorName + " and look down as your ");
				if (player.cocks.length > 0) {
					outputText(player.multiCockDescriptLight() + " erupts in front of you, liberally spraying the ground around you.  ");
				}
				if (player.cocks.length > 0 && player.vaginas.length > 0) {
					outputText("At the same time your ");
				}
				if (player.vaginas.length > 0) {
					outputText(player.vaginaDescript(0) + " soaks your thighs.  ");
				}
				if (player.gender == 0) outputText("body begins to quiver with orgasmic bliss.  ");
				outputText("Once you've had a chance to calm down, you notice that the explosion of pleasure you just experienced has rocked you to your core.  You are a little hornier than you were before.");
				//increase player libido, and maybe sensitivity too?
				player.orgasm('Generic');
				dynStats("lib", 2, "sen", 1);
			}
			if (player.lust > player.maxLust()) player.lust = player.maxLust();
			outputText("\n\n");
			player.refillHunger(5);
		}

		public function sharkTooth(type:Number,player:Player):void
		{
			var tfSource:String = "sharkTooth";
			if (type == 1) tfSource += "-tigershark";
			changes = 0;
			changeLimit = 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			clearOutput();
			if (type == 0) outputText("You have no idea why, but you decide to eat the pointed tooth. To your surprise, it's actually quite brittle, turning into a fishy-tasting dust. You figure it must just be a tablet made to look like a shark's tooth.");
			else if (type == 1) outputText("You have no idea why, but you decide to eat the pointed, glowing tooth. To your surprise, it's actually quite brittle, crumbling into a fishy-tasting dust. Maybe it's just a tablet made to look like a shark's tooth.");
			//STATS
			//Increase strength 1-2 points (Up to 50) (60 for tiger)
			if (((player.str100 < 60 && type == 1) || player.str100 < 50) && rand(3) == 0) {
				dynStats("str", 1 + rand(2));
				outputText("\n\nA painful ripple passes through the muscles of your body.  It takes you a few moments, but you quickly realize you're a little bit stronger now.");
				changes++;
			}
			//Increase Speed 1-3 points (Up to 75) (100 for tigers)
			if (((player.spe100 < 100 && type == 1) || player.spe100 < 75) && rand(3) == 0) {
				dynStats("spe", 1 + rand(3));
				changes++;
				outputText("\n\nShivering without warning, you nearly trip over yourself as you walk.  A few tries later you realize your muscles have become faster.");
			}
			//Reduce sensitivity 1-3 Points (Down to 25 points)
			if (player.sens100 > 25 && rand(1.5) == 0 && changes < changeLimit) {
				dynStats("sen", (-1 - rand(3)));
				changes++;
				outputText("\n\nIt takes a while, but you eventually realize your body has become less sensitive.");
			}
			//Increase Libido 2-4 points (Up to 75 points) (100 for tigers)
			if (((player.lib100 < 100 && type == 1) || player.lib100 < 75) && rand(3) == 0 && changes < changeLimit) {
				dynStats("lib", (1 + rand(3)));
				changes++;
				outputText("\n\nA blush of red works its way across your skin as your sex drive kicks up a notch.");
			}
			//Decrease intellect 1-3 points (Down to 40 points)
			if (player.inte100 > 40 && rand(3) == 0 && changes < changeLimit) {
				dynStats("int", -(1 + rand(3)));
				changes++;
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
			}
			//Smexual stuff!
			//-TIGGERSHARK ONLY: Grow a cunt (guaranteed if no gender)
			if (type == 1 && (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) == 0))) {
				changes++;
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your " + player.ballsDescriptLight() + ", but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your " + player.sackDescript() + ", and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your " + player.multiCockDescriptLight() + ". You pull the manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your " + player.armorName + " to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.setClitLength(.25);
				dynStats("sen", 10);
			}
			//WANG GROWTH - TIGGERSHARK ONLY
			if (type == 1 && (!player.hasCock()) && changes < changeLimit && rand(3) == 0) {
				//Genderless:
				if (!player.hasVagina()) outputText("\n\nYou feel a sudden stabbing pain in your featureless crotch and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of a new human-shaped penis");
				//Female:
				else outputText("\n\nYou feel a sudden stabbing pain just above your " + player.vaginaDescript() + " and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of not only a " + player.vaginaDescript() + ", but a new human-shaped penis");
				if (player.balls == 0) {
					outputText(" and a pair of balls");
					player.balls = 2;
					player.ballSize = 2;
				}
				outputText("!");
				player.createCock(7, 1.4);
				dynStats("lib", 4, "sen", 5, "lus", 20);
				changes++;
			}
			//(Requires the player having two testicles)
			if (type == 1 && (player.balls == 0 || player.balls == 2) && player.hasCock() && changes < changeLimit && rand(3) == 0) {
				if (player.balls == 2) {
					outputText("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two more testes drop down into your " + player.sackDescript() + ", your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>");
					player.balls = 4;
				}
				else if (player.balls == 0) {
					outputText("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>");
					player.balls = 2;
					player.ballSize = 2;
				}
				dynStats("lib", 2, "sen", 3, "lus", 10);
				changes++;
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//Transformations:
			//Mouth TF
			if (player.faceType != FACE_SHARK_TEETH && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.faceType > FACE_HUMAN && player.faceType < FACE_SHARK_TEETH) outputText("Your " + player.face() + " explodes with agony, reshaping into a more human-like visage.  ");
				player.faceType = FACE_SHARK_TEETH;
				outputText("You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them!  They even scare you a little.\n(Gain: 'Bite' special attack)");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyeType != EYES_HUMAN) {
				if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType == EYES_FOUR_SPIDER_EYES || player.eyeType == EYES_SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//Tail TF
			if (player.tailType != TAIL_TYPE_SHARK && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your " + player.armorName + " down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.");
				else outputText("\n\nJets of pain shoot down your spine into your tail.  You feel the tail bulging out until it explodes into a large and flexible shark-tail.  You swish it about experimentally, and find it quite easy to control.");
				player.tailType = TAIL_TYPE_SHARK;
			}
			//Gills TF
			if (player.gillType != GILLS_FISH && player.tailType == TAIL_TYPE_SHARK && player.faceType == FACE_SHARK_TEETH && changes < changeLimit && rand(3) == 0)
				updateGills(GILLS_FISH);
			//Hair
			if (player.hairColor != "silver" && rand(4) == 0 && changes < changeLimit) {
				changes++;
				outputText("\n\nYou feel a tingling in your scalp and reach up to your head to investigate. To your surprise, your hair color has changed into a silvery color, just like that of a shark girl!");
				player.hairColor = "silver";
			}
			//Skin
			if (((player.skinTone != "rough gray" && player.skinTone != "orange and black striped") || !player.hasPlainSkin()) && rand(7) == 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.isFurryOrScaley()) outputText("Your " + player.skinDesc + " falls out, collecting on the floor and exposing your supple skin underneath.  ");
				else if (player.hasGooSkin()) outputText("Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. ");
				else if (type == 0) outputText("Your skin itches and tingles becoming slightly rougher and turning gray.  ");
				if (type == 0) {
					outputText("You abruptly stop moving and gasp sharply as a shudder goes up your entire frame. Your skin begins to shift and morph, growing slightly thicker and changing into a shiny grey color. Your skin now feels oddly rough too, comparable to that of a marine mammal. You smile and run your hands across your new shark skin.");
					player.skinType = SKIN_TYPE_PLAIN;
					player.skinDesc = "skin";
					player.skinTone = "rough gray";
					player.underBody.restore();
					updateClaws(player.clawType);
					kGAMECLASS.rathazul.addMixologyXP(20);
					changes++;
				}
				else {
					outputText("Your skin begins to tingle and itch, before rapidly shifting to a shiny orange color, marked by random black stripes. You take a quick look in a nearby pool of water, to see your skin has morphed in appearance and texture to become more like a tigershark!");
					player.skinType = SKIN_TYPE_PLAIN;
					player.skinDesc = "skin";
					player.skinTone = "orange and black striped";
					player.underBody.restore();
					updateClaws(player.clawType);
					kGAMECLASS.rathazul.addMixologyXP(20);
					changes++;
				}
			}
			//FINZ R WINGS
			if ((player.wingType != WING_TYPE_NONE || player.rearBody.type != REAR_BODY_SHARK_FIN) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				if (player.wingType != WING_TYPE_NONE) outputText("Your wings fold into themselves, merging together with your back.  ");
				outputText("You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your " + player.armorName + " just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your " + player.armorName + " to accommodate your new fin.");
				player.rearBody.type = REAR_BODY_SHARK_FIN;
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nNothing happened.  Weird.");
			}
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function neonPinkEgg(pregnantChange:Boolean,player:Player):void
		{
			var tfSource:String = "neonPinkEgg";
			changes = 0;
			changeLimit = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//If this is a pregnancy change, only 1 change per proc.
			if (pregnantChange) changeLimit = 1;
			else clearOutput();
			//If not pregnancy, mention eating it.
			if (!pregnantChange) outputText("You eat the neon pink egg, and to your delight it tastes sweet, like candy.  In seconds you've gobbled down the entire thing, and you lick your fingers clean before you realize you ate the shell – and it still tasted like candy.");
			//If pregnancy, warning!
			if (pregnantChange) {
				outputText("\n<b>Your egg-stuffed ");
				if (player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
					outputText("womb ");
					if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("and ");
				}
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("backdoor ");
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY && player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("rumble");
				else outputText("rumbles");
				outputText(" oddly, and you have a hunch that something's about to change</b>.");
			}
			//STATS CHANGURYUUUUU
			//Boost speed (max 80!)
			if (changes < changeLimit && rand(3) == 0 && player.spe100 < 80) {
				if (player.spe100 < 30) outputText("\n\nTingles run through your muscles, and your next few movements seem unexpectedly fast.  The egg somehow made you faster!");
				else if (player.spe100 < 50) outputText("\n\nYou feel tingles running through your body, and after a moment, it's clear that you're getting faster.");
				else if (player.spe100 < 65) outputText("\n\nThe tight, ready feeling you've grown accustomed to seems to intensify, and you know in the back of your mind that you've become even faster.");
				else outputText("\n\nSomething changes in your physique, and you grunt, chopping an arm through the air experimentally.  You seem to move even faster than before, confirming your suspicions.");
				changes++;
				if (player.spe100 < 35) dynStats("spe", 1);
				dynStats("spe", 1);
			}
			//Boost libido
			if (changes < changeLimit && rand(5) == 0) {
				changes++;
				dynStats("lib", 1, "lus", (5 + player.lib / 7));
				if (player.lib100 < 30) dynStats("lib", 1);
				if (player.lib100 < 40) dynStats("lib", 1);
				if (player.lib100 < 60) dynStats("lib", 1);
				//Lower ones are gender specific for some reason
				if (player.lib100 < 60) {
					//(Cunts or assholes!
					if (!player.hasCock() || (player.gender == 3 && rand(2) == 0)) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 60) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 90) outputText("You pant a little and wonder where the nearest fertile male is.");
							else outputText("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your " + player.assholeOrPussy() + ", and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (player.hasCock()) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) == 0) outputText("female hare until she's immobilized by all her eggs");
							else outputText("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							outputText(". ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 50) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 75) outputText("You pant a little and wonder where the nearest fertile female is.");
							else outputText("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to " + player.sMultiCockDesc() + ", and you groan from how tight and hard it feels.  The desire to squeeze it, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (player.lib100 < 80) {
					outputText("\n\nYou fan your neck and start to pant as your " + player.skinTone + " skin begins to flush red with heat");
					if (!player.hasPlainSkin()) outputText(" through your " + player.skinDesc);
					outputText(".  ");
					if (player.gender == 1) outputText("Compression tightens down on " + player.sMultiCockDesc() + " as it strains against your " + player.armorName + ".  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (player.gender == 0) outputText("Sexual hunger seems to gnaw at your " + player.assholeDescript() + ", demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (player.gender == 2) outputText("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else outputText("Steamy moisture and tight compression war for your awareness in your groin as " + player.sMultiCockDesc() + " starts to strain against your " + player.armorName + ".  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					outputText("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (player.cor < 33) outputText("You sigh, trying not to give in completely.");
					else if (player.cor < 66) outputText("You pant and groan, not sure how long you'll even want to resist.");
					else {
						outputText("You smile and wonder if you can ");
						if (player.lib100 < 100) outputText("get your libido even higher.");
						else outputText("find someone to fuck right now.");
					}
				}
			}
			//BIG sensitivity gains to 60.
			if (player.sens100 < 60 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText("\n\n");
				//(low)
				if (rand(3) != 2) {
					outputText("The feeling of small breezes blowing over your " + player.skinDesc + " gets a little bit stronger.  How strange.  You pinch yourself and nearly jump when it hurts a tad more than you'd think. You've gotten more sensitive!");
					dynStats("sen", 5);
				}
				//(BIG boost 1/3 chance)
				else {
					dynStats("sen", 15);
					outputText("Every movement of your body seems to bring heightened waves of sensation that make you woozy.  Your " + player.armorName + " rubs your " + player.nippleDescript(0) + "s deliciously");
					if (player.hasFuckableNipples()) {
						outputText(", sticking to the ");
						if (player.biggestLactation() > 2) outputText("milk-leaking nipple-twats");
						else outputText("slippery nipple-twats");
					}
					else if (player.biggestLactation() > 2) outputText(", sliding over the milk-leaking teats with ease");
					else outputText(" catching on each of the hard nubs repeatedly");
					outputText(".  Meanwhile, your crotch... your crotch is filled with such heavenly sensations from ");
					if (player.gender == 1) {
						outputText(player.sMultiCockDesc() + " and your ");
						if (player.balls > 0) outputText(player.ballsDescriptLight());
						else outputText(player.assholeDescript());
					}
					else if (player.gender == 2) outputText("your " + player.vaginaDescript(0) + " and " + player.clitDescript());
					else if (player.gender == 3) {
						outputText(player.sMultiCockDesc() + ", ");
						if (player.balls > 0) outputText(player.ballsDescriptLight() + ", ");
						outputText(player.vaginaDescript(0) + ", and " + player.clitDescript());
					}
					//oh god genderless
					else outputText("you " + player.assholeDescript());
					outputText(" that you have to stay stock-still to keep yourself from falling down and masturbating on the spot.  Thankfully the orgy of tactile bliss fades after a minute, but you still feel way more sensitive than your previous norm.  This will take some getting used to!");
				}
			}
			//Makes girls very girl(90), guys somewhat girly (61).
			if (changes < changeLimit && rand(2) == 0) {
				var buffer:String = "";
				if (player.gender < 2) buffer += player.modFem(61, 4);
				else buffer += player.modFem(90, 4);
				if (buffer != "") {
					outputText(buffer);
					changes++;
				}
			}

			//De-wettification of cunt (down to 3?)!
			if (player.wetness() > 3 && changes < changeLimit && rand(3) == 0) {
				//Just to be safe
				if (player.hasVagina()) {
					outputText("\n\nThe constant flow of fluids that sluice from your " + player.vaginaDescript(0) + " slow down, leaving you feeling a bit less like a sexual slip-'n-slide.");
					player.vaginas[0].vaginalWetness--;
					changes++;
				}
			}
			//Fertility boost!
			if (changes < changeLimit && rand(4) == 0 && player.fertility < 50 && player.hasVagina()) {
				player.fertility += 2 + rand(5);
				changes++;
				outputText("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you know your body is just aching to be pregnant and give birth.");
			}
			//-VAGs
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(4) == 0) updateOvipositionPerk(tfSource);
			if (player.hasVagina() && player.findPerk(PerkLib.BunnyEggs) < 0 && changes < changeLimit && rand(4) == 0 && player.bunnyScore() > 3) {
				outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n\n");
				outputText("(<b>Perk Gained: Bunny Eggs</b>)");
				player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
				changes++;
			}
			//Shrink Balls!
			if (player.balls > 0 && player.ballSize > 5 && rand(3) == 0 && changes < changeLimit) {
				if (player.ballSize < 10) {
					outputText("\n\nRelief washes through your groin as your " + player.ballsDescript() + " lose about an inch of their diameter.");
					player.ballSize--;
				}
				else if (player.ballSize < 25) {
					outputText("\n\nRelief washes through your groin as your " + player.ballsDescript() + " lose a few inches of their diameter.  Wow, it feels so much easier to move!");
					player.ballSize -= (2 + rand(3));
				}
				else {
					outputText("\n\nRelief washes through your groin as your " + player.ballsDescript() + " lose at least six inches of diameter.  Wow, it feels SOOOO much easier to move!");
					player.ballSize -= (6 + rand(3));
				}
				changes++;
			}
			//Get rid of extra balls
			if (player.balls > 2 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText("\n\nThere's a tightening in your " + player.sackDescript() + " that only gets higher and higher until you're doubled over and wheezing.  When it passes, you reach down and discover that <b>two of your testicles are gone.</b>");
				player.balls -= 2;
			}
			//Boost cum production
			if ((player.balls > 0 || player.hasCock()) && player.cumQ() < 3000 && rand(3) == 0 && changeLimit > 1) {
				changes++;
				player.cumMultiplier += 3 + rand(7);
				if (player.cumQ() >= 250) dynStats("lus", 3);
				if (player.cumQ() >= 750) dynStats("lus", 4);
				if (player.cumQ() >= 2000) dynStats("lus", 5);
				//Balls
				if (player.balls > 0) {
					//(Small cum quantity) < 50
					if (player.cumQ() < 50) outputText("\n\nA twinge of discomfort runs through your " + player.ballsDescriptLight() + ", but quickly vanishes.  You heft your orbs but they haven't changed in size – they just feel a little bit denser.");
					//(medium cum quantity) < 250
					else if (player.cumQ() < 250) {
						outputText("\n\nA ripple of discomfort runs through your " + player.ballsDescriptLight() + ", but it fades into a pleasant tingling.  You reach down to heft the orbs experimentally but they don't seem any larger.");
						if (player.hasCock()) outputText("  In the process, you brush " + player.sMultiCockDesc() + " and discover a bead of pre leaking at the tip.");
					}
					//(large cum quantity) < 750
					else if (player.cumQ() < 750) {
						outputText("\n\nA strong contraction passes through your " + player.sackDescript() + ", almost painful in its intensity.  ");
						if (player.hasCock()) outputText(player.sMultiCockDesc() + " leaks and dribbles pre-cum down your " + player.legs() + " as your body's cum production kicks up even higher.");
						else outputText("You wince, feeling pent up and yet unable to release.  You really wish you had a cock right about now.");
					}
					//(XL cum quantity) < 2000
					else if (player.cumQ() < 2000) {
						outputText("\n\nAn orgasmic contraction wracks your " + player.ballsDescriptLight() + ", shivering through the potent orbs and passing as quickly as it came.  ");
						if (player.hasCock()) outputText("A thick trail of slime leaks from " + player.sMultiCockDesc() + " down your " + player.leg() + ", pooling below you.");
						else outputText("You grunt, feeling terribly pent-up and needing to release.  Maybe you should get a penis to go with these balls...");
						outputText("  It's quite obvious that your cum production has gone up again.");
					}
					//(XXL cum quantity)
					else {
						outputText("\n\nA body-wrenching contraction thrums through your " + player.ballsDescriptLight() + ", bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  ");
						if (player.hasCock()) outputText("pre-cum explodes from " + player.sMultiCockDesc() + ", running down your " + player.leg() + " and splattering into puddles that would shame the orgasms of lesser " + player.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
						else outputText("You pant and groan but the pleasure just turns to pain.  You're so backed up – if only you had some way to vent all your seed!");
					}
				}
				//NO BALLZ (guaranteed cock tho)
				else {
					//(Small cum quantity) < 50
					if (player.cumQ() < 50) outputText("\n\nA twinge of discomfort runs through your body, but passes before you have any chance to figure out exactly what it did.");
					//(Medium cum quantity) < 250)
					else if (player.cumQ() < 250) outputText("\n\nA ripple of discomfort runs through your body, but it fades into a pleasant tingling that rushes down to " + player.sMultiCockDesc() + ".  You reach down to heft yourself experimentally and smile when you see pre-beading from your maleness.  Your cum production has increased!");
					//(large cum quantity) < 750
					else if (player.cumQ() < 750) outputText("\n\nA strong contraction passes through your body, almost painful in its intensity.  " + player.SMultiCockDesc() + " leaks and dribbles pre-cum down your " + player.legs() + " as your body's cum production kicks up even higher!  Wow, it feels kind of... good.");
					//(XL cum quantity) < 2000
					else if (player.cumQ() < 2000) outputText("\n\nAn orgasmic contraction wracks your abdomen, shivering through your midsection and down towards your groin.  A thick trail of slime leaks from " + player.sMultiCockDesc() + "  and trails down your " + player.leg() + ", pooling below you.  It's quite obvious that your body is producing even more cum now.");
					//(XXL cum quantity)
					else outputText("\n\nA body-wrenching contraction thrums through your gut, bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  pre-cum explodes from " + player.sMultiCockDesc() + ", running down your " + player.legs() + " and splattering into puddles that would shame the orgasms of lesser " + player.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
				}
			}
			//Bunny feet! - requirez earz
			if (player.lowerBody != LOWER_BODY_TYPE_BUNNY && changes < changeLimit && rand(5) == 0 && player.earType == EARS_BUNNY) {
				//Taurs
				if (player.isTaur()) outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of fur-covered rabbit feet</b>!");
				//Non-taurs
				else {
					outputText("\n\nNumbness envelops your " + player.legs() + " as they pull tighter and tighter.  You overbalance and drop on your " + player.assDescript());
					if (player.tailType > TAIL_TYPE_NONE) outputText(", nearly smashing your tail flat");
					else outputText(" hard enough to sting");
					outputText(" while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs</b>!");
				}
				changes++;
				player.lowerBody = LOWER_BODY_TYPE_BUNNY;
				player.legCount = 2;
			}
			//BUN FACE!  REQUIREZ EARZ
			if (player.earType == EARS_BUNNY && player.faceType != FACE_BUNNY && rand(3) == 0 && changes < changeLimit) {
				outputText("\n\n");
				changes++;
				//Human(ish) face
				if (player.faceType == FACE_HUMAN || player.faceType == FACE_SHARK_TEETH) outputText("You catch your nose twitching on its own at the bottom of your vision, but as soon as you focus on it, it stops.  A moment later, some of your teeth tingle and brush past your lips, exposing a white pair of buckteeth!  <b>Your face has taken on some rabbit-like characteristics!</b>");
				//Crazy furry TF shit
				else outputText("You grunt as your " + player.face() + " twists and reforms.  Even your teeth ache as their positions are rearranged to match some new, undetermined order.  When the process finishes, <b>you're left with a perfectly human looking face, save for your constantly twitching nose and prominent buck-teeth.</b>");
				player.faceType = FACE_BUNNY;
			}
			//DAH BUNBUN EARZ - requires poofbutt!
			if (player.earType != EARS_BUNNY && changes < changeLimit && rand(3) == 0 && player.tailType == TAIL_TYPE_RABBIT) {
				outputText("\n\nYour ears twitch and curl in on themselves, sliding around on the flesh of your head.  They grow warmer and warmer before they finally settle on the top of your head and unfurl into long, fluffy bunny-ears.  <b>You now have a pair of bunny ears.</b>");
				player.earType = EARS_BUNNY;
				changes++;
			}
			//DAH BUNBUNTAILZ
			if (player.tailType != TAIL_TYPE_RABBIT && rand(2) == 0 && changes < changeLimit) {
				if (player.tailType > TAIL_TYPE_NONE) outputText("\n\nYour tail burns as it shrinks, pulling tighter and tighter to your backside until it's the barest hint of a stub.  At once, white, poofy fur explodes out from it.  <b>You've got a white bunny-tail!  It even twitches when you aren't thinking about it.</b>");
				else outputText("\n\nA burning pressure builds at your spine before dissipating in a rush of relief. You reach back and discover a small, fleshy tail that's rapidly growing long, poofy fur.  <b>You have a rabbit tail!</b>");
				player.tailType = TAIL_TYPE_RABBIT;
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//Bunny Breeder Perk?
			//FAILSAAAAFE
			if (changes == 0) {
				if (player.lib100 < 100) changes++;
				dynStats("lib", 1, "lus", (5 + player.lib / 7));
				if (player.lib100 < 30) dynStats("lib", 1);
				if (player.lib100 < 40) dynStats("lib", 1);
				if (player.lib100 < 60) dynStats("lib", 1);
				//Lower ones are gender specific for some reason
				if (player.lib100 < 60) {
					//(Cunts or assholes!
					if (!player.hasCock() || (player.gender == 3 && rand(2) == 0)) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 60) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 90) outputText("You pant a little and wonder where the nearest fertile male is.");
							else outputText("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your " + player.assholeOrPussy() + ", and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (player.hasCock()) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) == 0) outputText("female hare until she's immobilized by all her eggs");
							else outputText("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							outputText(". ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 50) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 75) outputText("You pant a little and wonder where the nearest fertile female is.");
							else outputText("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to " + player.sMultiCockDesc() + ", and you groan from how tight and hard it feels.  The desire to have it squeezed, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (player.lib100 < 80) {
					outputText("\n\nYou fan your neck and start to pant as your " + player.skinTone + " skin begins to flush red with heat");
					if (!player.hasPlainSkin()) outputText(" through your " + player.skinDesc);
					outputText(".  ");
					if (player.gender == 1) outputText("Compression tightens down on " + player.sMultiCockDesc() + " as it strains against your " + player.armorName + ".  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (player.gender == 0) outputText("Sexual hunger seems to gnaw at your " + player.assholeDescript() + ", demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (player.gender == 2) outputText("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else outputText("Steamy moisture and tight compression war for your awareness in your groin as " + player.sMultiCockDesc() + " starts to strain against your " + player.armorName + ".  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					outputText("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (player.cor < 33) outputText("You sigh, trying not to give in completely.");
					else if (player.cor < 66) outputText("You pant and groan, not sure how long you'll even want to resist.");
					else {
						outputText("You smile and wonder if you can ");
						if (player.lib100 < 100) outputText("get your libido even higher.");
						else outputText("find someone to fuck right now.");
					}
				}
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function goldenSeed(type:Number,player:Player):void
		{
			var tfSource:String = "goldenSeed";
			if (player.findPerk(PerkLib.HarpyWomb) >= 0) tfSource += "-HarpyWomb";
			//'type' refers to the variety of seed.
			//0 == standard.
			//1 == enhanced - increase change limit and no pre-reqs for TF
			changes = 0;
			changeLimit = 1;
			if (type == 1) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Generic eating text:
			clearOutput();
			outputText("You pop the nut into your mouth, chewing the delicious treat and swallowing it quickly.  No wonder harpies love these things so much!");
			//****************
			//Stats:
			//****************
			//-Speed increase to 100.
			if (player.spe100 < 100 && rand(3) == 0) {
				changes++;
				if (player.spe100 >= 75) outputText("\n\nA familiar chill runs down your spine. Your muscles feel like well oiled machinery, ready to snap into action with lightning speed.");
				else outputText("\n\nA chill runs through your spine, leaving you feeling like your reflexes are quicker and your body faster.");
				//Speed gains diminish as it rises.
				if (player.spe100 < 40) dynStats("spe", .5);
				if (player.spe100 < 75) dynStats("spe", .5);
				dynStats("spe", .5);
			}
			//-Toughness decrease to 50
			if (player.tou100 > 50 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (rand(2) == 0) outputText("\n\nA nice, slow warmth rolls from your gut out to your limbs, flowing through them before dissipating entirely. As it leaves, you note that your body feels softer and less resilient.");
				else outputText("\n\nYou feel somewhat lighter, but consequently more fragile.  Perhaps your bones have changed to be more harpy-like in structure?");
				dynStats("tou", -1);
			}
			//antianemone corollary:
			if (changes < changeLimit && player.hairType == 4 && rand(2) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nAs you down the seed, your head begins to feel heavier.  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels soft and fluffy, almost feathery; you watch as it dissolves into many thin, feathery strands.  <b>Your hair is now like that of a harpy!</b>");
				player.hairType = HAIR_FEATHER;
				changes++;
			}
			//-Strength increase to 70
			if (player.str100 < 70 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//(low str)
				if (player.str100 < 40) outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
				//(hi str – 50+)
				else outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				//Faster until 40 str.
				if (player.str100 < 40) dynStats("str", .5);
				dynStats("str", .5);
			}
			//-Libido increase to 90
			if ((player.lib100 < 90 || rand(3) == 0) && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (player.lib100 < 90) dynStats("lib", 1);
				//(sub 40 lib)
				if (player.lib100 < 40) {
					outputText("\n\nA passing flush colors your " + player.face() + " for a second as you daydream about sex. You blink it away, realizing the item seems to have affected your libido.");
					if (player.hasVagina()) outputText(" The moistness of your " + player.vaginaDescript() + " seems to agree.");
					else if (player.hasCock()) outputText(" The hardness of " + player.sMultiCockDesc() + " seems to agree.");
					dynStats("lus", 5);
				}
				//(sub 75 lib)
				else if (player.lib100 < 75) outputText("\n\nHeat, blessed heat, works through you from head to groin, leaving you to shudder and fantasize about the sex you could be having right now.\n\n");
				//(hi lib)
				else if (player.lib100 < 90) outputText("\n\nSexual need courses through you, flushing your skin with a reddish hue while you pant and daydream of the wondrous sex you should be having right now.\n\n");
				//(90+)
				else outputText("\n\nYou groan, something about the seed rubbing your libido in just the right way to make you horny. Panting heavily, you sigh and fantasize about the sex you could be having.\n\n");
				//(fork to fantasy)
				if (player.lib100 >= 40) {
					dynStats("lus", (player.lib / 5 + 10));
					//(herm – either or!)
					//Cocks!
					if (player.hasCock() && (player.gender != 3 || rand(2) == 0)) {
						//(male 1)
						if (rand(2) == 0) {
							outputText("In your fantasy you're winging through the sky, " + player.sMultiCockDesc() + " already hard and drizzling with male moisture while you circle an attractive harpy's nest. Her plumage is as blue as the sky, her eyes the shining teal of the sea, and legs splayed in a way that shows you how ready she is to be bred. You fold your wings and dive, wind whipping through your " + player.hairDescript() + " as she grows larger and larger. With a hard, body-slapping impact you land on top of her, plunging your hard, ready maleness into her hungry box. ");
							if (player.cockTotal() > 1) {
								outputText("The extra penis");
								if (player.cockTotal() > 2) outputText("es rub ");
								else outputText("rubs ");
								outputText("the skin over her taut, empty belly, drooling your need atop her.  ");
								outputText("You jolt from the vision unexpectedly, finding your " + player.sMultiCockDesc() + " is as hard as it was in the dream. The inside of your " + player.armorName + " is quite messy from all the pre-cum you've drooled. Perhaps you can find a harpy nearby to lie with.");
							}
						}
						//(male 2)
						else {
							outputText("In your fantasy you're lying back in the nest your harem built for you, stroking your dick and watching the sexy bird-girl spread her thighs to deposit another egg onto the pile. The lewd moans do nothing to sate your need, and you beckon for another submissive harpy to approach. She does, her thick thighs swaying to show her understanding of your needs. The bird-woman crawls into your lap, sinking down atop your shaft to snuggle it with her molten heat. She begins kissing you, smearing your mouth with her drugged lipstick until you release the first of many loads. You sigh, riding the bliss, secure in the knowledge that this 'wife' won't let up until she's gravid with another egg. Then it'll be her sister-wife's turn. The tightness of " + player.sMultiCockDesc() + " inside your " + player.armorName + " rouses you from the dream, reminding you that you're just standing there, leaking your need into your gear.");
						}
					}
					//Cunts!
					else if (player.hasVagina()) {
						//(female 1)
						if (rand(2) == 0) {
							outputText("In your fantasy you're a happy harpy mother, your womb stretched by the sizable egg it contains. The surging hormones in your body arouse you again, and you turn to the father of your children, planting a wet kiss on his slobbering, lipstick-gilt cock. The poor adventurer writhes, hips pumping futilely in the air. He's been much more agreeable since you started keeping his cock coated with your kisses. You mount the needy boy, fantasizing about that first time when you found him near the portal, in the ruins of your old camp. The feeling of your stiff nipples ");
							if (player.hasFuckableNipples()) outputText("and pussy leaking over ");
							else if (player.biggestLactation() >= 1.5) outputText("dripping milk inside ");
							else outputText("rubbing inside ");
							outputText("your " + player.armorName + " shocks you from the dream, leaving you with nothing but the moistness of your loins for company. Maybe next year you'll find the mate of your dreams?");
						}
						//(female 2)
						else {
							outputText("In your fantasy you're sprawled on your back, thick thighs splayed wide while you're taken by a virile male. The poor stud was wandering the desert all alone, following some map, but soon you had his bright red rod sliding between your butt-cheeks, the pointed tip releasing runnels of submission to lubricate your loins. You let him mount your pussy before you grabbed him with your powerful thighs and took off. He panicked at first, but the extra blood flow just made him bigger. He soon forgot his fear and focused on the primal needs of all males – mating with a gorgeous harpy. You look back at him and wink, feeling his knot build inside you. Your aching, tender " + player.nippleDescript(0) + "s pull you out of the fantasy as they rub inside your " + player.armorName + ". Maybe once your quest is over you'll be able to find a shy, fertile male to mold into the perfect cum-pump.");
						}
					}
				}
			}
			//****************
			//   Sexual:
			//****************
			//-Grow a cunt (guaranteed if no gender)
			if (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) == 0)) {
				changes++;
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your " + player.ballsDescriptLight() + ", but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your " + player.sackDescript() + ", and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your " + player.multiCockDescriptLight() + ". You pull your manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your " + player.armorName + " to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.setClitLength(.25);
				dynStats("sen", 10);
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + player.breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.breastRows.length >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + player.nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//-Shrink tits if above DDs.
			//Cannot happen at same time as row removal
			else if (changes < changeLimit && player.breastRows.length == 1 && rand(3) == 0 && player.breastRows[0].breastRating >= 7 && !flags[kFLAGS.HYPER_HAPPY])
			{
				changes++;
				//(Use standard breast shrinking mechanism if breasts are under 'h')
				if (player.breastRows[0].breastRating < 19)
				{
					player.shrinkTits();
				}
				//(H+)
				else {
					player.breastRows[0].breastRating -= (4 + rand(4));
					outputText("\n\nYour chest pinches tight, wobbling dangerously for a second before the huge swell of your bust begins to shrink into itself. The weighty mounds jiggle slightly as they shed cup sizes like old, discarded coats, not stopping until they're " + player.breastCup(0) + "s.");
				}
			}
			//-Grow tits to a B-cup if below.
			if (changes < changeLimit && player.breastRows[0].breastRating < 2 && rand(3) == 0) {
				changes++;
				outputText("\n\nYour chest starts to tingle, the " + player.skinDesc + " warming under your " + player.armorName + ". Reaching inside to feel the tender flesh, you're quite surprised when it puffs into your fingers, growing larger and larger until it settles into a pair of B-cup breasts.");
				if (player.breastRows[0].breastRating < 1) outputText("  <b>You have breasts now!</b>");
				player.breastRows[0].breastRating = 2;
			}
			//Change cock if you have a penis.
			if (changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.AVIAN) < player.cockTotal() && rand(type == 1 ? 4 : 10) == 0 ) { //2.5x chance if magic seed.
				changes++;
				outputText("\n\nYou feel a strange tingling sensation in your cock as erection forms. You " + player.clothedOrNakedLower("open up your " + player.armorName + " and", "") + " look down to see " + (player.cockTotal() == 1 ? "your cock" : "one of your cocks") + " shifting! By the time the transformation's complete, you notice it's tapered, red, and ends in a tip. When you're not aroused, your cock rests nicely in a newly-formed sheath. <b>You now have an avian penis!</b>");
				for (var i:int = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType != CockTypesEnum.AVIAN) {
						player.cocks[i].cockType = CockTypesEnum.AVIAN;
						break;
					}
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//****************
			//General Appearance:
			//****************
			//-Femininity to 85
			if (player.femininity < 85 && changes < changeLimit && rand(3) == 0) {
				changes++;
				outputText(player.modFem(85, 3 + rand(5)));
			}
			//-Skin color change – tan, olive, dark, light
			if ((player.skinTone != "tan" && player.skinTone != "olive" && player.skinTone != "dark" && player.skinTone != "light") && changes < changeLimit && rand(5) == 0) {
				changes++;
				outputText("\n\nIt takes a while for you to notice, but <b>");
				if (player.hasFur()) outputText("the skin under your " + player.hairColor + " " + player.skinDesc);
				else outputText("your " + player.skinDesc);
				outputText(" has changed to become ");
				temp = rand(4);
				if (temp == 0) player.skinTone = "tan";
				else if (temp == 1) player.skinTone = "olive";
				else if (temp == 2) player.skinTone = "dark";
				else if (temp == 3) player.skinTone = "light";
				outputText(player.skinTone + " colored.</b>");
				updateClaws(player.clawType);
			}
			//-Grow hips out if narrow.
			if (player.hipRating < 10 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening " + player.hipDescript() + ". The change is subtle, but they're definitely broader.");
				player.hipRating++;
				changes++;
			}
			//-Narrow hips if crazy wide
			if (player.hipRating >= 15 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour gait shifts inward, your " + player.hipDescript() + " narrowing significantly. They remain quite thick, but they're not as absurdly wide as before.");
				player.hipRating--;
				changes++;
			}
			//-Big booty
			if (player.buttRating < 8 && changes < changeLimit && rand(3) == 0) {
				player.buttRating++;
				changes++;
				outputText("\n\nA slight jiggle works through your rear, but instead of stopping it starts again. You can actually feel your " + player.armorName + " being filled out by the growing cheeks. When it stops, you find yourself the proud owner of a " + player.buttDescript() + ".");
			}
			//-Narrow booty if crazy huge.
			if (player.buttRating >= 14 && changes < changeLimit && rand(4) == 0) {
				changes++;
				player.buttRating--;
				outputText("\n\nA feeling of tightness starts in your " + player.buttDescript() + ", increasing gradually. The sensation grows and grows, but as it does your center of balance shifts. You reach back to feel yourself, and sure enough your massive booty is shrinking into a more manageable size.");
			}
			//-Body thickness to 25ish
			if (player.thickness > 25 && changes < changeLimit && rand(3) == 0) {
				outputText(player.modThickness(25, 3 + rand(4)));
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyeType > EYES_HUMAN) {
				if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType == EYES_FOUR_SPIDER_EYES || player.eyeType == EYES_SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//****************
			//Harpy Appearance:
			//****************
			//-Harpy legs
			if (player.lowerBody != LOWER_BODY_TYPE_HARPY && changes < changeLimit && (type == 1 || player.tailType == TAIL_TYPE_HARPY) && rand(4) == 0) {
				//(biped/taur)
				if (!player.isGoo()) outputText("\n\nYour " + player.legs() + " creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your " + player.feet() + " have changed.  ");
				//goo
				else outputText("\n\nYour gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet!  ");
				player.lowerBody = LOWER_BODY_TYPE_HARPY;
				player.legCount = 2;
				changes++;
				//(cont)
				outputText("While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in " + player.hairColor + " feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>");
			}
			//-Feathery Tail
			if (player.tailType != TAIL_TYPE_HARPY && changes < changeLimit && (type == 1 || player.wingType == WING_TYPE_FEATHERED_LARGE) && rand(4) == 0) {
				//(tail)
				if (player.tailType > TAIL_TYPE_NONE) outputText("\n\nYour tail shortens, folding into the crack of your " + player.buttDescript() + " before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>");
				//(no tail)
				else outputText("\n\nA tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your " + player.skinDesc + " in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>");
				player.tailType = TAIL_TYPE_HARPY;
				changes++;
			}
			//-Propah Wings
			if (player.wingType == WING_TYPE_NONE && changes < changeLimit && (type == 1 || player.armType == ARM_TYPE_HARPY) && rand(4) == 0) {
				outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your " + player.skinDesc + ". It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your " + player.armorName + ". Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and");
				player.wings.setProps({
					type: WING_TYPE_FEATHERED_LARGE,
					color: player.hasFur() ? player.furColor : player.hairColor
				});
				outputText(" <b>you're able to curve the new growths far enough around to behold your brand new, " + player.wings.color + " wings.</b>");
				changes++;
			}
			//-Remove old wings
			if (([WING_TYPE_NONE, WING_TYPE_FEATHERED_LARGE].indexOf(player.wingType) == -1 || player.rearBody.type == REAR_BODY_SHARK_FIN) && changes < changeLimit && rand(4) == 0) {
				if (player.rearBody.type == REAR_BODY_SHARK_FIN) {
					outputText("\n\nSensation fades from your large fin slowly but surely, leaving it a dried out husk that breaks off to fall on the"
					          +" ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
					player.rearBody.restore();
				} else {
					outputText("\n\nSensation fades from your [wings] slowly but surely, leaving them dried out husks that break off to fall on the"
					          +" ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
				}
				player.wings.restore();
				changes++;
			}
			//-Feathery Arms
			if (player.armType != ARM_TYPE_HARPY && changes < changeLimit && (type == 1 || player.hairType == 1) && rand(4) == 0) {
				outputText("\n\nYou smile impishly as you lick the last bits of the nut from your teeth, but when you go to wipe your mouth, instead of the usual texture of your " + player.skinDesc + " on your lips, you feel feathers! You look on in horror while more of the avian plumage sprouts from your " + player.skinDesc + ", covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
				changes++;
				player.armType = ARM_TYPE_HARPY;
				updateClaws();
			}
			//-Feathery Hair
			if (player.hairType != HAIR_FEATHER && changes < changeLimit && (type == 1 || player.faceType == FACE_HUMAN) && rand(4) == 0) {
				outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a harpy!");
				player.hairType = HAIR_FEATHER;
				changes++;
			}
			//-Human face
			if (player.faceType != FACE_HUMAN && changes < changeLimit && (type == 1 || (player.earType == EARS_HUMAN || player.earType == EARS_ELFIN)) && rand(4) == 0) {
				outputText("\n\nSudden agony sweeps over your " + player.face() + ", your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face.");
				player.faceType = FACE_HUMAN;
				changes++;
			}
			//-Gain human ears (keep elf ears)
			if ((player.earType != EARS_HUMAN && player.earType != EARS_ELFIN) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
				player.earType = EARS_HUMAN;
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			//SPECIAL:
			//Harpy Womb – All eggs are automatically upgraded to large, requires legs + tail to be harpy.
			if (player.findPerk(PerkLib.HarpyWomb) < 0 && player.lowerBody == LOWER_BODY_TYPE_HARPY && player.tailType == TAIL_TYPE_HARPY && rand(4) == 0 && changes < changeLimit) {
				player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
				outputText("\n\nThere's a rumbling in your womb, signifying that some strange change has taken place in your most feminine area. No doubt something in it has changed to be more like a harpy. (<b>You've gained the Harpy Womb perk! All the eggs you lay will always be large so long as you have harpy legs and a harpy tail.</b>)");
				changes++;
			}
			if (changes < changeLimit && rand(4) == 0 && ((player.ass.analWetness > 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) || player.ass.analWetness > 1)) {
				outputText("\n\nYou feel a tightening up in your colon and your [asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				player.ass.analWetness--;
				if (player.ass.analLooseness > 1) player.ass.analLooseness--;
				changes++;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + player.nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && player.vaginaType() == 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes == 0) outputText("\n\nAside from being a tasty treat, it doesn't seem to do anything to you this time.");
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		/*
		 General Effects:
		 -Speed to 70
		 -Int to 10

		 Appearance Effects:
		 -Hip widening funtimes
		 -Remove feathery hair

		 Sexual:
		 -Shrink balls down to reasonable size (3?)
		 -Shorten clits to reasonable size
		 -Shrink dicks down to 8\" max.
		 -Rut/heat

		 Big Roo Tfs:
		 -Roo ears
		 -Roo tail
		 -Roo footsies
		 -Fur
		 -Roo face*/
		public function kangaFruit(type:Number,player:Player):void
		{
			var tfSource:String = "kangaFruit";
			clearOutput();
			outputText("You squeeze the pod around the middle, forcing the end open.  Scooping out a handful of the yeasty-smelling seeds, you shovel them in your mouth.  Blech!  Tastes like soggy burnt bread... and yet, you find yourself going for another handful...");
			//Used to track changes and the max
			changes = 0;
			changeLimit = 1;
			if (type == 1) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Used as a holding variable for biggest dicks and the like
			var biggestCock:Number;
			//****************
			//General Effects:
			//****************
			//-Int less than 10
			if (player.inte < 10 && player.findPerk(PerkLib.TransformationResistance) < 0) {
				if (player.inte < 8 && player.kangaScore() >= 5) {
					outputText("\n\nWhile you gnaw on the fibrous fruit, your already vacant mind continues to empty, leaving nothing behind but the motion of your jaw as you slowly chew and swallow your favorite food.  Swallow.  Chew.  Swallow.  You don't even notice your posture worsening or your arms shortening.  Without a single thought, you start to hunch over but keep munching on the food in your paws as if were the most normal thing in the world.  Teeth sink into one of your fingers, leaving you to yelp in pain.  With the last of your senses, you look at your throbbing paw to notice you've run out of kanga fruit!");
					outputText("\n\nStill hungry and licking your lips in anticipation, you sniff in deep lungfuls of air.  There's more of that wonderful fruit nearby!  You bound off in search of it on your incredibly muscular legs, their shape becoming more and more feral with every hop.  Now guided completely by instinct, you find a few stalks that grow from the ground.  Your belly rumbles, reminding you of your hunger, as you begin to dig into the kanga fruits...");
					outputText("\n\nLosing more of what little remains of yourself, your body is now entirely that of a feral kangaroo and your mind has devolved to match it.  After you finish the handful of fruits you found, you move on in search for more of the tasty treats.  Though you pass by your camp later on, there's no memory, no recognition, just a slight feeling of comfort and familiarity.  There's no food here so you hop away.");
					//[GAME OVER]
					getGame().gameOver();
					return;
				}
				outputText("\n\nWhile chewing, your mind becomes more and more tranquil.  You find it hard to even remember your mission, let alone your name.  <b>Maybe more kanga fruits will help?</b>");
			}
			//-Speed to 70
			if (player.spe100 < 70 && rand(3) == 0) {
				//2 points up if below 40!
				if (player.spe100 < 40) dynStats("spe", 1);
				dynStats("spe", 1);
				outputText("\n\nYour legs fill with energy as you eat the kanga fruit.  You feel like you could set a long-jump record!  You give a few experimental bounds, both standing and running, with your newfound vigor.  Your stride seems longer too; you even catch a bit of air as you push off with every powerful step.");
				changes++;
			}
			//-Int to 10
			if (player.inte > 2 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//Gain dumb (smart!)
				if (player.inte > 30) outputText("\n\nYou feel... antsy. You momentarily forget your other concerns as you look around you, trying to decide which direction you'd be most likely to find more food in.  You're about to set out on the search when your mind refocuses and you realize you already have some stored at camp.");
				//gain dumb (30-10 int):
				else if (player.inte > 10) outputText("\n\nYour mind wanders as you eat; you think of what it would be like to run forever, bounding across the wastes of Mareth in the simple joy of movement.  You bring the kanga fruit to your mouth one last time, only to realize there's nothing edible left on it.  The thought brings you back to yourself with a start.");
				//gain dumb (10-1 int):
				else outputText("\n\nYou lose track of everything as you eat, staring at the bugs crawling across the ground.  After a while you notice the dull taste of saliva in your mouth and realize you've been sitting there, chewing the same mouthful for five minutes.  You vacantly swallow and take another bite, then go back to staring at the ground.  Was there anything else to do today?");
				dynStats("int", -1);
			}
			//****************
			//Appearance Effects:
			//****************
			//-Hip widening funtimes
			if (changes < changeLimit && rand(4) == 0 && player.hipRating < 40) {
				outputText("\n\nYou weeble and wobble as your hipbones broaden noticeably, but somehow you don't fall down.  Actually, you feel a bit MORE stable on your new widened stance, if anything.");
				player.hipRating++;
				changes++;
			}
			//-Restore arms to become human arms again
			if (rand(4) == 0) restoreArms(tfSource);
			//-Remove feathery hair
			removeFeatheryHair();
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && player.eyeType > EYES_HUMAN) {
				if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType == EYES_FOUR_SPIDER_EYES || player.eyeType == EYES_SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//****************
			//Sexual:
			//****************
			//-Shrink balls down to reasonable size (3?)
			if (player.ballSize >= 4 && changes < changeLimit && rand(2) == 0) {
				player.ballSize--;
				player.cumMultiplier++;
				outputText("\n\nYour " + player.sackDescript() + " pulls tight against your groin, vibrating slightly as it changes.  Once it finishes, you give your " + player.ballsDescriptLight() + " a gentle squeeze and discover they've shrunk.  Even with the reduced volume, they feel just as heavy.");
				changes++;
			}
			//-Shorten clits to reasonable size
			if (player.getClitLength() >= 4 && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nPainful pricks work through your " + player.clitDescript() + ", all the way into its swollen clitoral sheath.  Gods, it feels afire with pain!  Agony runs up and down its length, and by the time the pain finally fades, the feminine organ has lost half its size.");
				player.setClitLength(player.getClitLength() / 2);
				changes++;
			}
			//Find biggest dick!
			biggestCock = player.biggestCockIndex();
			//-Shrink dicks down to 8\" max.
			if (player.hasCock()) {
				if (player.cocks[biggestCock].cockLength >= 16 && changes < changeLimit && rand(5) == 0) {
					outputText("\n\nA roiling inferno of heat blazes in your " + player.cockDescript(biggestCock) + ", doubling you over in the dirt.  You rock back and forth while tears run unchecked down your cheeks.  Once the pain subsides and you're able to move again, you find the poor member has lost nearly half its size.");
					player.cocks[biggestCock].cockLength /= 2;
					player.cocks[biggestCock].cockThickness /= 1.5;
					if (player.cocks[biggestCock].cockThickness * 6 > player.cocks[biggestCock].cockLength) player.cocks[biggestCock].cockThickness -= .2;
					if (player.cocks[biggestCock].cockThickness * 8 > player.cocks[biggestCock].cockLength) player.cocks[biggestCock].cockThickness -= .2;
					if (player.cocks[biggestCock].cockThickness < .5) player.cocks[biggestCock].cockThickness = .5;
					changes++;
				}
				//COCK TF!
				if (player.countCocksOfType(CockTypesEnum.KANGAROO) < player.cockTotal() && (type == 1 && rand(2) == 0) && changes < changeLimit) {
					outputText("\n\nYou feel a sharp pinch at the end of your penis and whip down your clothes to check.  Before your eyes, the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into ");
					if (player.hasSheath()) outputText("your sheath");
					else outputText("a sheath that forms at the base of it");
					outputText(".  <b>You now have a kangaroo-penis!</b>");
					var cockIdx:int = 0;
					//Find first non-roocock!
					while (cockIdx < player.cockTotal()) {
						if (player.cocks[cockIdx].cockType != CockTypesEnum.KANGAROO) {
							player.cocks[cockIdx].cockType = CockTypesEnum.KANGAROO;
							player.cocks[cockIdx].knotMultiplier = 1;
							break;
						}
						cockIdx++;
					}
					changes++;
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//****************
			//Big Kanga Morphs
			//type 1 ignores normal restrictions
			//****************
			//-Face (Req: Fur + Feet)
			if (player.faceType != FACE_KANGAROO && ((player.hasFur() && player.lowerBody == LOWER_BODY_TYPE_KANGAROO) || type == 1) && changes < changeLimit && rand(4) == 0) {
				//gain roo face from human/naga/shark/bun:
				if (player.faceType == FACE_HUMAN || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SHARK_TEETH || player.faceType == FACE_BUNNY) outputText("\n\nThe base of your nose suddenly hurts, as though someone were pinching and pulling at it.  As you shut your eyes against the pain and bring your hands to your face, you can feel your nose and palate shifting and elongating.  This continues for about twenty seconds as you stand there, quaking.  When the pain subsides, you run your hands all over your face; what you feel is a long muzzle sticking out, whiskered at the end and with a cleft lip under a pair of flat nostrils.  You open your eyes and receive confirmation. <b>You now have a kangaroo face!  Crikey!</b>");
				//gain roo face from other snout:
				else outputText("\n\nYour nose tingles. As you focus your eyes toward the end of it, it twitches and shifts into a muzzle similar to a stretched-out rabbit's, complete with harelip and whiskers.  <b>You now have a kangaroo face!</b>");
				changes++;
				player.faceType = FACE_KANGAROO;
			}
			//-Fur (Req: Footsies)
			if (!player.hasFur() && (player.lowerBody == LOWER_BODY_TYPE_KANGAROO || type == 1) && changes < changeLimit && rand(4) == 0) {
				changes++;
				outputText("\n\nYour " + player.skinDesc + " itches terribly all over and you try cartoonishly to scratch everywhere at once.  ");
				player.skinType = SKIN_TYPE_FUR;
				player.skinDesc = "fur";
				player.furColor = "brown";
				player.underBody.restore(); // Restore the underbody for now
				outputText("As you pull your hands in, you notice " + player.furColor + " fur growing on the backs of them.  All over your body the scene is repeated, covering you in the stuff.  <b>You now have fur!</b>");
			}
			//-Roo footsies (Req: Tail)
			if (player.lowerBody != LOWER_BODY_TYPE_KANGAROO && (type == 1 || player.tailType == TAIL_TYPE_KANGAROO) && changes < changeLimit && rand(4) == 0) {
				//gain roo feet from centaur:
				if (player.isTaur()) outputText("\n\nYour backlegs suddenly wobble and collapse, causing you to pitch over onto your side.  Try as you might, you can't get them to stop spasming so you can stand back up; you thrash your hooves wildly as a pins-and-needles sensation overtakes your lower body.  A dull throbbing along your spine makes you moan in agony; it's as though someone had set an entire bookshelf on your shoulders and your spine were being compressed far beyond its limit.  After a minute of pain, the pressure evaporates and you look down at your legs.  Not only are your backlegs gone, but your forelegs have taken on a dogleg shape, with extremely long feet bearing a prominent middle toe!  You set about rubbing the feeling back into your legs and trying to move the new feet.  <b>You now have kangaroo legs!</b>");
				//gain roo feet from naga:
				else if (player.lowerBody == LOWER_BODY_TYPE_NAGA) outputText("\n\nYour tail quivers, then shakes violently, planting you on your face.  As you try to bend around to look at it, you can just see the tip shrinking out of your field of vision from the corner of your eye.  The scaly skin below your waist tightens intolerably, then splits; you wriggle out of it, only to find yourself with a pair of long legs instead!  A bit of hair starts to grow in as you stand up unsteadily on your new, elongated feet.  <b>You now have kangaroo legs!</b>  Now, what are you going to do with a giant shed snakeskin?");
				//gain roo feet from slime:
				else if (player.lowerBody == LOWER_BODY_TYPE_GOO) outputText("\n\nYour mounds of goo shrink and part involuntarily, exposing your crotch.  Modesty overwhelms you and you try to pull them together, but the shrinkage is continuing faster than you can shift your gooey body around.  Before long you've run out of goo to move, and your lower body now ends in a pair of slippery digitigrade legs with long narrow feet.  They dry in the air and a bit of fur begins to sprout as you look for something to cover up with.  <b>You now have kangaroo legs!</b> You sigh.  Guess this means it's back to wearing underpants again.");
				//gain roo feet from human/bee/demon/paw/lizard:
				else outputText("\n\nYour feet begin to crack and shift as the metatarsal bones lengthen.  Your knees buckle from the pain of your bones rearranging themselves, and you fall over.  After fifteen seconds of what feels like your feet being racked, the sensation stops.  You look down at your legs; they've taken a roughly dog-leg shape, but they have extremely long feet with a prominent middle toe!  As you stand up you find that you're equally comfortable standing flat on your feet as you are on the balls of them!  <b>You now have kangaroo legs!</b>");
				player.lowerBody = LOWER_BODY_TYPE_KANGAROO;
				player.legCount = 2;
				changes++;
			}
			//-Roo tail (Req: Ears)
			if (player.tailType != TAIL_TYPE_KANGAROO && changes < changeLimit && rand(4) == 0 && (type == 1 || player.earType == EARS_KANGAROO)) {
				//gain roo tail:
				if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nA painful pressure in your lower body causes you to stand straight and lock up.  At first you think it might be gas.  No... something is growing at the end of your tailbone.  As you hold stock still so as not to exacerbate the pain, something thick pushes out from the rear of your garments.  The pain subsides and you crane your neck around to look; a long, tapered tail is now attached to your butt and a thin coat of fur is already growing in!  <b>You now have a kangaroo tail!</b>");
				//gain roo tail from bee tail:
				else if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.tailType == TAIL_TYPE_BEE_ABDOMEN) {
					outputText("\n\nYour chitinous backside shakes and cracks once you finish eating.  Peering at it as best you can, it appears as though the fuzz is falling out in clumps and the chitin is flaking off.  As convulsions begin to wrack your body and force you to collapse, the ");
					if (player.tailType == TAIL_TYPE_BEE_ABDOMEN) outputText("hollow stinger drops out of the end, taking the venom organ with it.");
					else outputText("spinnerets drop out of the end, taking the last of your webbing with it.");
					outputText("  By the time you're back to yourself, the insectile carapace has fallen off completely, leaving you with a long, thick, fleshy tail in place of your proud, insectile abdomen.  <b>You now have a kangaroo tail!</b>  You wipe the errant spittle from your mouth as you idly bob your new tail about.");
				}
				//gain roo tail from other tail:
				else {
					outputText("\n\nYour tail twitches as you eat.  It begins to feel fat and swollen, and you try to look at your own butt as best you can.  What you see matches what you feel as your tail thickens and stretches out into a long cone shape.  <b>You now have a kangaroo tail!</b>");
				}
				player.tailType = TAIL_TYPE_KANGAROO;
				changes++;
			}
			//-Roo ears
			if (player.earType != EARS_KANGAROO && changes < changeLimit && rand(4) == 0) {
				//Bunbun ears get special texts!
				if (player.earType == EARS_BUNNY) outputText("\n\nYour ears stiffen and shift to the sides!  You reach up and find them pointed outwards instead of up and down; they feel a bit wider now as well.  As you touch them, you can feel them swiveling in place in response to nearby sounds.  <b>You now have a pair of kangaroo ears!</b>");
				//Everybody else?  Yeah lazy.
				else outputText("\n\nYour ears twist painfully as though being yanked upwards and you clap your hands to your head.  Feeling them out, you discover them growing!  They stretch upwards, reaching past your fingertips, and then the tugging stops.  You cautiously feel along their lengths; they're long and stiff, but pointed outwards now, and they swivel around as you listen.  <b>You now have a pair of kangaroo ears!</b>");
				changes++;
				player.earType = EARS_KANGAROO;
			}
			//UBEROOOO
			//kangaroo perk: - any liquid or food intake will accelerate a pregnancy, but it will not progress otherwise
			if (player.findPerk(PerkLib.Diapause) < 0 && player.kangaScore() > 4 && rand(4) == 0 && changes < changeLimit && player.hasVagina()) {
				//Perk name and description:
				player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
				outputText("\n\nYour womb rumbles as something inside it changes.\n<b>(You have gained the Diapause perk.  Pregnancies will not progress when fluid intake is scarce, and will progress much faster when it isn't.)");
				changes++;
				//trigger effect: Your body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();
			if (changes == 0) {
				outputText("\n\nIt did not seem to have any effects, but you do feel better rested.");
				player.changeFatigue(-40);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function sweetGossamer(type:Number,player:Player):void
		{
			var tfSource:String = "sweetGossamer";
			if (type == 1) tfSource += "-drider";
			clearOutput();
			changes = 0;
			changeLimit = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Consuming Text
			if (type == 0) outputText("You wad up the sweet, pink gossamer and eat it, finding it to be delicious and chewy, almost like gum.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");
			else if (type == 1) outputText("You wad up the sweet, black gossamer and eat it, finding it to be delicious and chewy, almost like licorice.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");

			//*************
			//Stat Changes
			//*************
			//(If speed<70, increases speed)
			if (player.spe100 < 70 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air.  A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire.  Why would you ever want to do something like that?");
				dynStats("spe", 1.5);
				changes++;
			}
			//(If speed>80, decreases speed down to minimum of 80)
			if (player.spe100 > 80 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou feel like resting high in the trees and waiting for your unsuspecting prey to wander below so you can take them without having to exert yourself.  What an odd thought!");
				dynStats("spe", -1.5);
				changes++;
			}
			//(increases sensitivity)
			if (changes < changeLimit && rand(3) == 0) {
				outputText("\n\nThe hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on.");
				dynStats("sen", 1);
				changes++;
			}
			//(Increase libido)
			if (changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth.  You wish there had been more.");
				dynStats("lib", 1);
				changes++;
			}
			//(increase toughness to 60)
			if (changes < changeLimit && rand(3) == 0 && player.tou100 < 60) {
				outputText("\n\nStretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs.  How strange.  You probe at yourself, and while your " + player.skinFurScales() + " doesn't feel much different, the underlying flesh does seem tougher.");
				dynStats("tou", 1);
				changes++;
			}
			//(decrease strength to 70)
			if (player.str100 > 70 && rand(3) == 0) {
				outputText("\n\nLethargy rolls through you while you burp noisily.  You rub at your muscles and sigh, wondering why you need to be strong when you could just sew up a nice sticky web to catch your enemies.  ");
				if (player.spiderScore() < 4) outputText("Wait, you're not a spider, that doesn't make any sense!");
				else outputText("Well, maybe you should put your nice, heavy abdomen to work.");
				dynStats("str", -1);
				changes++;
			}
			//****************
			//Sexual Changes
			//****************
			//Increase venom recharge
			if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && player.tailRecharge < 25 && changes < changeLimit) {
				changes++;
				outputText("\n\nThe spinnerets on your abdomen twitch and drip a little webbing.  The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.");
				player.tailRecharge += 5;
			}
			//(tightens vagina to 1, increases lust/libido)
			if (player.hasVagina()) {
				if (player.looseness() > 1 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nWith a gasp, you feel your " + player.vaginaDescript(0) + " tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your " + player.vaginaDescript(0) + " excitedly. You can't wait to try this out!");
					dynStats("lib", 2, "lus", 25);
					changes++;
					player.vaginas[0].vaginalLooseness--;
				}
			}
			//(tightens asshole to 1, increases lust)
			if (player.ass.analLooseness > 1 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou let out a small cry as your " + player.assholeDescript() + " shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.");
				dynStats("lib", 2, "lus", 25);
				changes++;
				player.ass.analLooseness--;
			}
			//[Requires penises]
			//(Thickens all cocks to a ratio of 1\" thickness per 5.5\"
			if (player.hasCock() && changes < changeLimit && rand(4) == 0) {
				//Use temp to see if any dicks can be thickened
				temp = 0;
				counter = 0;
				while (counter < player.cockTotal()) {
					if (player.cocks[counter].cockThickness * 5.5 < player.cocks[counter].cockLength) {
						player.cocks[counter].cockThickness += .1;
						temp = 1;
					}
					counter++;
				}
				//If something got thickened
				if (temp == 1) {
					outputText("\n\nYou can feel your " + player.multiCockDescriptLight() + " filling out in your " + player.armorName + ". Pulling ");
					if (player.cockTotal() == 1) outputText("it");
					else outputText("them");
					outputText(" out, you look closely.  ");
					if (player.cockTotal() == 1) outputText("It's");
					else outputText("They're");
					outputText(" definitely thicker.");
					var counter:Number;
					changes++;
				}
			}
			//[Increase to Breast Size] - up to Large DD
			if (player.smallestTitSize() < 6 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + player.breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
				player.breastRows[player.smallestTitRow()].breastRating++;
				changes++;
			}
			//[Increase to Ass Size] - to 11
			if (player.buttRating < 11 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou look over your shoulder at your " + player.buttDescript() + " only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!");
				player.buttRating++;
				changes++;
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//***************
			//Appearance Changes
			//***************
			//(Ears become pointed if not human)
			if (player.earType != EARS_HUMAN && player.earType != EARS_ELFIN && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
				player.earType = EARS_ELFIN;
				changes++;
			}
			//(Fur/Scales fall out)
			if (!player.hasPlainSkin() && (player.earType == EARS_HUMAN || player.earType == EARS_ELFIN) && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your " + player.skinFurScales() + " ");
				if (player.hasScales()) outputText("are");
				else outputText("is");
				outputText(" falling to the ground, revealing flawless, almost pearly-white skin underneath.  <b>You now have pale white skin.</b>");
				player.skinTone = "pale white";
				player.skinAdj = "";
				player.skinType = SKIN_TYPE_PLAIN;
				player.skinDesc = "skin";
				player.underBody.restore();
				updateClaws(player.clawType);
				changes++;
			}
			//(Gain human face)
			if (player.hasPlainSkin() && (player.faceType != FACE_SPIDER_FANGS && player.faceType != FACE_HUMAN) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nWracked by pain, your face slowly reforms into a perfect human shape.  Awed by the transformation, you run your fingers delicately over the new face, marvelling at the change.  <b>You have a human face again!</b>");
				player.faceType = FACE_HUMAN;
				changes++;
			}
			//-Remove breast rows over 2.
			if (changes < changeLimit && player.bRows() > 2 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + player.breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.bRows() >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + player.nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.hairColor + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA chill runs over your " + player.allBreastsDescript() + " and vanishes.  You stick a hand under your " + player.armorName + " and discover that your extra nipples are missing!  You're down to just one per ");
				if (player.biggestTitSize() < 1) outputText("'breast'.");
				else outputText("breast.");
				changes++;
				//Loop through and reset nipples
				for (temp = 0; temp < player.breastRows.length; temp++) {
					player.breastRows[temp].nipplesPerBreast = 1;
				}
			}
			//Nipples Turn Black:
			if (!player.hasStatusEffect(StatusEffects.BlackNipples) && rand(6) == 0 && changes < changeLimit) {
				outputText("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!");
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
				changes++;
			}
			//eyes!
			if (player.hasPlainSkin() && (player.faceType != FACE_SPIDER_FANGS || player.faceType != FACE_HUMAN) && player.eyeType == EYES_HUMAN && rand(4) == 0 && changes < changeLimit) {
				player.eyeType = EYES_SPIDER;
				player.eyeCount = 4;
				changes++;
				outputText("\n\nYou suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!");
				dynStats("int", 5);
			}
			//(Gain spider fangs)
			if (player.faceType == FACE_HUMAN && player.hasPlainSkin() && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nTension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>");
				player.faceType = FACE_SPIDER_FANGS;
				changes++;
			}
			//(Arms to carapace-covered arms)
			if (player.armType != ARM_TYPE_SPIDER && changes < changeLimit && rand(4) == 0) {
				outputText("\n\n");
				//(Bird pretext)
				if (player.armType == ARM_TYPE_HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
				outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
				player.armType = ARM_TYPE_SPIDER;
				updateClaws();
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody != LOWER_BODY_TYPE_DRIDER_LOWER_BODY && player.lowerBody != LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS) restoreLegs(tfSource);
			//Drider butt
			if (type == 1 && player.findPerk(PerkLib.SpiderOvipositor) < 0 && player.isDrider() && player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && changes < changeLimit && rand(3) == 0 && (player.hasVagina || rand(2) == 0)) {
				outputText("\n\nAn odd swelling sensation floods your spider half.  Curling your abdomen underneath you for a better look, you gasp in recognition at your new 'equipment'!  Your semi-violent run-ins with the swamp's population have left you <i>intimately</i> familiar with the new appendage.  <b>It's a drider ovipositor!</b>  A few light prods confirm that it's just as sensitive as any of your other sexual organs.  You idly wonder what laying eggs with this thing will feel like...");
				outputText("\n\n(<b>Perk Gained:  Spider Ovipositor - Allows you to lay eggs in your foes!</b>)");
				//V1 - Egg Count
				//V2 - Fertilized Count
				player.createPerk(PerkLib.SpiderOvipositor, 0, 0, 0, 0);
				//Opens up drider ovipositor scenes from available mobs. The character begins producing unfertilized eggs in their arachnid abdomen. Egg buildup raises minimum lust and eventually lowers speed until the player has gotten rid of them.  This perk may only be used with the drider lower body, so your scenes should reflect that.
				//Any PC can get an Ovipositor perk, but it will be much rarer for characters without vaginas.
				//Eggs are unfertilized by default, but can be fertilized:
				//-female/herm characters can fertilize them by taking in semen; successfully passing a pregnancy check will convert one level ofunfertilized eggs to fertilized, even if the PC is already pregnant.
				//-male/herm characters will have a sex dream if they reach stage three of unfertilized eggs; this will represent their bee/drider parts drawing their own semen from their body to fertilize the eggs, and is accompanied by a nocturnal emission.
				//-unsexed characters cannot currently fertilize their eggs.
				//Even while unfertilized, eggs can be deposited inside NPCs - obviously, unfertilized eggs will never hatch and cannot lead to any egg-birth scenes that may be written later.
				changes++;
			}
			//(Normal Biped Legs -> Carapace-Clad Legs)
			if (((type == 1 && player.lowerBody != LOWER_BODY_TYPE_DRIDER_LOWER_BODY && player.lowerBody != LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS) || (type != 1 && player.lowerBody != LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS)) && (!player.isGoo() && !player.isNaga() && !player.isTaur()) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nStarting at your " + player.feet() + ", a tingle runs up your " + player.legs() + ", not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your " + player.buttDescript() + " in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>");
				player.lowerBody = LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS;
				player.legCount = 2;
				changes++;
			}
			//(Tail becomes spider abdomen GRANT WEB ATTACK)
			if (player.tailType != TAIL_TYPE_SPIDER_ADBOMEN && (player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS || player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY) && player.armType == ARM_TYPE_SPIDER && rand(4) == 0) {
				outputText("\n\n");
				//(Pre-existing tails)
				if (player.tailType > TAIL_TYPE_NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your " + player.buttDescript() + " and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + player.buttDescript() + "!</b>\n\n");
				//(No tail)
				else outputText("A burst of pain hits you just above your " + player.buttDescript() + ", coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + player.buttDescript() + "!</b>");
				player.tailType = TAIL_TYPE_SPIDER_ADBOMEN;
				player.tailVenom = 5;
				player.tailRecharge = 5;
				changes++;
			}
			//(Drider Item Only: Carapace-Clad Legs to Drider Legs)
			if (type == 1 && player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS && rand(4) == 0 && player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) {
				outputText("\n\nJust like when your legs changed to those of a spider-morph, you find yourself suddenly paralyzed below the waist.  Your dark, reflective legs splay out and drop you flat on your back.   Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them.  Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down.  As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs.  Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start.  Your abdomen has gotten even larger as well.  Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance.  As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance.  That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your " + player.buttDescript() + " is still positioned just above the start of your arachnid half.  <b>You're now a drider.</b>");
				player.lowerBody = LOWER_BODY_TYPE_DRIDER_LOWER_BODY;
				player.legCount = 8;
				changes++;
			}
			// Remove gills
			if (rand(4) == 0 && player.hasGills() && changes < changeLimit) updateGills();

			if (changes == 0) {
				outputText("\n\nThe sweet silk energizes you, leaving you feeling refreshed.");
				player.changeFatigue(-33);
			}
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

//Miscellaneous
//ITEM GAINED FROM LUST WINS
//bottle of ectoplasm. Regular stat-stuff include higher speed, (reduced libido?), reduced sensitivity, and higher intelligence. First-tier effects include 50/50 chance of sable skin with bone-white veins or ivory skin with onyx veins. Second tier, \"wisp-like legs that flit back and forth between worlds,\" or \"wisp-like legs\" for short. Third tier gives an \"Ephemeral\" perk, makes you (10%, perhaps?) tougher to hit, and gives you a skill that replaces tease/seduce—allowing the PC to possess the creature and force it to masturbate to gain lust. Around the same effectiveness as seduce.
//Mouseover script: \"The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel...uncomfortable, as you observe it.\"

		/**
		 * Transformation for Fox Berry or (enhanced) Vixen's Vigor
		 * 
		 * @param	enhanced if true, it's Vixen's Vigor
		 * @param	player affected by the item
		 */
		public function foxTF(enhanced:Boolean,player:Player):void
		{
			var tfSource:String = "foxTF";
			clearOutput();
			if (!enhanced) outputText("You examine the berry a bit, rolling the orangish-red fruit in your hand for a moment before you decide to take the plunge and chow down.  It's tart and sweet at the same time, and the flavors seem to burst across your tongue with potent strength.  Juice runs from the corners of your lips as you finish the tasty snack.");
			else outputText("You pop the cap on the enhanced \"Vixen's Vigor\" and decide to take a swig of it.  Perhaps it will make you as cunning as the crude fox Lumi drew on the front?");
			changes = 0;
			changeLimit = 1;
			if (enhanced) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Used for dick and boob TFs
			var counter:int = 0;

			if (player.faceType == FACE_FOX && player.tailType == TAIL_TYPE_FOX && player.earType == EARS_FOX && player.lowerBody == LOWER_BODY_TYPE_FOX && player.hasFur() && rand(3) == 0 && player.findPerk(PerkLib.TransformationResistance) < 0) {
				if (flags[kFLAGS.FOX_BAD_END_WARNING] == 0) {
					outputText("\n\nYou get a massive headache and a craving to raid a henhouse.  Thankfully, both pass in seconds, but <b>maybe you should cut back on the vulpine items...</b>");
					flags[kFLAGS.FOX_BAD_END_WARNING] = 1;
				}
				else {
					outputText("\n\nYou scarf down the ");
					if (enhanced) outputText("fluid ");
					else outputText("berries ");
					outputText("with an uncommonly voracious appetite, taking particular enjoyment in the succulent, tart flavor.  As you carefully suck the last drops of ochre juice from your fingers, you note that it tastes so much more vibrant than you remember.  Your train of thought is violently interrupted by the sound of bones snapping, and you cry out in pain, doubling over as a flaming heat boils through your ribs.");
					outputText("\n\nWrithing on the ground, you clutch your hand to your chest, looking on in horror through tear-streaked eyes as the bones in your fingers pop and fuse, rearranging themselves into a dainty paw covered in coarse black fur, fading to a ruddy orange further up.  You desperately try to call out to someone - anyone - for help, but all that comes out is a high-pitched, ear-splitting yap.");
					if (player.tailVenom > 1) outputText("  Your tails thrash around violently as they begin to fuse painfully back into one, the fur bristling back out with a flourish.");
					outputText("\n\nA sharp spark of pain jolts through your spinal column as the bones shift themselves around, the joints in your hips migrating forward.  You continue to howl in agony even as you feel your intelligence slipping away.  In a way, it's a blessing - as your thoughts grow muddied, the pain is dulled, until you are finally left staring blankly at the sky above, tilting your head curiously.");
					outputText("\n\nYou roll over and crawl free of the " + player.armorName + " covering you, pawing the ground for a few moments before a pang of hunger rumbles through your stomach.  Sniffing the wind, you bound off into the wilderness, following the telltale scent of a farm toward the certain bounty of a chicken coop.");
					getGame().gameOver();
					return;
				}
			}
			//[increase Intelligence, Libido and Sensitivity]
			if (changes < changeLimit && rand(3) == 0 && (player.lib100 < 80 || player.inte100 < 80 || player.sens100 < 80)) {
				outputText("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental picture of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				if (player.inte100 < 80) dynStats("int", 4);
				if (player.lib100 < 80) dynStats("lib", 1);
				if (player.sens100 < 80) dynStats("sen", 1);
				//gain small lust also
				dynStats("lus", 10);
				changes++;
			}
			//[decrease Strength] (to some floor) // I figured 15 was fair, but you're in a better position to judge that than I am.
			if (changes < changeLimit && rand(3) == 0 && player.str100 > 40) {
				outputText("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				dynStats("str", -1);
				if (player.str100 > 60) dynStats("str", -1);
				if (player.str100 > 80) dynStats("str", -1);
				if (player.str100 > 90) dynStats("str", -1);
				changes++;
			}
			//[decrease Toughness] (to some floor) // 20 or so was my thought here
			if (changes < changeLimit && rand(3) == 0 && player.tou100 > 30) {
				if (player.tou100 < 60) outputText("\n\nYou feel your skin becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your supple skin isn't going to offer you much protection.");
				else outputText("\n\nYou feel your skin becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				dynStats("tou", -1);
				if (player.tou100 > 60) dynStats("tou", -1);
				if (player.tou100 > 80) dynStats("tou", -1);
				if (player.tou100 > 90) dynStats("tou", -1);
				changes++;
			}

			//[Change Hair Color: Golden-blonde or Reddish-orange]
			var fox_hair:Array = ["golden blonde", "reddish-orange", "silver", "white", "red", "black"];
			if (!InCollection(player.hairColor, fox_hair) && !InCollection(player.hairColor, KitsuneScene.basicKitsuneHair) && !InCollection(player.hairColor, KitsuneScene.elderKitsuneColors) && changes < changeLimit && rand(4) == 0) {
				if (player.tailType == TAIL_TYPE_FOX && player.tailVenom > 1)
					if (player.tailVenom < 9) player.hairColor = randomChoice(KitsuneScene.basicKitsuneHair);
					else player.hairColor = randomChoice(KitsuneScene.elderKitsuneColors);
				else player.hairColor = randomChoice(fox_hair);
				outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become " + player.hairColor + "!");
			}
			//[Adjust hips toward 10 – wide/curvy/flared]
			if (changes < changeLimit && rand(3) == 0 && player.hipRating != 10) {
				//from narrow to wide
				if (player.hipRating < 10) {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has widened into [hips]!");
					player.hipRating++;
					if (player.hipRating < 7) player.hipRating++;
				}
				//from wide to narrower
				else {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has narrowed, becoming [hips].");
					player.hipRating--;
					if (player.hipRating > 15) player.hipRating--;
				}
				changes++;
			}
			//[Remove tentacle hair]
			//required if the hair length change below is triggered
			if (changes < changeLimit && player.hairType == 4 && rand(3) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nEerie flames of the jewel migrate up your body to your head, where they cover your [hair].  Though they burned nowhere else in their lazy orbit, your head begins to heat up as they congregate.  Fearful, you raise your hands to it just as the temperature peaks, but as you touch your hair, the searing heat is suddenly gone - along with your tentacles!  <b>Your hair is normal again!</b>");
				player.hairType = HAIR_NORMAL;
				changes++;
			}
			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			if (player.hairType != 4 && (player.hairLength > 26 || player.hairLength < 16) && changes < changeLimit && rand(4) == 0) {
				if (player.hairLength < 16) {
					player.hairLength += 1 + rand(4);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming " + num2Text(Math.round(player.hairLength)) + " inches long.");
				}
				else {
					player.hairLength -= 1 + rand(4);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming " + num2Text(Math.round(player.hairLength)) + " inches long.");
				}
				changes++;
			}
			if (changes < changeLimit && rand(10) == 0) {
				outputText("\n\nYou sigh as the exotic flavor washes through you, and unbidden, you begin to daydream.  Sprinting through the thicket, you can feel the corners of your muzzle curling up into a mischievous grin.  You smell the scent of demons, and not far away either.  With your belly full and throat watered, now is the perfect time for a little bit of trickery.   As the odor intensifies, you slow your playful gait and begin to creep a bit more carefully.");
				outputText("\n\nSuddenly, you are there, at a demonic camp, and you spy the forms of an incubus and a succubus, their bodies locked together at the hips and slowly undulating, even in sleep.  You carefully prance around their slumbering forms and find their supplies.  With the utmost care, you put your razor-sharp teeth to work, and slowly, meticulously rip through their packs - not with the intention of theft, but with mischief.  You make sure to leave small holes in the bottom of each, and after making sure your stealth remains unbroken, you urinate on their hooves.");
				outputText("\n\nThey don't even notice, so lost in the subconscious copulation as they are.  Satisfied at your petty tricks, you scurry off into the night, a red blur amidst the foliage.");
				changes++;
				player.changeFatigue(-10);
			}

			//dog cocks!
			if (changes < changeLimit && rand(3) == 0 && player.dogCocks() < player.cocks.length) {
				var choices:Array = [];
				counter = player.cockTotal();
				while (counter > 0) {
					counter--;
					//Add non-dog locations to the array
					if (player.cocks[counter].cockType != CockTypesEnum.DOG) choices[choices.length] = counter;
				}
				if (choices.length != 0) {
					var select:int = choices[rand(choices.length)];
					if (player.cocks[select].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour " + player.cockDescript(select) + " clenches painfully, becoming achingly, throbbingly erect.  A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath.  You shudder as the crown of your " + player.cockDescript(select) + " reshapes into a point, the sensations nearly too much for you.  You throw back your head as the transformation completes, your " + Appearance.cockNoun(CockTypesEnum.DOG) + " much thicker than it ever was before.  <b>You now have a dog-cock.</b>");
						player.cocks[select].cockThickness += .3;
						dynStats("sen", 10, "lus", 5);
					}
					//Horse
					else if (player.cocks[select].cockType == CockTypesEnum.HORSE) {
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes into a more pointed form, a thick knotted bulge forming just above your sheath.  <b>You now have a dog-cock.</b>");
						//Tweak length/thickness.
						if (player.cocks[select].cockLength > 6) player.cocks[select].cockLength -= 2;
						else player.cocks[select].cockLength -= .5;
						player.cocks[select].cockThickness += .5;

						dynStats("sen", 4, "lus", 5);
					}
					//Tentacular Tuesday!
					else if (player.cocks[select].cockType == CockTypesEnum.TENTACLE) {
						outputText("\n\nYour " + player.cockDescript(select) + " coils in on itself, reshaping and losing its plant-like coloration as thickens near the base, bulging out in a very canine-looking knot.  Your skin bunches painfully around the base, forming into a sheath.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 10);
					}
					//Misc
					else {
						outputText("\n\nYour " + player.cockDescript(select) + " trembles, reshaping itself into a shiny red doggie-dick with a fat knot at the base.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 10);
					}
					player.cocks[select].cockType = CockTypesEnum.DOG;
					player.cocks[select].knotMultiplier = 1.25;
					changes++;
				}

			}
			//Cum Multiplier Xform
			if (player.cumQ() < 5000 && rand(3) == 0 && changes < changeLimit && player.hasCock()) {
				temp = 2 + rand(4);
				//Lots of cum raises cum multiplier cap to 2 instead of 1.5
				if (player.findPerk(PerkLib.MessyOrgasms) >= 0) temp += rand(10);
				player.cumMultiplier += temp;
				//Flavor text
				if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.");
				if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ".  It quickly settles, leaving them feeling somewhat more dense.");
				outputText("  A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.");
				changes++;
			}
			if (changes < changeLimit && player.balls > 0 && player.ballSize > 4 && rand(3) == 0) {
				outputText("\n\nYour [sack] gets lighter and lighter, the skin pulling tight around your shrinking balls until you can't help but check yourself.");
				if (player.ballSize > 10) player.ballSize -= 5;
				if (player.ballSize > 20) player.ballSize -= 4;
				if (player.ballSize > 30) player.ballSize -= 4;
				if (player.ballSize > 40) player.ballSize -= 4;
				if (player.ballSize > 50) player.ballSize -= 8;
				if (player.ballSize > 60) player.ballSize -= 8;
				if (player.ballSize <= 10) player.ballSize--;
				changes++;
				outputText("  You now have a [balls].");
			}
			//Sprouting more!
			if (changes < changeLimit && enhanced && player.bRows() < 4 && player.breastRows[player.bRows() - 1].breastRating > 1) {
				outputText("\n\nYour belly rumbles unpleasantly for a second as the ");
				if (!enhanced) outputText("berry ");
				else outputText("drink ");
				outputText("settles deeper inside you.  A second later, the unpleasant gut-gurgle passes, and you let out a tiny burp of relief.  Before you finish taking a few breaths, there's an itching below your " + player.allChestDesc() + ".  You idly scratch at it, but gods be damned, it hurts!  You peel off part of your " + player.armorName + " to inspect the unwholesome itch, ");
				if (player.biggestTitSize() >= 8) outputText("it's difficult to see past the wall of tits obscuring your view.");
				else outputText("it's hard to get a good look at.");
				outputText("  A few gentle prods draw a pleasant gasp from your lips, and you realize that you didn't have an itch - you were growing new nipples!");
				outputText("\n\nA closer examination reveals your new nipples to be just like the ones above in size and shape");
				if (player.breastRows[player.bRows() - 1].nipplesPerBreast > 1) outputText(", not to mention number");
				else if (player.hasFuckableNipples()) outputText(", not to mention penetrability");
				outputText(".  While you continue to explore your body's newest addition, a strange heat builds behind the new nubs. Soft, jiggly breastflesh begins to fill your cupped hands.  Radiant warmth spreads through you, eliciting a moan of pleasure from your lips as your new breasts catch up to the pair above.  They stop at " + player.breastCup(player.bRows() - 1) + "s.  <b>You have " + num2Text(player.bRows() + 1) + " rows of breasts!</b>");
				player.createBreastRow();
				player.breastRows[player.bRows() - 1].breastRating = player.breastRows[player.bRows() - 2].breastRating;
				player.breastRows[player.bRows() - 1].nipplesPerBreast = player.breastRows[player.bRows() - 2].nipplesPerBreast;
				if (player.hasFuckableNipples()) player.breastRows[player.bRows() - 1].fuckable = true;
				player.breastRows[player.bRows() - 1].lactationMultiplier = player.breastRows[player.bRows() - 2].lactationMultiplier;
				dynStats("sen", 2, "lus", 30);
				changes++;
			}
			//Find out if tits are eligible for evening
			var tits:Boolean = false;
			counter = player.bRows();
			while (counter > 1) {
				counter--;
				//If the row above is 1 size above, can be grown!
				if (player.breastRows[counter].breastRating <= (player.breastRows[counter - 1].breastRating - 1) && changes < changeLimit && rand(2) == 0) {
					if (tits) outputText("\n\nThey aren't the only pair to go through a change!  Another row of growing bosom goes through the process with its sisters, getting larger.");
					else {
						var select2:Number = rand(3);
						if (select2 == 1) outputText("\n\nA faint warmth buzzes to the surface of your " + player.breastDescript(counter) + ", the fluttering tingles seeming to vibrate faster and faster just underneath your [skin].  Soon, the heat becomes uncomfortable, and that row of chest-flesh begins to feel tight, almost thrumming like a newly-stretched drum.  You " + player.nippleDescript(counter) + "s go rock hard, and though the discomforting feeling of being stretched fades, the pleasant, warm buzz remains.  It isn't until you cup your tingly tits that you realize they've grown larger, almost in envy of the pair above.");
						else if (select2 == 2) outputText("\n\nA faintly muffled gurgle emanates from your " + player.breastDescript(counter) + " for a split-second, just before your flesh shudders and shakes, stretching your " + player.skinFurScales() + " outward with newly grown breast.  Idly, you cup your hands to your swelling bosom, and though it stops soon, you realize that your breasts have grown closer in size to the pair above.");
						else {
							outputText("\n\nAn uncomfortable stretching sensation spreads its way across the curves of your " + player.breastDescript(counter) + ", threads of heat tingling through your flesh.  It feels as though your heartbeat has been magnified tenfold within the expanding mounds, your [skin] growing flushed with arousal and your " + player.nippleDescript(counter) + " filling with warmth.  As the tingling heat gradually fades, a few more inches worth of jiggling breast spill forth.  Cupping them experimentally, you confirm that they have indeed grown to be a bit more in line with the size of the pair above.")
						}
					}
					//Bigger change!
					if (player.breastRows[counter].breastRating <= (player.breastRows[counter - 1].breastRating - 3))
						player.breastRows[counter].breastRating += 2 + rand(2);
					//Smallish change.
					else player.breastRows[counter].breastRating++;
					outputText("  You do a quick measurement and determine that your " + num2Text2(counter + 1) + " row of breasts are now " + player.breastCup(counter) + "s.");

					if (!tits) {
						tits = true;
						changes++;
					}
					dynStats("sen", 2, "lus", 10);
				}
			}
			//HEAT!
			if (player.statusEffectv2(StatusEffects.Heat) < 30 && rand(6) == 0 && changes < changeLimit) {
				if (player.goIntoHeat(true)) {
						changes++;
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//[Grow Fur]
			//FOURTH
			if ((enhanced || player.lowerBody == LOWER_BODY_TYPE_FOX) && !player.hasFur() && changes < changeLimit && rand(4) == 0) {
				var colorChoices:Array = ["invalid color"]; // Failsafe ... should hopefully not happen (Stadler76)
				var foxFurColors:Array = [
					["orange", "white"],
					["orange", "white"],
					["orange", "white"],
					["red", "white"],
					["black", "white"],
					"white",
					"tan",
					"brown"
				];
				//from scales
				if (player.hasScales()) outputText("\n\nYour skin shifts and every scale stands on end, sending you into a mild panic.  No matter how you tense, you can't seem to flatten them again.  The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out.  You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old.  <b>Oh well; at least you won't need to sun yourself as much with your new fur.</b>");
				//from skin
				else outputText("\n\nYour skin itches all over, the sudden intensity and uniformity making you too paranoid to scratch.  As you hold still through an agony of tiny tingles and pinches, fine, luxuriant fur sprouts from every bare inch of your skin!  <b>You'll have to get used to being furry...</b>");
				player.skinType = SKIN_TYPE_FUR;
				player.skinAdj = "";
				player.skinDesc = "fur";
				if (player.kitsuneScore() >= 4)
					if (InCollection(player.hairColor, convertMixedToStringArray(KitsuneScene.basicKitsuneFur)) || InCollection(player.hairColor, KitsuneScene.elderKitsuneColors))
						colorChoices = [player.hairColor];
					else
						if (player.tailType == TAIL_TYPE_FOX && player.tailVenom == 9)
							colorChoices = KitsuneScene.elderKitsuneColors;
						else
							colorChoices = KitsuneScene.basicKitsuneFur;
				else
					colorChoices = foxFurColors;
				player.setFurColor(colorChoices, {type: UNDER_BODY_TYPE_FURRY}, true);
				changes++;
			}
			//[Grow Fox Legs]
			//THIRD
			if ((enhanced || player.earType == EARS_FOX) && player.lowerBody != LOWER_BODY_TYPE_FOX && changes < changeLimit && rand(5) == 0) {
				//4 legs good, 2 legs better
				if (player.isTaur()) outputText("\n\nYou shiver as the strength drains from your back legs.  Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over;  their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides.  A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations.  When they reopen, what greets them are not four legs, but only two... and those roughly in the shape of your old hindleg, except for the furry toes where your hooves used to be.  <b>You now have fox legs!</b>");
				//n*ga please
				else if (player.isNaga()) outputText("\n\nYour scales split at the waistline and begin to peel, shedding like old snakeskin.  If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal.  As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin.  Within minutes, it crumbles completely and is taken by the ever-moving wind.  <b>Your legs are now those of a fox!</b>");
				//other digitigrade
				else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_DOG || player.lowerBody == LOWER_BODY_TYPE_CAT || player.lowerBody == LOWER_BODY_TYPE_BUNNY || player.lowerBody == LOWER_BODY_TYPE_KANGAROO)
					outputText("\n\nYour legs twitch and quiver, forcing you to your seat.  As you watch, the ends shape themselves into furry, padded toes.  <b>You now have fox feet!</b>  Rather cute ones, actually.");
				//red drider bb gone
				else if (player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY) outputText("\n\nYour legs buckle under you and you fall, smashing your abdomen on the ground.  Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves.  Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible.  When you try to part them, you find you cannot.  Several minutes pass uncomfortably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>");
				//goo home and goo to bed
				else if (player.isGoo()) outputText("\n\nIt takes a while before you notice that your gooey mounds have something more defined in them.  As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg.  You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot.  The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>");
				//reg legs, not digitigrade
				else {
					outputText("\n\nYour hamstrings tense painfully and begin to pull, sending you onto your face.  As you writhe on the ground, you can feel your thighs shortening and your feet stretching");
					if (player.lowerBody == LOWER_BODY_TYPE_BEE) outputText(", while a hideous cracking fills the air");
					outputText(".  When the spasms subside and you can once again stand, <b>you find that your legs have been changed to those of a fox!</b>");
				}
				player.lowerBody = LOWER_BODY_TYPE_FOX;
				player.legCount = 2;
				changes++;
			}
			//Grow Fox Ears]
			//SECOND
			if ((enhanced || player.tailType == TAIL_TYPE_FOX) && player.earType != EARS_FOX && changes < changeLimit && rand(4) == 0) {
				//from human/gob/liz ears
				if (player.earType == EARS_HUMAN || player.earType == EARS_ELFIN || player.earType == EARS_LIZARD) {
					outputText("\n\nThe sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  <b>You now have fox ears.</b>");
				}
				//from dog/cat/roo ears
				else {
					outputText("\n\nYour ears change, shifting from their current shape to become vulpine in nature.  <b>You now have fox ears.</b>");
				}
				player.earType = EARS_FOX;
				changes++;
			}
			//[Grow Fox Tail](fairly common)
			//FIRST
			if (player.tailType != TAIL_TYPE_FOX && changes < changeLimit && rand(4) == 0) {
				//from no tail
				if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nA pressure builds on your backside.  You feel under your [armor] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own.  <b>You now have a fox's tail!</b>");
				//from another type of tail
				else outputText("\n\nPain lances through your lower back as your tail shifts violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox's tail!</b>");
				player.tailType = TAIL_TYPE_FOX;
				player.tailVenom = 1;
				changes++;
			}
			//[Grow Fox Face]
			//LAST - muzzlygoodness
			//should work from any face, including other muzzles
			if (player.hasFur() && player.faceType != FACE_FOX && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nYour face pinches and you clap your hands to it.  Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror.  <b>Looks like you now have a fox's face.</b>");
				if (silly()) outputText("  And they called you crazy...");
				changes++;
				player.faceType = FACE_FOX;
			}
			if (player.tone > 40 && changes < changeLimit && rand(2) == 0) {
				outputText("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				player.tone -= 4;
			}
			if (changes == 0) {
				outputText("\n\nWell that didn't do much, but you do feel a little refreshed!");
				player.changeFatigue(-5);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		public function foxJewel(mystic:Boolean,player:Player):void
		{
			var tfSource:String = "foxJewel";
			if (mystic) tfSource += "-mystic";
			clearOutput();
			changes = 0;
			changeLimit = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (mystic) changeLimit += 2;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			if (mystic) outputText("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie purple flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale lavender flames swirl around you, the air is filled with a sickly sweet scent that drips with the bitter aroma of licorice, filling you with a dire warmth.");
			else outputText("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie blue flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale azure flames swirl around you, the air is filled with a sweet scent that drips with the aroma of wintergreen, sending chills down your spine.");

			//**********************
			//BASIC STATS
			//**********************
			//[increase Intelligence, Libido and Sensitivity]
			if (player.inte100 < 100 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0))) {
				outputText("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental image of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				//Raise INT, Lib, Sens. and +10 LUST
				dynStats("int", 2, "lib", 1, "sen", 2, "lus", 10);
				changes++;
			}
			//[decrease Strength toward 15]
			if (player.str100 > 15 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				outputText("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				dynStats("str", -1);
				if (player.str100 > 70) dynStats("str", -1);
				if (player.str100 > 50) dynStats("str", -1);
				if (player.str100 > 30) dynStats("str", -1);
				changes++;
			}
			//[decrease Toughness toward 20]
			if (player.tou100 > 20 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				//from 66 or less toughness
				if (player.tou100 <= 66) outputText("\n\nYou feel your " + player.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your " + player.skinFurScales() + " won't offer you much protection.");
				//from 66 or greater toughness
				else outputText("\n\nYou feel your " + player.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				dynStats("tou", -1);
				if (player.tou100 > 66) dynStats("tou", -1);
				changes++;
			}
			if (mystic && changes < changeLimit && rand(2) == 0 && player.cor < (100 + player.corruptionTolerance())) {
				if (player.cor < 33) outputText("\n\nA sense of dirtiness comes over you, like the magic of this gem is doing some perverse impropriety to you.");
				else if (player.cor < 66) outputText("\n\nA tingling wave of sensation rolls through you, but you have no idea what exactly just changed.  It must not have been that important.");
				else outputText("\n\nThoughts of mischief roll across your consciousness, unbounded by your conscience or any concern for others.  You should really have some fun - who cares who it hurts, right?");
				dynStats("cor", 1);
			}


			//**********************
			//MEDIUM/SEXUAL CHANGES
			//**********************
			//[adjust Femininity toward 50]
			//from low to high
			//Your facial features soften as your body becomes more androgynous.
			//from high to low
			//Your facial features harden as your body becomes more androgynous.
			if (((mystic && rand(2) == 0) || (!mystic && rand(4) == 0)) && changes < changeLimit && player.femininity != 50) {
				outputText(player.modFem(50, 2));
				changes++;
			}
			//[decrease muscle tone toward 40]
			if (player.tone >= 40 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0))) {
				outputText("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				player.tone -= 2 + rand(3);
				changes++;
			}

			//[Adjust hips toward 10 – wide/curvy/flared]
			//from narrow to wide
			if (player.hipRating < 10 && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && changes < changeLimit) {
				player.hipRating++;
				if (player.hipRating < 7) player.hipRating++;
				if (player.hipRating < 4) player.hipRating++;
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have widened nicely!");
				changes++;
			}
			//from wide to narrower
			if (player.hipRating > 10 && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && changes < changeLimit) {
				player.hipRating--;
				if (player.hipRating > 14) player.hipRating--;
				if (player.hipRating > 19) player.hipRating--;
				if (player.hipRating > 24) player.hipRating--;
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have narrowed.");
				changes++;
			}

			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			if ((player.hairLength < 16 || player.hairLength > 26) && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && changes < changeLimit) {
				//from short to long
				if (player.hairLength < 16) {
					player.hairLength += 3 + rand(3);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming " + player.hairDescript() + ".");
				}
				//from long to short
				else {
					player.hairLength -= 3 + rand(3);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming " + player.hairDescript() + ".");
				}
				changes++;
			}
			//[Increase Vaginal Capacity] - requires vagina, of course
			if (player.hasVagina() && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && player.statusEffectv1(StatusEffects.BonusVCapacity) < 200 && changes < changeLimit) {
				outputText("\n\nA gurgling sound issues from your abdomen, and you double over as a trembling ripple passes through your womb.  The flesh of your stomach roils as your internal organs begin to shift, and when the sensation finally passes, you are instinctively aware that your " + player.vaginaDescript(0) + " is a bit deeper than it was before.");
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) {
					player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				}
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 10 + rand(10));
				changes++;
			}
			else if (((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && player.statusEffectv1(StatusEffects.BonusACapacity) < 150 && changes < changeLimit) {
				outputText("\n\nYou feel... more accommodating somehow.  Your " + player.assholeDescript() + " is tingling a bit, and though it doesn't seem to have loosened, it has grown more elastic.");
				if (!player.hasStatusEffect(StatusEffects.BonusACapacity)) {
					player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
				}
				player.addStatusValue(StatusEffects.BonusACapacity, 1, 10 + rand(10));
				changes++;
			}
			//[Vag of Holding] - rare effect, only if PC has high vaginal looseness
			else if (player.hasVagina() && ((mystic) || (!mystic && rand(5) == 0)) && player.statusEffectv1(StatusEffects.BonusVCapacity) >= 200 && player.statusEffectv1(StatusEffects.BonusVCapacity) < 8000 && changes < changeLimit) {
				outputText("\n\nYou clutch your stomach with both hands, dropping to the ground in pain as your internal organs begin to twist and shift violently inside you.  As you clench your eyes shut in agony, you are overcome with a sudden calm.  The pain in your abdomen subsides, and you feel at one with the unfathomable infinity of the universe, warmth radiating through you from the vast swirling cosmos contained within your womb.");
				if (silly()) outputText("  <b>Your vagina has become a universe unto itself, capable of accepting colossal insertions beyond the scope of human comprehension!</b>");
				else outputText("  <b>Your vagina is now capable of accepting even the most ludicrously sized insertions with no ill effects.</b>");
				player.changeStatusValue(StatusEffects.BonusVCapacity, 1, 8000);
				changes++;
			}


			//**********************
			//BIG APPEARANCE CHANGES
			//**********************
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//[Grow Fox Tail]
			if (player.tailType != TAIL_TYPE_FOX && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0))) {
				//if PC has no tail
				if (player.tailType == TAIL_TYPE_NONE) {
					outputText("\n\nA pressure builds on your backside.  You feel under your " + player.armorName + " and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it has a mind of its own.  <b>You now have a fox-tail.</b>");
				}
				//if PC has another type of tail
				else if (player.tailType != TAIL_TYPE_FOX) {
					outputText("\n\nPain lances through your lower back as your tail shifts and twitches violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox-tail.</b>");
				}
				player.tailType = TAIL_TYPE_FOX;
				player.tailVenom = 1;
				changes++;
			}
			if (!mystic && player.earType == EARS_FOX && player.tailType == TAIL_TYPE_FOX && player.tailVenom == 8 && rand(3) == 0) {
				outputText("\n\nYou have the feeling that if you could grow a ninth tail you would be much more powerful, but you would need to find a way to enhance one of these gems or meditate with one to have a chance at unlocking your full potential.");
			}
			//[Grow Addtl. Fox Tail]
			//(rare effect, up to max of 8 tails, requires PC level and int*10 = number of tail to be added)
			else if (player.tailType == TAIL_TYPE_FOX && player.tailVenom < 8 && player.tailVenom + 1 <= player.level && player.tailVenom + 1 <= player.inte / 10 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				//if PC has 1 fox tail
				if (player.tailVenom == 1) {
					outputText("\n\nA tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail splits into two!  <b>You now have a pair of fox-tails.</b>");
					//increment tail by 1
				}
				//else if PC has 2 or more fox tails
				else {
					outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailVenom + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailVenom + 1) + " fox-tails.</b>");
					//increment tail by 1
				}
				player.tailVenom++;
				changes++;
			}
			//[Grow 9th tail and gain Corrupted Nine-tails perk]
			else if (mystic && rand(4) == 0 && changes < changeLimit && player.tailType == TAIL_TYPE_FOX && player.tailVenom == 8 && player.level >= 9 && player.earType == EARS_FOX && player.inte >= 90 && player.findPerk(PerkLib.CorruptedNinetails) < 0 && (player.findPerk(PerkLib.EnlightenedNinetails) < 0 || player.perkv4(PerkLib.EnlightenedNinetails) > 0)) {
				outputText("Your bushy tails begin to glow with an eerie, ghostly light, and with a crackle of electrical energy, split into nine tails.  <b>You are now a nine-tails!  But something is wrong...  The cosmic power radiating from your body feels...  tainted somehow.  The corruption pouring off your body feels...  good.</b>");
				outputText("\n\nYou have the inexplicable urge to set fire to the world, just to watch it burn.  With your newfound power, it's a goal that is well within reach.");
				outputText("\n\n(Perk Gained: Corrupted Nine-tails - Grants two magical special attacks.)");
				player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
				dynStats("lib", 2, "lus", 10, "cor", 10);
				player.tailVenom = 9;
				changes++;
			}

			//[Grow Fox Ears]
			if (player.tailType == TAIL_TYPE_FOX && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0)) && player.earType != EARS_FOX && changes < changeLimit) {
				//if PC has non-animal ears
				if (player.earType == EARS_HUMAN) outputText("\n\nThe sides of your face painfully stretch as your ears morph and begin to migrate up past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  You now have fox ears.");
				//if PC has animal ears
				else outputText("\n\nYour ears change shape, shifting from their current shape to become vulpine in nature.  You now have fox ears.");
				player.earType = EARS_FOX;
				changes++;
			}
			//[Change Hair Color: Golden-blonde, SIlver Blonde, White, Black, Red]
			if (((mystic && rand(2) == 0) || (!mystic && rand(4) == 0)) && changes < changeLimit && !InCollection(player.hairColor, KitsuneScene.basicKitsuneHair) && !InCollection(player.hairColor, KitsuneScene.elderKitsuneColors)) {
				if (player.tailType == TAIL_TYPE_FOX && player.tailVenom == 9) player.hairColor = randomChoice(KitsuneScene.elderKitsuneColors);
				else player.hairColor = randomChoice(KitsuneScene.basicKitsuneHair);
				outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand, pulling it forward to check it.  Your hair has become the same " + player.hairColor + " as a kitsune's!");
				changes++;
			}
			var tone:Array = mystic ? ["dark", "ebony", "ashen", "sable", "milky white"] : ["tan", "olive", "light"];
			//[Change Skin Type: remove fur or scales, change skin to Tan, Olive, or Light]
			var theFurColor:String = player.furColor;
			if (player.hasFur() && player.underBody.type == UNDER_BODY_TYPE_FURRY && player.furColor != player.underBody.skin.furColor)
				theFurColor = player.furColor + " and " + player.underBody.skin.furColor;

			if ((player.hasFur() 
					&& player.faceType != FACE_FOX
					&& !InCollection(theFurColor, convertMixedToStringArray(KitsuneScene.basicKitsuneFur))
					&& !InCollection(theFurColor, KitsuneScene.elderKitsuneColors)
					&& !InCollection(theFurColor, ["orange and white", "black and white", "red and white", "tan", "brown"])
					)
				|| player.hasScales() && ((mystic) || (!mystic && rand(2) == 0))) {
				outputText("\n\nYou begin to tingle all over your [skin], starting as a cool, pleasant sensation but gradually worsening until you are furiously itching all over.");
				if (player.hasFur()) outputText("  You stare in horror as you pull your fingers away holding a handful of " + player.furColor + " fur!  Your fur sloughs off your body in thick clumps, falling away to reveal patches of bare, " + player.skinTone + " skin.");
				else if (player.hasScales()) outputText("  You stare in horror as you pull your fingers away holding a handful of dried up scales!  Your scales continue to flake and peel off your skin in thick patches, revealing the tender " + player.skinTone + " skin underneath.");
				outputText("  Your skin slowly turns raw and red under your severe scratching, the tingling sensations raising goosebumps across your whole body.  Over time, the itching fades, and your flushed skin resolves into a natural-looking ");
				player.skinType = SKIN_TYPE_PLAIN;
				player.skinAdj = "";
				player.skinDesc = "skin";
				player.underBody.restore();
				if (!InCollection(player.skinTone, tone)) player.skinTone = randomChoice(tone);
				outputText(player.skinTone + " complexion.");
				outputText("  <b>You now have [skin]!</b>");
				updateClaws(player.clawType);
				changes++;
			}
			//Change skin tone if not changed you!
			else if (!InCollection(player.skinTone, tone) && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				outputText("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  Holding an arm up to your face, you discover that <b>you now have ");
				player.skinTone = randomChoice(tone);
				outputText("[skin]!</b>");
				updateClaws(player.clawType);
				changes++;
			}
			//[Change Skin Color: add "Tattoos"]
			//From Tan, Olive, or Light skin tones
			else if (9999 == 0 && InCollection(player.skinTone, tone) && changes < changeLimit) {
				outputText("You feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing tribal tattoos adorns your [skin].  The glow gradually fades, but the distinctive ");
				if (mystic) outputText("angular");
				else outputText("curved");
				outputText(" markings remain, as if etched into your skin.");
				changes++;
				//9999 - pending tats system
			}
			//Nipples Turn Back:
			if (!player.hasFur() && player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + player.nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (!player.hasFur() && changes < changeLimit && rand(3) == 0 && player.vaginaType() == 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			// Kitsunes should have normal arms and legs. exspecially skinny arms with claws are somewhat weird (Stadler76).
			if (player.hasPlainSkin() && rand(4) == 0) restoreArms(tfSource);
			if (player.hasPlainSkin() && rand(4) == 0) restoreLegs(tfSource);

			if (changes == 0) {
				outputText("\n\nOdd.  You don't feel any different.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}

		/**
		 * Changes shared by succubi milk and incubi draft
		 * @param	player affected by the mutation
		 */
		private function demonChanges(player:Player):void
		{
			//Change tail if already horned.
			if (player.tailType != TAIL_TYPE_DEMONIC && player.horns > 0) {
				if (player.tailType != TAIL_TYPE_NONE) {
					outputText("\n\n");
					if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.tailType == TAIL_TYPE_BEE_ABDOMEN) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ");
					else outputText("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ");
					outputText("<b>Your tail is now demonic in appearance.</b>");
				}
				else outputText("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.");
				dynStats("cor", 4);
				player.tailType = TAIL_TYPE_DEMONIC;
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//grow horns!
			if (player.horns == 0 || (rand(player.horns + 3) == 0)) {
				if (player.horns < 12 && (player.hornType == HORNS_NONE || player.hornType == HORNS_DEMON)) {
					outputText("\n\n");
					if (player.horns == 0) {
						outputText("A small pair of demon horns erupts from your forehead.  They actually look kind of cute.  <b>You have horns!</b>");
					}
					else outputText("Another pair of demon horns, larger than the last, forms behind the first row.");
					if (player.hornType == HORNS_NONE) player.hornType = HORNS_DEMON;
					player.horns++;
					player.horns++;
					dynStats("cor", 3);
				}
				//Text for shifting horns
				else if (player.hornType > HORNS_DEMON) {
					outputText("\n\n");
					outputText("Your horns shift, shrinking into two small demonic-looking horns.");
					player.horns = 2;
					player.hornType = HORNS_DEMON;
					dynStats("cor", 3);
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && rand(3) == 0) {
				outputText("\n\nSomething invisible brushes against your " + player.nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				player.removeStatusEffect(StatusEffects.BlackNipples);
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//remove fur
			if ((player.faceType != FACE_HUMAN || !player.hasPlainSkin()) && rand(3) == 0) {
				//Remove face before fur!
				if (player.faceType != FACE_HUMAN) {
					outputText("\n\n");
					outputText("Your visage twists painfully, returning to a more normal human shape, albeit with flawless skin.  <b>Your face is human again!</b>");
					player.faceType = FACE_HUMAN;
				}
				//De-fur
				else if (!player.hasPlainSkin()) {
					outputText("\n\n");
					if (player.hasFur()) outputText("Your skin suddenly feels itchy as your fur begins falling out in clumps, <b>revealing inhumanly smooth skin</b> underneath.");
					if (player.hasScales()) outputText("Your scales begin to itch as they begin falling out in droves, <b>revealing your inhumanly smooth " + player.skinTone + " skin</b> underneath.");
					player.skinType = SKIN_TYPE_PLAIN;
					player.skinDesc = "skin";
					player.underBody.restore();
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//Demon tongue
			if (player.tongueType == TONGUE_SNAKE && rand(3) == 0) {
				outputText("\n\nYour snake-like tongue tingles, thickening in your mouth until it feels more like your old human tongue, at least for the first few inches.  It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>");
				player.tongueType = TONGUE_DEMONIC;
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//foot changes - requires furless
			if (player.hasPlainSkin() && rand(4) == 0) {
				//Males/genderless get clawed feet
				if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
					if (player.lowerBody != LOWER_BODY_TYPE_DEMONIC_CLAWS) {
						outputText("\n\n");
						outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>");
						player.lowerBody = LOWER_BODY_TYPE_DEMONIC_CLAWS;
						player.legCount = 2;
					}
				}
				//Females/futa get high heels
				else if (player.lowerBody != LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS) {
					outputText("\n\n");
					outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horn protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.");
					player.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
					player.legCount = 2;
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			//Grow demon wings
			if ((player.wingType != WING_TYPE_BAT_LIKE_LARGE || player.rearBody.type == REAR_BODY_SHARK_FIN) && rand(8) == 0 && player.cor >= (50 - player.corruptionTolerance())) {
				//grow smalls to large
				if (player.wingType == WING_TYPE_BAT_LIKE_TINY && player.cor >= (75 - player.corruptionTolerance())) {
					outputText("\n\n");
					outputText("Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>");
					player.wingType = WING_TYPE_BAT_LIKE_LARGE;
				}
				else if (player.rearBody.type == REAR_BODY_SHARK_FIN) {
					outputText("\n\nThe muscles around your shoulders bunch up uncomfortably, changing to support the new bat-like wings growing from"
					          +" your back.  You twist your head as far as you can for a look"
					          +" and realize your fin has changed into small bat-like demon-wings!");
					player.rearBody.restore();
					player.wingType = WING_TYPE_BAT_LIKE_TINY;
				}
				//No wings
				else if (player.wingType == WING_TYPE_NONE) {
					outputText("\n\n");
					outputText("A knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your " + player.armorName + ".  <b>You now have tiny demonic wings</b>.");
					player.wingType = WING_TYPE_BAT_LIKE_TINY;
				}
				//Other wing types
				else {
					outputText("\n\n");
					outputText("The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing.  You twist your head as far as you can for a look and realize they've changed into ");
					if ([WING_TYPE_BEE_LIKE_SMALL, WING_TYPE_HARPY, WING_TYPE_IMP, WING_TYPE_DRACONIC_SMALL].indexOf(player.wingType) != -1) {
						outputText("small ");
						player.wingType = WING_TYPE_BAT_LIKE_TINY;
					}
					else {
						outputText("large ");
						player.wingType = WING_TYPE_BAT_LIKE_LARGE;
					}
					outputText("<b>bat-like demon-wings!</b>");
				}
				flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
		}
		
		public function pigTruffle(boar:Boolean, player:Player):void
		{
			var tfSource:String = "pigTruffle";
			if (boar) tfSource += "-boar";
			changes = 0;
			changeLimit = 1;
			var temp:int = 0;
			var x:int = 0;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (boar) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			outputText("You take a bite into the pigtail truffle. It oddly tastes like bacon. You eventually finish eating. ");
			player.refillHunger(20);
			//-----------------------
			// SIZE MODIFICATIONS
			//-----------------------
			//Increase thickness
			if (rand(3) == 0 && changes < changeLimit && player.thickness < 75) {
				outputText(player.modThickness(75, 3));
				changes++;
			}
			//Decrease muscle tone
			if (rand(3) == 0 && changes < changeLimit && player.gender >= 2 && player.tone > 20) {
				outputText(player.modTone(20, 4));
				changes++;
			}
			//Increase hip rating
			if (rand(3) == 0 && changes < changeLimit && player.gender >= 2 && player.hipRating < 15) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening " + player.hipDescript() + ". The change is subtle, but they're definitely broader.");
				player.hipRating++;
				changes++;
			}
			//Increase ass rating
			if (rand(3) == 0 && changes < changeLimit && player.buttRating < 12) {
				outputText("\n\nWhen you stand back, up your [ass] jiggles with a good bit of extra weight.");
				player.buttRating++;
				changes++;
			}
			//Increase ball size if you have balls.
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0 && player.ballSize < 4) {
				if (player.ballSize < 3)
					outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + (player.balls == 4 ? "quartette" : "duo") + " of [balls] have grown larger than a human’s.");
				else
					outputText("\n\nA sudden onset of heat envelops your groin, focusing on your ballsack. Walking becomes difficult as you discover your " + (player.balls == 4 ? "quartette" : "duo") + " of testicles have enlarged again.");
				player.ballSize++;
				changes++;
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) updateOvipositionPerk(tfSource);
			//-----------------------
			// TRANSFORMATIONS
			//-----------------------
			//Gain pig cock, independent of other pig TFs.
			if (rand(4) == 0 && changes < changeLimit && player.cocks.length > 0 && player.cocks[0].cockType != CockTypesEnum.PIG) {
				if (player.cocks.length == 1) { //Single cock
					outputText("\n\nYou feel an uncomfortable pinching sensation in your [cock]. " + player.clothedOrNakedLower("You pull open your [armor]", "You look down at your exposed groin") + ", watching as it warps and changes. As the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[0].cockType = CockTypesEnum.PIG;
				}
				else { //Multiple cocks
					outputText("\n\nYou feel an uncomfortable pinching sensation in one of your cocks. You pull open your [armor], watching as it warps and changes. As the transformation completes, you’re left with a shiny pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[rand(player.cocks.length+1)].cockType = CockTypesEnum.PIG;
				}
				changes++;
			}
			//Gain pig ears!
			if (rand(boar ? 3 : 4) == 0 && changes < changeLimit && player.earType != EARS_PIG) {
				outputText("\n\nYou feel a pressure on your ears as they begin to reshape. Once the changes finish, you flick them about experimentally, <b>and you’re left with pointed, floppy pig ears.</b>");
				player.earType = EARS_PIG;
				changes++;
			}
			//Gain pig tail if you already have pig ears!
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.earType == EARS_PIG && player.tailType != TAIL_TYPE_PIG) {
				if (player.tailType > 0) //If you have non-pig tail.
					outputText("\n\nYou feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>");
				else //If you don't have a tail. 
					outputText("\n\nYou feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>");
				player.tailType = TAIL_TYPE_PIG;
				changes++;
			}
			//Gain pig tail even when centaur, needs pig ears.
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.earType == EARS_PIG && player.tailType != TAIL_TYPE_PIG && player.isTaur() && (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_PONY)) {
				outputText("\n\nThere is a tingling in your [tail] as it begins to warp and change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b> This new, mismatched tail looks a bit odd on your horse lower body.");
				player.tailType = TAIL_TYPE_PIG;
				changes++;
			}
			//Turn your lower body into pig legs if you have pig ears and tail.
			if (rand(boar ? 3 : 4) == 0 && changes < changeLimit && player.earType == EARS_PIG && player.tailType == TAIL_TYPE_PIG && player.lowerBody != LOWER_BODY_TYPE_CLOVEN_HOOFED) {
				if (player.isTaur()) //Centaur
					outputText("\n\nYou scream in agony as a horrible pain racks your entire bestial lower half. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the animal's lower body. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>");
				else if (player.lowerBody == LOWER_BODY_TYPE_NAGA) //Naga
					outputText("\n\nYou scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>");
				else //Bipedal
					outputText("\n\nYou scream in agony as the bones in your legs break and rearrange. Once the pain subsides, you inspect your legs, finding that they are digitigrade and ending in cloven hooves. <b>You now have pig legs!</b>");
				player.lowerBody = LOWER_BODY_TYPE_CLOVEN_HOOFED;
				player.legCount = 2;
				changes++;
			}
			//Gain pig face when you have the first three pig TFs.
			if (rand(boar ? 2 : 3) == 0 && changes < changeLimit && player.earType == EARS_PIG && player.tailType == TAIL_TYPE_PIG && player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED && (player.faceType != FACE_PIG && player.faceType != FACE_BOAR)) {
				outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new pig face!</b>");
				player.faceType = FACE_PIG;
				changes++;
			}
			//Gain boar face if you have pig face.
			if (rand(3) == 0 && changes < changeLimit && player.earType == EARS_PIG && player.tailType == TAIL_TYPE_PIG && player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED && player.faceType == FACE_PIG) {
				outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. Your bottom teeth ache as well. What’s happening to you? As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new tusky boar face!</b>");
				player.faceType = FACE_BOAR;
				changes++;
			}
			//Change skin colour
			if (rand(boar ? 3 : 4) == 0 && changes < changeLimit) {
				var skinChoose:int = rand(3);
				var skinToBeChosen:String = "pink";
				if (boar) {
					if (skinChoose == 0) skinToBeChosen = "dark brown";
					else skinToBeChosen = "brown";
				}
				else {
					if (skinChoose == 0) skinToBeChosen = "pink";
					else if (skinChoose == 1) skinToBeChosen = "tan";
					else skinToBeChosen = "sable";
				}
				outputText("\n\nYour skin tingles ever so slightly as you skin’s color changes before your eyes. As the tingling diminishes, you find that your skin has turned " + skinToBeChosen + ".");
				player.skinTone = skinToBeChosen;
				updateClaws(player.clawType);
				kGAMECLASS.rathazul.addMixologyXP(20);
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nOddly, you do not feel any changes. Perhaps you're lucky? Or not.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function winterPudding(player:Player, returnToBakery:Boolean = false):void
		{
			var tfSource:String = "winterPudding";
			changes = 0;
			changeLimit = 2;
			outputText("You stuff the stodgy pudding down your mouth, the taste of brandy cream sauce and bitter black treacle sugar combining in your mouth.  You can tell by its thick spongy texture that it's far from good for you, so its exclusivity is more than likely for the best.");
			player.refillHunger(30);
			if (player.thickness < 100 || player.tone > 0) {
				//outputText("\n\nYou feel your waist protrude slightly.  Did you just put on a little weight?  It sure looks like it.");
				outputText(player.modTone(0,2));
				outputText(player.modThickness(100,2));
			}
			outputText("\n\nYou lick your lips clean, savoring the taste of the Winter Pudding.  You feel kinda antsy...");
			//[Decrease player tone by 5, Increase Lust by 20, Destroy item.]
			dynStats("lus", (10+player.lib/10), "resisted", false);
			
			//[Optional, give the player antlers! (30% chance) Show this description if the player doesn't have horns already.]
			if (player.horns == 0 && rand(2) == 0) {
				outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree.  Investigating the exotic additions sprouting from your head, the situation becomes clear.  <b>You've grown antlers!</b>");
				//[Player horn type changed to Antlers.]
				player.hornType = HORNS_ANTLERS;
				player.horns = 4 + rand(12);
				changes++;
			}
			//[Show this description instead if the player already had horns when the transformation occurred.] 
			else if (player.horns > 0 && player.hornType != HORNS_ANTLERS && rand(2) == 0) {
				outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else.  Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained antlers!</b>");
				//[Player horn type changed to Antlers.]
				player.hornType = HORNS_ANTLERS;
				player.horns = 4 + rand(12);
				changes++;
			}
			if (rand(5) == 0) updateOvipositionPerk(tfSource); // I doubt, that winterPudding will ever be affected, but well ... just in case
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			if (returnToBakery) {
				doNext(kGAMECLASS.telAdre.bakeryScene.bakeryuuuuuu);
				return;
			}
		}
		
		public function prisonBread(player:Player):void {
			prison.prisonItemBread(false);
		}
		
		public function prisonCumStew(player:Player):void {
			prison.prisonItemBread(true);
		}
	}
}
