package classes.Items.Consumables 
{
	import classes.Appearance;
	import classes.CoC_Settings;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Equine transformative item.
	 */
	public class Equinum extends Consumable 
	{
		public function Equinum() 
		{
			super("Equinum", "Equinum", "a vial of Equinum", ConsumableLib.DEFAULT_VALUE, "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.");
		}
		
		override public function useItem():Boolean {
			var tfSource:String = "equinum";
			player.slimeFeed();
			//Changes done
			changes = 0;
			//Change limit
			changeLimit = 1;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Store location of cock to be changed
			var old:Number = 0;
			//Chancee to raise limit
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Used for random chances
			// Maybe we should implement new Enums for furcolors and probably other colors and tones?
			// For example: FurColorsEnum.HORSE, ScaleColorsEnum.LIZARD, SkinTonesEnum.HUMAN, SkinTonesEnum:SALAMANDER, HairColorsEnum.HUMAN and so on (Stadler76)
			var horseFurColors:Array = ["brown", "chocolate", "auburn", "sandy brown", "caramel", "peach", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "brown and white", "black and white"];
			//Set up output
			clearOutput();
			outputText("You down the potion, grimacing at the strong taste.");
			//CHANCE OF BAD END - 20% if face/tail/skin/cock are appropriate.
			if (player.hasFur() && player.faceType === FACE_HORSE && player.tailType === TAIL_TYPE_HORSE && player.lowerBody === LOWER_BODY_TYPE_HOOFED) {
				//WARNINGS
				//Repeat warnings
				if (player.hasStatusEffect(StatusEffects.HorseWarning) && rand(3) === 0) {
					if (player.statusEffectv1(StatusEffects.HorseWarning) === 0) outputText("<b>\n\nYou feel a creeping chill down your back as your entire body shivers, as if rejecting something foreign.  Maybe you ought to cut back on the horse potions.</b>");
					if (player.statusEffectv1(StatusEffects.HorseWarning) > 0) outputText("<b>\n\nYou wonder how many more of these you can drink before you become a horse...</b>");
					player.addStatusValue(StatusEffects.HorseWarning,1,1);
				}
				//First warning
				if (!player.hasStatusEffect(StatusEffects.HorseWarning)) {
					outputText("<b>\n\nWhile you drink the tasty potion, you realize how horse-like you already are, and wonder what else the potion could possibly change...</b>");
					player.createStatusEffect(StatusEffects.HorseWarning, 0, 0, 0, 0);
				}
				//Bad End
				if (rand(4) === 0 && player.hasStatusEffect(StatusEffects.HorseWarning) && player.findPerk(PerkLib.TransformationResistance) < 0) {
					//Must have been warned first...
					if (player.statusEffectv1(StatusEffects.HorseWarning) > 0) {
						//If player has dicks check for horsedicks
						if (player.cockTotal() > 0) {
							//If player has horsedicks
							if (player.countCocksOfType(CockTypesEnum.HORSE) > 0) {
								outputText("\n\nSoon after you drink the Equinum, a burning sensation fills your chest. You have consumed too much of the potion, and the overdose starts to provoke dramatic changes in your body.  You collapse suddenly, twitching in pain as all the bones and muscles in your body break and reform. Eventually, you pass out from the strain you are put through.\n\nYou wake up after a few minutes. Once you get up on your legs, doubt fills your mind. You rush to a nearby pond and look down, nearly jumping when the reflection of a ");
								if (player.gender === 0 || player.gender === 3) outputText("horse ");
								if (player.gender === 1) outputText("stallion ");
								if (player.gender === 2) outputText("mare ");
								outputText(" with beautiful " + player.hairColor + " " + player.skinDesc + " covering its body gazes back up at you.  That's you, and yet the doubt in your mind remains. Strange images fill your mind, and you feel as if you have not always been a horse, but some kind of funny fur-less creature standing on two legs. Your equine mind rapidly dismisses that doubt as a daydream however, and you trot away, oblivious to who you once were.\n\n");
								outputText("<b>One year later...</b>\n\nAs you graze upon the small plants that coat the open plains of your home, you hear a noise on your right side. As you raise your head to check where the noise comes from, preparing to run from a potential predator, you see a strange creature. It stands on its two feet, its furless pink skin appearing beneath its clothes.  With a start, you realize you can identify the strange creatures gender.  ");
								if (player.gender === 0 || player.gender === 1) outputText("He is clearly a male, but you are somewhat confused as you can see not one but three bulges where his manhood would be.\n\n");
								if (player.gender === 2) outputText("She is clearly a female, as you can see her six breasts jiggle as she walks towards you, small stains appearing on her shirt where her nipples are.\n\n");
								if (player.gender === 3) outputText("You are somewhat confused as you can see a bulge near her thighs but also huge boobs jiggling as she walks, and you can't say if she's a male or female.\n\n");
								outputText("As soon as you lay eyes on the creature, a wave of nostalgia overtakes you. Somehow, looking at that creature makes you sad, as if you forgot something important.\n\n\"<i>How strange to see a horse here all alone,</i>\" the creature muses, \"<i>In any case, you're still the least bizarre creature I've met here.  Not to mention the only one that hasn't tried to rape me,</i>\" it says with a sigh.\n\nYou answer with an interrogative whinny.\n\n\"<i>Hey, I've got an idea. I'll take you back to the camp. I'll feed you and in return you can help me complete my quest. What do you say?</i>\"\n\nInstinctively, you utter a happy and approving whinny.\n\nYou failed in your quest, losing your focus and more importantly, losing yourself.  But, even so, you found a new meaning to your life, and have a new chance to succeed where you once failed.");
								getGame().gameOver();
								return false;
							}
						}
						//If player has no cocks
						else {
							outputText("\n\nSoon after you drink the Equinum, a burning sensation fills your chest. You have consumed too much of the drink, and the overdose starts to provoke dramatic changes in your body.  You collapse suddenly, twitching in pain as all the bones and all the muscles in your body break and reform. Eventually, you pass out from the strain you are put through.\n\nYou wake up after a few minutes. Once you get up on your legs, doubt fills your mind. You rush to a nearby pond and look down, nearly jumping when the reflection of a ");
							if (player.gender === 0 || player.gender === 3) outputText("horse ");
							if (player.gender === 1) outputText("stallion ");
							if (player.gender === 2) outputText("mare ");
							outputText("with beautiful " + player.hairColor + " " + player.skinDesc + " covering its body looks back at you.  That's you, and yet the doubt in your mind remains. Strange mental images fill your mind.  You feel as if you have not always been a horse, but some kind of funny fur-less creature standing on two legs. But your equine mind rapidly dismisses that doubt as a daydream, and you trot away, oblivious to who you once were.\n\n");
							outputText("<b>One year after...</b>\n\nAs you graze small plants in the open plains that became your home, you hear a noise on your right side. As you raise your head to check where the noise comes from, preparing to run from a potential predator, you see a strange creature. It stands on two feet, its furless pink skin appearing beneath its clothes.  ");
							if (player.gender === 0 || player.gender === 1) outputText("He is clearly a male, but you are somewhat confused as you can see not one but three bulges where his manhood would be.\n\n");
							if (player.gender === 2) outputText("She is clearly a female, as you can see her six breasts jiggle as she walks towards you, small stains appearing on her shirt where her nipples are.\n\n");
							if (player.gender === 3) outputText("You are somewhat confused as you can see a bulge near her thighs but also huge boobs jiggling as she walks, and you can't say if she's a male or female.\n\n");
							outputText("As soon as you lay eyes on the creature, a wave of nostalgia overtakes you. Somehow, looking at that creature makes you sad, as if you forgot something important.\n\n\"<i>How strange to see a horse here all alone,</i>\" the creature muses, \"<i>In any case, you're still the least bizarre creature I've met here.  Not to mention the only one that hasn't tried to rape me,</i>\" it says with a sigh.\n\nYou answer with an interrogative whinny.\n\n\"<i>Hey, I've got an idea. I'll take you back to the camp. I'll feed you and in return you can help me to complete my quest. What do you say?</i>\"\n\nInstictively, you utter a happy and approving whinny.\n\nYou failed in your quest, losing you focus and more importantly, losing yourself.  But, even so, you found a new meaning to your life, and have a new chance to achieve what you once failed.");
							getGame().gameOver();
							return false;
						}
					}
				}

			}
			//Stat changes first
			//STRENGTH
			if (rand(2) === 0) {
				//Maxxed
				if (player.str100 >= 60) {
					outputText("\n\nYou feel strong enough to single-handedly pull a fully-loaded wagon.");
				}
				//NOT MAXXED
				else {
					dynStats("str", 1);
					outputText("\n\nYour muscles clench and surge, making you feel as strong as a horse.");
					changes++;
				}
			}
			//TOUGHNESS
			if (rand(2) === 0) {
				//MAXXED ALREADY
				if (player.tou100 >= 75) {
					outputText("\n\nYour body is as tough and solid as a ");
					if (player.gender === 1 || player.gender === 3) outputText("stallion's.");
					else outputText("mare's.");
				}
				//NOT MAXXED
				else {
					dynStats("tou", 1.25);
					outputText("\n\nYour body suddenly feels tougher and more resilient.");
					changes++;
				}
			}
			//INTELLECT
			if (rand(3) === 0) {
				if (player.inte100 <= 5) {
					outputText("\n\nYou let out a throaty \"Neiiiigh\" as your animalistic instincts take over.");
				}
				if (player.inte100 < 10 && player.inte100 > 5) {
					dynStats("int", -1);
					outputText("\n\nYou smile vacantly as you drink the potion, knowing you're just a big dumb animal who loves to fuck.");
					changes++;
				}
				if (player.inte100 <= 20 && player.inte100 >= 10) {
					dynStats("int", -2);
					outputText("\n\nYou find yourself looking down at the empty bottle in your hand and realize you haven't thought ANYTHING since your first sip.");
					changes++;
				}
				if (player.inte100 <= 30 && player.inte100 > 20) {
					dynStats("int", -3);
					outputText("\n\nYou smile broadly as your cares seem to melt away.  A small part of you worries that you're getting dumber.");
					changes++;
				}
				if (player.inte100 <= 50 && player.inte100 > 30) {
					dynStats("int", -4);
					outputText("\n\nIt becomes harder to keep your mind focused as your intellect diminishes.");
					changes++;
				}
				if (player.inte100 > 50) {
					dynStats("int", -5);
					outputText("\n\nYour usually intelligent mind feels much more sluggish.");
					changes++;
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Restore arms to become human arms again
			if (rand(4) === 0) {
				mutations.restoreArms(tfSource);
			}
			//Remove feathery hair
			mutations.removeFeatheryHair();
			//
			//SEXUAL CHARACTERISTICS
			//
			//MALENESS.
			if ((player.gender === 1 || player.gender === 3) && rand(1.5) === 0 && changes < changeLimit) {
				//If cocks that aren't horsified!
				if ((player.countCocksOfType(CockTypesEnum.HORSE) + player.countCocksOfType(CockTypesEnum.DEMON)) < player.cocks.length) {
					//Transform a cock and store it's index value to talk about it.
					//Single cock
					if (player.cocks.length === 1) {
						temp = 0;
						//Use temp3 to track whether or not anything is changed.
						temp3 = 0;
						if (player.cocks[0].cockType === CockTypesEnum.HUMAN) {
							outputText("\n\nYour " + player.cockDescript(0) + " begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
							temp = player.addHorseCock();
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (player.cocks[0].cockType === CockTypesEnum.DOG) {
							temp = player.addHorseCock();
							outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond it's traditional size.  You notice your knot vanishing, the extra flesh pushing more horsecock out from your sheath.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (player.cocks[0].cockType === CockTypesEnum.TENTACLE) {
							temp = player.addHorseCock();
							outputText("\n\nYour " + player.cockDescript(0) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + player.cockDescript(0) + " as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (player.cocks[0].cockType.Index > 4) {
							outputText("\n\nYour " + player.cockDescript(0) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + player.cockDescript(0) + " as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
							temp = player.addHorseCock();
							temp2 = player.increaseCock(temp, rand(4) + 4);
							temp3 = 1;
							dynStats("lib", 5, "sen", 4, "lus", 35);
						}
						if (temp3 === 1) outputText("  <b>Your penis has transformed into a horse's!</b>");
					}
					//MULTICOCK
					else {
						dynStats("lib", 5, "sen", 4, "lus", 35);
						temp = player.addHorseCock();
						outputText("\n\nOne of your penises begins to feel strange.  You pull down your clothes to take a look and see the skin of your " + player.cockDescript(temp) + " darkening to a mottled brown and black pattern.");
						if (temp === -1) {
							CoC_Settings.error("");
							clearOutput();
							outputText("FUKKKK ERROR NO COCK XFORMED");
						}
						//Already have a sheath
						if (player.countCocksOfType(CockTypesEnum.HORSE) > 1 || player.dogCocks() > 0) outputText("  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.");
						else outputText("  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your " + player.cockDescript(temp) + "'s root, tightening and pulling your " + player.cockDescript(temp) + " inside its depths.");
						temp2 = player.increaseCock(temp, rand(4) + 4);
						outputText("  The shaft suddenly explodes with movement, growing longer and developing a thick flared head leaking steady stream of animal-cum.");
						outputText("  <b>You now have a horse-cock.</b>");
					}
					//Make cock thicker if not thick already!
					if (player.cocks[temp].cockThickness <= 2) player.cocks[temp].thickenCock(1);
					changes++;
				}
				//Players cocks are all horse-type - increase size!
				else {
					//single cock
					if (player.cocks.length === 1) {
						temp2 = player.increaseCock(0, rand(3) + 1);
						temp = 0;
						dynStats("sen", 1, "lus", 10);
					}
					//Multicock
					else {
						//Find smallest cock
						//Temp2 = smallness size
						//temp = current smallest
						temp3 = player.cocks.length;
						temp = 0;
						while (temp3 > 0) {
							temp3--;
							//If current cock is smaller than saved, switch values.
							if (player.cocks[temp].cockLength > player.cocks[temp3].cockLength) {
								temp2 = player.cocks[temp3].cockLength;
								temp = temp3;
							}
						}
						//Grow smallest cock!
						//temp2 changes to growth amount
						temp2 = player.increaseCock(temp, rand(4) + 1);
						dynStats("sen", 1, "lus", 10);
					}
					outputText("\n\n");
					if (temp2 > 2) outputText("Your " + player.cockDescript(temp) + " tightens painfully, inches of taut horse-flesh pouring out from your sheath as it grows longer.  Thick animal-pre forms at the flared tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) outputText("Aching pressure builds within your sheath, suddenly releasing as an inch or more of extra dick flesh spills out.  A dollop of pre beads on the head of your enlarged " + player.cockDescript(temp) + " from the pleasure of the growth.");
					if (temp2 <= 1) outputText("A slight pressure builds and releases as your " + player.cockDescript(temp) + " pushes a bit further out of your sheath.");
					changes++;
				}
				//Chance of thickness + daydream
				if (rand(2) === 0 && changes < changeLimit && player.countCocksOfType(CockTypesEnum.HORSE) > 0) {
					temp3 = 0;
					temp2 = player.cocks.length;
					while (temp2 > 0) {
						temp2--;
						if (player.cocks[temp2].cockThickness <= player.cocks[temp3].cockThickness) {
							temp3 = temp2;
						}
					}
					temp = temp3;
					player.cocks[temp].thickenCock(.5);
					outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " thickens inside its sheath, growing larger and fatter as your veins thicken, becoming more noticeable.  It feels right");
					if (player.cor + player.lib < 50) outputText(" to have such a splendid tool.  You idly daydream about cunts and pussies, your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " plowing them relentlessly, stuffing them pregnant with cum");
					if (player.cor + player.lib >= 50 && player.cor + player.lib < 80) outputText(" to be this way... You breath the powerful animalistic scent and fantasize about fucking centaurs night and day until their bellies slosh with your cum");
					if (player.cor + player.lib >= 75 && player.cor + player.lib <= 125) outputText(" to be a rutting stud.  You ache to find a mare or centaur to breed with.  Longing to spend your evenings plunging a " + Appearance.cockNoun(CockTypesEnum.HORSE) + " deep into their musky passages, dumping load after load of your thick animal-cum into them.  You'd be happy just fucking horsecunts morning, noon, and night.  Maybe somewhere there is a farm needing a breeder..");
					if (player.cor + player.lib > 125) outputText(" to whinny loudly like a rutting stallion.  Your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " is perfect for fucking centaurs and mares.  You imagine the feel of plowing an equine pussy deeply, bottoming out and unloading sticky jets of horse-jizz into its fertile womb.  Your hand strokes your horsecock of its own accord, musky pre dripping from the flared tip with each stroke.  Your mind wanders to the thought of you with a harem of pregnant centaurs.");
					outputText(".");
					if (player.cor < 30) outputText("  You shudder in revulsion at the strange thoughts and vow to control yourself better.");
					if (player.cor >= 30 && player.cor < 60) outputText("  You wonder why you thought such odd things, but they have a certain appeal.");
					if (player.cor >= 60 && player.cor < 90) outputText("  You relish your twisted fantasies, hoping to dream of them again.");
					if (player.cor >= 90) outputText("  You flush hotly and give a twisted smile, resolving to find a fitting subject to rape and relive your fantasies.");
					dynStats("lib", .5, "lus", 10);
				}
				//Chance of ball growth if not 3" yet
				if (rand(2) === 0 && changes < changeLimit && player.ballSize <= 3 && player.countCocksOfType(CockTypesEnum.HORSE) > 0) {
					if (player.balls === 0) {
						player.balls = 2;
						player.ballSize = 1;
						outputText("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.");
						dynStats("lib", 2, "lus", 5);
					}
					else {
						player.ballSize++;
						if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
						if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ".  Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
						dynStats("lib", 1, "lus", 3);
					}
					changes++;
				}
			}
			//FEMALE
			if (player.gender === 2 || player.gender === 3) {
				//Single vag
				if (player.vaginas.length === 1) {
					if (player.vaginas[0].vaginalLooseness <= VAGINA_LOOSENESS_GAPING && changes < changeLimit && rand(2) === 0) {
						outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your " + player.vaginaDescript(0) + " has grown larger, in depth AND size.");
						player.vaginas[0].vaginalLooseness++;
						changes++;
					}
					if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_NORMAL && changes < changeLimit && rand(2) === 0) {
						outputText("\n\nYour " + player.vaginaDescript(0) + " moistens perceptably, giving off an animalistic scent.");
						player.vaginas[0].vaginalWetness++;
						changes++;
					}
				}
				//Multicooch
				else {
					//determine least wet
					//temp - least wet
					//temp2 - saved wetness
					//temp3 - counter
					temp = 0;
					temp2 = player.vaginas[temp].vaginalWetness;
					temp3 = player.vaginas.length;
					while (temp3 > 0) {
						temp3--;
						if (temp2 > player.vaginas[temp3].vaginalWetness) {
							temp = temp3;
							temp2 = player.vaginas[temp].vaginalWetness;
						}
					}
					if (player.vaginas[temp].vaginalWetness <= VAGINA_WETNESS_NORMAL && changes < changeLimit && rand(2) === 0) {
						outputText("\n\nOne of your " + player.vaginaDescript(temp) + " moistens perceptably, giving off an animalistic scent.");
						player.vaginas[temp].vaginalWetness++;
						changes++;
					}
					//determine smallest
					//temp - least big
					//temp2 - saved looseness
					//temp3 - counter
					temp = 0;
					temp2 = player.vaginas[temp].vaginalLooseness;
					temp3 = player.vaginas.length;
					while (temp3 > 0) {
						temp3--;
						if (temp2 > player.vaginas[temp3].vaginalLooseness) {
							temp = temp3;
							temp2 = player.vaginas[temp].vaginalLooseness;
						}
					}
					if (player.vaginas[0].vaginalLooseness <= VAGINA_LOOSENESS_GAPING && changes < changeLimit && rand(2) === 0) {
						outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize one of your " + player.vaginaDescript(temp) + " has grown larger, in depth AND size.");
						player.vaginas[temp].vaginalLooseness++;
						changes++;
					}
				}
				if (player.statusEffectv2(StatusEffects.Heat) < 30 && rand(2) === 0 && changes < changeLimit) {
					if (player.goIntoHeat(true)) {
						changes++;
					}
				}

				if (!flags[kFLAGS.HYPER_HAPPY])
				{
					if (rand(2) === 0 && changes < changeLimit) {
						//Shrink B's!
						//Single row
						if (player.breastRows.length === 1) {
							//Shrink if bigger than B cups
							if (player.breastRows[0].breastRating > 3) {
								temp = 1;
								player.breastRows[0].breastRating--;
								//Shrink again if huuuuge
								if (player.breastRows[0].breastRating > 8) {
									temp++;
									player.breastRows[0].breastRating--;
								}
								//Talk about shrinkage
								if (temp === 1) outputText("\n\nYou feel a weight lifted from you, and realize your " + player.breastDescript(0) + " have shrunk to a " + player.breastCup(0) + ".");
								if (temp === 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + player.breastCup(0) + "s.");
								changes++;
							}

						}
						//multiple
						else {
							//temp2 = amount changed
							//temp3 = counter
							temp2 = 0;
							temp3 = player.breastRows.length;
							if (player.biggestTitSize() > 3) outputText("\n");
							while (temp3 > 0) {
								temp3--;
								if (player.breastRows[temp3].breastRating > 3) {
									player.breastRows[temp3].breastRating--;
									temp2++;
									outputText("\n");
									if (temp3 < player.breastRows.length - 1) outputText("...and y");
									else outputText("Y");
									outputText("our " + player.breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.");
								}
							}
							if (temp2 === 2) outputText("\nYou feel so much lighter after the change.");
							if (temp2 === 3) outputText("\nWithout the extra weight you feel particularly limber.");
							if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
							if (temp2 > 0) changes++;
						}
					}
				}
			}
			//NON - GENDER SPECIFIC CHANGES
			//Tail -> Ears -> Fur -> Face
			//Remove odd eyes
			if (changes < changeLimit && rand(5) === 0 && player.eyeType > EYES_HUMAN) {
				if (player.eyeType === EYES_BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyeType === EYES_FOUR_SPIDER_EYES || player.eyeType === EYES_SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//HorseFace - Req's Fur && Ears
			if (player.faceType !== FACE_HORSE && player.hasFur() && changes < changeLimit && rand(5) === 0 && player.earType === EARS_HORSE) {
				if (player.faceType === FACE_DOG) outputText("\n\nMind-numbing pain shatters through you as you feel your facial bones rearranging.  You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your dog-like characteristics with those of a horse.  <b>You now have a horse's face.</b>");
				else outputText("\n\nMind-numbing pain shatters through you as you feel your facial bones breaking and shifting.  You clutch at yourself in agony as you feel your skin crawl and elongate under your fingers.  Eventually the pain subsides, leaving you with a face that seamlessly blends human and equine features.  <b>You have a very equine-looking face.</b>");
				changes++;
				player.faceType = FACE_HORSE;
			}
			//Fur - if has horse tail && ears and not at changelimit
			if (!player.hasFur() && changes < changeLimit && rand(4) === 0 && player.tailType === TAIL_TYPE_HORSE) {
				player.setFurColor(horseFurColors);
				if (player.hasPlainSkin()) outputText("\n\nAn itchy feeling springs up over every inch of your skin.  As you scratch yourself madly, you feel fur grow out of your skin until <b>you have a fine coat of " + player.furColor + "-colored fur.</b>");
				if (player.hasScales()) {
					player.skinDesc = "fur";
					outputText("\n\nYour " + player.skinTone + " scales begin to itch insufferably.  You reflexively scratch yourself, setting off an avalanche of discarded scales.  The itching intensifies as you madly scratch and tear at yourself, revealing a coat of " + player.furColor + " " + player.skinDesc + ".  At last the itching stops as <b>you brush a few more loose scales from your new coat of " + player.furColor + "-colored fur.</b>");
				}
				changes++;
				player.skinType = SKIN_TYPE_FUR;
				player.skinDesc = "fur";
				player.underBody.restore(); // Restore the underbody for now
			}
			// Hooves - Tail
			if (player.lowerBody !== LOWER_BODY_TYPE_HOOFED && player.tailType === TAIL_TYPE_HORSE && changes < changeLimit && rand(5) === 0) {
				changes++;
				if (player.lowerBody === LOWER_BODY_TYPE_HUMAN) outputText("\n\nYou stagger as your feet change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
				else if (player.lowerBody === LOWER_BODY_TYPE_DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
				else if (player.lowerBody === LOWER_BODY_TYPE_NAGA) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
				//Catch-all
				else if (player.lowerBody > LOWER_BODY_TYPE_NAGA) outputText("\n\nYou stagger as your " + player.feet() + " change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
				else if (!player.hasFur()) outputText("  A fine coat of fur grows out below your waist, itching briefly as it fills in.");
				outputText("<b>  You now have hooves in place of your feet!</b>");
				player.lowerBody = LOWER_BODY_TYPE_HOOFED;
				player.legCount = 2;
				dynStats("spe", 1);
				changes++;
			}
			//Ears - requires tail
			if (player.earType !== EARS_HORSE && player.tailType === TAIL_TYPE_HORSE && changes < changeLimit && rand(3) === 0) {
				if (player.earType === -1) outputText("\n\nTwo painful lumps sprout on the top of your head, forming into tear-drop shaped ears, covered with short fur.  ");
				if (player.earType === EARS_HUMAN) outputText("\n\nYour ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into an upright animalistic ears.  ");
				if (player.earType === EARS_DOG) outputText("\n\nYour ears change shape, morphing into from their doglike shape into equine-like ears!  ");
				if (player.earType > EARS_DOG) outputText("\n\nYour ears change shape, morphing into teardrop-shaped horse ears!  ");
				player.earType = EARS_HORSE;
				player.earValue = 0;
				outputText("<b>You now have horse ears.</b>");
				changes++;
			}
			//Tail - no-prereq
			if (player.tailType !== TAIL_TYPE_HORSE && rand(2) === 0 && changes < changeLimit) {
				//no tail
				if (player.tailType === 0) {
					outputText("\n\nThere is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same " + player.hairColor + " color as your hair.");
				}
				//if other animal tail
				if (player.tailType > TAIL_TYPE_HORSE && player.tailType <= TAIL_TYPE_COW) {
					outputText("\n\nPain lances up your " + player.assholeDescript() + " as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
				}
				//if bee/spider-butt.
				if ((player.tailType > TAIL_TYPE_COW && player.tailType < TAIL_TYPE_SHARK)) {
					outputText("\n\nYour insect-like abdomen bunches up as it begins shrinking, exoskeleton flaking off like a snake sheds its skin.  It bunches up until it is as small as a tennis ball, then explodes outwards, growing into an animalistic tail shape.  Moments later, it explodes into filaments of pain, dividing into hundreds of strands and turning into a shiny horsetail.");
				}
				if (player.tailType >= TAIL_TYPE_SHARK) {
					outputText("\n\nPain lances up your " + player.assholeDescript() + " as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
				}
				outputText("  <b>You now have a horse-tail.</b>");
				player.tailType = TAIL_TYPE_HORSE;
				player.tailVenom = 0;
				player.tailRecharge = 0;
				changes++;
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}

			if (rand(3) === 0) outputText(player.modTone(60, 1));
			//FAILSAFE CHANGE
			if (changes === 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				game.HPChange(20, true);
				dynStats("lus", 3);
			}
			player.refillHunger(15);
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
