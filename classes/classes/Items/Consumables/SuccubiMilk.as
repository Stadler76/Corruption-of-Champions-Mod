package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.VaginaClass;

	/**
	 * @since March 31, 2018
	 * @author Stadler76
	 */
	public class SuccubiMilk extends Consumable 
	{
		public static const TAINTED:int  = 0;
		public static const PURIFIED:int = 1;

		private var tainted:Boolean;

		public function SuccubiMilk(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			tainted = type === TAINTED;

			switch (type) {
				case TAINTED:
					id = "SucMilk";
					shortName = "SucMilk";
					longName = "a bottle of Succubi milk";
					description = 'This milk-bottle is filled to the brim with a creamy white milk of dubious origin.'
					             +' A pink label proudly labels it as "<i>Succubi Milk</i>".'
					             +' In small text at the bottom of the label it reads: "<i>To bring out the succubus in YOU!</i>"';
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case PURIFIED:
					id = "P.S.Mlk";
					shortName = "P.S.Mlk";
					longName = "";
					description = 'This milk-bottle is filled to the brim with a creamy white milk of dubious origin.'
					             +' A pink label proudly labels it as "<i>Succubi Milk</i>".'
					             +' In small text at the bottom of the label it reads: "<i>To bring out the succubus in YOU!</i>"'
					             +' Purified by Rathazul to prevent corruption.';
					value = 20;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "succubiMilk";
			if (!tainted) tfSource += "-purified";
			var temp:int;
			player.slimeFeed();
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = rand(100);
			if (player.hasPerk(PerkLib.HistoryAlchemist)) rando += 10;
			if (player.hasPerk(PerkLib.TransformationResistance)) rando -= 10;
			clearOutput();
			if (player.cor < 35) outputText("You wonder why in the gods' names you would drink such a thing, but you have to admit, it is the best thing you have ever tasted.");
			if (player.cor >= 35 && player.cor < 70) {
				outputText("You savor the incredible flavor as you greedily gulp it down.");
				if (player.gender == 2 || player.gender == 3) {
					outputText("  The taste alone makes your " + player.vaginaDescript(0) + " feel ");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("tingly.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("wet.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("sloppy and wet.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("sopping and juicy.");
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("dripping wet.");
				}
				else if (player.hasCock()) outputText("  You feel a building arousal, but it doesn't affect your cock.");
			}
			if (player.cor >= 70) {
				outputText("You pour the milk down your throat, chugging the stuff as fast as you can.  You want more.");
				if (player.gender == 2 || player.gender == 3) {
					outputText("  Your " + player.vaginaDescript(0));
					if (player.vaginas.length > 1) outputText(" quiver in orgasm, ");
					if (player.vaginas.length == 1) outputText(" quivers in orgasm, ");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("becoming slightly sticky.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("leaving your undergarments sticky.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("wet with girlcum.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("staining your undergarments with cum.");
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("leaving cunt-juice trickling down your leg.");
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLAVERING) outputText("spraying your undergarments liberally with slick girl-cum.");
					player.orgasm('Vaginal');
				}
				else if (player.gender !== 0) {
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
					if (player.breastRows[0].breastRating < 2 && rand(3) === 0) temp++;
					if (player.breastRows[0].breastRating < 5 && rand(4) === 0) temp++;
					if (player.breastRows[0].breastRating < 6 && rand(5) === 0) temp++;
				}
				outputText("\n\n");
				player.growTits(temp, player.breastRows.length, true, 3);
				if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
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
			if (player.vaginas.length == 0 && (rand(3) === 0 || (rando > 75 && rando < 90))) {
				player.createVagina();
				player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
				player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
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
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) {
						if (player.vaginas.length == 1) outputText("Your " + player.vaginaDescript(0) + " gushes fluids down your leg as you spontaneously orgasm.");
						else outputText("Your " + player.vaginaDescript(0) + "s gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
						player.orgasm('Vaginal');
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) {
						if (player.vaginas.length == 1) outputText("Your pussy feels hot and juicy, aroused and tender.  You cannot resist as your hands dive into your " + player.vaginaDescript(0) + ".  You quickly orgasm, squirting fluids everywhere.  <b>You are now a squirter</b>.");
						if (player.vaginas.length > 1) outputText("Your pussies feel hot and juicy, aroused and tender.  You cannot resist plunging your hands inside your " + player.vaginaDescript(0) + "s.  You quiver around your fingers, squirting copious fluids over yourself and the ground.  The fluids quickly disappear into the dirt.");
						player.orgasm('Vaginal');
						if (tainted) dynStats("cor", 1);
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) {
						if (player.vaginas.length == 1) outputText("You feel a sudden trickle of fluid down your leg.  You smell it and realize it's your pussy-juice.  Your " + player.vaginaDescript(0) + " now drools lubricant constantly down your leg.");
						if (player.vaginas.length > 1) outputText("You feel sudden trickles of fluids down your leg.  You smell the stuff and realize it's your pussies-juices.  They seem to drool lubricant constantly down your legs.");
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) {
						outputText("You flush in sexual arousal as you realize how moist your cunt-lips have become.  Once you've calmed down a bit you realize they're still slick and ready to fuck, and always will be.");
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) {
						if (player.vaginas.length == 1) outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your " + player.vaginaDescript(0) + " felt much wetter than normal.");
						else outputText("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your " + player.vaginaDescript(0) + " were much wetter than normal.");
					}
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) {
						outputText("You feel a tingling in your crotch, but cannot identify it.");
					}
					temp = player.vaginas.length;
					while (temp > 0) {
						temp--;
						if (player.vaginas[temp].vaginalWetness < VaginaClass.WETNESS_SLAVERING) player.vaginas[temp].vaginalWetness++;
					}
				}
			}
			if (rando >= 90) {
				if (!tainted || player.skin.tone == "blue" || player.skin.tone == "purple" || player.skin.tone == "indigo" || player.skin.tone == "shiny black") {
					if (player.vaginas.length > 0) {
						outputText("\n\nYour heart begins beating harder and harder as heat floods to your groin.  You feel your clit peeking out from under its hood, growing larger and longer as it takes in more and more blood.");
						if (player.getClitLength() > 3 && !player.hasPerk(PerkLib.BigClit)) outputText("  After some time it shrinks, returning to its normal aroused size.  You guess it can't get any bigger.");
						if (player.getClitLength() > 5 && player.hasPerk(PerkLib.BigClit)) outputText("  Eventually it shrinks back down to its normal (but still HUGE) size.  You guess it can't get any bigger.");
						if (((player.hasPerk(PerkLib.BigClit)) && player.getClitLength() < 6)
							|| player.getClitLength() < 3) {
							temp = 2; // minimum growth
							if (player.hasPerk(PerkLib.BigClit)) temp += 2;
							player.changeClitLength((rand(4) + temp) / 10);
						}
						dynStats("sen", 3, "lus", 8);
					}
					else {
						player.createVagina();
						player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
						player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
						player.vaginas[0].virgin = true;
						player.setClitLength(.25);
						outputText("\n\nAn itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!");
					}
				}
				else {
					temp = rand(10);
					if (temp == 0) player.skin.tone = "shiny black";
					if (temp == 1 || temp == 2) player.skin.tone = "indigo";
					if (temp == 3 || temp == 4 || temp == 5) player.skin.tone = "purple";
					if (temp > 5) player.skin.tone = "blue";
					outputText("\n\nA tingling sensation runs across your skin in waves, growing stronger as <b>your skin's tone slowly shifts, darkening to become " + player.skin.tone + " in color.</b>");
					player.arms.updateClaws(player.arms.claws.type);
					if (tainted) dynStats("cor", 1);
					else dynStats("cor", 0);
					kGAMECLASS.rathazul.addMixologyXP(20);
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
			if (tainted) {
				outputText(player.modFem(100, 2));
				if (rand(3) === 0) outputText(player.modTone(15, 2));
			}
			else {
				outputText(player.modFem(90, 1));
				if (rand(3) === 0) outputText(player.modTone(20, 2));
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
