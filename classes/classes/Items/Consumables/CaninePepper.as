package classes.Items.Consumables 
{
	import classes.Appearance;
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.PerkLib;
	import classes.StatusEffects;
	import classes.lists.ColorLists;
	
	public class CaninePepper extends Consumable
	{
		private const ids:Array = ["CanineP", "LargePp", "DblPepp", "BlackPp", "KnottyP", "BulbyPp"];
		private const snm:Array = ["Canine Pp", "Large Pp", "Double Pp", "Black Pp", "Knotty Pp", "Bulby Pp"];
		private const lnm:Array = ["a canine pepper", "an overly large canine pepper", "a double canine pepper", "a solid black canine pepper", "a knotty canine pepper", "a bulbous canine pepper"];
		private const dsc:Array = [
			"The pepper is shiny and red, bulbous at the base but long and narrow at the tip. It smells spicy.",
			"This large canine pepper is much bigger than any normal peppers you've seen.",
			"This canine pepper is actually two that have grown together due to some freak coincidence.",
			"This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...",
			"This knotted pepper is very swollen, with a massive, distended knot near the base.",
			"This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base."
		];
		
		public function CaninePepper(type:int)
		{
			super(ids[type], snm[type], lnm[type], 10, dsc[type]);
		}
		
		override public function useItem():Boolean
		{
			switch(this.id) {
				case "LargePp":
					caninePepper(1);
					break;
				case "DblPepp":
					caninePepper(2);
					break;
				case "BlackPp":
					caninePepper(3);
					break;
				case "KnottyP":
					caninePepper(4);
					break;
				case "BulbyPp":
					caninePepper(5);
					break;
				default:
					caninePepper(0);
			}
			return false;
		}
		
		//1-Oversized Pepper (+size, thickness)
		//2-Double Pepper (+grows second cock or changes two cocks to dogcocks)
		//3-Black Pepper (Dark Fur, +corruption/libido)
		//4-Knotty Pepper (+Knot + Cum Multiplier)
		//5-Bulbous Pepper (+ball size or fresh balls)
		public function caninePepper(type:Number):void
		{
			var tfSource:String = "caninePepper";
			if (player.hasPerk(PerkLib.Hellfire)) tfSource += "-hellfire";
			switch (type) {
				case 5:  tfSource += "-bulbous";   break;
				case 4:  tfSource += "-knotty";    break;
				case 3:  tfSource += "-black";     break;
				case 2:  tfSource += "-double";    break;
				case 1:  tfSource += "-oversized"; break;
				default: // type == 0 --> Canine Pepper
			}
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			var crit:Number = 1;
			//Set up changes and changeLimit
			mutations.initTransformation([2, 2]);
			//Initial outputs & crit level
			clearOutput();
			switch(type) {
				case 0:
					if (rand(100) < 15) {
						crit = int(Math.random() * 20) / 10 + 2;
						outputText("The pepper tastes particularly potent, searingly hot and spicy.");
					}
					else outputText("The pepper is strangely spicy but very tasty.");
					break;
				case 1: //Oversized pepper
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("The pepper is so large and thick that you have to eat it in several large bites.  It is not as spicy as the normal ones, but is delicious and flavorful.");
					break;
				case 2: //Double Pepper
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("The double-pepper is strange, looking like it was formed when two peppers grew together near their bases.");
					break;
				case 3: //Black Pepper
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("This black pepper tastes sweet, but has a bit of a tangy aftertaste.");
					break;
				case 4: //Knotty Pepper
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("The pepper is a bit tough to eat due to the swollen bulge near the base, but you manage to cram it down and munch on it.  It's extra spicy!");
					break;
				case 5: //Bulbous Pepper
					crit = int(Math.random() * 20) / 10 + 2;
					outputText("You eat the pepper, even the two orb-like growths that have grown out from the base.  It's delicious!");
					break;
				default:
					crit = int(Math.random() * 20) / 10 + 2;
			}
			//OVERDOSE Bad End!
			if (type <= 0 && crit > 1 && player.hasFur() && player.face.type == Face.DOG && player.ears.type == Ears.DOG && player.lowerBody.type == LowerBody.DOG && player.tail.type == Tail.DOG && rand(2) === 0 && player.hasStatusEffect(StatusEffects.DogWarning) && !player.hasPerk(PerkLib.TransformationResistance)) {
				temp = rand(2);
				if (temp == 0) {
					outputText("\n\nAs you swallow the pepper, you note that the spicy hotness on your tongue seems to be spreading. Your entire body seems to tingle and burn, making you feel far warmer than normal, feverish even. Unable to stand it any longer you tear away your clothes, hoping to cool down a little. Sadly, this does nothing to aid you with your problem. On the bright side, the sudden feeling of vertigo you've developed is more than enough to take your mind off your temperature issues. You fall forward onto your hands and knees, well not really hands and knees to be honest. More like paws and knees. That can't be good, you think for a moment, before the sensation of your bones shifting into a quadrupedal configuration robs you of your concentration. After that, it is only a short time before your form is remade completely into that of a large dog, or perhaps a wolf. The distinction would mean little to you now, even if you were capable of comprehending it. ");
					if (player.hasPerk(PerkLib.MarblesMilk)) outputText("All you know is that there is a scent on the wind, it is time to hunt, and at the end of the day you need to come home for your milk.");
					else outputText("All you know is that there is a scent on the wind, and it is time to hunt.");
				}
				if (temp == 1) outputText("\n\nYou devour the sweet pepper, carefully licking your fingers for all the succulent juices of the fruit, and are about to go on your way when suddenly a tightness begins to build in your chest and stomach, horrid cramps working their way first through your chest, then slowly flowing out to your extremities, the feeling soon joined by horrible, blood-curdling cracks as your bones begin to reform, twisting and shifting, your mind exploding with pain. You fall to the ground, reaching one hand forward. No... A paw, you realize in horror, as you try to push yourself back up. You watch in horror, looking down your foreleg as thicker fur erupts from your skin, a " + player.hair.color + " coat slowly creeping from your bare flesh to cover your body. Suddenly, you feel yourself slipping away, as if into a dream, your mind warping and twisting, your body finally settling into its new form. With one last crack of bone you let out a yelp, kicking free of the cloth that binds you, wresting yourself from its grasp and fleeing into the now setting sun, eager to find prey to dine on tonight.");
				getGame().gameOver();
				return;
			}
			//WARNING, overdose VERY close!
			if (type <= 0 && player.hasFur() && player.face.type == Face.DOG && player.tail.type == Tail.DOG && player.ears.type == Ears.DOG && player.lowerBody.type == LowerBody.DOG && player.hasStatusEffect(StatusEffects.DogWarning) && rand(3) === 0) {
				outputText("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			//WARNING, overdose is close!
			if (type <= 0 && player.hasFur() && player.face.type == Face.DOG && player.tail.type == Tail.DOG && player.ears.type == Ears.DOG && player.lowerBody.type == LowerBody.DOG && !player.hasStatusEffect(StatusEffects.DogWarning)) {
				player.createStatusEffect(StatusEffects.DogWarning, 0, 0, 0, 0);
				outputText("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			if (type == 3) {
				dynStats("lib", 2 + rand(4), "lus", 5 + rand(5), "cor", 2 + rand(4));
				outputText("\n\nYou feel yourself relaxing as gentle warmth spreads through your body.  Honestly you don't think you'd mind running into a demon or monster right now, they'd make for good entertainment.");
				if (player.cor < 50) outputText("  You shake your head, blushing hotly.  Where did that thought come from?");
			}
			if (player.str100 < 50 && rand(3) === 0) {
				dynStats("str", (crit));
				if (crit > 1) outputText("\n\nYour muscles ripple and grow, bulging outwards.");
				else outputText("\n\nYour muscles feel more toned.");
			}
			if (player.spe100 < 30 && rand(3) === 0 && changes < changeLimit) {
				dynStats("spe", (crit));
				if (crit > 1) outputText("\n\nYou find your muscles responding quicker, faster, and you feel an odd desire to go for a walk.");
				else outputText("\n\nYou feel quicker.");
			}
			if (player.inte100 > 30 && rand(3) === 0 && changes < changeLimit && type !== 3) {
				dynStats("int", (-1 * crit));
				outputText("\n\nYou feel ");
				if (crit > 1) outputText("MUCH ");
				outputText("dumber.");
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) mutations.updateOvipositionPerk(tfSource);
			//Restore arms to become human arms again
			if (rand(4) === 0) mutations.restoreArms(tfSource);
			//Remove feathery hair
			mutations.removeFeatheryHair();
			//if (type !== 2 && type !== 4 && type !== 5) outputText("\n");
			//Double Pepper!
			//Xforms/grows dicks to make you have two dogcocks
			if (type == 2) {
				//If already doubled up, GROWTH
				if (player.dogCocks() >= 2) {
					type = 1;
				}
				//If player doesnt have 2 dogdicks
				else {
					//If player has NO dogdicks
					if (player.dogCocks() === 0) {
						//Dickless - grow two dogpeckers
						if (player.cockTotal() === 0) {
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							outputText("\n\nA painful lump forms on your groin, nearly doubling you over as it presses against your " + player.armorName + ".  You rip open your gear and watch, horrified as the discolored skin splits apart, revealing a pair of red-tipped points.  A feeling of relief, and surprising lust grows as they push forward, glistening red and thickening.  The skin bunches up into an animal-like sheath, while a pair of fat bulges pop free.  You now have two nice thick dog-cocks, with decent sized knots.  Both pulse and dribble animal-pre, arousing you in spite of your attempts at self-control.");
							player.cocks[0].knotMultiplier = 1.7;
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[1].knotMultiplier = 1.7;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							dynStats("lus", 50);
						}
						//1 dick - grow 1 and convert 1
						else if (player.cockTotal() == 1) {
							outputText("\n\nYour " + player.cockDescript(0) + " vibrates, the veins clearly visible as it reddens and distorts.  The head narrows into a pointed tip while a gradually widening bulge forms around the base.  Where it meets your crotch, the skin bunches up around it, forming a canine-like sheath.  ");
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[0].knotMultiplier = 1.5;
							outputText("You feel something slippery wiggling inside the new sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.cocks[1].knotMultiplier = 1.7;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							dynStats("lib", 2, "lus", 50);
						}
						//2 dicks+ - convert first 2 to doggie-dom
						else {
							outputText("\n\nYour crotch twitches, and you pull open your " + player.armorName + " to get a better look.  You watch in horror and arousal as your " + player.cockDescript(0) + " and " + player.cockDescript(1) + " both warp and twist, becoming red and pointed, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
							player.cocks[0].cockType = CockTypesEnum.DOG;
							player.cocks[1].cockType = CockTypesEnum.DOG;
							player.cocks[0].knotMultiplier = 1.4;
							player.cocks[1].knotMultiplier = 1.4;
							dynStats("lib", 2, "lus", 50);
						}
					}
					//If player has 1 dogdicks
					else {
						//if player has 1 total
						if (player.cockTotal() == 1) {
							outputText("\n\nYou feel something slippery wiggling inside your sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							player.createCock(7 + rand(7), 1.5 + rand(10) / 10);
							player.cocks[1].cockType = CockTypesEnum.DOG;
							player.cocks[1].knotMultiplier = 1.4;
							dynStats("lib", 2, "lus", 50);
						}
						//if player has more
						if (player.cockTotal() >= 1) {
							//if first dick is already doggi'ed
							if (player.cocks[0].cockType == CockTypesEnum.DOG) {
								outputText("\n\nYour crotch twitches, and you pull open your " + player.armorName + " to get a better look.  You watch in horror and arousal as your " + player.cockDescript(1) + " warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
								player.cocks[1].cockType = CockTypesEnum.DOG;
								player.cocks[1].knotMultiplier = 1.4;
							}
							//first dick is not dog
							else {
								outputText("\n\nYour crotch twitches, and you pull open your " + player.armorName + " to get a better look.  You watch in horror and arousal as your " + player.cockDescript(0) + " warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
								player.cocks[0].cockType = CockTypesEnum.DOG;
								player.cocks[0].knotMultiplier = 1.4;
							}
							dynStats("lib", 2, "lus", 50);
						}
					}
				}
			}
			//Knotty knot pepper!
			if (type == 4) {
				//Cocks only!
				if (player.cockTotal() > 0) {
					//biggify knots
					if (player.dogCocks() > 0) {
						temp = 0;
						//set temp2 to first dogdick for initialization
						while (temp < player.cocks.length) {
							if (player.cocks[temp].cockType == CockTypesEnum.DOG) {
								temp2 = temp;
								break;
							}
							else temp++;
						}
						//Reset temp for nex tcheck
						temp = player.cocks.length;
						//Find smallest knot
						while (temp > 0) {
							temp--;
							if (player.cocks[temp].cockType == CockTypesEnum.DOG && player.cocks[temp].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = temp;
						}
						//Have smallest knotted cock selected.
						temp3 = (rand(2) + 5) / 20 * crit;
						if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
						if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
						if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
						player.cocks[temp2].knotMultiplier += (temp3);
						outputText("\n\n");
						if (temp3 < .06) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " feels unusually tight in your sheath as your knot grows.");
						if (temp3 >= .06 && temp3 <= .12) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " pops free of your sheath, thickening nicely into a bigger knot.");
						if (temp3 > .12) outputText("Your " + Appearance.cockNoun(CockTypesEnum.DOG) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
						dynStats("sen", .5, "lus", 5 * crit);
					}
					//Grow dogdick with big knot
					else {
						outputText("\n\nYour " + player.cockDescript(0) + " twitches, reshaping itself.  The crown tapers down to a point while the base begins swelling.  It isn't painful in the slightest, actually kind of pleasant.  Your dog-like knot slowly fills up like a balloon, eventually stopping when it's nearly twice as thick as the rest.  You touch and shiver with pleasure, oozing pre-cum.");
						player.cocks[0].cockType = CockTypesEnum.DOG;
						player.cocks[0].knotMultiplier = 2.1;
					}
				}
				//You wasted knot pepper!
				else outputText("\n\nA slight wave of nausea passes through you.  It seems this pepper does not quite agree with your body.");
			}
			//GROW BALLS
			if (type == 5) {
				if (player.balls <= 1) {
					outputText("\n\nA spike of pain doubles you up, nearly making you vomit.  You stay like that, nearly crying, as a palpable sense of relief suddenly washes over you.  You look down and realize you now have a small sack, complete with two relatively small balls.");
					player.balls = 2;
					player.ballSize = 1;
					dynStats("lib", 2, "lus", -10);
				}
				else {
					//Makes your balls biggah!
					player.ballSize++;
					//They grow slower as they get bigger...
					if (player.ballSize > 10) player.ballSize -= .5;
					//Texts
					if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
					if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ".  Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
					dynStats("lib", 1, "lus", 3);
				}
			}
			//Sexual Stuff Now
			//------------------
			//Man-Parts
			//3 Changes,
			//1. Cock Xform
			//2. Knot Size++
			//3. cumMultiplier++ (to max of 1.5)
			if (player.cocks.length > 0) {
				//Grow knot on smallest knotted dog cock
				if (type !== 4 && player.dogCocks() > 0 && ((changes < changeLimit && rand(1.4) === 0) || type == 1)) {
					temp = 0;
					//set temp2 to first dogdick for initialization
					while (temp < player.cocks.length) {
						if (player.cocks[temp].cockType == CockTypesEnum.DOG) {
							temp2 = temp;
							break;
						}
						else temp++;
					}
					//Reset temp for nex tcheck
					temp = player.cocks.length;
					//Find smallest knot
					while (temp > 0) {
						temp--;
						if (player.cocks[temp].cockType == CockTypesEnum.DOG && player.cocks[temp].knotMultiplier < player.cocks[temp2].knotMultiplier) temp2 = temp;
					}
					//Have smallest knotted cock selected.
					temp3 = (rand(2) + 1) / 20 * crit;
					if (player.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
					if (player.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
					player.cocks[temp2].knotMultiplier += (temp3);
					if (temp3 < .06) outputText("\n\nYour " + player.cockDescript(temp2) + " feels unusually tight in your sheath as your knot grows.");
					if (temp3 >= .06 && temp3 <= .12) outputText("\n\nYour " + player.cockDescript(temp2) + " pops free of your sheath, thickening nicely into a bigger knot.");
					if (temp3 > .12) outputText("\n\nYour " + player.cockDescript(temp2) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
					dynStats("sen", .5, "lus", 5 * crit);
					changes++;
				}
				//Cock Xform if player has free cocks.
				if (player.dogCocks() < player.cocks.length && ((changes < changeLimit && rand(1.6)) || type == 1) === 0) {
					//Select first human cock
					temp = player.cocks.length;
					temp2 = 0;
					while (temp > 0 && temp2 == 0) {
						temp--;
						//Store cock index if not a dogCock and exit loop.
						if (player.cocks[temp].cockType !== CockTypesEnum.DOG) {
							temp3 = temp;
							//kicking out of tah loop!
							temp2 = 1000;
						}
					}
					//Talk about it
					//Hooooman
					if (player.cocks[temp3].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " clenches painfully, becoming achingly, throbbingly erect.  A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath.  You shudder as the crown of your " + player.cockDescript(temp3) + " reshapes into a point, the sensations nearly too much for you.  You throw back your head as the transformation completes, your " + Appearance.cockNoun(CockTypesEnum.DOG) + " much thicker than it ever was before.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 10, "lus", 5 * crit);
					}
					//Horse
					if (player.cocks[temp3].cockType == CockTypesEnum.HORSE) {
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes into a more pointed form, a thick knotted bulge forming just above your sheath.  <b>You now have a dog-cock.</b>");
						//Tweak length/thickness.
						if (player.cocks[temp3].cockLength > 6) player.cocks[temp3].cockLength -= 2;
						else player.cocks[temp3].cockLength -= .5;
						player.cocks[temp3].cockThickness += .5;

						dynStats("sen", 4, "lus", 5 * crit);
					}
					//Tentacular Tuesday!
					if (player.cocks[temp3].cockType == CockTypesEnum.TENTACLE) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " coils in on itself, reshaping and losing its plant-like coloration as it thickens near the base, bulging out in a very canine-looking knot.  Your skin bunches painfully around the base, forming into a sheath.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 5 * crit);
					}
					//Misc
					if (player.cocks[temp3].cockType.Index > 4) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " trembles, reshaping itself into a shiny red doggie-dick with a fat knot at the base.  <b>You now have a dog-cock.</b>");
						dynStats("sen", 4, "lus", 5 * crit);
					}
					temp = 0;
					//Demon
					if (player.cocks[temp3].cockType == CockTypesEnum.DEMON) {
						outputText("\n\nYour " + player.cockDescript(temp3) + " color shifts red for a moment and begins to swell at the base, but within moments it smooths out, retaining its distinctive demonic shape, only perhaps a bit thicker.");
						dynStats("sen", 1, "lus", 2 * crit);
						temp = 1;
					}
					//Xform it!
					player.cocks[temp3].cockType = CockTypesEnum.DOG;
					player.cocks[temp3].knotMultiplier = 1.1;
					player.cocks[temp3].thickenCock(2);
					if (temp == 1) {
						player.cocks[temp3].cockType = CockTypesEnum.DEMON;
					}
					changes++;

				}
				//Cum Multiplier Xform
				if (player.cumMultiplier < 2 && rand(2) === 0 && changes < changeLimit) {
					temp = 1.5;
					//Lots of cum raises cum multiplier cap to 2 instead of 1.5
					if (player.hasPerk(PerkLib.MessyOrgasms)) temp = 2;
					if (temp < player.cumMultiplier + .05 * crit) {
						changes--;
					}
					else {
						player.cumMultiplier += .05 * crit;
						//Flavor text
						if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.");
						if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ".  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) outputText("  A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.");
					}
					changes++;
				}
				//Oversized pepper
				if (type == 1) {
					//GET LONGER
					//single cock
					if (player.cocks.length == 1) {
						temp2 = player.increaseCock(0, rand(4) + 3);
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
						temp2 = player.increaseCock(temp, rand(4) + 3);
						dynStats("sen", 1, "lus", 10);
						if (player.cocks[temp].cockThickness <= 2) player.cocks[temp].thickenCock(1);
					}
					if (temp2 > 2) outputText("\n\nYour " + player.cockDescript(temp) + " tightens painfully, inches of bulging dick-flesh pouring out from your crotch as it grows longer.  Thick pre forms at the pointed tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) outputText("\n\nAching pressure builds within your crotch, suddenly releasing as an inch or more of extra dick-flesh spills out.  A dollop of pre beads on the head of your enlarged " + player.cockDescript(temp) + " from the pleasure of the growth.");
					if (temp2 <= 1) outputText("\n\nA slight pressure builds and releases as your " + player.cockDescript(temp) + " pushes a bit further out of your crotch.");
				}
			}
			//Female Stuff
			//Multiboobages
			if (player.breastRows.length > 0) {
				//if bigger than A cup
				if (player.breastRows[0].breastRating > 0 && player.vaginas.length > 0) {
					//Doggies only get 3 rows of tits! FENOXO HAS SPOKEN
					if (player.breastRows.length < 3 && rand(2) === 0 && changes < changeLimit) {
						player.createBreastRow();
						//Store temp to the index of the newest row
						temp = player.breastRows.length - 1;
						//Breasts are too small to grow a new row, so they get bigger first
						//But ONLY if player has a vagina (dont want dudes weirded out)
						if (player.vaginas.length > 0 && player.breastRows[0].breastRating <= player.breastRows.length) {
							outputText("\n\nYour " + player.breastDescript(0) + " feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach ");
							player.breastRows[0].breastRating += 2;
							outputText(player.breastCup(0) + " size.  But it doesn't stop there, you feel a tightness beginning lower on your torso...");
							changes++;
						}
						//Had 1 row to start
						if (player.breastRows.length == 2) {
							//1 size below primary breast row!
							player.breastRows[temp].breastRating = player.breastRows[0].breastRating - 1;
							if (player.breastRows[0].breastRating - 1 == 0) outputText("\n\nA second set of breasts forms under your current pair, stopping while they are still fairly flat and masculine looking.");
							else outputText("\n\nA second set of breasts bulges forth under your current pair, stopping as they reach " + player.breastCup(temp) + "s.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							dynStats("sen", 6, "lus", 5);
							changes++;
						}
						//Many breast Rows - requires larger primary tits...
						if (player.breastRows.length > 2 && player.breastRows[0].breastRating > player.breastRows.length) {
							dynStats("sen", 6, "lus", 5);
							//New row's size = the size of the row above -1
							player.breastRows[temp].breastRating = player.breastRows[temp - 1].breastRating - 1;
							//If second row are super small but primary row is huge it could go negative.
							//This corrects that problem.
							if (player.breastRows[temp].breastRating < 0) player.breastRows[temp].breastRating = 0;
							if (player.breastRows[temp - 1].breastRating < 0) player.breastRows[temp - 1].breastRating = 0;
							if (player.breastRows[temp].breastRating == 0) outputText("\n\nYour abdomen tingles and twitches as a new row of breasts sprouts below the others.  Your new breasts stay flat and masculine, not growing any larger.");
							else outputText("\n\nYour abdomen tingles and twitches as a new row of " + player.breastCup(temp) + " " + player.breastDescript(temp) + " sprouts below your others.");
							outputText("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							changes++;
						}
						//Extra sensitive if crit
						if (crit > 1) {
							if (crit > 2) {
								outputText("  You heft your new chest experimentally, exploring the new flesh with tender touches.  Your eyes nearly roll back in your head from the intense feelings.");
								dynStats("sen", 6, "lus", 15, "cor", 0)
							}
							else {
								outputText("  You touch your new nipples with a mixture of awe and desire, the experience arousing beyond measure.  You squeal in delight, nearly orgasming, but in time finding the willpower to stop yourself.");
								dynStats("sen", 3, "lus", 10);
							}
						}

					}
					//If already has max doggie breasts!
					else if (rand(2) === 0) {
						//Check for size mismatches, and move closer to spec!
						temp = player.breastRows.length;
						temp2 = 0;
						var evened:Boolean = false;
						//Check each row, and if the row above or below it is
						while (temp > 1 && temp2 == 0) {
							temp--;
							//Gimme a sec
							if (player.breastRows[temp].breastRating + 1 < player.breastRows[temp - 1].breastRating) {
								if (!evened) {
									evened = true;
									outputText("\n");
								}
								outputText("\nYour ");
								if (temp == 0) outputText("first ");
								if (temp == 1) outputText("second ");
								if (temp == 2) outputText("third ");
								if (temp == 3) outputText("fourth ");
								if (temp == 4) outputText("fifth ");
								if (temp > 4) outputText("");
								outputText("row of " + player.breastDescript(temp) + " grows larger, as if jealous of the jiggling flesh above.");
								temp2 = (player.breastRows[temp - 1].breastRating) - player.breastRows[temp].breastRating - 1;
								if (temp2 > 5) temp2 = 5;
								if (temp2 < 1) temp2 = 1;
								player.breastRows[temp].breastRating += temp2;
							}
						}
					}
				}
			}
			//Grow tits if have NO breasts/nipples AT ALL
			else if (rand(2) === 0 && changes < changeLimit) {
				outputText("\n\nYour chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of B-cup breasts.</b>");
				outputText("  A sensitive nub grows on the summit of each tit, becoming a new nipple.");
				player.createBreastRow();
				player.breastRows[0].breastRating = 2;
				player.breastRows[0].breasts = 2;
				dynStats("sen", 4, "lus", 6);
				changes++;
			}
			//Go into heat
			if (rand(2) === 0 && changes < changeLimit) {
        if (player.goIntoHeat(true)) {
          changes++;
        }
			}
			if (changes < changeLimit && player.dogScore() >= 3 && rand(4) === 0) {
				changes++;
				outputText("\n\n");
				outputText("Images and thoughts come unbidden to your mind, overwhelming your control as you rapidly lose yourself in them, daydreaming of... ");
				//cawk fantasies
				if (player.gender <= 1 || (player.gender == 3 && rand(2) === 0)) {
					outputText("bounding through the woods, hunting with your master.  Feeling the wind in your fur and the thrill of the hunt coursing through your veins intoxicates you.  You have your nose to the ground, tracking your quarry as you run, until a heavenly scent stops you in your tracks.");
					dynStats("lus", 5 + player.lib / 20);
					//break1
					if (player.cor < 33 || !player.hasCock()) outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					else {
						outputText("  Heart pounding, your shaft pops free of its sheath on instinct, as you take off after the new scent.  Caught firmly in the grip of a female's heat, you ignore your master's cry as you disappear into the wild, " + Appearance.cockNoun(CockTypesEnum.DOG) + " growing harder as you near your quarry.  You burst through a bush, spotting a white-furred female.  She drops, exposing her dripping fem-sex to you, the musky scent of her sex channeling straight through your nose and sliding into your " + Appearance.cockNoun(CockTypesEnum.DOG) + ".");
						dynStats("lus", 5 + player.lib / 20);
						//Break 2
						if (player.cor < 66) outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						else {
							outputText("  Unable to wait any longer, you mount her, pressing your bulging knot against her vulva as she yips in pleasure. The heat of her sex is unreal, the tight passage gripping you like a vice as you jackhammer against her, biting her neck gently in spite of the violent pounding.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								if (player.vaginas.length > 0) outputText("\nYou reluctantly pry your hand from your aching " + player.vaginaDescript(0) + " as you drag yourself out of your fantasy.");
								else outputText("\nYou reluctantly pry your hand from your aching " + player.cockDescript(0) + " as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  At last your knot pops into her juicy snatch, splattering her groin with a smattering of her arousal.  The scents of your mating reach a peak as the velvet vice around your " + Appearance.cockNoun(CockTypesEnum.DOG) + " quivers in the most indescribably pleasant way.  You clamp down on her hide as your whole body tenses, unleashing a torrent of cum into her sex.  Each blast is accompanied by a squeeze of her hot passage, milking you of the last of your spooge.  Your " + player.legs() + " give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				//Pure female fantasies
				else if (player.hasVagina()) {
					outputText("wagging your dripping " + player.vaginaDescript(0) + " before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at your fertile scent.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled snatch and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to breed you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching " + player.vaginaDescript(0) + " as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused wetness, stretching you tightly, every beat of his heart vibrating through your nethers.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
				else {
					outputText("wagging your [asshole] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at you after going so long without a female in the pack.");
					dynStats("lus", 5 + player.lib / 20);
					//BREAK 1
					if (player.cor < 33) {
						outputText("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						outputText("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						dynStats("lus", 5 + player.lib / 20);
						//BREAK 2
						if (player.cor <= 66) {
							outputText("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							outputText("  The feeling of all that hot wolf-spooge spilling from your overfilled ass and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to spend his lust on you.");
							dynStats("lus", 5 + player.lib / 20);
							//break3
							if (player.cor < 80) {
								outputText("\nYou reluctantly pry your hand from your aching asshole as you drag yourself out of your fantasy.");
							}
							else {
								outputText("  You growl with discomfort as he pushes into your abused, wet hole, stretching you tightly, every beat of his heart vibrating through your hindquarters.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								dynStats("lus", 5 + player.lib / 20);
							}
						}
					}
				}
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) === 0 && player.eyes.type > Eyes.HUMAN) {
				if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyes.type == Eyes.FOUR_SPIDER_EYES || player.eyes.type == Eyes.SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyes.type = Eyes.HUMAN;
				player.eyes.count = 2;
				changes++;
			}
			//Master Furry Appearance Order:
			//Tail -> Ears -> Paws -> Fur -> Face
			//Dog-face requires fur & paws  Should be last morph to take place
			if (rand(5) === 0 && changes < changeLimit &&
					player.face.type !== Face.DOG && player.hasFur() &&
					player.lowerBody.type == LowerBody.DOG) {
				if (player.face.type == Face.HORSE) outputText("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else.  <b>Your horse-like features rearrange to take on many canine aspects.</b>");
				else outputText("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different.  You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>");
				player.face.type = Face.DOG;
				changes++;
			}

			// break things, so it'll be fixed below ;-)
			if (type == 3 && !player.hasFur() && player.skin.furColor == "midnight black") player.skin.furColor = "no";

			if (type == 3 && (player.hair.color !== "midnight black" || player.skin.furColor !== "midnight black")) {
				var furHairText:String;
				if (!player.hasFur())
					outputText("<b>\n\nYour " + player.skin.desc + " itches like crazy as fur grows out from it, coating your body.  It's incredibly dense and black as the middle of a moonless night.</b>");
				else {
					if (player.hair.color !== "midnight black" && player.skin.furColor !== "midnight black")
						furHairText = "fur and hair";
					else 
						furHairText = (player.skin.furColor !== "midnight black") ? "fur" : "hair";
					outputText("<b>\n\nYour " + furHairText + " tingles, growing in thicker than ever as darkness begins to spread from the roots, turning it midnight black.</b>");
				}
				player.skin.type = Skin.FUR;
				player.skin.adj = "thick";
				player.skin.desc = "fur";
				player.hair.color = "midnight black";
				player.skin.furColor = player.hair.color;
				player.underBody.restore(); // Restore the underbody for now
			}
			//Become furred - requires paws and tail
			if (rand(4) === 0 && changes < changeLimit && player.lowerBody.type == LowerBody.DOG && player.tail.type == Tail.DOG && !player.hasFur()) {
				player.setFurColor(ColorLists.DOG_FUR);
				if (player.hasPlainSkin()) outputText("\n\nYour skin itches intensely.  You gaze down as more and more hairs break forth from your skin, quickly transforming into a soft coat of fur.  <b>You are now covered in " + player.skin.furColor + " fur from head to toe.</b>");
				if (player.hasScales()) outputText("\n\nYour scales itch incessantly.  You scratch, feeling them flake off to reveal a coat of " + player.skin.furColor + " fur growing out from below!  <b>You are now covered in " + player.skin.furColor + " fur from head to toe.</b>");
				player.skin.type = Skin.FUR;
				player.skin.desc = "fur";
				player.underBody.restore(); // Restore the underbody for now
				changes++;
			}
			//Change to paws - requires tail and ears
			if (rand(3) === 0 && player.lowerBody.type !== LowerBody.DOG && player.tail.type == Tail.DOG && player.ears.type == Ears.DOG && changes < changeLimit) {
				//Feet -> paws
				if (player.lowerBody.type == LowerBody.HUMAN) outputText("\n\nYou scream in agony as you feel the bones in your feet break and begin to rearrange. <b>You now have paws</b>.");
				//Hooves -> Paws
				else if (player.lowerBody.type == LowerBody.HOOFED) outputText("\n\nYou feel your hooves suddenly splinter, growing into five unique digits.  Their flesh softens as your hooves reshape into furred paws.");
				else outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on fur-covered paws!  <b>You now have paws</b>.");
				player.lowerBody.type = LowerBody.DOG;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//Change to dog-ears!  Requires dog-tail
			if (rand(2) === 0 && player.ears.type !== Ears.DOG && player.tail.type == Tail.DOG && changes < changeLimit) {
				if (player.ears.type == -1) outputText("\n\nTwo painful nubs begin sprouting from your head, growing and opening into canine ears.  ");
				if (player.ears.type == Ears.HUMAN) outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head.  They shift and elongate, becoming canine in nature.  ");
				if (player.ears.type == Ears.HORSE) outputText("\n\nYour equine ears twist as they transform into canine versions.  ");
				if (player.ears.type > Ears.DOG) outputText("\n\nYour ears transform, becoming more canine in appearance.  ");
				player.ears.type = Ears.DOG;
				player.ears.value = 2;
				outputText("<b>You now have dog ears.</b>");
				changes++;
			}
			//Grow tail if not dog-tailed
			if (rand(3) === 0 && changes < changeLimit && player.tail.type !== Tail.DOG) {
				if (player.tail.type == Tail.NONE) outputText("\n\nA pressure builds on your backside.  You feel under your clothes and discover an odd bump that seems to be growing larger by the moment.  In seconds it passes between your fingers, bursts out the back of your clothes, and grows most of the way to the ground.  A thick coat of fur springs up to cover your new tail.  ");
				if (player.tail.type == Tail.HORSE) outputText("\n\nYou feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur.  ");
				if (player.tail.type == Tail.DEMONIC) outputText("\n\nThe tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail.  ");
				//Generic message for now
				if (player.tail.type >= Tail.COW) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a long puffy tail!  ");
				changes++;
				player.tail.type = Tail.DOG;
				outputText("<b>You now have a dog-tail.</b>");
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) mutations.updateGills();

			if (player.hasFur() && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou become more... solid.  Sinewy.  A memory comes unbidden from your youth of a grizzled wolf you encountered while hunting, covered in scars, yet still moving with an easy grace.  You imagine that must have felt something like this.");
				dynStats("tou", 4, "sen", -3);
				changes++;
			}
			//If no changes yay
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				player.HPChange(20, true);
				dynStats("lus", 3);
			}
			player.refillHunger(15);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
	}

}