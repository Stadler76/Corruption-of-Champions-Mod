package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	import classes.lists.Gender;

	/**
	 * @since  March 27, 2018
	 * @author Stadler76
	 */
	public class EchidnaCake extends Consumable 
	{
		public function EchidnaCake() 
		{
			super(
				"EchidCk",
				"EchidCk",
				"an echidna cake",
				ConsumableLib.DEFAULT_VALUE,
				"Try our special cake, a favorite among the echidna-morphs!\n\nDISCLAIMER: We are not responsible if you find yourself altered."
			);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "echidnaTFs";
			var i:int = 0;
			var temp:int;
			mutations.initTransformation(null, 3);
			player.refillHunger(40);
			// Stats Changes
			//------------
			//None at the moment
			
			// Normal TFs
			//------------
			if (rand(4) == 0 && changes < changeLimit && player.hair.type != Hair.NORMAL && player.hair.type != Hair.QUILL) {
				outputText("\n\nYour scalp feels really strange, but the sensation is brief. You feel your hair, and you immediately notice the change. <b>It would seem that your hair is normal again!</b>");
				player.hair.type = Hair.NORMAL;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.arms.type == Arms.HARPY) {
				outputText("\n\nYour arm feathers fall out completely, <b>leaving only the " + player.skinFurScales() + " underneath.</b>");
				player.arms.type = Arms.HUMAN;
				changes++;
			}
			//Remove gills
			if (rand(3) == 0 && changes < changeLimit && player.hasGills()) mutations.updateGills();

			if (rand(3) == 0 && changes < changeLimit && player.eyes.type == Eyes.FOUR_SPIDER_EYES || player.eyes.type == Eyes.SPIDER) {
				outputText("\n\nYour eyes start throbbing painfully, your sight in them eventually going dark. You touch your head to inspect your eyes, only to find out that they have changed. <b>You have human eyes now!</b>");
				player.eyes.type == Eyes.HUMAN;
				player.eyes.count = 2;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.averageNipplesPerBreast() > 4) {
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely, the leftover nipples migrating to the middle of your breasts. <b>You are left with only one nipple on each breast.</b>");
				for (i = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].nipplesPerBreast = 1;
				}
				changes++;
			}
			// Main TFs
			//------------
			//Change to fur
			if (rand(3) == 0 && changes < changeLimit && !player.hasFur()) {
				outputText("\n\nYou shiver, feeling a bit cold. Just as you begin to wish for something to cover up with, it seems your request is granted; <b>fur begins to grow all over your body!</b> You tug at the tufts in alarm, but they're firmly rooted and... actually pretty soft. Huh. ");
				player.skin.adj = "";
				player.skin.desc = "fur";
				player.skin.type = Skin.FUR;
				player.skin.furColor = "brown";
				player.underBody.restore(); // Restore the underbody for now
				changes++;
			}
			//Gain Echidna ears
			if (rand(3) == 0 && changes < changeLimit && player.ears.type != Ears.ECHIDNA) {
				outputText("\n\n");
				switch(player.ears.type) {
					case Ears.LIZARD:
						outputText("You feel a strange itching in your reptilian ears. As you scratch them, you can feel their scales flaking away, leaving you with smooth, rounded holes for ears.");
						break;
					default:
						outputText("Tightness centers on your scalp, pulling your ears down from their normal shape into small bumps with holes in their centers.");
				}
				outputText(" <b>You now have echidna ears!</b>");
				player.ears.type = Ears.ECHIDNA;
				changes++;
			}
			//Gain Echidna tail
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.ECHIDNA && player.tail.type != Tail.ECHIDNA) {
				outputText("\n\n");
				switch(player.tail.type) {
					case Tail.NONE:
						outputText("You feel a brief pinch at the base of your spine. Reaching behind yourself, you find that a small stump has formed above your [ass], just barely enough to qualify as a tail.");
						break;
					case Tail.HARPY:
						outputText("You feel a soft tingle as your tail feathers fall out one by one, leaving you with just a little stump for a tail.");
						break;
					case Tail.RABBIT:
						outputText("Your tiny, poofy bunny tail begins to feel chilly as its fur falls out in clumps, leaving you with just a little stump for a tail.");
						break;
					case Tail.COW:
						outputText("Your ropey cow tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.CAT:
						outputText("Your long cat tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.DOG:
						outputText("Your wagging dog tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.KANGAROO:
						outputText("Your tapered kangaroo tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.LIZARD:
					case Tail.DRACONIC:
						outputText("Your long, tapered tail becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail. You now have an echidna tail!");
						break;
					case Tail.FOX:
						outputText("Your swishing fox tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.RACCOON:
						outputText("Your ringed raccoon tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.HORSE:
						if (player.isTaur()) outputText("Your shiny horse tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail. This new, mismatched tail looks a bit odd on your horse lower body.");
						else outputText("Your shiny horse tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.MOUSE:
						outputText("Your bald mouse tail becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.FERRET:
						outputText("Your tapered ferret tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case Tail.RHINO:
						outputText("The tip of your long rhino tail begins to itch as the fur begins to fall out. The entire length of your tail becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					default: //Catch-all
						outputText("You groan as you feel your tail shifting and reforming. By the time the sensation is over, you find that you have a little stump for a tail.");
				}
				outputText(" <b>You now have an echidna tail!</b>");
				player.tail.type = Tail.ECHIDNA;
				changes++;
			}
			//Gain Echidna legs
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.ECHIDNA && player.tail.type && Tail.ECHIDNA && player.lowerBody.type != LowerBody.ECHIDNA) {
				outputText("\n\n");
				switch(player.lowerBody.type) {
					//Irregular lower body type
					case LowerBody.NAGA:
						outputText("You collapse to the ground, a sharp pain encompassing your serpentine tail. The pain quickly becomes so severe that you black out on the spot. Eventually you awake to find that you no longer have the lower body of a snake. You have two legs again, and your feet look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LowerBody.GOO:
						outputText("You collapse to the ground, a sharp pain encompassing your amorphous lower half. The pain quickly becomes so severe that you black out on the spot. Eventually you awake to find that you no longer have a gooey lower body. You have two legs again, and your feet look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					//Regular lower body type (Bipedal)
					case LowerBody.HUMAN:
						outputText("You feel a sharp stinging at your toenails that only grows worse by the second. As you inspect your aching toes, you’re shocked to see that your toenails are lengthening, eventually becoming fierce claws. It would seem that the bottoms of your feet have changed as well. They’ve become padded!");
						break;
					case LowerBody.HOOFED:
					case LowerBody.CLOVEN_HOOFED:
						outputText("You nearly drop to the ground as a fuzzy sensation erupts at your hooves. Have they gone to sleep? As you inspect your feet, you find that they are no longer hooved! In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LowerBody.HARPY:
					case LowerBody.DEMONIC_CLAWS:
					case LowerBody.DEMONIC_HIGH_HEELS:
					case LowerBody.LIZARD:
					case LowerBody.DRAGON:
						outputText("Your feet feel strange, almost as if they’ve fallen asleep. What’s wrong with them? You take a look, and you’re shocked to see that your feet have changed. In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LowerBody.CAT:
					case LowerBody.DOG:
					case LowerBody.FOX:
					case LowerBody.KANGAROO:
					case LowerBody.BUNNY:
					case LowerBody.RACCOON:
					case LowerBody.FERRET:
						outputText("Ow! What’s wrong with your paws? They hurt! You sit down, taking a moment to inspect your aching paws. What’s this? It would appear that they’ve changed! In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					default: //Catch-all
						outputText("Your feet feel strange, almost as if they’ve fallen asleep. What’s wrong with them? You take a look, and you’re shocked to see that your feet have changed. In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
				}
				outputText(" <b>They actually look like the feet of an echidna!</b>");
				player.lowerBody.type = LowerBody.ECHIDNA;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//Gain Echidna cock
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.ECHIDNA) < player.cockTotal()) {
				outputText("\n\n");
				if (player.cockTotal() == 1) outputText("Your [cock] suddenly becomes rock hard out of nowhere. You " + player.clothedOrNakedLower("pull it out from your [armor], right in the middle of the food tent, watching", "watch") + " as it begins to shift and change. It becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath.");
				else outputText("One of your penises begins to feel strange. You " + player.clothedOrNakedLower("pull the offending cock out from your [armor], right in the middle of the food tent, watching", "watch") + " as it begins to shift and change. It becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath.");
				outputText(" <b>You now have an echidna penis!</b>");
				for (i = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType != CockTypesEnum.ECHIDNA) {
						player.cocks[i].cockType = CockTypesEnum.ECHIDNA;
						break;
					}
				}
				changes++;
			}
			//Gain Echidna tongue
			if (rand(3) == 0 && changes < changeLimit && player.echidnaScore() >= 2 && player.tongue.type != Tongue.ECHIDNA) {
				outputText("\n\nYou feel an uncomfortable pressure in your tongue as it begins to shift and change. Within moments, you are able to behold your long, thin tongue. It has to be at least a foot long. <b>You now have an echidna tongue!</b>");
				player.tongue.type = Tongue.ECHIDNA;
				changes++;
			}
			//Gain quill hair
			if (rand(4) == 0 && changes < changeLimit && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 1 && player.hair.type == Hair.NORMAL) {
				outputText("\n\nYour scalp begins to tingle as your hair falls out in clumps, leaving you with a bald head. You aren’t bald for long, though. An uncomfortable pressure racks the entirety of your scalp as hard quills begin to sprout from your hair pores. Their growth stops as they reach shoulder length. <b>You now have quills in place of your hair!</b>");
				player.hair.type = Hair.QUILL;
				changes++;
			}
			//Gain Echidna face if you have the right conditions.
			if (rand(4) == 0 && changes < changeLimit && player.hasFur() && player.ears.type == Ears.ECHIDNA && player.tail.type == Tail.ECHIDNA && player.tongue.type == Tongue.ECHIDNA) {
				outputText("You groan loudly as the bones in your face begin to reshape and rearrange. Most notable, you feel your mouth lengthening into a long, thin snout. <b>You now have an echidna face!</b>");
				player.face.type = Face.ECHIDNA;
				changes++;
			}
			// Other Changes
			//------------
			//Hair stops growing
			if (rand(4) == 0 && changes < changeLimit && player.echidnaScore() >= 2 && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
				outputText("\n\nYour scalp tingles oddly. In a panic, you reach up to your " + player.hairDescript() + ", but thankfully it appears unchanged.\n");
				outputText("(<b>Your hair has stopped growing.</b>)");
				changes++;
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD]++;
			}

			//Sexual changes
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.cumMultiplier < 25) {
				temp = 1 + rand(4);
				//Lots of cum raises cum multiplier cap to 2 instead of 1.5
				if (player.findPerk(PerkLib.MessyOrgasms) >= 0) temp += rand(10);
				temp *= 0.1;
				player.cumMultiplier += temp;
				//Flavor text
				if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.");
				if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ". It quickly settles, leaving them feeling somewhat more dense.");
				outputText(" A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.");
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.gender == Gender.MALE && player.averageBreastSize() > 2 && flags[kFLAGS.HYPER_HAPPY] == 0) {
				outputText("\n\nYou cup your tits as they begin to tingle strangely. You can actually feel them getting smaller in your hands!");
				player.shrinkTits();
				changes++;
			}
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk gain
			if (rand(4) == 0 && changes < changeLimit && player.echidnaScore() >= 3 && player.hasVagina() && player.findPerk(PerkLib.Oviposition) < 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			if (rand(3) == 0 && (rand(2) == 0 || !player.inHeat) && player.hasVagina() && player.statusEffectv2(StatusEffects.Heat) < 30) {
				player.goIntoHeat(true);
			}
			//Thickness and hip modifier
			if (rand(2) == 0 && player.thickness < 90) {
				player.modThickness(90, 2);
			}
			if (rand(2.4) == 0 && changes < changeLimit && player.hasVagina() && player.mf("m", "f") == "f" && player.hips.rating < 14) {
				outputText("\n\nAfter finishing, you find that your gait has changed. Did your [hips] widen?");
				player.hips.rating++;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}

	}
}
