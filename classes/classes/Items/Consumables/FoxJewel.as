package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	import classes.lists.ColorLists;

	/**
	 * @since March 31, 2018
	 * @author Stadler76
	 */
	public class FoxJewel extends Consumable 
	{
		public static const STANDARD:int = 0;
		public static const MYSTIC:int   = 1;

		private var mystic:Boolean;

		public function FoxJewel(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			mystic = type === MYSTIC;

			switch (type) {
				case STANDARD:
					id = "FoxJewl";
					shortName = "Fox Jewel";
					longName = "a fox jewel";
					description = "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case MYSTIC:
					id = "MystJwl";
					shortName = "MystJwl";
					longName = "a mystic jewel";
					description = "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue."
					             +" It has been enhanced to increase its potency, allowing it to transform you more easily,"
					             +" but may have odd side-effects...";
					value = 20;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "foxJewel";
			if (mystic) tfSource += "-mystic";
			mutations.initTransformation([2, 2, 3], mystic ? 3 : 1);
			clearOutput();
			if (mystic) outputText("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie purple flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale lavender flames swirl around you, the air is filled with a sickly sweet scent that drips with the bitter aroma of licorice, filling you with a dire warmth.");
			else outputText("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie blue flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale azure flames swirl around you, the air is filled with a sweet scent that drips with the aroma of wintergreen, sending chills down your spine.");

			//**********************
			//BASIC STATS
			//**********************
			//[increase Intelligence, Libido and Sensitivity]
			if (player.inte100 < 100 && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(4) === 0))) {
				outputText("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental image of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				//Raise INT, Lib, Sens. and +10 LUST
				dynStats("int", 2, "lib", 1, "sen", 2, "lus", 10);
			}
			//[decrease Strength toward 15]
			if (player.str100 > 15 && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0))) {
				outputText("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				dynStats("str", -1);
				if (player.str100 > 70) dynStats("str", -1);
				if (player.str100 > 50) dynStats("str", -1);
				if (player.str100 > 30) dynStats("str", -1);
			}
			//[decrease Toughness toward 20]
			if (player.tou100 > 20 && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0))) {
				//from 66 or less toughness
				if (player.tou100 <= 66) outputText("\n\nYou feel your " + player.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your " + player.skinFurScales() + " won't offer you much protection.");
				//from 66 or greater toughness
				else outputText("\n\nYou feel your " + player.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				dynStats("tou", -1);
				if (player.tou100 > 66) dynStats("tou", -1);
			}
			if (mystic && changes < changeLimit && rand(2) === 0 && player.cor < 100) {
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
			if (((mystic && rand(2) === 0) || (!mystic && rand(4) === 0)) && changes < changeLimit && player.femininity !== 50) {
				outputText(player.modFem(50, 2));
				changes++;
			}
			//[decrease muscle tone toward 40]
			if (player.tone >= 40 && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(4) === 0))) {
				outputText("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				player.tone -= 2 + rand(3);
				changes++;
			}

			//[Adjust hips toward 10 – wide/curvy/flared]
			//from narrow to wide
			if (player.hips.rating < 10 && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0)) && changes < changeLimit) {
				player.hips.rating++;
				if (player.hips.rating < 7) player.hips.rating++;
				if (player.hips.rating < 4) player.hips.rating++;
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have widened nicely!");
				changes++;
			}
			//from wide to narrower
			if (player.hips.rating > 10 && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0)) && changes < changeLimit) {
				player.hips.rating--;
				if (player.hips.rating > 14) player.hips.rating--;
				if (player.hips.rating > 19) player.hips.rating--;
				if (player.hips.rating > 24) player.hips.rating--;
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have narrowed.");
				changes++;
			}

			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			if ((player.hair.length < 16 || player.hair.length > 26) && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0)) && changes < changeLimit) {
				//from short to long
				if (player.hair.length < 16) {
					player.hair.length += 3 + rand(3);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming " + player.hairDescript() + ".");
				}
				//from long to short
				else {
					player.hair.length -= 3 + rand(3);
					outputText("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming " + player.hairDescript() + ".");
				}
				changes++;
			}
			//[Increase Vaginal Capacity] - requires vagina, of course
			if (player.hasVagina() && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0)) && player.statusEffectv1(StatusEffects.BonusVCapacity) < 200 && changes < changeLimit) {
				outputText("\n\nA gurgling sound issues from your abdomen, and you double over as a trembling ripple passes through your womb.  The flesh of your stomach roils as your internal organs begin to shift, and when the sensation finally passes, you are instinctively aware that your " + player.vaginaDescript(0) + " is a bit deeper than it was before.");
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) {
					player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				}
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 10 + rand(10));
				changes++;
			}
			else if (((mystic && rand(2) === 0) || (!mystic && rand(3) === 0)) && player.statusEffectv1(StatusEffects.BonusACapacity) < 150 && changes < changeLimit) {
				outputText("\n\nYou feel... more accommodating somehow.  Your " + player.assholeDescript() + " is tingling a bit, and though it doesn't seem to have loosened, it has grown more elastic.");
				if (!player.hasStatusEffect(StatusEffects.BonusACapacity)) {
					player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
				}
				player.addStatusValue(StatusEffects.BonusACapacity, 1, 10 + rand(10));
				changes++;
			}
			//[Vag of Holding] - rare effect, only if PC has high vaginal looseness
			else if (player.hasVagina() && ((mystic) || (!mystic && rand(5) === 0)) && player.statusEffectv1(StatusEffects.BonusVCapacity) >= 200 && player.statusEffectv1(StatusEffects.BonusVCapacity) < 8000 && changes < changeLimit) {
				outputText("\n\nYou clutch your stomach with both hands, dropping to the ground in pain as your internal organs begin to twist and shift violently inside you.  As you clench your eyes shut in agony, you are overcome with a sudden calm.  The pain in your abdomen subsides, and you feel at one with the unfathomable infinity of the universe, warmth radiating through you from the vast swirling cosmos contained within your womb.");
				if (game.silly()) outputText("  <b>Your vagina has become a universe unto itself, capable of accepting colossal insertions beyond the scope of human comprehension!</b>");
				else outputText("  <b>Your vagina is now capable of accepting even the most ludicrously sized insertions with no ill effects.</b>");
				player.changeStatusValue(StatusEffects.BonusVCapacity, 1, 8000);
				changes++;
			}


			//**********************
			//BIG APPEARANCE CHANGES
			//**********************
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
			//[Grow Fox Tail]
			if (player.tail.type !== Tail.FOX && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(4) === 0))) {
				//if PC has no tail
				if (player.tail.type == Tail.NONE) {
					outputText("\n\nA pressure builds on your backside.  You feel under your " + player.armorName + " and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it has a mind of its own.  <b>You now have a fox-tail.</b>");
				}
				//if PC has another type of tail
				else if (player.tail.type !== Tail.FOX) {
					outputText("\n\nPain lances through your lower back as your tail shifts and twitches violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox-tail.</b>");
				}
				player.tail.type = Tail.FOX;
				player.tail.venom = 1;
				changes++;
			}
			if (!mystic && player.ears.type == Ears.FOX && player.tail.type == Tail.FOX && player.tail.venom == 8 && rand(3) === 0) {
				outputText("\n\nYou have the feeling that if you could grow a ninth tail you would be much more powerful, but you would need to find a way to enhance one of these gems or meditate with one to have a chance at unlocking your full potential.");
			}
			//[Grow Addtl. Fox Tail]
			//(rare effect, up to max of 8 tails, requires PC level and int*10 = number of tail to be added)
			else if (player.tail.type == Tail.FOX && player.tail.venom < 8 && player.tail.venom + 1 <= player.level && player.tail.venom + 1 <= player.inte / 10 && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0))) {
				//if PC has 1 fox tail
				if (player.tail.venom == 1) {
					outputText("\n\nA tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail splits into two!  <b>You now have a pair of fox-tails.</b>");
					//increment tail by 1
				}
				//else if PC has 2 or more fox tails
				else {
					outputText("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tail.venom + 1) + "!  <b>You now have a cluster of " + num2Text(player.tail.venom + 1) + " fox-tails.</b>");
					//increment tail by 1
				}
				player.tail.venom++;
				changes++;
			}
			//[Grow 9th tail and gain Corrupted Nine-tails perk]
			else if (mystic && rand(4) === 0 && changes < changeLimit && player.tail.type == Tail.FOX && player.tail.venom == 8 && player.level >= 9 && player.ears.type == Ears.FOX && player.inte >= 90 && player.findPerk(PerkLib.CorruptedNinetails) < 0 && (player.findPerk(PerkLib.EnlightenedNinetails) < 0 || player.perkv4(PerkLib.EnlightenedNinetails) > 0)) {
				outputText("Your bushy tails begin to glow with an eerie, ghostly light, and with a crackle of electrical energy, split into nine tails.  <b>You are now a nine-tails!  But something is wrong...  The cosmic power radiating from your body feels...  tainted somehow.  The corruption pouring off your body feels...  good.</b>");
				outputText("\n\nYou have the inexplicable urge to set fire to the world, just to watch it burn.  With your newfound power, it's a goal that is well within reach.");
				outputText("\n\n(Perk Gained: Corrupted Nine-tails - Grants two magical special attacks.)");
				player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
				dynStats("lib", 2, "lus", 10, "cor", 10);
				player.tail.venom = 9;
				changes++;
			}

			//[Grow Fox Ears]
			if (player.tail.type == Tail.FOX && ((mystic && rand(2) === 0) || (!mystic && rand(4) === 0)) && player.ears.type !== Ears.FOX && changes < changeLimit) {
				//if PC has non-animal ears
				if (player.ears.type == Ears.HUMAN) outputText("\n\nThe sides of your face painfully stretch as your ears morph and begin to migrate up past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  You now have fox ears.");
				//if PC has animal ears
				else outputText("\n\nYour ears change shape, shifting from their current shape to become vulpine in nature.  You now have fox ears.");
				player.ears.type = Ears.FOX;
				changes++;
			}
			//[Change Hair Color: Golden-blonde, SIlver Blonde, White, Black, Red]
			if (((mystic && rand(2) === 0) || (!mystic && rand(4) === 0)) && changes < changeLimit && !InCollection(player.hair.color, ColorLists.BASIC_KITSUNE_HAIR) && !InCollection(player.hair.color, ColorLists.ELDER_KITSUNE)) {
				if (player.tail.type == Tail.FOX && player.tail.venom == 9) player.hair.color = randomChoice(ColorLists.ELDER_KITSUNE);
				else player.hair.color = randomChoice(ColorLists.BASIC_KITSUNE_HAIR);
				outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand, pulling it forward to check it.  Your hair has become the same " + player.hair.color + " as a kitsune's!");
				changes++;
			}
			var tone:Array = mystic ? ColorLists.KITSUNE_SKIN_MYSTIC : ColorLists.KITSUNE_SKIN;
			//[Change Skin Type: remove fur or scales, change skin to Tan, Olive, or Light]
			var theFurColor:String = player.skin.furColor;
			if (player.hasFur() && player.underBody.type == UnderBody.FURRY && player.skin.furColor !== player.underBody.skin.furColor)
				theFurColor = player.skin.furColor + " and " + player.underBody.skin.furColor;

			if ((player.hasFur()
					&& player.face.type != Face.FOX
					&& !InCollection(theFurColor, convertMixedToStringArray(ColorLists.BASIC_KITSUNE_FUR))
					&& !InCollection(theFurColor, ColorLists.ELDER_KITSUNE)
					&& !InCollection(theFurColor, ["orange and white", "black and white", "red and white", "tan", "brown"])
					)
				|| player.hasScales() && ((mystic) || (!mystic && rand(2) === 0))) {
				outputText("\n\nYou begin to tingle all over your [skin], starting as a cool, pleasant sensation but gradually worsening until you are furiously itching all over.");
				if (player.hasFur()) outputText("  You stare in horror as you pull your fingers away holding a handful of " + player.skin.furColor + " fur!  Your fur sloughs off your body in thick clumps, falling away to reveal patches of bare, " + player.skin.tone + " skin.");
				else if (player.hasScales()) outputText("  You stare in horror as you pull your fingers away holding a handful of dried up scales!  Your scales continue to flake and peel off your skin in thick patches, revealing the tender " + player.skin.tone + " skin underneath.");
				outputText("  Your skin slowly turns raw and red under your severe scratching, the tingling sensations raising goosebumps across your whole body.  Over time, the itching fades, and your flushed skin resolves into a natural-looking ");
				player.skin.type = Skin.PLAIN;
				player.skin.adj = "";
				player.skin.desc = "skin";
				player.underBody.restore();
				if (!InCollection(player.skin.tone, tone)) player.skin.tone = randomChoice(tone);
				outputText(player.skin.tone + " complexion.");
				outputText("  <b>You now have [skin]!</b>");
				player.arms.updateClaws(player.arms.claws.type);
				changes++;
			}
			//Change skin tone if not changed you!
			else if (!InCollection(player.skin.tone, tone) && changes < changeLimit && ((mystic && rand(2) === 0) || (!mystic && rand(3) === 0))) {
				outputText("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  Holding an arm up to your face, you discover that <b>you now have ");
				player.skin.tone = randomChoice(tone);
				outputText("[skin]!</b>");
				player.arms.updateClaws(player.arms.claws.type);
				changes++;
			}
			//[Change Skin Color: add "Tattoos"]
			//From Tan, Olive, or Light skin tones
			else if (9999 == 0 && InCollection(player.skin.tone, tone) && changes < changeLimit) {
				outputText("You feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing tribal tattoos adorns your [skin].  The glow gradually fades, but the distinctive ");
				if (mystic) outputText("angular");
				else outputText("curved");
				outputText(" markings remain, as if etched into your skin.");
				changes++;
				//9999 - pending tats system
			}
			//Nipples Turn Back:
			if (!player.hasFur() && player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) === 0) {
				mutations.removeBlackNipples(tfSource);
			}
			//Debugcunt
			if (!player.hasFur() && changes < changeLimit && rand(3) === 0 && player.vaginaType() == 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			// Kitsunes should have normal arms and legs. exspecially skinny arms with claws are somewhat weird (Stadler76).
			if (player.hasPlainSkin() && rand(4) === 0) mutations.restoreArms(tfSource);
			if (player.hasPlainSkin() && rand(4) === 0) mutations.restoreLegs(tfSource);

			if (changes == 0) {
				outputText("\n\nOdd.  You don't feel any different.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
