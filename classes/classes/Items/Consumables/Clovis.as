package classes.Items.Consumables
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	
	/**
	 * Sheep transformative item.
	 * 
	 * @author written by MissBlackthorne and coded by Foxwells
	 */
	public class Clovis extends Consumable
	{
		public function Clovis()
		{
			super("Clovis", "Clovis", "a bottle of Clovis", ConsumableLib.DEFAULT_VALUE, "This bottle is in the shape of a 4-leaf-clover and contains a soft pink potion. An image of a sheep is on the label along with text, \"<i>Clovis - to help you to live in clover</i>\".");
		}
		
		override public function useItem():Boolean
		{
			var tfSource: String = "clovis";
			mutations.initTransformation([2, 2]);
			outputText("You open the bottle of Clovis, its sweet smell making you feel carefree. You drink the contents and relax to the sensation it brings, feeling like you're being cuddled by a big fluffy cloud.");
			// Stat changes!
			if (player.inte > 90 && rand(3) === 0 && changes < changeLimit) {
				dynStats("int", -(rand(1) + 1));
				outputText("\n\nThe sense of calm the potion gives you slowly fades into dopey bliss. You haven't a care in the world, not even the fact that you've got a little dumber.");
			}
			if (rand(3) === 0 && changes < changeLimit) {
				dynStats("tou", rand(1) + 1);
				outputText("\n\nYou feel a wave of stubborn pride wash over you as you finish the potion. You’re sure nothing could stop you now, not even the demons.");
			}
			if (player.spe < 75 && rand(3) === 0 && changes < changeLimit) {
				dynStats("spe", rand(2) + 1);
				outputText("\n\nYou feel oddly compelled to jump from rock to rock across a nearby stream, a sense of sure footedness and increased agility deep within you. To your surprise, you make it across with no trouble. The damp and uneven rocks are barely a challenge to your increased speed.");
			}
			if (rand(3) === 0 && changes < changeLimit) {
				dynStats("sens", -(rand(1) + 1));
				outputText("\n\nYou feel less sensitive to the touch, a slight numbness pervading your body as if truly wrapped in cotton wool. The numbness eventually fades, leaving you now less affected by the lusty touches of your foes.");
			}
			if (rand(3) === 0 && changes < changeLimit) {
				dynStats("cor", -(rand(3) + 2));
				outputText("\n\nYou close your eyes as your mind becomes clearer, a purging white searing through your being. It envelops you in its fluffy softness as it chases out the taint, first burning but then soothing. As you open your eyes, you feel you have regained some of your purity that this perverted realm seeks to claim.");
				changes++;
			}
			if (player.tallness > 67 && rand(2) === 0 && changes < changeLimit) {
				player.tallness -= (1 + rand(4));
				outputText("\n\nYou blink as you feel your center of gravity shift lower. You look down and realize the ground is closer now. You appear to have gotten shorter!");
				changes++;
			}
			if (player.butt.rating < 6 && rand(3) === 0 && changes < changeLimit) {
				player.butt.rating += (1 + rand(1));
				if (player.butt.rating > 6) {
					player.butt.rating = 6;
				}
				outputText("\n\nYou feel your clothes tighten around your [butt], your behind expanding. Thankfully, it stops before your clothes can't handle it. As you run your hand over the tight fabric, you can't help but grope the now plumper flesh.");
			}
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0)
				mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.rearBody.type != RearBody.NONE && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			if (player.ears.type !== Ears.SHEEP && rand(3) === 0 && changes < changeLimit) {
				if (player.ears.type === -1) { outputText("\n\nTwo painful nubs begin sprouting from your head, growing out in a tear-drop shape and flopping over. To top it off, wool coats them."); } else { outputText("\n\nYou feel your ears shift and elongate, becoming much floppier. They take on a more tear drop shape, flopping at the side of your head cutely as a light coat of downy wool forms on them.");	}		
				player.ears.type = Ears.SHEEP;
				player.ears.value = 2;
				outputText(" <b>You now have sheep ears!</b>");
				changes++;
			}
			if (player.tail.type !== Tail.SHEEP && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel the flesh above your [butt] knotting and changing. It twists and writhes around itself, lengthening before flopping straight down. With a slight poof, a coat of soft and fluffy wool coats it, your new tail taking on the wooly appearance of a sheep's.");
				player.tail.type = Tail.SHEEP;
				outputText(" <b>You now have a sheep's tail!</b>");
				changes++;
			}
			if (player.lowerBody.type !== LowerBody.CLOVEN_HOOFED && player.tail.type === Tail.SHEEP && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel a strange tightness from your feet and nearly topple over as your balance shifts. You're balancing on your toes for some reason. You look down in amazement as your legs slim and shorten, your feet elongating and darkening at the ends, all morphing until you're balancing on two sheep legs, complete with cute little hooves.");
				player.lowerBody.type = LowerBody.CLOVEN_HOOFED;
				player.lowerBody.legCount = 2;
				outputText(" <b>You now have sheep hooves!</b>");
				changes++;
			}
			if (player.horns.type !== Horns.SHEEP && player.horns.type !== Horns.RAM && player.ears.type === Ears.SHEEP && rand(3) === 0 && changes < changeLimit) {
					if (player.horns.type !== Horns.NONE) {
						outputText("\n\nYou feel your horns suddenly crumble, falling apart in large chunks until they flake away into nothing.");
					} 
					outputText("\n\nYou grip your head as a surge of pain hits you. A pair of horns slowly emerge from your skull, curling out and forward in a half circle. The ribbed curls remind you of the horns of the sheep back in Ingnam. <b>You now have sheep horns!</b>");
				player.horns.type = Horns.SHEEP;
				player.horns.value = 1;
				changes++;
			}
			if (rand(3) === 0 && changes < changeLimit && player.lowerBody.legCount === 2 && player.lowerBody.type === LowerBody.CLOVEN_HOOFED && player.horns.type === Horns.SHEEP && player.tail.type === Tail.SHEEP && player.ears.type === Ears.SHEEP && !player.hasWool()) {
			    var sheepWoolColors: Array = [
				"white",
				"black",
				"gray",
				"silver",
				"brown",
				"moorit"
			    ];
				if (!player.hasFur()) {
					outputText("\n\nWith an almost audible \*POMF\*, a soft fleece erupts from your body. The fleece covers all of your midsection and thighs, thick and fluffy. It doesn't fully hide your sexual features, instead obscuring them in an enticing manner. You can't help but run your hands over your soft, " + player.skin.furColor + " wool, reveling in plushness. <b>You now have sheep wool!</b>");
				} else {
					outputText("\n\nYou feel your fur suddenly stand on end, every follicle suddenly detaching and leaving your skin bare. As you stand with a pile of shed fur around your feet, you feel your skin tingle, and you're sure it isn't from the cold. With an almost audible \*POMF\*, a soft fleece erupts from your body. The fleece covers all of your midsection and thighs, thick and fluffy. It doesn't fully hide your sexual features, instead obscuring them in an enticing manner. You can't help but run your hands over your soft, " + player.skin.furColor + " wool, reveling in plushness. <b>You now have sheep wool!</b>");
				}
				player.skin.type = Skin.WOOL;
				player.skin.desc = "wool";
				player.setFurColor(sheepWoolColors, {
					type: UnderBody.FURRY
				}, true);
				changes++;
			}
			if (player.horns.type === Horns.SHEEP && player.hasWool() && player.femininity <= 45 && rand(3) === 0 && changes < changeLimit) {
					outputText("\n\nYou feel a familiar pain in your head. Your horns are growing! More ribbed horn emerges from your scalp, your horns slowly curling around fully as they thicken. Once a full ring of horn is complete they lengthen until the pointed ends face forward, tucked under your ears. You run your fingers over your curled horns in awe. These could seriously do some damage! Or at least stun your foes. <b>You now have the horns of a ram!</b>");
				player.horns.type = Horns.RAM;
				player.horns.value = 2;
				changes++;
			}
			if (player.horns.type === Horns.RAM && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou groan and clutch your head as your horns stretch out, becoming even longer.");
				player.horns.type = Horns.RAM;
				player.horns.value += (1 + rand(3));
				changes++;
			}
			if (player.hasWool() && player.hair.type !== Hair.WOOL && player.femininity >= 65 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYour hair suddenly poofs out as if you had filled it with static. You attempt to smooth it down, but you can't seem to straighten it out properly. It keeps bouncing back in a cushion-like manner. You in a nearby puddle. Your hair is now much thicker, it having become rather curly and bouffant like the wool of a sheep. You realize that <b>you now have woolen hair!</b>");
				player.hair.type = Hair.WOOL;
				changes++;
			}
			if (player.hips.rating < 10 && player.femininity >= 65 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou grip your hips as they shift, getting wider and altering your stance. Your hips seem much more fitting for a sheep now, all big and cuddly.");
				player.hips.rating += (rand(1) + 1);
				if (player.hips.rating > 10) {
					player.hips.rating = 10;
				}
				changes++;
			}
			if (player.breastRows[0].breastRating < 5 && player.femininity >= 65 && rand(3) === 0 && changes < changeLimit) {
				player.breastRows[0].breastRating += (rand(1) + 1);
				if (player.breastRows[0].breastRating > 5) {
					player.breastRows[0].breastRating = 5;
				}
				outputText("\n\nYour breasts feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach " + player.breastCup(0) + "-cup. You rub the tender orbs as you get used to your larger breast flesh.");
				changes++;
			}
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
