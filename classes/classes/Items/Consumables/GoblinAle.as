package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Goblin transformative item.
	 */
	public class GoblinAle extends Consumable 
	{
		public function GoblinAle() 
		{
			super("Gob.Ale","Gob.Ale", "a flagon of potent goblin ale", ConsumableLib.DEFAULT_VALUE, "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "goblinAle";
			player.slimeFeed();
			changes = 0;
			changeLimit = 1;
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (rand(4) === 0) changeLimit++;
			if (rand(5) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			clearOutput();
			outputText("You drink the ale, finding it to have a remarkably smooth yet potent taste.  You lick your lips and sneeze, feeling slightly tipsy.");
			dynStats("lus", 15);
			//Stronger
			if (player.str100 > 50) {
				dynStats("str", -1);
				if (player.str100 > 70) dynStats("str", -1);
				if (player.str100 > 90) dynStats("str", -2);
				outputText("\n\nYou feel a little weaker, but maybe it's just the alcohol.");
			}
			///Less tough
			if (player.tou100 > 50) {
				outputText("\n\nGiggling, you poke yourself, which only makes you giggle harder when you realize how much softer you feel.");
				dynStats("tou", -1);
				if (player.tou100 > 70) dynStats("tou", -1);
				if (player.tou100 > 90) dynStats("tou", -2);
			}
			//antianemone corollary:
			if (changes < changeLimit && player.hairType === 4 && rand(2) === 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nAs you down the potent ale, your head begins to feel heavier - and not just from the alcohol!  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels smooth, silky, and fibrous; you watch as it dissolves into many thin, hair-like strands.  <b>Your hair is now back to normal!</b>");
				player.hairType = HAIR_NORMAL;
				changes++;
			}
			//Shrink
			if (rand(2) === 0 && player.tallness > 48) {
				changes++;
				outputText("\n\nThe world spins, and not just from the strength of the drink!  Your viewpoint is closer to the ground.  How fun!");
				player.tallness -= (1 + rand(5));
			}
			//Speed boost
			if (rand(3) === 0 && player.spe100 < 50 && changes < changeLimit) {
				dynStats("spe", 1 + rand(2));
				outputText("\n\nYou feel like dancing, and stumble as your legs react more quickly than you'd think.  Is the alcohol slowing you down or are you really faster?  You take a step and nearly faceplant as you go off balance.  It's definitely both.");
				changes++;
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Restore arms to become human arms again
			if (rand(4) === 0) {
				mutations.restoreArms(tfSource);
			}
			//SEXYTIEMS
			//Multidick killa!
			if (player.cocks.length > 1 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\n");
				player.killCocks(1);
				changes++;
			}
			//Boost vaginal capacity without gaping
			if (changes < changeLimit && rand(3) === 0 && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 40) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				outputText("\n\nThere is a sudden... emptiness within your " + player.vaginaDescript(0) + ".  Somehow you know you could accommodate even larger... insertions.");
				changes++;
			}
			//Boost fertility
			if (changes < changeLimit && rand(4) === 0 && player.fertility < 40 && player.hasVagina()) {
				player.fertility += 2 + rand(5);
				changes++;
				outputText("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you're ready to be a mother.");
			}
			//Shrink primary dick to no longer than 12 inches
			else if (player.cocks.length === 1 && rand(2) === 0 && changes < changeLimit && !flags[kFLAGS.HYPER_HAPPY]) {
				if (player.cocks[0].cockLength > 12) {
					changes++;
					var temp3:Number = 0;
					outputText("\n\n");
					//Shrink said cock
					if (player.cocks[0].cockLength < 6 && player.cocks[0].cockLength >= 2.9) {
						player.cocks[0].cockLength -= .5;
						temp3 -= .5;
					}
					temp3 += player.increaseCock(0, (rand(3) + 1) * -1);
					player.lengthChange(temp3, 1);
				}
			}
			//GENERAL APPEARANCE STUFF BELOW
			//REMOVAL STUFF
			//Removes wings!
			if ((player.wingType != WING_TYPE_NONE) && changes < changeLimit && rand(4) === 0) {
				if (player.rearBody.type == REAR_BODY_SHARK_FIN) {
					outputText("\n\nYour back tingles, feeling lighter.  Something lands behind you with a 'thump', and when you turn to look, you"
					          +" see your fin has fallen off.  This might be the best (and worst) booze you've ever had!"
					          +"  <b>You no longer have a fin!</b>");
					player.rearBody.restore();
				} else {
					outputText("\n\nYour shoulders tingle, feeling lighter.  Something lands behind you with a 'thump', and when you turn to look you"
					          +" see your wings have fallen off.  This might be the best (and worst) booze you've ever had!"
					          +"  <b>You no longer have wings!</b>");
				}
				player.wings.restore();
				changes++;
			}
			//Removes antennae!
			if (player.antennae != ANTENNAE_NONE && changes < changeLimit && rand(3) === 0) {
				mutations.removeAntennae();
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) === 0 && player.eyeType > EYES_HUMAN) {
				if (player.eyeType === EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType === EYES_FOUR_SPIDER_EYES || player.eyeType === EYES_SPIDER) outputText("  Yourarachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.bRows() > 1 && rand(3) === 0) {
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
			//Skin/fur
			if (!player.hasPlainSkin() && changes < changeLimit && rand(4) === 0 && player.faceType === FACE_HUMAN) {
				if (player.hasFur()) outputText("\n\nYour fur itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is nude.  <b>You've lost your fur!</b>");
				if (player.hasScales()) outputText("\n\nYour scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your scales!</b>");
				if (player.hasGooSkin()) outputText("\n\nYour " + player.skinDesc + " itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.  <b>Your skin is once again normal!</b>");
				player.skinAdj = "";
				player.skinDesc = "skin";
				player.skinType = SKIN_TYPE_PLAIN;
				player.underBody.restore();
				changes++;
			}
			//skinTone
			if (player.skinTone !== "green" && player.skinTone !== "grayish-blue" && player.skinTone !== "dark green" && player.skinTone !== "pale yellow" && changes < changeLimit && rand(2) === 0) {
				if (rand(10) !== 0) player.skinTone = "dark green";
				else {
					if (rand(2) === 0) player.skinTone = "pale yellow";
					else player.skinTone = "grayish-blue";
				}
				mutations.updateClaws(player.clawType);
				changes++;
				outputText("\n\nWhoah, that was weird.  You just hallucinated that your ");
				if (player.hasFur()) outputText("skin");
				else outputText(player.skinDesc);
				outputText(" turned " + player.skinTone + ".  No way!  It's staying, it really changed color!");
				kGAMECLASS.rathazul.addMixologyXP(20);
			}
			//Face!
			if (player.faceType !== FACE_HUMAN && changes < changeLimit && rand(4) === 0 && player.earType === EARS_ELFIN) {
				changes++;
				player.faceType = FACE_HUMAN;
				outputText("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look.  <b>You have a human looking face again!</b>");
			}
			//Ears!
			if (player.earType !== EARS_ELFIN && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nA weird tingling runs through your scalp as your " + player.hairDescript() + " shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
				changes++;
				player.earType = EARS_ELFIN;
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}

			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nSomething invisible brushes against your " + player.nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) === 0 && player.vaginaType() === 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes < changeLimit && rand(4) === 0 && ((player.ass.analWetness > 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) || player.ass.analWetness > 1)) {
				outputText("\n\nYou feel a tightening up in your colon and your [asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				player.ass.analWetness--;
				if (player.ass.analLooseness > 1) player.ass.analLooseness--;
				changes++;
			}
			if (changes < changeLimit && rand(3) === 0) {
				if (rand(2) === 0) player.modFem(85, 3);
				if (rand(2) === 0) player.modThickness(20, 3);
				if (rand(2) === 0) player.modTone(15, 5);
			}
			player.refillHunger(15);
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
