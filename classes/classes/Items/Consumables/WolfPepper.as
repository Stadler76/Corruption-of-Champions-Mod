package classes.Items.Consumables
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	
	/**
	 * Wolf transformative item.
	 * 
	 * @author Foxwells
	 */
	public class WolfPepper extends Consumable
	{
		public function WolfPepper()
		{
			super("Wolf Pp","Wolf Pp", "a Wolf Pepper", ConsumableLib.DEFAULT_VALUE, "The pepper is shiny and black, bulbous at the base but long and narrow at the tip. It has a fuzzy feel to it and it smells spicy. Somehow, you know it's different from the usual Canine Peppers you see.")
		}
		
		// Fuck yo dog shit we full-on wolf bitches now -Foxwells
		override public function useItem():Boolean
		{
			var tfSource:String = "wolfPepper";
			var temp:int = 0; // best variable name ever!
			var temp2:Number = 0;
			var temp3:Number = 0;
			var crit:Number = 1;
			changes = 0;
			changeLimit = 1;
			if (rand(2) === 0) changeLimit++;
			if (rand(2) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			outputText("The pepper has an uncomfortable texture to it, being covered in soft fuzz like it's a peach but somewhat crunchy like any other pepper. Its spiciness makes you nearly spit it out, and you're left sniffling after.");
			if (rand(100) < 15) {
				crit = int(Math.random() * 20) / 10 + 2;
				outputText(" Maybe it was a bit too spicy... The pepper seemed far more ripe than what you'd expect.");
			}
			//STAT CHANGES - TOU SPE INT RANDOM CHANCE, LIB LUST COR ALWAYS UPPED
			dynStats("lib", 1 + rand(2), "lus", 5 + rand(10), "cor", 1 + rand(5));
			outputText("\n\nYou lick your lips after you finish. That spiciness hit you in more ways than one.");
			if (player.tou100 < 70 && rand(3) === 0 && changes < changeLimit) {
				dynStats("tou", (1 * crit));
				if (crit > 1) outputText("\n\nYou roll your shoulders and tense your arms experimentally. You feel more durable, and your blood seems to run through you more clearly. You know you have more endurance.");
				else outputText("\n\nYour muscles feel denser and more durable. Not so much that feel stronger, but you feel like you can take more hits.");
				//[removed:1.4.10]//changes++;
			}
			if (player.spe100 > 30 && rand(7) === 0 && changes < changeLimit) {
				dynStats("spe", (-1 * crit));
				if (crit > 1) outputText("\n\nThe pepper's strong taste makes you take a couple steps back and lean against the nearest solid object. You don't feel like you'll be moving very fast anymore.");
				else outputText("\n\nYou stumble forward, but manage to catch yourself. Still, though, you feel somewhat slower.");
				//[removed:1.4.10]//changes++;
			}
			if (player.inte100 < 60 && rand(7) === 0 && changes < changeLimit) {
				dynStats("int", (1 * crit));
				outputText("\n\nThe spiciness makes your head twirl, but you manage to gather yourself. A strange sense of clarity comes over you in the aftermath, and you feel ");
				if (crit > 1) outputText("a lot ");
				outputText("smarter somehow.");
				//[removed:1.4.10]//changes++;
			}
			//MUTATIONZZZZZ
			//PRE-CHANGES: become biped, remove horns, remove wings, give human tongue, remove claws, remove antennea
			//no claws
			if (rand(4) === 0) {
				mutations.updateClaws();
			}
			//remove antennae
			if (player.antennae.type !== Antennae.NONE && rand(3) === 0 && changes < changeLimit) {
				mutations.removeAntennae();
			}
			//remove horns
			if ((player.horns.type !== Horns.NONE || player.horns.value > 0) && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel your horns crumble, falling apart in large chunks until they flake away into nothing.");
				player.horns.value = 0;
				player.horns.type = Horns.NONE;
				changes++;
			}
			//remove wings
			if ((player.wings.type !== Wings.NONE || player.rearBody.type == RearBody.SHARK_FIN) && rand(3) === 0 && changes < changeLimit) {
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
			//give human tongue
			if (player.tongue.type !== Tongue.HUMAN && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou lick the roof of your mouth, noticing that your tongue feels different. It then hits you-- <b>You have a human tongue!</b>");
				player.tongue.type === Tongue.HUMAN;
				changes++;
			}
			//remove non-wolf eyes
			if (changes < changeLimit && rand(3) === 0 && player.eyes.type !== Eyes.HUMAN && player.eyes.type !== Eyes.WOLF) {
				if (player.eyes.type === Eyes.BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink. It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				} else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you. As you steady and open your eyes, you realize something seems different. Your vision is changed somehow.");
					if (player.eyes.type === Eyes.FOUR_SPIDER_EYES || player.eyes.type == Eyes.SPIDER) outputText(" Your arachnid eyes are gone!");
					outputText("  <b>You have normal, human eyes.</b>");
				}
				player.eyes.type = Eyes.HUMAN;
				player.eyes.count = 2;
				changes++;
			}
			//normal legs
			if (player.lowerBody.type !== LowerBody.WOLF && rand(4) === 0) {
				mutations.restoreLegs(tfSource);
			}
			//normal arms
			if (rand(4) === 0) {
				mutations.restoreArms(tfSource);
			}
			//remove feather hair
			if (rand(4) === 0) {
				mutations.removeFeatheryHair();
			}
			//remove basilisk hair
			if (rand(4) === 0) {
				mutations.removeBassyHair();
			}
			//MUTATIONZ AT ANY TIME: wolf dick, add/decrease breasts, decrease breast size if above D
			//get a wolf dick
			//if ya genderless we give ya a dick cuz we nice like that
			if (player.gender === 0 && player.cocks.length === 0 && changes < changeLimit) {
				outputText("\n\nYou double over as a pain fills your groin, and you take off your " + player.armorName + " just in time to watch a bulge push out of your body. The skin folds back and bunches up into a sheath, revealing a red, knotted wolf cock drooling pre-cum underneath it. You take a shuddering breath as the pain dies down, leaving you with only a vague sense of lust and quiet admiration for your new endowment. <b>You now have a wolf cock.</b>");
				player.createCock();
				player.cocks[0].cockLength = rand(4) + 4;
				player.cocks[0].cockThickness = rand(2);
				player.cocks[0].knotMultiplier = 1.5;
				player.cocks[0].cockType = CockTypesEnum.WOLF;
				dynStats("lib", 3, "sen", 2, "lus", 25);
				changes++;
			}
			//if ya got a dick that's ok too we'll change it to wolf
			if (player.hasCock()) { //shamelessly copy/pasted from dog cock
				if (player.wolfCocks() < player.cocks.length && changes < changeLimit && rand(2) === 0) {
					//Select first non-wolf cock
					temp = player.cocks.length;
					temp2 = 0;
					while (temp > 0 && temp2 === 0) {
						temp--;
						//Store cock index if not a wolfCock and exit loop
						if (player.cocks[temp].cockType !== CockTypesEnum.WOLF) {
							temp3 = temp;
							//kicking out of the loop
							temp2 = 1000;
						}
					}
					//Using generic description because what's even the point of multiple descriptions--
					if (player.cocks[temp3].cockType.Index > 4) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " trembles, resizing and reshaping itself into a shining, red wolf cock with a fat knot at the base. <b>You now have a wolf cock.</b>");
						dynStats("sen", 3, "lus", 5 * crit);
						if (player.cocks[temp3].cockType === CockTypesEnum.HORSE) { //horses get changes
							if (player.cocks[temp3].cockLength > 6) player.cocks[temp3].cockLength -= 2;
							else player.cocks[temp3].cockLength -= .5;
							player.cocks[temp3].cockThickness += .5;
						}
					}
					player.cocks[temp3].cockType = CockTypesEnum.WOLF;
					player.cocks[temp3].knotMultiplier = 1.5;
					player.cocks[temp3].thickenCock(2);
					changes++;
				}
			}
			//titties for those who got titties
			//wolfs have 8 nips so, 4 rows max. fen has no power here I'm making a wolf not a dog.
			//tbh also shamelessly copy/pasted from dog and adjusted according
			if (player.breastRows.length > 0 && player.breastRows.length <= 4) {
				if (player.breastRows[0].breastRating > 0) {
					if (player.breastRows.length < 4 && rand(2) === 0 && changes < changeLimit) {
						player.createBreastRow();
						//Store temp to the index of the newest row
						temp = player.breastRows.length - 1;
						//Breasts are too small to grow a new row, so they get bigger first
						if (player.breastRows[0].breastRating <= player.breastRows.length) {
							outputText("\n\nYour " + player.breastDescript(0) + " feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach ");
							player.breastRows[0].breastRating += 1;
							outputText(player.breastCup(0) + " size.");
							changes++;
						}
						//Had 1 row to start
						if (player.breastRows.length === 2 && changes < changeLimit) {
							//1 size below primary breast row
							player.breastRows[temp].breastRating = player.breastRows[0].breastRating - 1;
							if (player.breastRows[0].breastRating - 1 === 0) outputText("\n\nA second set of breasts forms under your current pair, stopping while they are still fairly flat and masculine looking.");
							else outputText("\n\nA second set of breasts bulges forth under your current pair, stopping as they reach " + player.breastCup(temp) + "s.");
							outputText(" A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							dynStats("sen", 2, "lus", 5);
							changes++;
						}
						//Many breast Rows - requires larger primary tits
						if (player.breastRows.length > 2 && player.breastRows[0].breastRating > player.breastRows.length && changes < changeLimit) {
							dynStats("sen", 2, "lus", 5);
							//New row's size = the size of the row above -1
							player.breastRows[temp].breastRating = player.breastRows[temp - 1].breastRating - 1;
							//If second row are super small but primary row is huge it could go negative.
							//This corrects that problem.
							if (player.breastRows[temp].breastRating < 0) player.breastRows[temp].breastRating = 0;
							if (player.breastRows[temp - 1].breastRating < 0) player.breastRows[temp - 1].breastRating = 0;
							if (player.breastRows[temp].breastRating === 0) outputText("\n\nYour abdomen tingles and twitches as a new row of breasts sprouts below the others. Your new breasts stay flat and masculine, not growing any larger.");
							else outputText("\n\nYour abdomen tingles and twitches as a new row of " + player.breastCup(temp) + " " + player.breastDescript(temp) + " sprouts below your others.");
							outputText(" A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							changes++;
						}
						//Extra sensitive if crit
						if (crit > 1) {
							if (crit > 2) {
								outputText(" You heft your new chest experimentally, exploring the new flesh with tender touches. Your eyes nearly roll back in your head from the intense feelings.");
								dynStats("sen", 8, "lus", 15)
							} else {
								outputText(" You touch your new nipples with a mixture of awe and desire, the experience arousing beyond measure. You squeal in delight, nearly orgasming, but in time finding the willpower to stop yourself.");
								dynStats("sen", 4, "lus", 10);
							}
						}
					
					}
					//If already has max breasts
					else if (rand(2) === 0) {
						//Check for size mismatches, and move closer to spec
						temp = player.breastRows.length;
						temp2 = 0;
						var evened: Boolean = false;
						//Check each row, and if the row above or below it is
						while (temp > 1 && temp2 === 0) {
							temp--;
							if (player.breastRows[temp].breastRating + 1 < player.breastRows[temp - 1].breastRating) {
								if (!evened) {
									evened = true;
									outputText("\n");
								}
								outputText("\nYour ");
								if (temp === 0) outputText("first ");
								if (temp === 1) outputText("second ");
								if (temp === 2) outputText("third ");
								if (temp === 3) outputText("fourth ");
								if (temp > 3) outputText("");
								outputText("row of " + player.breastDescript(temp) + " grows larger, as if jealous of the jiggling flesh above.");
								temp2 = (player.breastRows[temp - 1].breastRating) - player.breastRows[temp].breastRating - 1;
								if (temp2 > 4) temp2 = 4;
								if (temp2 < 1) temp2 = 1;
								player.breastRows[temp].breastRating += temp2;
							}
						}
					}
				}
			}
			//Remove breast rows if over 4
			if (changes < changeLimit && player.bRows() > 4 && rand(3) === 0) {
				mutations.removeExtraBreastRow(tfSource);
			}
			//Grow breasts if has vagina and has no breasts/nips
			else if (player.hasVagina() && player.bRows() === 0 && player.breastRows[0].breastRating === 0 && player.nippleLength === 0 && rand(2) === 0 && changes < changeLimit) {
				outputText("\n\nYour chest tingles uncomfortably as your center of balance shifts. <b>You now have a pair of D-cup breasts.</b>");
				outputText(" A sensitive nub grows on the summit of each tit, becoming a new nipple.");
				player.createBreastRow();
				player.breastRows[0].breastRating = 4;
				player.breastRows[0].breasts = 2;
			player.nippleLength = 0.25;
				dynStats("sen", 4, "lus", 6);
				changes++;
			}
			//Shrink breasts if over D-cup
			if (changes < changeLimit && rand(3) === 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				temp2 = 0;
				temp3 = 0;
				//Determine if shrinking is required
				if (player.biggestTitSize() > 4) temp2 = 4;
				if (temp2 > 0) {
					//temp3 stores how many rows are changed
					temp3 = 0;
					for (var k: Number = 0; k < player.breastRows.length; k++) {
						//If this row is over threshhold
						if (player.breastRows[k].breastRating > temp2) {
							//Big change
							if (player.breastRows[k].breastRating > 10) {
								player.breastRows[k].breastRating -= 2 + rand(3);
								if (temp3 === 0) outputText("\n\nThe " + player.breastDescript(0) + " on your chest wobble for a second, then tighten up, losing several cup-sizes in the process!");
								else outputText(" The change moves down to your " + num2Text2(k + 1) + " row of " + player.breastDescript(0) + ". They shrink greatly, losing a couple cup-sizes.");
							}
							//Small change
							else {
								player.breastRows[k].breastRating -= 1;
								if (temp3 === 0) outputText("\n\nAll at once, your sense of gravity shifts. Your back feels a sense of relief, and it takes you a moment to realize your " + player.breastDescript(k) + " have shrunk!");
								else outputText(" Your " + num2Text2(k + 1) + " row of " + player.breastDescript(k) + " gives a tiny jiggle as it shrinks, losing some off its mass.");
							}
							//Increment changed rows
							temp3++;
						}
					}
				}
				//Count shrinking
				if (temp3 > 0) changes++;
			}
			//MUTATIONZ LEVEL 1: fur, stop hair growth, ears, tail
			//Gain fur
			if (rand(5) === 0 && changes < changeLimit && !player.hasFur()) {
				var wolfFurColors: Array = [
					"white",
					"gray",
					"dark gray",
					"light gray",
					"black",
					"light brown",
					"sandy brown",
					"golden",
					"silver",
					"brown",
					"auburn",
					["black", "gray"],
					["black", "brown"],
					["black", "silver"],
					["black", "auburn"],
					["white", "gray"],
					["white", "silver"],
					["white", "golden"],
				];
				outputText("\n\nYour " + player.skin.desc + " begins to tingle, then itch. ");
				player.skin.type = Skin.FUR;
				player.skin.desc = "fur";
				player.setFurColor(wolfFurColors, {
					type: UnderBody.FURRY
				}, true);
				outputText("You reach down to scratch your arm absent-mindedly and pull your fingers away to find strands of " + player.skin.furColor + " fur. You stare at it. Fur. Wait, you just grew fur?! What happened?! Your mind reeling, you do know one thing for sure: <b>you now have fur!</b>");
				changes++;
			}
			//Ears time
			if (rand(3) === 0 && player.ears.type !== Ears.WOLF && changes < changeLimit) {
				if (player.ears.type === -1) outputText("\n\nTwo painful nubs begin sprouting from your head, growing and opening into canine ears. ");
				if (player.ears.type === Ears.HUMAN) outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate, becoming canine in nature. ");
				if (player.ears.type === Ears.HORSE) outputText("\n\nYour equine ears twist as they transform into canine versions. ");
				if (player.ears.type === Ears.DOG) outputText("\n\nYour dog ears widen out, curving and becoming more aware of your surroundings. ");
				if (player.ears.type > Ears.WOLF) outputText("\n\nYour ears transform, becoming more canine in appearance. ");
				player.ears.type = Ears.WOLF;
				player.ears.value = 2;
				outputText("<b>You now have wolf ears.</b>");
				changes++;
			}
			//Wolf tail
			if (rand(3) === 0 && changes < changeLimit && player.tail.type !== Tail.WOLF) {
				if (player.tail.type === Tail.NONE) outputText("\n\nA pressure builds on your backside. You feel under your clothes and discover an odd, thick bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grows most of the way to the ground. A nushy coat of fur springs up to cover your new tail.  ");
				if (player.tail.type === Tail.HORSE) outputText("\n\nYou feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together. In seconds they fuse into a single, thick tail, rapidly sprouting bushy fur. ");
				if (player.tail.type === Tail.DEMONIC) outputText("\n\nThe tip of your tail feels strange. As you pull it around to check on it, the spaded tip disappears, quickly replaced by a bushy coat of fur over the entire surface of your tail. Your tail thickens with it. ");
				if (player.tail.type >= Tail.COW) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a thick, bushy tail. ");
				changes++;
				player.tail.type = Tail.WOLF;
				outputText("<b>You now have a wolf tail!</b>");
			}
			//Sets hair normal
			if (player.hair.type !== Hair.NORMAL && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou reach up and feel the top of your head as it begins to tingle. You put a hand on the top of your head and slowly pull it down. Chunks of your " + player.hairDescript() + " come with, replaced by a set of normal, human hair.");
				player.hair.type = Hair.NORMAL;
				changes++;
			}
			//MUTATIONZ LEVEL 2: fur->arms fur+tail+ears->face stophair->nohair fur+tail->legs
			//gain wolf face
			if (player.face.type !== Face.WOLF && player.ears.type === Ears.WOLF && player.tail.type === Tail.WOLF && player.hasFur() && rand(5) === 0 && changes < changeLimit) {
				outputText("\n\nYou screech in pain as the bones of your face begin to rearrange themselves. Your [skinFurScales] practically melts off you, dropping onto the ground with heavy streams of blood. You put your hands to your face, writhing, blackness covering your vision as pain overwhelms you. But as quickly as it came, it stops, and you pull your shaking hands from your face. You scramble to the nearest reflective surface. <b>You have a wolf's face!</b>");
				player.face.type = Face.WOLF;
				changes++;
			}
			//legz
			if (player.lowerBody.legCount === 2 && player.lowerBody.type !== LowerBody.WOLF && player.tail.type === Tail.WOLF && player.skin.type === Skin.FUR && rand(4) === 0 && changes < changeLimit) {
				//Hooman feets
				if (player.lowerBody.type === LowerBody.HUMAN) outputText("\n\nYou stumble and fall, howling in pain as your legs and feet break apart and reform into wolf-like legs and paws. The worst of the pain eventually passes, but you're still left whimpering for a while. <b>You now have paws!</b>");
				//Hooves -> Paws
				else if (player.lowerBody.type === LowerBody.HOOFED) outputText("\n\nYou feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred paws. <b>You now have paws!</b>");
				else outputText("\n\nYour lower body is suddenly wracked by pain, causing you to collapse onto the ground in agony. Once it passes, you discover that you're standing on fur-covered paws. <b>You now have paws!</b>");
				player.lowerBody.type = LowerBody.WOLF;
				changes++;
			}
			//MUTATIONZ LEVEL 3: face->eyes
			if (player.eyes.type !== Eyes.WOLF && player.face.type === Face.WOLF && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel a sudden surge of pain in your face as your eyes begin to change. You close them and feel something wet slide under your eyelids. You jump in surprise. The feeling's gone, but now the distance is a blurred view, and greens seem to be mixed with yellows.");
				outputText("\n\nYou turn to a nearby reflective surface to investigate. Your eyes have massive amber irises and are dipped into your face, hiding any sign of your sclera. Blackness surrounds them and emphasise the wolfish shape of your face. You blink a few times as you stare at your reflection. <b>You now have wolf eyes!</b> Your peripherals and night vision has probably improved, too.");
				player.eyes.type = Eyes.WOLF;
				changes++;
			}
			//MISC CRAP
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			if (rand(3) === 0) {
				outputText(player.modTone(100, 4));
			}
			if (rand(3) === 0) {
				outputText(player.modThickness(75, 3));
			}
			player.refillHunger(10);
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
