package classes.Items.Consumables 
{
	import classes.Appearance;
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;

	/**
	 * Golden Rind/Deer TF, part of the Wild Hunt by Frogapus
	 * @author Kitteh6660
	 */
	public class GoldenRind extends Consumable
	{
		
		public function GoldenRind() 
		{
			super("GldRind", "GoldenRind", "a golden rind", ConsumableLib.DEFAULT_VALUE, "This shimmering, citrus peel is shaped like a corkscrew and smells sweet and sour at the same time.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "deerTFs";
			var temp:int = 0;
			var x:int = 0;
			outputText("You pop the sliver of fruit in your mouth, delighting in the sweetness and tanginess as you chew it.  A burst of lime-like tartness slaps your senses, and you feel an answering tingle further down in your body.");
			player.refillHunger(10);
			mutations.initTransformation([2, 3], 2);
			//Main TFs
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0) //neck restore
				mutations.restoreNeck(tfSource);
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) //rear body restore
				mutations.restoreRearBody(tfSource);
			if (rand(5) == 0) //ovi perk loss
				mutations.updateOvipositionPerk(tfSource);
			if (rand(3) == 0 && changes < changeLimit && player.ears.type != Ears.DEER) {
				if (player.ears.type == -1) outputText("\n\nTwo painful lumps sprout on the top of your head, forming into tear-drop shaped ears, covered with short fur.  ");
				if (player.ears.type == Ears.HUMAN) outputText("\n\nYour ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into an upright animalistic ears.  ");
				if (player.ears.type == Ears.DOG) outputText("\n\nYour ears change shape, morphing into from their doglike shape into deer-like ears!  ");
				if (player.ears.type > Ears.DOG) outputText("\n\nYour ears change shape, morphing into teardrop-shaped deer ears!  ");
				outputText("<b>You now have deer ears.</b>");
				player.ears.type = Ears.DEER; //gain deer ears
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.DEER && player.tail.type != Tail.DEER) {
				outputText("\n\nYou feel a tightening just above your ass, as if a massive hand was pinching you.  It releases with a curious “pomf”-ing noise.  You turn this way and that, finally managing to crane your neck to see your <b>fluffy, flicking deer tail.</b>");
				player.tail.type = Tail.DEER; //gain deer tail
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.NONE) {
				outputText("\n\nYou feel an immense pressure from your forehead, and you reach up, feeling the nubs of two new horns.");
				player.horns.type = Horns.ANTLERS; //gain deer horns AKA antlers
				player.horns.value = 1;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.value > 0 && player.horns.type != Horns.ANTLERS) {
				outputText("\n\nYou feel a strange twisting sensation from your horns as they extend outwards.  You reach up to feel them and realize that you’ve now got <b>pronged, stag-like horns.</b>");
				player.horns.type = Horns.ANTLERS; //gain deer horns AKA antlers
				player.horns.value = 4;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.ANTLERS && player.horns.value < 30) {
				outputText("\n\nYou feel a strange twisting sensation from your antlers as they extend and split outwards.  You reach up to feel them and realize that your antlers are now even more branched out.");
				if (player.horns.value < 20 && rand(2) == 0) player.horns.value += (1 + rand(4));
				player.horns.value++; //increase points on deer antlers
				outputText("  After counting the number of points you have on your antlers, <b>you have " + player.horns.value + " points.</b>");
				if (player.horns.value >= 30) outputText("<b>  It seems that your antlers can't get any more pointier.</b>");
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.horns.value > 0 && !player.hasFur()) {
				outputText("\n\nFor a moment, it looks like a ray of sunlight has shimmered through the canopy. You blink and realize that your fur has become dappled, with lighter, sun-speckled spots highlighting it.");
				player.skin.type = Skin.FUR; //gain fur
				player.skin.adj = "";
				player.skin.desc = "fur";
				player.skin.furColor = "brown";
				player.underBody.type = UnderBody.FURRY;
				player.copySkinToUnderBody({furColor: "white"});
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.DEER && (player.face.type != Face.HUMAN && player.face.type != Face.DEER)) {
				outputText("\n\nYour face grows warm as suddenly your vision is engulfed in smoke, coughing and beating the smoke back you noticed a marked change in your features. Touching yourself you confirm you have a <b>normal human shaped face once again</b>.");
				player.face.type = Face.HUMAN; //change face to human
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.hasFur() && player.ears.type == Ears.DEER && player.tail.type == Tail.DEER && player.face.type != Face.DEER) {
				outputText("\n\nYou feel a grinding noise from your jaw, and a massive pressure in your sinuses, as your cheeks pinch in, followed immediately by a pointing of the lower half of your face.  You frantically (and gently) feel your face, discovering, to your surprise, that you’ve <b>gained the delicate facial features of a deer.</b>");
				player.face.type = Face.DEER; //gain deer face
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.ears.type == Ears.DEER && player.tail.type == Tail.DEER && player.hasFur() && player.lowerBody.type != LowerBody.CLOVEN_HOOFED) {
				if (player.lowerBody.type == LowerBody.HOOFED)
					 outputText("\n\nYou feel a sharp stinging sensation from your hooves, accompanied by a loud CRACK.  You look down in alarm, prancing from one hooved foot to another, realizing that your solid, heavy hooves have been replaced with delicate, cloven hooves.  You squint, also noting a subtle thinness across your legs in general--if you had to guess, you’d hazard that you’re looking <b>more deer-like than horse-like</b>.");
				else outputText("\n\nYou feel a strange tightness from your feet and nearly topple over as your balance shifts.  You’re balancing on your toes for some reason.  You look down in amazement as your legs slim and lengthen, your feet elongating and darkening at the ends until you’re balancing on <b>two, graceful deer legs</b>.");
				player.lowerBody.type = LowerBody.CLOVEN_HOOFED; //change legs to cloven hooves
				if (!player.isTaur() && !player.isBiped()) player.lowerBody.legCount = 2;
				changes++;
			}
			//Genital Changes
			if (rand(3) == 0 && changes < changeLimit && player.cocks.length > 0) { //morph dick to horsediiiiick
				var selectedCockValue:int = -1; //changed as selectedCock and i caused duplicate var warnings
				for (var indexI:int = 0; indexI < player.cocks.length; indexI++) {
					if (player.cocks[indexI].cockType != CockTypesEnum.HORSE) { selectedCockValue = indexI; break; }
				}
				if (selectedCockValue != -1) {
					if (player.cocks[selectedCockValue].cockType == CockTypesEnum.HUMAN || player.cocks[selectedCockValue].cockType.Index > 2) //text for humandicks or others
						outputText("\n\nYour " + player.cockDescript(selectedCockValue) + " begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
					if (player.cocks[selectedCockValue].cockType == CockTypesEnum.DOG) //text for dogdicks
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd...  You pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond its traditional size.  You notice your knot vanishing, the extra flesh pushing more fresh horsecock out from your sheath.  <b>Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + "</b>, and you jerk yourself off, splattering thick ropes of cum with intense force.");
					player.cocks[selectedCockValue].cockType = CockTypesEnum.HORSE;
					player.increaseCock(selectedCockValue, 4);
					dynStats("lib", 5, "sen", 4, "lus", 35);
					outputText("<b>  You now have a");
					if (player.countCocksOfType(CockTypesEnum.HORSE) > 1) outputText("nother");
					outputText(" horse-penis.</b>");
					changes++;
				}
			}
			//Body thickness/tone changes
			if (rand(3) == 0 && player.tone > 20) {
				if (player.tone > 50) player.modTone(20, 2 + rand(3));
				else player.modTone(20, 2);
			}
			if (rand(3) == 0 && player.thickness > 20) {
				if (player.thickness > 50) player.modThickness(20, 2 + rand(3));
				else player.modThickness(20, 2);
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}

}