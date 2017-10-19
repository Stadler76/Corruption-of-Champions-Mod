package classes.Items.Consumables 
{
	import classes.Appearance;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Reptile transformativ item.
	 */
	public class Reptilum extends Consumable 
	{
		public function Reptilum() 
		{
			super("Reptlum","Reptilum", "a vial of Reptilum", ConsumableLib.DEFAULT_VALUE, "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "reptilum";
			if (player.hasDragonWingsAndFire())
				tfSource += player.isBasilisk() ? "-dracolisk" : "-dragonewt";
			else
				tfSource += player.isBasilisk() ? "-basilisk"  : "-lizan";
			//if (player.isTaur()) tfSource += "-taur";
			player.slimeFeed();
			//init variables
			changes = 0;
			changeLimit = 1;
			var temp2:Number = 0;
			//Randomly choose affects limit
			if (rand(2) === 0) changeLimit++;
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (rand(4) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//clear screen
			clearOutput();
			outputText("You uncork the vial of fluid and drink it down.  The taste is sour, like a dry wine with an aftertaste not entirely dissimilar to alcohol.  Instead of the warmth you'd expect, it leaves your throat feeling cold and a little numb.");

			//Statistical changes:
			//-Reduces speed down to 50.
			if (player.spe > player.ngPlus(50) && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nYou start to feel sluggish and cold.  Lying down to bask in the sun might make you feel better.");
				dynStats("spe", -1);
				changes++;
			}
			//-Reduces sensitivity.
			if (player.sens100 > 20 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nThe sensation of prickly pins and needles moves over your body, leaving your senses a little dulled in its wake.");
				dynStats("sen", -1);
				changes++;
			}
			//Raises libido greatly to 50, then somewhat to 75, then slowly to 100.
			if (player.lib100 < 100 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments.  As you straighten you can feel the heat seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender !== 3 || rand(2) === 0)) {
					outputText("filling ");
					if (player.cocks.length > 1) outputText("each of ");
					outputText("your " + player.multiCockDescriptLight() + " with the desire to breed.  You get a bit hornier when you realize your sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) outputText("puddling in your " + player.vaginaDescript(0) + ".  An instinctive desire to mate and lay eggs spreads through you, increasing your lust and boosting your sex-drive.");
				//(TARDS)
				else outputText("puddling in your featureless crotch for a split-second before it slides into your " + player.assDescript() + ".  You want to be fucked, filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been permanently increased.");
				//+3 lib if less than 50
				if (player.lib100 < 50) dynStats("lib", 1);
				//+2 lib if less than 75
				if (player.lib100 < 75) dynStats("lib", 1);
				//+1 if above 75.
				dynStats("lib", 1);
				changes++;
			}
			//-Raises toughness to 70
			//(+3 to 40, +2 to 55, +1 to 70)
			if (player.tou < player.ngPlus(70) && changes < changeLimit && rand(3) === 0) {
				//(+3)
				if (player.tou < player.ngPlus(40)) {
					outputText("\n\nYour body and skin both thicken noticeably.  You pinch your " + player.skinDesc + " experimentally and marvel at how much tougher your hide has gotten.");
					dynStats("tou", 3);
				}
				//(+2)
				else if (player.tou < player.ngPlus(55)) {
					outputText("\n\nYou grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
					dynStats("tou", 2);
				}
				//(+1)
				else {
					outputText("\n\nYou snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your " + player.skinDesc + " getting tough enough to make you feel invincible.");
					dynStats("tou", 1);
				}
				changes++;
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
			//-Grows second lizard dick if only 1 dick
			if (player.countCocksOfType(CockTypesEnum.LIZARD) === 1 && player.cocks.length === 1 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nA knot of pressure forms in your groin, forcing you off your " + player.feet() + " as you try to endure it.  You examine the affected area and see a lump starting to bulge under your " + player.skinDesc + ", adjacent to your " + player.cockDescript(0) + ".  The flesh darkens, turning purple");
				if (player.isFurryOrScaley())
					outputText(" and shedding " + player.skinDesc);
				outputText(" as the bulge lengthens, pushing out from your body.  Too surprised to react, you can only pant in pain and watch as the fleshy lump starts to take on a penis-like appearance.  <b>You're growing a second lizard-cock!</b>  It doesn't stop growing until it's just as long as its brother and the same shade of shiny purple.  A dribble of cum oozes from its tip, and you feel relief at last.");

				player.createCock();
				player.cocks[1].cockType = CockTypesEnum.LIZARD;
				player.cocks[1].cockLength = player.cocks[0].cockLength;
				player.cocks[1].cockThickness = player.cocks[0].cockThickness;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//--Worms leave if 100% lizard dicks?
			//Require mammals?
			if (player.countCocksOfType(CockTypesEnum.LIZARD) === player.cockTotal() && changes < changeLimit && player.hasStatusEffect(StatusEffects.Infested)) {
				outputText("\n\nLike rats from a sinking ship, worms escape from your body in a steady stream.  Surprisingly, the sensation is remarkably pleasant, similar to the pleasure of sexual release in a way.  Though they seem inexhaustible, the tiny, cum-slimed invertebrates slow to a trickle.  The larger worm-kin inside you stirs as if disturbed from a nap, coming loose from whatever moorings it had attached itself to in the interior of your form.  It slowly works its way up your urethra, stretching to an almost painful degree with every lurching motion.  Your dick bloats out around the base, stretched like the ovipositor on a bee-girl in order to handle the parasitic creature, but thankfully, the ordeal is a brief one.");
				if (player.balls > 1) outputText("  The remaining " + num2Text(player.balls - 1) + " slither out the pre-stretched holes with ease, though the last one hangs from your tip for a moment before dropping to the ground.");
				outputText("  The white creature joins its kin on the ground and slowly slithers away.  Perhaps they prefer mammals? In any event, <b>you are no longer infected with worms</b>.");
				player.removeStatusEffect(StatusEffects.Infested);
				changes++;
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
			//-Lactation stoppage.
			if (player.biggestLactation() >= 1 && changes < changeLimit && rand(4) === 0) {
				if (player.totalNipples() === 2) outputText("\n\nBoth of your");
				else outputText("\n\nAll of your many");
				outputText(" nipples relax.  It's a strange feeling, and you pull back your top to touch one.  It feels fine, though there doesn't seem to be any milk leaking out.  You give it a squeeze and marvel when nothing ");
				if (player.hasFuckableNipples()) outputText("but sexual fluid ");
				outputText("escapes it.  <b>You are no longer lactating.</b>  That makes sense, only mammals lactate!  Smiling, you muse at how much time this will save you when cleaning your gear.");
				if (player.findPerk(PerkLib.Feeder) >= 0 || player.hasStatusEffect(StatusEffects.Feeder)) {
					outputText("\n\n(<b>Feeder perk lost!</b>)");
					player.removePerk(PerkLib.Feeder);
					player.removeStatusEffect(StatusEffects.Feeder);
				}
				changes++;
				//Loop through and reset lactation
				for (temp2 = 0; temp2 < player.breastRows.length; temp2++) {
					player.breastRows[temp2].lactationMultiplier = 0;
				}
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
			//-VAGs
			if (player.hasVagina() && rand(5) === 0 && player.lizardScore() > 3) {
				mutations.updateOvipositionPerk(tfSource); // does all the magic, nuff said!
			}

			//Physical changes:
			//-Existing horns become draconic, max of 4, max length of 1'
			if (!player.hasDragonHorns(true) && changes < changeLimit && rand(5) === 0){
				mutations.gainDraconicHorns(tfSource);
			}

			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//-Hair changes
			if (changes < changeLimit && rand(4) === 0) {
				mutations.lizardHairChange(tfSource);
			}
			//Remove beard!
			if (player.hasBeard() && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYour " + player.beardDescript() + " feels looser and looser until finally, your beard falls out.  ");
				outputText("(<b>You no longer have a beard!</b>)");
				player.beardLength = 0;
				player.beardStyle = 0;
			}
			//Big physical changes:
			//-Legs – Draconic, clawed feet
			if (player.lowerBody !== LOWER_BODY_TYPE_LIZARD && changes < changeLimit && rand(5) === 0) {
				//Hooves -
				if (player.lowerBody === LOWER_BODY_TYPE_HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//TAURS -
				else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with lizard-like claws.");
				//feet types -
				else if (player.lowerBody === LOWER_BODY_TYPE_HUMAN || player.lowerBody === LOWER_BODY_TYPE_DOG || player.lowerBody === LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS || player.lowerBody === LOWER_BODY_TYPE_DEMONIC_CLAWS || player.lowerBody === LOWER_BODY_TYPE_BEE || player.lowerBody === LOWER_BODY_TYPE_CAT || player.lowerBody === LOWER_BODY_TYPE_LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
				//Else –
				else outputText("\n\nPain rips through your " + player.legs() + ", morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
				outputText("  <b>You have reptilian legs and claws!</b>");
				player.lowerBody = LOWER_BODY_TYPE_LIZARD;
				player.legCount = 2;
				changes++;
			}
			// <mod name="Predator arms" author="Stadler76">
			//Gain predator arms
			if (player.armType !== ARM_TYPE_PREDATOR && player.hasReptileScales() && player.lowerBody === LOWER_BODY_TYPE_LIZARD && changes < changeLimit && rand(3) === 0) {
				player.armType = ARM_TYPE_PREDATOR;
				mutations.updateClaws(CLAW_TYPE_LIZARD);
				outputText("\n\nYou scratch your biceps absentmindedly, but no matter how much you scratch, you can't get rid of the itch.  After a longer moment of ignoring it you finally glance down in irritation, only to discover that your arms former appearance has changed into those of some reptilian killer with " + player.skinFurScales() + " and short " + player.clawTone + " claws replacing your fingernails.");
				outputText("\n<b>You now have reptilian arms.</b>");
				changes++
			}
			//Claw transition
			if (player.armType === ARM_TYPE_PREDATOR && player.hasLizardScales() && player.clawType !== CLAW_TYPE_LIZARD && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYour " + player.claws() + " change a little to become reptilian.");
				mutations.updateClaws(CLAW_TYPE_LIZARD);
				outputText(" <b>You now have " + player.claws() + ".</b>");
				changes++
			}
			// </mod>
			//-Tail – sinuous lizard tail
			if (player.tailType !== TAIL_TYPE_LIZARD && player.lowerBody === LOWER_BODY_TYPE_LIZARD && changes < changeLimit && rand(5) === 0) {
				//No tail
				if (player.tailType === TAIL_TYPE_NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + player.assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  <b>You now have a reptilian tail!</b>");
				//Yes tail
				else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  <b>You now have a reptilian tail.</b>");
				player.tailType = TAIL_TYPE_LIZARD;
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) === 0 && player.eyeType !== EYES_HUMAN && !player.hasReptileEyes()) {
				if (player.eyeType === EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType === EYES_FOUR_SPIDER_EYES || player.eyeType === EYES_SPIDER) outputText(" <b>Your arachnid eyes are gone!</b>");
					outputText(" <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//-Ears become smaller nub-like openings?
			if (player.earType !== EARS_LIZARD && player.tailType === TAIL_TYPE_LIZARD && player.lowerBody === LOWER_BODY_TYPE_LIZARD && changes < changeLimit && rand(5) === 0) {
				outputText("\n\nTightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers.  <b>You have reptilian ears!</b>");
				player.earType = EARS_LIZARD;
				changes++;
			}
			//-Scales – color changes to red, green, white, blue, or black.  Rarely: purple or silver.
			if (!player.hasLizardScales() && player.earType === EARS_LIZARD && player.tailType === TAIL_TYPE_LIZARD && player.lowerBody === LOWER_BODY_TYPE_LIZARD && changes < changeLimit && rand(5) === 0) {
				//(fur)
				var newSkinTones:Array = mutations.newLizardSkinTone();
				if (player.hasFur()) {
					player.skin.tone = newSkinTones[0];
					mutations.updateClaws(player.clawType);
					outputText("\n\nYou scratch yourself, and come away with a large clump of " + player.furColor + " fur.  Panicked, you look down"
					          +" and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body"
					          +" relentlessly, shedding the remaining fur with alarming speed.  Underneath the fur your skin feels incredibly"
					          +" smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + player.skinTone
					          +" scales covering most of your body.  The rest of the fur is easy to remove.");
				}
				else if (player.hasNonLizardScales()) {
					outputText("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly"
					          +" developed pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice"
					          +" small fragments of your " + player.skinFurScales() + " hanging from your fingers.  Nevertheless you continue to"
					          +" scratch yourself, and when you're finally done, you look yourself over. New scales have grown to replace your"
					          +" peeled off [skinFurScales].");
					player.skin.tone = newSkinTones[0];
					mutations.updateClaws(player.clawType);
				}
				//(no fur)
				else {
					outputText("\n\nYou idly reach back to scratch yourself and nearly jump out of your " + player.armorName + " when you hit"
					          +" something hard.  A quick glance down reveals that scales are growing out of your " + player.skinTone + " skin with"
					          +" alarming speed.  As you watch, the surface of your skin is covered in smooth scales.  They interlink together so"
					          +" well that they may as well be seamless.  You peel back your " + player.armorName + " and the transformation has"
					          +" already finished on the rest of your body.");
					player.skin.tone = newSkinTones[0];
					mutations.updateClaws(player.clawType);
				}
				player.skin.setProps({
					type: SKIN_TYPE_LIZARD_SCALES,
					adj: "",
					desc: "scales"
				});
				player.underBody.type = UNDER_BODY_TYPE_REPTILE;
				player.copySkinToUnderBody({ // copy the main skin props to the underBody skin ...
					desc: "ventral scales",  // ... and only override the desc
					tone: newSkinTones[1]    // ... and the color (tone)
				});
				outputText("\n\n<b>You're covered from head to toe in shiny " + player.skinTone + " scales with [underBody.skinFurScales] on your underside.</b>");
				kGAMECLASS.rathazul.addMixologyXP(20);
				changes++;
			}
			//-Lizard-like face.
			if (player.faceType !== FACE_LIZARD && player.hasReptileScales() && player.earType === EARS_LIZARD && player.tailType === TAIL_TYPE_LIZARD && player.lowerBody === LOWER_BODY_TYPE_LIZARD && changes < changeLimit && rand(5) === 0) {
				outputText("\n\nTerrible agony wracks your " + player.face() + " as bones crack and shift.  Your jawbone rearranges while your cranium shortens.  The changes seem to last forever; once they've finished, no time seems to have passed.  Your fingers brush against your toothy snout as you get used to your new face.  It seems <b>you have a toothy, reptilian visage now.</b>");
				player.faceType = FACE_LIZARD;
			}
			//-Lizard tongue
			if (player.tongueType === TONGUE_SNAKE && changes < changeLimit && rand(10) < 6) {
				// Higher (60%) chance to be 'fixed' if old variant
				mutations.gainLizardTongue();
			}

			if ([TONGUE_LIZARD, TONGUE_SNAKE].indexOf(player.tongueType) === -1 && player.hasReptileFace() && changes < changeLimit && rand(3) === 0) {
				mutations.gainLizardTongue();
			}
			//-Remove Gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}
			//<mod name="Reptile eyes" author="Stadler76">
			//-Lizard eyes
			if (!player.hasLizardEyes() && player.faceType === FACE_LIZARD && player.hasReptileScales() && player.earType === EARS_LIZARD && changes < changeLimit && rand(4) === 0) {
				if (player.hasReptileEyes())
					outputText("\n\nYour eyes change slightly in their appearance.  ");
				else
				{
					outputText("\n\nYou feel a sudden surge of pain in your eyes as they begin to reshape. Your pupils begin to elongate becoming vertically slitted and your irises change their color, too.");
					outputText("\nAs the pain passes, you examine your eyes in a nearby puddle. You look into your new eyes with vertically slitted pupils surrounded by green-yellowish irises. With a few tears remaining, the look is a bit blurry. Wanting to get a clearer look at them, you blink your remaining tears away and suddenly you realize, that you just did that with your second set of eyelids.\n");
				}
				outputText("<b>You now have lizard eyes.</b>");
				player.eyeType = EYES_LIZARD;
				changes++;
			}
			//</mod>
			//FAILSAFE CHANGE
			if (changes === 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				game.HPChange(50, true);
				dynStats("lus", 3);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}		
	}
}
