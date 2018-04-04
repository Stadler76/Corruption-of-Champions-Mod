package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;

	/**
	 * @since March 26, 2018
	 * @author Stadler76
	 */
	public class SweetGossamer extends Consumable 
	{
		public static const SPIDER:int = 0;
		public static const DRIDER:int = 1;

		private var type:int;

		public function SweetGossamer(_type:int) 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			type = _type;

			switch (type) {
				case SPIDER:
					id = "S.Gossr";
					shortName = "S.Gossr";
					longName = "a bundle of pink, gossamer webbing";
					description = "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce."
					             +" It smells sweet and is clearly edible, but who knows what it might do to you?";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case DRIDER:
					id = "B.Gossr";
					shortName = "B.Gossr";
					longName = "a bundle of black, gossamer webbing";
					description = "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce."
					             +" It smells sweet and is clearly edible, but who knows what it might do to you?";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "sweetGossamer";
			if (type === DRIDER) tfSource += "-drider";
			var temp:int;
			mutations.initTransformation([2, 2]);
			clearOutput();
			//Consuming Text
			if (type === SPIDER) outputText("You wad up the sweet, pink gossamer and eat it, finding it to be delicious and chewy, almost like gum.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");
			else if (type === DRIDER) outputText("You wad up the sweet, black gossamer and eat it, finding it to be delicious and chewy, almost like licorice.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");

			//*************
			//Stat Changes
			//*************
			//(If speed<70, increases speed)
			if (player.spe100 < 70 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYour reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air.  A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire.  Why would you ever want to do something like that?");
				dynStats("spe", 1.5);
			}
			//(If speed>80, decreases speed down to minimum of 80)
			if (player.spe100 > 80 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou feel like resting high in the trees and waiting for your unsuspecting prey to wander below so you can take them without having to exert yourself.  What an odd thought!");
				dynStats("spe", -1.5);
			}
			//(increases sensitivity)
			if (changes < changeLimit && rand(3) === 0) {
				outputText("\n\nThe hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on.");
				dynStats("sen", 1);
			}
			//(Increase libido)
			if (changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth.  You wish there had been more.");
				dynStats("lib", 1);
			}
			//(increase toughness to 60)
			if (changes < changeLimit && rand(3) === 0 && player.tou100 < 60) {
				outputText("\n\nStretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs.  How strange.  You probe at yourself, and while your " + player.skinFurScales() + " doesn't feel much different, the underlying flesh does seem tougher.");
				dynStats("tou", 1);
			}
			//(decrease strength to 70)
			if (player.str100 > 70 && rand(3) === 0) {
				outputText("\n\nLethargy rolls through you while you burp noisily.  You rub at your muscles and sigh, wondering why you need to be strong when you could just sew up a nice sticky web to catch your enemies.  ");
				if (player.spiderScore() < 4) outputText("Wait, you're not a spider, that doesn't make any sense!");
				else outputText("Well, maybe you should put your nice, heavy abdomen to work.");
				dynStats("str", -1);
			}
			//****************
			//Sexual Changes
			//****************
			//Increase venom recharge
			if (player.tail.type == Tail.SPIDER_ABDOMEN && player.tail.recharge < 25 && changes < changeLimit) {
				changes++;
				outputText("\n\nThe spinnerets on your abdomen twitch and drip a little webbing.  The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.");
				player.tail.recharge += 5;
			}
			//(tightens vagina to 1, increases lust/libido)
			if (player.hasVagina()) {
				if (player.looseness() > 1 && changes < changeLimit && rand(3) === 0) {
					outputText("\n\nWith a gasp, you feel your " + player.vaginaDescript(0) + " tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your " + player.vaginaDescript(0) + " excitedly. You can't wait to try this out!");
					dynStats("lib", 2, "lus", 25);
					changes++;
					player.vaginas[0].vaginalLooseness--;
				}
			}
			//(tightens asshole to 1, increases lust)
			if (player.ass.analLooseness > 1 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou let out a small cry as your " + player.assholeDescript() + " shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.");
				dynStats("lib", 2, "lus", 25);
				changes++;
				player.ass.analLooseness--;
			}
			//[Requires penises]
			//(Thickens all cocks to a ratio of 1\" thickness per 5.5\"
			if (player.hasCock() && changes < changeLimit && rand(4) === 0) {
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
					if (player.cockTotal() == 1) {
						outputText("it");
					} else {
						outputText("them");
					}

					outputText(" out, you look closely.  ");

					if (player.cockTotal() === 1) {
						outputText("It's");
					} else {
						outputText("They're");
					}

					outputText(" definitely thicker.");
					var counter:Number;
					changes++;
				}
			}
			//[Increase to Breast Size] - up to Large DD
			if (player.smallestTitSize() < 6 && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + player.breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
				player.breastRows[player.smallestTitRow()].breastRating++;
				changes++;
			}
			//[Increase to Ass Size] - to 11
			if (player.butt.rating < 11 && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nYou look over your shoulder at your " + player.buttDescript() + " only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!");
				player.butt.rating++;
				changes++;
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

			//***************
			//Appearance Changes
			//***************
			//(Ears become pointed if not human)
			if (player.ears.type !== Ears.HUMAN && player.ears.type !== Ears.ELFIN && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
				player.ears.type = Ears.ELFIN;
				changes++;
			}
			//(Fur/Scales fall out)
			if (!player.hasPlainSkin() && (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN) && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your " + player.skinFurScales() + " ");
				if (player.hasScales()) outputText("are");
				else outputText("is");
				outputText(" falling to the ground, revealing flawless, almost pearly-white skin underneath.  <b>You now have pale white skin.</b>");
				player.skin.tone = "pale white";
				player.skin.adj = "";
				player.skin.type = Skin.PLAIN;
				player.skin.desc = "skin";
				player.underBody.restore();
				player.arms.updateClaws(player.arms.claws.type);
				changes++;
			}
			//(Gain human face)
			if (player.hasPlainSkin() && (player.face.type !== Face.SPIDER_FANGS && player.face.type !== Face.HUMAN) && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nWracked by pain, your face slowly reforms into a perfect human shape.  Awed by the transformation, you run your fingers delicately over the new face, marvelling at the change.  <b>You have a human face again!</b>");
				player.face.type = Face.HUMAN;
				changes++;
			}
			//-Remove breast rows over 2.
			if (changes < changeLimit && player.bRows() > 2 && rand(3) === 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				mutations.removeExtraBreastRow(tfSource);
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) === 0) {
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
			if (!player.hasStatusEffect(StatusEffects.BlackNipples) && rand(6) === 0 && changes < changeLimit) {
				outputText("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!");
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
				changes++;
			}
			//eyes!
			if (player.hasPlainSkin() && (player.face.type !== Face.SPIDER_FANGS || player.face.type !== Face.HUMAN) && player.eyes.type == Eyes.HUMAN && rand(4) === 0 && changes < changeLimit) {
				player.eyes.type = Eyes.SPIDER;
				player.eyes.count = 4;
				changes++;
				outputText("\n\nYou suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!");
				dynStats("int", 5);
			}
			//(Gain spider fangs)
			if (player.face.type == Face.HUMAN && player.hasPlainSkin() && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nTension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>");
				player.face.type = Face.SPIDER_FANGS;
				changes++;
			}
			//(Arms to carapace-covered arms)
			if (player.arms.type !== Arms.SPIDER && changes < changeLimit && rand(4) === 0) {
				outputText("\n\n");
				//(Bird pretext)
				if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
				outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
				player.arms.setType(Arms.SPIDER);
				changes++;
			}
			if (rand(4) === 0 && changes < changeLimit && player.lowerBody.type !== LowerBody.DRIDER && player.lowerBody.type !== LowerBody.CHITINOUS_SPIDER_LEGS) {
				mutations.restoreLegs(tfSource);
			}
			//Drider butt
			if (type === DRIDER && player.findPerk(PerkLib.SpiderOvipositor) < 0 && player.isDrider() && player.tail.type == Tail.SPIDER_ABDOMEN && changes < changeLimit && rand(3) === 0 && (player.hasVagina || rand(2) === 0)) {
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
			if (((type === DRIDER && player.lowerBody.type !== LowerBody.DRIDER && player.lowerBody.type !== LowerBody.CHITINOUS_SPIDER_LEGS) || (type !== 1 && player.lowerBody.type !== LowerBody.CHITINOUS_SPIDER_LEGS)) && (!player.isGoo() && !player.isNaga() && !player.isTaur()) && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nStarting at your " + player.feet() + ", a tingle runs up your " + player.legs() + ", not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your " + player.buttDescript() + " in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>");
				player.lowerBody.type = LowerBody.CHITINOUS_SPIDER_LEGS;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//(Tail becomes spider abdomen GRANT WEB ATTACK)
			if (player.tail.type !== Tail.SPIDER_ABDOMEN && (player.lowerBody.type == LowerBody.CHITINOUS_SPIDER_LEGS || player.lowerBody.type == LowerBody.DRIDER) && player.arms.type == Arms.SPIDER && rand(4) === 0) {
				outputText("\n\n");
				//(Pre-existing tails)
				if (player.tail.type > Tail.NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your " + player.buttDescript() + " and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + player.buttDescript() + "!</b>\n\n");
				//(No tail)
				else outputText("A burst of pain hits you just above your " + player.buttDescript() + ", coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + player.buttDescript() + "!</b>");
				player.tail.type = Tail.SPIDER_ABDOMEN;
				player.tail.venom = 5;
				player.tail.recharge = 5;
				changes++;
			}
			//(Drider Item Only: Carapace-Clad Legs to Drider Legs)
			if (type === DRIDER && player.lowerBody.type == LowerBody.CHITINOUS_SPIDER_LEGS && rand(4) === 0 && player.tail.type == Tail.SPIDER_ABDOMEN) {
				outputText("\n\nJust like when your legs changed to those of a spider-morph, you find yourself suddenly paralyzed below the waist.  Your dark, reflective legs splay out and drop you flat on your back.   Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them.  Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down.  As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs.  Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start.  Your abdomen has gotten even larger as well.  Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance.  As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance.  That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your " + player.buttDescript() + " is still positioned just above the start of your arachnid half.  <b>You're now a drider.</b>");
				player.lowerBody.type = LowerBody.DRIDER;
				player.lowerBody.legCount = 8;
				changes++;
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}

			if (changes == 0) {
				outputText("\n\nThe sweet silk energizes you, leaving you feeling refreshed.");
				player.changeFatigue(-33);
			}
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
