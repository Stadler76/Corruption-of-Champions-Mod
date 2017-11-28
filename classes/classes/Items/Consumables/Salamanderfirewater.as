package classes.Items.Consumables 
{
	import classes.Appearance;
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	
	/**
	 * Salamander transformative item.
	 */
	public class Salamanderfirewater extends Consumable 
	{
		public function Salamanderfirewater() 
		{
			super("SalamFW","SalamFW", "a hip flask of Salamander Firewater", ConsumableLib.DEFAULT_VALUE, "This hip flask contains high-proof beverage called 'Salamander Firewater', which one sip can make your throat feel like it been set on fire.  What would happen if you drink the contents of the whole flask?");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "salamanderfirewater";
			player.slimeFeed();
			//init variables
			changes = 0;
			changeLimit = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (rand(4) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//clear screen
			clearOutput();
			outputText("You uncork the hip flask and drink it down.  The taste is actually quite good, like an alcohol but with a little fire within.  Just as you expected, it makes you feel all hot and ready to take whole world head on.");

			//Statistical changes:
			//-Reduces speed down to 70.
			if (player.spe100 > 70 && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nYou start to feel sluggish.  Lying down and enjoying liquor might make you feel better.");
				dynStats("spe", -1);
				//[removed:1.4.10]//changes++;
			}
			//-Reduces intelligence down to 60.
			if (player.inte100 > 60 && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nYou start to feel a bit dizzy, but the sensation quickly passes.  Thinking hard on it, you mentally brush away the fuzziness that seems to permeate your brain and determine that this firewater may have actually made you dumber.  It would be best not to drink too much of it.");
				dynStats("int", -1);
				//[removed:1.4.10]//changes++;
			}
			//-Raises libido up to 90.
			if (player.lib100 < 90 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender !== 3 || rand(2) === 0)) {
					outputText("filling ");
					if (player.cocks.length > 1) outputText("each of ");
					outputText("your " + player.multiCockDescriptLight() + " with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) outputText("puddling in your " + player.vaginaDescript(0) + ".  An instinctive desire to mate spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else outputText("puddling in your featureless crotch for a split-second before it slides into your " + player.assDescript() + ".  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				dynStats("lib", 2);
				//[removed:1.4.10]//changes++;
			}
			//-Raises toughness up to 90.
			//(+3 to 50, +2 to 70, +1 to 90)
			if (player.tou100 < 90 && changes < changeLimit && rand(3) === 0) {
				//(+3)
				if (player.tou100 < 50) {
					outputText("\n\nYour body and skin both thicken noticeably.  You pinch your " + player.skin.desc + " experimentally and marvel at how much tougher it is now.");
					dynStats("tou", 3);
				}
				//(+2)
				else if (player.tou100 < 70) {
					outputText("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
					dynStats("tou", 2);
				}
				//(+1)
				else {
					outputText("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your " + player.skin.desc + " getting tough enough to make you feel invincible.");
					dynStats("tou", 1);
				}
				//[removed:1.4.10]//changes++;
			}
			//-Raises strength to 80.
			if (player.str100 < 80 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nWhile heat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength than before.");
				dynStats("str", 1);
				//[removed:1.4.10]//changes++;
			}
			//Sexual Changes:
			//-Lizard dick - first one
			if (player.countCocksOfType(CockTypesEnum.LIZARD) === 0 && player.cockTotal() > 0 && changes < changeLimit && rand(4) === 0) {
				//Find the first non-lizzy dick
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType !== CockTypesEnum.LIZARD) break;
				}
				outputText("\n\nA slow tingle warms your groin.  Before it can progress any further, you yank back your " + player.armorName + " to investigate.  Your " + player.cockDescript(temp2) + " is changing!  It ripples loosely from ");
				if (player.hasSheath()) outputText("sheath ");
				else outputText("base ");
				outputText("to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker ");
				if (player.cor < 33) outputText("horrifies you.");
				else if (player.cor < 66) outputText("is a little strange for your tastes.");
				else {
					outputText("looks like it might be more fun to receive than use on others.  ");
					if (player.hasVagina()) outputText("Maybe you could find someone else with one to ride?");
					else outputText("Maybe you should test it out on someone and ask them exactly how it feels?");
				}
				outputText("  <b>You now have a bulbous, lizard-like cock.</b>");
				//Actually xform it nau
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + player.cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//(CHANGE OTHER DICK)
			//Requires 1 lizard cock, multiple cocks
			if (player.cockTotal() > 1 && player.countCocksOfType(CockTypesEnum.LIZARD) > 0 && player.cockTotal() > player.countCocksOfType(CockTypesEnum.LIZARD) && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nA familiar tingle starts in your crotch, and before you can miss the show, you pull open your " + player.armorName + ".  As if operating on a cue, ");
				for (temp2 = 0; temp2 < player.cocks.length; temp2++) {
					//Stop loopahn when dick be found
					if (player.cocks[temp2].cockType !== CockTypesEnum.LIZARD) break;
				}
				if (player.cockTotal() === 2) outputText("your other dick");
				else outputText("another one of your dicks");
				outputText(" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  ");
				if (player.cumQ() < 50) outputText("pre-cum oozes from the tip");
				else if (player.cumQ() < 700) outputText("Thick pre-cum rains from the tip");
				else outputText("A wave of pre-cum splatters on the ground");
				outputText(" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>");
				//(REMOVE SHEATH IF NECESSARY)
				if (player.hasSheath()) {
					player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath()) outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your " + player.cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[temp2].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//-Breasts vanish to 0 rating if male
			if (player.biggestTitSize() >= 1 && player.gender === 1 && changes < changeLimit && rand(3) === 0) {
				//(HUEG)
				if (player.biggestTitSize() > 8) {
					outputText("\n\nThe flesh on your chest tightens up, losing nearly half its mass in the span of a few seconds.  With your center of balance shifted so suddenly, you stagger about trying not to fall on your ass.  You catch yourself and marvel at the massive change in breast size.");
					//Half tit size
				}
				//(NOT HUEG < 4)
				else outputText("\n\nIn an instant, your chest compacts in on itself, consuming every ounce of breast-flesh.  You're left with a  smooth, masculine torso, though your nipples remain.");
				//(BOTH – no new PG)
				outputText("  With the change in weight and gravity, you find it's gotten much easier to move about.");
				//Loop through behind the scenes and adjust all tits.
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					if (player.breastRows[temp2].breastRating > 8) player.breastRows[temp2].breastRating /= 2;
					else player.breastRows[temp2].breastRating = 0;
				}
				//(+2 speed)
				dynStats("lib", 2);
				changes++;
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nA chill runs over your " + player.allBreastsDescript() + " and vanishes.  You stick a hand under your " + player.armorName + " and discover that your extra nipples are missing!  You're down to just one per ");
				if (player.biggestTitSize() < 1) outputText("'breast'.");
				else outputText("breast.");
				changes++;
				//Loop through and reset nipples
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					player.breastRows[temp2].nipplesPerBreast = 1;
				}
			}
			//Increase player's breast size, if they are big DD or smaller
			if (player.smallestTitSize() < 6 && player.gender === 2 && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + player.breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
				player.breastRows[player.smallestTitRow()].breastRating++;
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				mutations.removeExtraBreastRow(tfSource);
			}
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) === 0) {
				mutations.restoreNeck(tfSource);
			}
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) {
				mutations.restoreRearBody(tfSource);
			}
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Physical changes:
			//Tail - 1st gain reptilian tail, 2nd unlocks enhanced with fire tail whip attack
			if (player.tail.type !== Tail.LIZARD && player.tail.type !== Tail.SALAMANDER && changes < changeLimit && rand(3) === 0) {
				//No tail
				if (player.tail.type === Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + player.assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  <b>You now have a reptilian tail!</b>");
				//Yes tail
				else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  <b>You now have a reptilian tail.</b>");
				player.tail.type = Tail.LIZARD;
				changes++;
			}
			if (player.tail.type === Tail.LIZARD && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou feel a strange heating sensation in your tail and when you grab your own tail, you can see that it retains the same shape though the color changes to red. It becomes hotter to the touch and you let go of your tail before it gets too hot. For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail!</b>");
				player.tail.type = Tail.SALAMANDER;
				changes++;
			}
			//Legs
			if (player.lowerBody.type !== LowerBody.SALAMANDER && player.tail.type === Tail.SALAMANDER && changes < changeLimit && rand(3) === 0) {
				//Hooves -
				if (player.lowerBody.type === LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//TAURS -
				else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with salamander-like claws.");
				//feet types -
				else if (player.lowerBody.type === LowerBody.HUMAN || player.lowerBody.type === LowerBody.DOG || player.lowerBody.type === LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody.type === LowerBody.DEMONIC_CLAWS || player.lowerBody.type === LowerBody.BEE || player.lowerBody.type === LowerBody.CAT || player.lowerBody.type === LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//Else –
				else outputText("\n\nPain rips through your " + player.legs() + ", morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				outputText("  <b>You have salamander legs and claws!</b>");
				player.lowerBody.type = LowerBody.SALAMANDER;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//Arms
			if (player.arms.type !== Arms.SALAMANDER && player.lowerBody.type === LowerBody.SALAMANDER && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou scratch your biceps absentmindedly, but no matter how much you scratch, you can't get rid of the itch.  After a longer moment of ignoring it you finally glance down in irritation, only to discover that your arms former appearance has changed into those of a salamander with leathery, red scales and short, fiery-red claws replacing your fingernails.  <b>You now have salamander arms.</b>");
				player.arms.type = Arms.SALAMANDER;
				mutations.updateClaws(Claws.SALAMANDER);
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(4) === 0 && player.eyes.type > Eyes.HUMAN) {
				if (player.eyes.type === Eyes.BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyes.type === Eyes.FOUR_SPIDER_EYES || player.eyes.type === Eyes.SPIDER) outputText(" <b>Your arachnid eyes are gone!</b>");
					outputText(" <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyes.type = Eyes.HUMAN;
				player.eyes.count = 2;
				changes++;
			}
			//Human face
			if (player.face.type !== Face.HUMAN && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nSudden agony sweeps over your " + player.faceDescript() + ", your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face.");
				player.face.type = Face.HUMAN;
				changes++;
			}
			//Human ears
			if (player.face.type === Face.HUMAN && player.ears.type !== Ears.HUMAN && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
				player.ears.type = Ears.HUMAN;
				changes++;
			}
			//-Skin color change
			var humanSkinColors:Array = ["light", "fair", "tan", "dark"];
			if (humanSkinColors.indexOf(player.skin.tone) < 0 && changes < changeLimit && rand(4) === 0) {
				changes++;
				outputText("\n\nIt takes a while for you to notice, but <b>");
				if (player.hasFur()) outputText("the skin under your " + player.skin.furColor + " " + player.skin.desc + " has ");
				else outputText("your " + player.skin.desc + (player.skin.desc.indexOf("scales") !== -1 ? " have " : " has "));
				player.skin.tone = randomChoice(humanSkinColors);
				mutations.updateClaws(player.claws.type);
				outputText("changed to become " + player.skin.tone + " colored.</b>");
			}
			//Change skin to normal
			if (!player.hasPlainSkin() && player.ears.type === Ears.HUMAN && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your " + player.skinFurScales());
				outputText(" " + (player.hasScales() ? "are" : "is") + " falling to the ground, revealing flawless skin below.  <b>You now have normal skin.</b>");
				player.skin.type = Skin.PLAIN;
				player.skin.desc = "skin";
				player.skin.adj  = "";
				player.underBody.restore();
				changes++;
			}
			//Removing gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}
			//FAILSAFE CHANGE
			if (changes === 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				game.HPChange(100, true);
				dynStats("lus", 5);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}
	}
}
