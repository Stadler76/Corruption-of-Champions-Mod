package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.StatusEffects;

	/**
	 * @since  March 27, 2018
	 * @author Stadler76
	 */
	public class RhinoSteak extends Consumable 
	{
		public function RhinoSteak() 
		{
			super(
				"RhinoSt",
				"RhinoSt",
				"a rhino steak",
				ConsumableLib.DEFAULT_VALUE,
				"Despite the name, it doesn't come from any rhinoceros or a rhino-morph. We can guarantee you that no rhinoceros were harmed in the"+
				" production of this food.\n\nDISCLAIMER: We are not responsible if you find yourself altered."
			);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "rhinoTFs";
			var temp:int;
			mutations.initTransformation(null, 3);
			player.refillHunger(40);
			// Stats Changes
			//------------
			if (rand(3) == 0 && player.str100 < 100) {
				if (player.str100 < 50) {
					outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
					dynStats("str", .5);
				}
				else {
					outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				}
				dynStats("str", .5);
			}
			if (rand(3) == 0 && player.tou100 < 100) {
				outputText("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
				dynStats("tou", 1);
			}
			if (rand(2) == 0 && player.spe100 > 80 && player.str100 >= 50) {
				outputText("\n\nYou begin to feel that the size of your muscles is starting to slow you down.");
				dynStats("spe", -1);
			}
			if (rand(3) == 0 && player.tou100 < 50 && changes < changeLimit) {
				outputText("\n\nYour skin feels clammy and a little rubbery. You touch yourself experimentally and notice that you can barely feel the pressure from your fingertips. Consumed with curiosity, you punch yourself lightly in the arm; the most you feel is a dull throb!");
				dynStats("sen", -1);
			}
			if (rand(3) == 0 && player.inte > 15 && player.face.type == Face.RHINO && player.horns.value == 2) {
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
				dynStats("int", -1);
			}
			if (rand(3) == 0 && player.rhinoScore() >= 2 && (rand(2) == 0 || !player.inRut) && player.hasCock()) {
				player.goIntoRut(true);
			}
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) mutations.updateOvipositionPerk(tfSource);
			// Special TFs
			//------------
			if (rand(4) == 0 && changes < changeLimit && player.horns.type != Horns.UNICORN && player.ears.type == Ears.HORSE && (player.lowerBody.type == LowerBody.HOOFED || player.lowerBody.type == LowerBody.CLOVEN_HOOFED || player.horseScore() >= 3)) {
				outputText("\n\nYou begin to feel an annoying tingling sensation at the top of your head. Reaching up to inspect it you find the <b>sharp nub of a horn protruding from the center of your forehead</b> and growing. Once it's complete you estimate it to be about six inches long.");
				player.horns.type = Horns.UNICORN;
				player.horns.value = 6;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.horns.type == Horns.UNICORN && player.horns.value > 0 && player.horns.value < 12) {
				outputText("\n\nYou begin to feel an intense pinching sensation in your central horn as it pushes out, growing longer and larger. You reach up and find <b>it has developed its own cute little spiral,</b> you estimate it to be about a foot long, two inches thick and very sturdy, a very useful natural weapon.");
				player.horns.value = 12;
				changes++;
			}
			// Normal TFs
			//------------
			//Removes wings
			if (rand(4) == 0 && changes < changeLimit && (player.wings.type != Wings.NONE || player.rearBody.type == RearBody.SHARK_FIN)) {
				if (player.rearBody.type == RearBody.SHARK_FIN) {
					outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into your spine."
					          +" After a moment the pain passes, though your fin is gone!");
					player.rearBody.restore();
				} else {
					outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your"
					          +" shoulder-blades. After a moment the pain passes, though your wings are gone!");
				}
				player.wings.restore();
				changes++;
			}
			//Fur/scales fall out
			if (rand(4) == 0 && changes < changeLimit && (!player.hasPlainSkin() || player.skin.tone != "gray" || player.skin.adj != "tough")) {
				outputText("\n\n");
				switch(player.skin.type) {
					case Skin.PLAIN:
						outputText("You feel an itchy sensation as your skin thickens, <b>becoming tough gray skin</b>.");
						break;
					case Skin.FUR:
						outputText("You feel an itching sensation as your fur beings to fall off in clumps, <b>revealing tough gray skin</b> beneath it.");
						break;
					case Skin.LIZARD_SCALES:
					case Skin.DRAGON_SCALES:
					case Skin.FISH_SCALES:
						outputText("You feel an odd rolling sensation as your scales begin to shift, spreading and reforming as they grow and disappear, <b>becoming tough gray skin</b>.");
						break;
					case Skin.GOO:
						outputText("You feel an itchy sensation as your gooey skin solidifies and thickens, <b>becoming tough gray skin</b>.");
						break;
					default:
						outputText("You feel an itchy sensation as your skin thickens, <b>becoming tough gray skin</b>.");
				}
				player.skin.tone = "gray";
				player.skin.adj = "tough";
				player.skin.type = Skin.PLAIN;
				player.skin.desc = "skin";
				player.underBody.restore();
				player.arms.updateClaws(player.arms.claws.type);
				changes++;
			}
			//Arms change to regular
			if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.HUMAN) {
				switch(player.arms.type) {
					case Arms.HARPY:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating. The wing-like shape your arms once had is gone in a matter of moments, leaving " + player.skin.desc + " behind.");
						break;
					case Arms.SPIDER:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering is flaking away. The glossy black coating is soon gone, leaving " + player.skin.desc + " behind.");
						break;
					default:
				}
				player.arms.restore();
				changes++;
			}
			//Change legs to normal
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody.type != LowerBody.HUMAN) {
				if (player.isBiped()) outputText("You feel an odd sensation in your [feet]. Your [feet] shift and you hear bones cracking as they reform into normal human feet.");
				player.lowerBody.type = LowerBody.HUMAN;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//Removes antennaes!
			if (rand(3) == 0 && changes < changeLimit && player.antennae.type > Antennae.NONE) {
				mutations.removeAntennae();
			}
			//Hair turns back to normal
			if (rand(4) == 0 && changes < changeLimit && player.hair.type != Hair.NORMAL) {
				switch(player.hair.type) {
					case Hair.FEATHER:
						if (player.hair.length >= 6) outputText("\n\nA lock of your downy-soft feather-hair droops over your eye. Before you can blow the offending down away, you realize the feather is collapsing in on itself. It continues to curl inward until all that remains is a normal strand of hair. <b>Your hair is no longer feathery!</b>");
						else outputText("\n\nYou run your fingers through your downy-soft feather-hair while you await the effects of the item you just ingested. While your hand is up there, it detects a change in the texture of your feathers. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer feathery!</b>");
						break;
					case Hair.GOO:
						outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>");
						break;
					case Hair.GHOST:
						break;
					case Hair.ANEMONE:
						outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your tentacle-hair, only to find out that the tentacles have vanished and replaced with normal hair. <b>Your hair is normal again!</b>");
						break;
					default:
						//This shouldn't happen, moving along...
				}
				changes++;
				player.hair.type = Hair.NORMAL;
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
			}
			//Restart hair growth
			if (rand(3) == 0 && changes < changeLimit && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0) {
				outputText("\n\nYou feel an itching sensation in your scalp as you realize the change. <b>Your hair is growing normally again!</b>");
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				changes++;
			}
			//Remove gills
			if (rand(4) == 0 && changes < changeLimit && player.hasGills()) mutations.updateGills();
			// Rhino TFs
			//------------
			//Change a cock to rhino.
			if (rand(4) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) < player.cockTotal()) {
				if (player.cockTotal() == 1) outputText("\n\nYou feel a stirring in your loins as your cock grows rock hard. ");
				else outputText("\n\nOne of your penises begins to feel strange. ");
				outputText("You " + player.clothedOrNakedLower("pull it out from your [armor]", "lean over") + ", right there in the center of The Black Cock, to take a look. You watch as the skin of your cock becomes a smooth, tough pink colored phallus. It takes on a long and narrow shape with an oval shaped bulge along the center. You feel a tightness near the base where your skin seems to be bunching up. A sheath begins forming around your flared rhino cock’s root, tightening as your stiff rhino dick elongates and settles, the thick flared head leaking a steady stream of funky animal-cum. <b>You now have a rhino-dick.</b>");
				for (var i:int = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType != CockTypesEnum.RHINO) {
						player.cocks[i].cockType = CockTypesEnum.RHINO;
						break;
					}
				}
				dynStats("lus", 20);
				changes++;
			}
			//Change ears to rhino
			if (rand(3) == 0 && changes < changeLimit && player.ears.type != Ears.RHINO) {
				outputText("\n\nYou feel an odd uncomfortable sensation in your ears. Reaching up you find your ears shifting into an open tube shape, once they’re done you flick them around, enjoying the sensation of your new ears swishing through the air. <b>You now have rhino ears.</b>");
				player.ears.type = Ears.RHINO;
				changes++;
			}
			//Change face to rhino
			if (rand(4) == 0 && changes < changeLimit && player.ears.type == Ears.RHINO && player.skin.tone == "gray" && player.face.type != Face.RHINO) {
				outputText("\n\nYour face suddenly goes numb. You begin to hear bone cracking as you vision suddenly shifts as you face stretches out and thickens. When your face is done growing you can see the edges of your elongated mouth and noise in the center of your field of vision. They barely impede your vision though. <b>You now have a rhino face.</b>");
				player.face.type = Face.RHINO;
				changes++;
			}
			//Change tail to rhino
			if (rand(3) == 0 && changes < changeLimit && player.isBiped() && player.tail.type != Tail.RHINO) {
				if (player.tail.type > 0) outputText("\n\nYou [tail] suddenly goes numb. Looking back you see it changing, twisting and reforming into a long ropy tail with a little " + player.skin.furColor + " tuft at the end. <b>You now have a rhino tail.</b>");
				else outputText("\n\nYou feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a long ropy tail with a little " + player.skin.furColor + " tuft on the end. <b>You now have a rhino tail.</b>");
				player.tail.type = Tail.RHINO;
				changes++;
			}
			//Gain rhino horns
			//Tier 1
			if (rand(4) == 0 && changes < changeLimit && player.face.type == Face.RHINO && player.horns.type != Horns.RHINO) {
				outputText("\n\nYou begin to feel an annoying tingling sensation at the top of your head. Reaching up to inspect it you find the sharp nub of a horn protruding from the center of your forehead and growing. Once it's complete you estimate it to be about six inches long. If it were sharper and a little longer it would make a useful natural weapon.");
				player.horns.value = 1;
				player.horns.type = Horns.RHINO;
				changes++;
			}
			//Tier 2
			if (rand(4) == 0 && changes < changeLimit && player.face.type == Face.RHINO && player.horns.type == Horns.RHINO && player.horns.value == 1) {
				outputText("\n\nYou begin to feel an annoying tingling sensation at the edge of your nose, above your field of vision. Reaching up you feel the sharp edge of a curved horn growing out the edge of your face. The itchy tingle continues as you feel both of your horns become sharp and tall. You estimate your older horn to be a mere seven inches and your new horn to be around a foot long. They’ll be useful natural weapons.");
				outputText("\n<b>(Gained physical special: Upheaval! Any time you lose your rhino face or horns, you will lose this ability.)</b>");
				player.horns.value = 2;
				player.horns.type = Horns.RHINO;
				changes++;
			}
			// Other Changes
			//------------
			//Increase cock size of non-rhino up to 10 inches.
			var cocksAffected:int = 0;
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.smallestCockLength() < 10 && player.cockTotal() - player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
				cocksAffected = 0;
				for (i = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockLength >= 10) continue; //Skip over if rhino cock.
					temp = player.increaseCock(player.smallestCockIndex(), rand(2) + 1);
					dynStats("lib", 0.5, "lus", 3);
					cocksAffected++;
				}
				outputText("\n\n");
				player.lengthChange(temp, cocksAffected);
				changes++;
			}
			//Increase girth of rhino cock.
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
				cocksAffected = 0;
				for (i = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockThickness < 3) {
						player.cocks[i].thickenCock(0.5);
						dynStats("lib", 0.5, "lus", 3);
						break;
					}
				}
				changes++;
			}
			//Increase length of rhino cock.
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
				cocksAffected = 0;
				for (i = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockLength < 18) {
						temp = player.increaseCock(i, 1 + rand(2));
						outputText("\n\n");
						player.lengthChange(temp, 1);
						dynStats("lib", 0.5, "lus", 3);
						break;
					}
				}
				changes++;
			}
			//Grow balls
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0 && player.ballSize < 4) {
				if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
				if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ". Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
				dynStats("lib", 1, "lus", 3);
				player.ballSize++;
				changes++;
			}
			//Boost vaginal capacity without gaping
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 40) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				outputText("\n\nThere is a sudden... emptiness within your " + player.vaginaDescript(0) + ". Somehow you know you could accommodate even larger... insertions.");
				changes++;
			}
			//Boost anal capacity without gaping
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 60) {
				if (player.statusEffectv1(StatusEffects.BonusACapacity) < 60) {
					if (!player.hasStatusEffect(StatusEffects.BonusACapacity)) player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 5);
					outputText("\n\nYou feel... more accommodating somehow. Your " + player.assholeDescript() + " is tingling a bit, and though it doesn't seem to have loosened, it has grown more elastic.");
					changes++;
				}
			}
			//Gain height
			if (rand(2) == 0 && changes < changeLimit && player.tallness < 102) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 90) temp = Math.floor(temp / 2);
				//Constrain height growth
				if (temp == 0) temp = 1; //Never 0
				if (temp > 6) temp = 6; //Constrain growth to 6 inches
				//Flavor texts. Flavored like 1950's cigarettes. Yum.
				if (temp < 3) outputText("\n\nYou shift uncomfortably as you realize you feel off balance. Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 3 && temp < 6) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 6) outputText("\n\nStaggering forwards, you clutch at your head dizzily. You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			//Gain muscle tone
			if (rand(2) == 0 && player.tone < 80) {
				if (player.tone < 50) player.modTone(80, 2 + rand(2));
				else player.modTone(80, 1 + rand(2));
			}
			//Gain thickness
			if (rand(2) == 0 && player.thickness < 80) {
				if (player.thickness < 50) player.modThickness(80, 2 + rand(2));
				else player.modThickness(80, 1 + rand(2));
			}
			//Slow hair production
			if (rand(3) == 0 && changes < changeLimit && flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] > 0) {
				outputText("\n\nYou feel a tingling sensation in your scalp. After a few seconds it stops… that was odd.");
				flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 0;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
