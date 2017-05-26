package classes.Items.Consumables 
{
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Human transformative item.
	 */
	public class RegularHummus extends Consumable 
	{
		private static const ITEM_VALUE:int = 100;
		
		public function RegularHummus() 
		{
			super("Hummus ","Hummanus", "a jar of cheesy-looking hummus", ITEM_VALUE, "This small clay jar contains a substance known as hummus. Given the label, it's probably going to help you regain lost humanity.");
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "regularHummus";
			var temp:int = 0;
			
			player.slimeFeed();
			clearOutput();
			changes = 0;
			changeLimit = 1;
			if (rand(2) === 0) changeLimit++;
			if (rand(2) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			clearOutput();
			outputText("You crack open the small clay jar to reveal a lightly colored paste that smells surprisingly delicious. You begin eating it with your fingers, wishing all the while for some crackers...");
			player.refillHunger(20);
			if (player.humanScore() > 4) {
				outputText("\n\nYou blink and the world twists around you.  You feel more like yourself than you have in a while, but exactly how isn't immediately apparent.  Maybe you should take a look at yourself?");
			}
			else {
				outputText("\n\nYou cry out as the world spins around you.  You're aware of your entire body sliding and slipping, changing and morphing, but in the sea of sensation you have no idea exactly what's changing.  You nearly black out, and then it's over.  Maybe you had best have a look at yourself and see what changed?");
			}
			//-----------------------
			// MAJOR TRANSFORMATIONS
			//-----------------------
			//1st priority: Change lower body to bipedal.
			if (rand(4) === 0 && changes < changeLimit) {
				mutations.restoreLegs(tfSource);
			}
			
			//Remove Oviposition Perk
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Remove Incorporeality Perk
			if (player.findPerk(PerkLib.Incorporeality) >= 0 && player.perkv4(PerkLib.Incorporeality) === 0 && changes < changeLimit && rand(10) === 0) {
				outputText("\n\nYou feel a strange sensation in your [legs] as they start to feel more solid. They become more opaque until finally, you can no longer see through your [legs]. \n<b>(Perk Lost: Incorporeality!)</b>");
				player.removePerk(PerkLib.Incorporeality);
				changes++;
			}
			//-Skin color change – tan, olive, dark, light
			if ((player.skinTone !== "tan" && player.skinTone !== "olive" && player.skinTone !== "dark" && player.skinTone !== "light") && changes < changeLimit && rand(5) === 0) {
				changes++;
				outputText("\n\nIt takes a while for you to notice, but <b>");
				if (player.hasFur()) outputText("the skin under your " + player.furColor + " " + player.skinDesc);
				else outputText("your " + player.skinDesc);
				outputText(" has changed to become ");
				temp = rand(4);
				if (temp === 0) player.skinTone = "tan";
				else if (temp === 1) player.skinTone = "olive";
				else if (temp === 2) player.skinTone = "dark";
				else if (temp === 3) player.skinTone = "light";
				outputText(player.skinTone + " colored.</b>");
				player.underBody.skin.tone = player.skin.tone;
				mutations.updateClaws(player.clawType);
			}
			//Change skin to normal
			if (!player.hasPlainSkin() && (player.earType === EARS_HUMAN || player.earType === EARS_ELFIN) && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your " + player.skinFurScales() + " ");
				if (player.hasScales()) outputText("are");
				else outputText("is");
				outputText(" falling to the ground, revealing flawless skin below.  <b>You now have normal skin.</b>");

				player.skin.restore();
				player.underBody.restore();
				changes++;
			}
			//Restore arms to become human arms again
			if (rand(4) === 0) {
				mutations.restoreArms(tfSource);
			}
			//-----------------------
			// MINOR TRANSFORMATIONS
			//-----------------------
			//-Human face
			if (player.faceType !== FACE_HUMAN && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nSudden agony sweeps over your " + player.face() + ", your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face.");
				player.faceType = FACE_HUMAN;
				changes++;
			}
			//-Human tongue
			if (player.tongueType !== TONGUE_HUMAN && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nYou feel something strange inside your face as your tongue shrinks and recedes until it feels smooth and rounded.  <b>You realize your tongue has changed back into human tongue!</b>");
				player.tongueType = TONGUE_HUMAN;
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) === 0 && player.eyeType > EYES_HUMAN) {
				if (player.eyeType === EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType === EYES_FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				changes++;
			}
			//-Gain human ears (If you have human face)
			if ((player.earType !== EARS_HUMAN && player.faceType === FACE_HUMAN) && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
				player.earType = EARS_HUMAN;
				changes++;
			}
			//Removes gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nSomething invisible brushes against your " + player.nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
				changes++;
				player.removeStatusEffect(StatusEffects.BlackNipples);
			}
			//Remove feathery hair
			mutations.removeFeatheryHair();
			//Remove anemone hair
			if (changes < changeLimit && player.hairType === HAIR_ANEMONE && rand(3) === 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your tentacle-hair, only to find out that the tentacles have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
				player.hairType = HAIR_NORMAL;
				changes++;
			}
			//Remove goo hair
			if (changes < changeLimit && player.hairType === HAIR_GOO && rand(3) === 0) {
				outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of hair sprouts from the skin of your scalp.  <b>Your hair is normal again!</b>");
				//Turn hair growth on.
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				player.hairType = HAIR_NORMAL;
				changes++;
			}
			//Remove bassy hair
			if ([HAIR_BASILISK_PLUME, HAIR_BASILISK_SPINES].indexOf(player.hairType) !== -1 && changes < changeLimit && rand(4) === 0)
				mutations.removeBassyHair();
			//Restart hair growth
			if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou feel an itching sensation in your scalp as you realize the change. <b>Your hair is growing normally again!</b>");
				//Turn hair growth on.
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				player.hairType = HAIR_NORMAL;
				changes++;
			}
			//-----------------------
			// EXTRA PARTS REMOVAL
			//-----------------------
			//Removes antennae
			if (player.antennae > ANTENNAE_NONE && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead.  When it passes, you touch yourself and discover your antennae have vanished!");
				player.antennae = ANTENNAE_NONE;
				changes++;
			}
			//Removes horns
			if (changes < changeLimit && player.horns > 0 && rand(5) === 0) {
				player.horns = 0;
				player.hornType = HORNS_NONE;
				outputText("\n\nYour horns crumble, falling apart in large chunks until they flake away to nothing.");
				changes++;
			}
			//Removes wings
			if (player.wingType > WING_TYPE_NONE && rand(5) === 0 && changes < changeLimit) {
				if (player.wingType === WING_TYPE_SHARK_FIN) outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into your spine.  After a moment the pain passes, though your fin is gone!");
				else outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
				player.wingType = WING_TYPE_NONE;
				changes++;
			}
			//Removes tail
			if (player.tailType > TAIL_TYPE_NONE && rand(5) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground.  <b>You no longer have a tail!</b>");
				player.tailType = TAIL_TYPE_NONE;
				player.tailVenom = 0;
				player.tailRecharge = 5;
				changes++;
			}
			//Increase height up to 4 feet.
			if (rand(2) === 0 && changes < changeLimit && player.tallness < 48) {
				temp = rand(5) + 3;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp === 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			//Decrease height down to a maximum of 8 feet.
			if (rand(2) === 0 && changes < changeLimit && player.tallness > 96) {
				outputText("\n\nYour skin crawls, making you close your eyes and shiver.  When you open them again the world seems... different.  After a bit of investigation, you realize you've become shorter!\n");
				player.tallness -= 1 + rand(3);
				changes++;
			}
			//-----------------------
			// SEXUAL TRANSFORMATIONS
			//-----------------------
			//Remove additional cocks
			if (player.cocks.length > 1 && rand(3) === 0 && changes < changeLimit) {
				player.killCocks(1);
				outputText("\n\nYou have a strange feeling as your crotch tingles.  Opening your " + player.armorName + ", <b>you realize that one of your cocks have vanished completely!</b>");
				changes++;
			}
			//Remove additional balls
			if (player.balls > 2 && rand(3) === 0 && changes < changeLimit) {
				if (player.ballSize > 2) {
					if (player.ballSize > 5) player.ballSize -= 1 + rand(3);
					player.ballSize -= 1;
					outputText("\n\nYour scrotum slowly shrinks, settling down at a smaller size.  <b>Your " + player.ballsDescriptLight() + " are smaller now.</b>\n\n");
				}
				else {
					player.balls = 2;
					outputText("\n\nYour scrotum slowly shrinks until they seem to have reached a normal size. <b>You can feel as if your extra balls fused together, leaving you with a pair of balls.</b>\n\n");
				}
				changes++;
			}
			//Change cock back to normal
			if (player.hasCock() && changes < changeLimit) {
				if (rand(3) === 0 && player.cocks[0].cockType !== CockTypesEnum.HUMAN) {
					outputText("\n\nA strange tingling begins behind your " + player.cockDescript(0) + ", slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your " + player.armorName + " to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, <b>leaving you with a completely human penis.</b>");
					player.cocks[0].cockType = CockTypesEnum.HUMAN;
					changes++;
				}
			}
			//Shrink oversized cocks
			if (player.hasCock() && player.biggestCockLength() > 12 && rand(3) === 0 && changes < changeLimit) {
				var idx:int = player.biggestCockIndex();
				if (player.cocks.length === 1) outputText("\n\nYou feel a tingling sensation as your cock shrinks to a smaller size!");
				else outputText("\n\nYou feel a tingling sensation as the largest of your cocks shrinks to a smaller size!");
				player.cocks[idx].cockLength -= (rand(10) + 2) / 10;
				if (player.cocks[idx].cockThickness > 1.5) {
					outputText(" Your " + player.cockDescript(idx) + " definitely got a bit thinner as well.");
					player.cocks[idx].cockThickness -= (rand(4) + 1) / 10;
				}
				changes++;
			}
			//Remove additional breasts
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) === 0 && !flags[kFLAGS.HYPER_HAPPY]) {
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
				changes++;
			}
			//Remove extra nipples
			if (player.averageNipplesPerBreast() > 1 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely, the leftover nipples migrating to the middle of your breasts.  <b>You are left with only one nipple on each breast.</b>");
				for(var x:int = 0; x < player.bRows(); x++)
				{
					player.breastRows[x].nipplesPerBreast = 1;
				}
				changes++;
			}
			//Shrink tits!
			if (changes < changeLimit && rand(3) === 0 && player.biggestTitSize() > 6)
			{
				player.shrinkTits();
				changes++;
			}
			//Change vagina back to normal
			if (changes < changeLimit && rand(3) === 0 && player.vaginaType() === 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			//Reduce wetness down to a minimum of 2
			if (changes < changeLimit && rand(3) === 0 && player.hasVagina() && player.vaginas[0].vaginalWetness > 2) {
				outputText("\n\nThe constant flow of fluids that sluice from your " + player.vaginaDescript(0) + " slow down, leaving you feeling a bit less like a sexual slip-'n-slide.");
				player.vaginas[0].vaginalWetness--;
				changes++;
			}
			//Fertility Decrease:
			if (player.hasVagina() && rand(3) === 0 && changes < changeLimit) {
				var tempChanges:int = 0;
				if (player.sens > 10) {
					outputText("\n\nThe vague numbness in your skin sinks slowly downwards, and you put a hand on your lower stomach as the sensation centers itself there.  ");
					dynStats("sen", -2);
					tempChanges = 1;
				}
				if (player.fertility > 10 || (player.fertility > 5 && (player.gender & GENDER_FEMALE) === 0)) {
					//High fertility:
					if (player.fertility >= 30) outputText("It feels like your overcharged reproductive organs have simmered down a bit.");
					//Average fertility:
					else if (player.fertility >= 10) outputText("You feel like you have dried up a bit inside; you are left feeling oddly tranquil.");
					//[Low/No fertility:
					else {
						outputText("Although the numbness makes you feel serene, the hummus has no effect upon your ");
						if (player.fertility > 0) outputText("mostly ");
						outputText("sterile system.");
						if (player.cor > 70) outputText("  For some reason the fact that you cannot function as nature intended makes you feel helpless and submissive.  Perhaps the only way to be a useful creature now is to find a dominant, fertile being willing to plow you full of eggs? You shake the alien, yet oddly alluring thought away.");
					}
					player.fertility -= 1 + rand(3);
					if (player.fertility < 10 && (player.gender & GENDER_FEMALE) > 0) player.fertility = 10;
					if (player.fertility < 5) player.fertility = 5;
					tempChanges = 1;
				}
				changes += tempChanges;
			}
			//Cum Multiplier Decrease:
			if (player.hasCock() && player.cumMultiplier > 5 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel a strange tingling sensation in your ");
				if (player.balls > 0) outputText("balls");
				else outputText("groin");
				outputText(" as you can feel the density reducing. You have a feeling you're going to produce less cum now.");
				player.cumMultiplier -= (1 + (rand(20) / 10));
				if (player.cumMultiplier < 1) player.cumMultiplier = 1;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}
	}
}
