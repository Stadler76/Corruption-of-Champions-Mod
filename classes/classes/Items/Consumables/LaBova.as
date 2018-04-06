package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;
	import classes.VaginaClass;

	/**
	 * @since March 31, 2018
	 * @author Stadler76
	 */
	public class LaBova extends Consumable 
	{
		public static const STANDARD:int = 0;
		public static const ENHANCED:int = 1;
		public static const PURIFIED:int = 2;

		private var tainted:Boolean = false;
		private var enhanced:Boolean = false;

		public function LaBova(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			switch (type) {
				case STANDARD:
					id = "LaBova";
					shortName = "La Bova";
					longName = 'a bottle containing a misty fluid labeled "LaBova"';
					description = "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base."
					             +" The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.";
					value = ConsumableLib.DEFAULT_VALUE;
					tainted = true;
					enhanced = false;
					break;

				case ENHANCED:
					id = "ProBova";
					shortName = "ProBova";
					longName = 'a bottle containing a misty fluid labeled "ProBova"';
					description = "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.";
					value = ConsumableLib.DEFAULT_VALUE;
					tainted = true;
					enhanced = true;
					break;

				case PURIFIED:
					id = "P.LBova";
					shortName = "P.LBova";
					longName = 'a bottle containing a white fluid labeled "Pure LaBova"';
					description = "A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base."
					             +" The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off."
					             +" It has been purified by Rathazul.";
					value = ConsumableLib.DEFAULT_VALUE;
					tainted = false;
					enhanced = false;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		public function applyEffect(player:Player):Boolean
		{
			var tfSource:String = "laBova";
			player.slimeFeed();
			mutations.initTransformation([2, 3, 3], enhanced ? 3 : 1);
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
			if (changes < changeLimit && rand(3) === 0) {
				temp = 60 - player.str;
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) === 0) outputText("\n\nThere is a slight pain as you feel your muscles shift somewhat.  Their appearance does not change much, but you feel much stronger.");
					else outputText("\n\nYou feel your muscles tighten and clench as they become slightly more pronounced.");
					dynStats("str", temp / 10);
				}
			}
			//Increase player tou:
			if (changes < changeLimit && rand(3) === 0) {
				temp = 60 - player.tou;
				if (temp <= 0) temp = 0;
				else {
					if (rand(2) === 0) outputText("\n\nYou feel your insides toughening up; it feels like you could stand up to almost any blow.");
					else outputText("\n\nYour bones and joints feel sore for a moment, and before long you realize they've gotten more durable.");
					dynStats("tou", temp / 10);

				}
			}
			//Decrease player spd if it is over 30:
			if (changes < changeLimit && rand(3) === 0) {
				if (player.spe100 > 30) {
					outputText("\n\nThe body mass you've gained is making your movements more sluggish.");
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
			if (player.cocks.length > 0 && rand(2) === 0 && !flags[kFLAGS.HYPER_HAPPY]) {
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
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
					player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
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
			if (((tainted && player.biggestTitSize() <= 11) || (!tainted && player.biggestTitSize() <= 5)) && changes < changeLimit && (rand(3) === 0 || enhanced)) {
				if (rand(2) === 0) outputText("\n\nYour " + player.breastDescript(0) + " tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your " + player.breastDescript(0) + " seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				dynStats("sen", .5);
				boobsGrew = true;
			}
			//Remove feathery hair
			mutations.removeFeatheryHair();
			//If breasts are D or bigger and are not lactating, they also start lactating:
			if (player.biggestTitSize() >= 4 && player.breastRows[0].lactationMultiplier < 1 && changes < changeLimit && (rand(3) === 0 || boobsGrew || enhanced)) {
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
					if (rand(2) === 0) outputText("\n\nA wave of pleasure passes through your chest as your " + player.breastDescript(0) + " start leaking milk from a massive jump in production.");
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
				if (tainted && player.breastRows[0].lactationMultiplier > 1 && player.breastRows[0].lactationMultiplier < 5 && changes < changeLimit && (rand(3) === 0 || enhanced)) {
					if (rand(2) === 0) outputText("\n\nA wave of pleasure passes through your chest as your " + player.breastDescript(0) + " start producing more milk.");
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
					if (player.breastRows[0].lactationMultiplier > 1 && player.breastRows[0].lactationMultiplier < 3.2 && changes < changeLimit && rand(3) === 0) {
						if (rand(2) === 0) outputText("\n\nA wave of pleasure passes through your chest as your " + player.breastDescript(0) + " start producing more milk.");
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
						if (rand(2) === 0) outputText("\n\nYour breasts suddenly feel less full, it seems you aren't lactating at quite the level you were.");
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
			if (!player.hasStatusEffect(StatusEffects.Feeder) && player.biggestLactation() >= 3 && rand(2) === 0 && player.biggestTitSize() >= 5 && player.isCorruptEnough(35)) {
				outputText("\n\nYou start to feel a strange desire to give your milk to other creatures.  For some reason, you know it will be very satisfying.\n\n<b>(You have gained the 'Feeder' perk!)</b>");
				player.createStatusEffect(StatusEffects.Feeder, 0, 0, 0, 0);
				player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
				changes++;
			}
			//UNFINISHED
			//If player has addictive quality and drinks pure version, removes addictive quality.
			//if the player has a vagina and it is tight, it loosens.
			if (player.hasVagina()) {
				if (player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE && changes < changeLimit && rand(2) === 0) {
					outputText("\n\nYou feel a relaxing sensation in your groin.  On further inspection you discover your " + player.vaginaDescript(0) + " has somehow relaxed, permanently loosening.");
					player.vaginas[0].vaginalLooseness++;
					player.vaginas[0].resetRecoveryProgress();
					player.vaginas[0].vaginalLooseness++;
					changes++;
					dynStats("lus", 10);
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
			if (tainted && rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//General Appearance (Tail -> Ears -> Paws(fur stripper) -> Face -> Horns
			//Give the player a bovine tail, same as the minotaur
			if (tainted && player.tail.type !== Tail.COW && changes < changeLimit && rand(3) === 0) {
				if (player.tail.type == Tail.NONE) outputText("\n\nYou feel the flesh above your " + player.buttDescript() + " knotting and growing.  It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				else {
					if (player.tail.type < Tail.SPIDER_ABDOMEN || player.tail.type > Tail.BEE_ABDOMEN) {
						outputText("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
					}
					//insect
					if (player.tail.type == Tail.SPIDER_ABDOMEN || player.tail.type == Tail.BEE_ABDOMEN) {
						outputText("\n\nYour insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.");
					}
				}
				player.tail.type = Tail.COW;
				changes++;
			}
			//Give the player bovine ears, same as the minotaur
			if (tainted && player.ears.type !== Ears.COW && changes < changeLimit && rand(4) === 0 && player.tail.type == Tail.COW) {
				outputText("\n\nYou feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like.  <b>You now have cow ears.</b>");
				player.ears.type = Ears.COW;
				changes++;
			}
			//If the player is under 7 feet in height, increase their height, similar to the minotaur
			if (((enhanced && player.tallness < 96) || player.tallness < 84) && changes < changeLimit && rand(2) === 0) {
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
			if (tainted && player.lowerBody.type !== LowerBody.HOOFED && player.ears.type == Ears.COW) {
				if (changes < changeLimit && rand(3) === 0) {
					changes++;
					if (player.lowerBody.type == LowerBody.HUMAN) outputText("\n\nYou stagger as your feet change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					else if (player.lowerBody.type == LowerBody.DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					else if (player.lowerBody.type == LowerBody.NAGA) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
					//Catch-all
					else if (player.lowerBody.type > LowerBody.NAGA) outputText("\n\nYou stagger as your " + player.feet() + " change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
					outputText("  A coat of beastial fur springs up below your waist, itching as it fills in.<b>  You now have hooves in place of your feet!</b>");
					player.lowerBody.type = LowerBody.HOOFED;
					player.lowerBody.legCount = 2;
					dynStats("cor", 0);
					changes++;
				}
			}
			//If the player's face is non-human, they gain a human face
			if (!enhanced && player.lowerBody.type == LowerBody.HOOFED && player.face.type !== Face.HUMAN && changes < changeLimit && rand(4) === 0) {
				//Remove face before fur!
				outputText("\n\nYour visage twists painfully, returning to a normal human shape.  <b>Your face is human again!</b>");
				player.face.type = Face.HUMAN;
				changes++;
			}
			//enhanced get shitty fur
			if (enhanced && (player.skin.desc !== "fur" || player.skin.furColor !== "black and white spotted")) {
				if (player.skin.desc !== "fur") outputText("\n\nYour " + player.skin.desc + " itches intensely.  You scratch and scratch, but it doesn't bring any relief.  Fur erupts between your fingers, and you watch open-mouthed as it fills in over your whole body.  The fur is patterned in black and white, like that of a cow.  The color of it even spreads to your hair!  <b>You have cow fur!</b>");
				else outputText("\n\nA ripple spreads through your fur as some patches darken and others lighten.  After a few moments you're left with a black and white spotted pattern that goes the whole way up to the hair on your head!  <b>You've got cow fur!</b>");
				player.skin.desc = "fur";
				player.skin.adj = "";
				player.skin.type = Skin.FUR;
				player.hair.color = "black and white spotted";
				player.skin.furColor = player.hair.color;
				player.underBody.restore(); // Restore the underbody for now
			}
			//if enhanced to probova give a shitty cow face
			else if (enhanced && player.face.type !== Face.COW_MINOTAUR) {
				outputText("\n\nYour visage twists painfully, warping and crackling as your bones are molded into a new shape.  Once it finishes, you reach up to touch it, and you discover that <b>your face is like that of a cow!</b>");
				player.face.type = Face.COW_MINOTAUR;
				changes++;
			}
			//Give the player bovine horns, or increase their size, same as the minotaur
			//New horns or expanding mino horns
			if (tainted && changes < changeLimit && rand(3) === 0 && player.face.type == Face.HUMAN) {
				//Get bigger or change horns
				if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.NONE) {
					//Get bigger if player has horns
					if (player.horns.type == Horns.COW_MINOTAUR) {
						if (player.horns.value < 5) {
							//Fems horns don't get bigger.
							outputText("\n\nYour small horns get a bit bigger, stopping as medium sized nubs.");
							player.horns.value += 1 + rand(2);
							changes++;
						}
					}
					//If no horns yet..
					if (player.horns.type == Horns.NONE || player.horns.value == 0) {
						outputText("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.");
						player.horns.type = Horns.COW_MINOTAUR;
						player.horns.value = 1;
						changes++;
					}
					//TF other horns
					if (player.horns.type !== Horns.NONE && player.horns.type !== Horns.COW_MINOTAUR && player.horns.value > 0) {
						outputText("\n\nYour horns twist, filling your skull with agonizing pain for a moment as they transform into cow-horns.");
						player.horns.type = Horns.COW_MINOTAUR;
					}
				}
				//Not mino horns, change to cow-horns
				if (player.horns.type == Horns.DEMON || player.horns.type > Horns.COW_MINOTAUR) {
					outputText("\n\nYour horns vibrate and shift as if made of clay, reforming into two small bovine nubs.");
					player.horns.type = Horns.COW_MINOTAUR;
					player.horns.value = 2;
					changes++;
				}
			}
			//Increase the size of the player's hips, if they are not already childbearing or larger
			if (rand(2) === 0 && player.hips.rating < 15 && changes < changeLimit) {
				if (!tainted && player.hips.rating < 8 || tainted) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hips.rating += 1 + rand(4);
					changes++;
				}
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}

			//Increase the size of the player's ass (less likely then hips), if it is not already somewhat big
			if (rand(2) === 0 && player.butt.rating < 13 && changes < changeLimit) {
				if (!tainted && player.butt.rating < 8 || tainted) {
					outputText("\n\nA sensation of being unbalanced makes it difficult to walk.  You pause, paying careful attention to your new center of gravity before understanding dawns on you - your ass has grown!");
					player.butt.rating += 1 + rand(2);
					changes++;
				}
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) === 0) {
				mutations.removeBlackNipples(tfSource);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) === 0 && player.vaginaType() == 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (rand(3) === 0) outputText(player.modFem(79, 3));
			if (rand(3) === 0) outputText(player.modThickness(70, 4));
			if (rand(5) === 0) outputText(player.modTone(10, 5));
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}

		override public function useItem():Boolean
		{
			return applyEffect(player);
		}
	}
}
