package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	import classes.lists.ColorLists;
	
	/**
	 * Ferret transformative item.
	 */
	public class FerretFruit extends Consumable 
	{
		public function FerretFruit() 
		{
			super("Frrtfrt","FerretFrt","a ferret fruit", ConsumableLib.DEFAULT_VALUE, "This fruit is curved oddly, just like the tree it came from.  The skin is fuzzy and brown, like the skin of a peach.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "ferretTF";
			changes = 0;
			changeLimit = 1;
			var temp:int = 0;
			var x:int = 0;
			
			clearOutput();
			credits.authorText = "Revised by Coalsack";
			outputText("Feeling parched, you gobble down the fruit without much hesitation. Despite the skin being fuzzy like a peach, the inside is relatively hard, and its taste reminds you of that of an apple.  It even has a core like an apple. Finished, you toss the core aside.");

			if (rand(100) === 0)
			{
				outputText("\n\nSeems like nothing else happened. Was the fruit spoiled?");
				return false;
			}

			//BAD END:
			if (
				player.face.type === Face.FERRET &&
				player.ears.type === Ears.FERRET &&
				player.tail.type === Tail.FERRET &&
				player.lowerBody.type === LowerBody.FERRET &&
				player.hasFur() &&
				!player.hasPerk(PerkLib.TransformationResistance)
			) {
				//Get warned!
				if (flags[kFLAGS.FERRET_BAD_END_WARNING] === 0) {
					outputText("\n\nYou find yourself staring off into the distance, dreaming idly of chasing rabbits through a warren.  You shake your head, returning to reality.  <b>Perhaps you should cut back on all the Ferret Fruit?</b>");
					player.inte -= 5 + rand(3);
					if (player.inte < 5) player.inte = 5;
					flags[kFLAGS.FERRET_BAD_END_WARNING] = 1;
				}
				//BEEN WARNED! BAD END! DUN DUN DUN
				else if (rand(3) === 0)
				{
					credits.authorText = "";
					//-If you fail to heed the warning, it’s game over:
					outputText("\n\nAs you down the fruit, you begin to feel all warm and fuzzy inside.  You flop over on your back, eagerly removing your clothes.  You laugh giddily, wanting nothing more than to roll about happily in the grass.  Finally finished, you attempt to get up, but something feels...  different.  Try as you may, you find yourself completely unable to stand upright for a long period of time.  You only manage to move about comfortably on all fours.  Your body now resembles that of a regular ferret.  That can’t be good!  As you attempt to comprehend your situation, you find yourself less and less able to focus on the problem.  Your attention eventually drifts to a rabbit in the distance.  You lick your lips. Nevermind that, you have warrens to raid!");
					getGame().gameOver();
					return false;
				}
			}
			//Reset the warning if ferret score drops.
			else
			{
				flags[kFLAGS.FERRET_BAD_END_WARNING] = 0;
			}
			
			if (rand(2) === 0) changeLimit++;
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Ferret Fruit Effects
			//- + Thin:
			if (player.thickness > 15 && changes < changeLimit && rand(3) === 0)
			{
				outputText("\n\nEach movement feels a tiny bit easier than the last.  Did you just lose a little weight!? (+2 thin)");
				player.thickness -=2;
				changes++;
			}
			//- If speed is < 100, increase speed:
			if (player.spe100 < 100 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYour muscles begin to twitch rapidly under the fruit effects, but the feeling is not entirely unpleasant."
				          +" In fact, you have the feeling that running will be now much easier.");
				dynStats("spe", 2 + rand(2));
			}
			//- If male with a hip rating >4 or a female/herm with a hip rating >6:
			if ((player.hips.rating > (player.isFemaleOrHerm() ? 6 : 4)) && rand(3) === 0 && changes < changeLimit)
			{
				outputText("\n\nA warm, tingling sensation arises in your [hips]. Immediately, you reach down to them, concerned."
				          +" You can feel a small portion of your [hips] dwindling away under your hands. Seem like more voluptuous assets would be"
				          +" cumbersome for you now streamlined frame.");
				player.hips.rating--;
				if (player.hips.rating > 10) player.hips.rating--;
				if (player.hips.rating > 15) player.hips.rating--;
				if (player.hips.rating > 20) player.hips.rating--;
				if (player.hips.rating > 23) player.hips.rating--;
				changes++;
			}
			//- If butt rating is greater than “petite”:
			if (player.butt.rating > 6 && rand(3) === 0 && changes < changeLimit)
			{
				outputText("\n\nYou cringe as your [butt] begins to feel uncomfortably tight.  Once the sensation passes,"
				          +" you look over your shoulder, inspecting yourself. It would appear that your ass has become smaller."
				          +" While a bit of a disappointment, at least the loss of extra mass will make you light and faster.");
				player.butt.rating--;
				if (player.butt.rating > 10) player.butt.rating--;
				if (player.butt.rating > 15) player.butt.rating--;
				if (player.butt.rating > 20) player.butt.rating--;
				if (player.butt.rating > 23) player.butt.rating--;
				changes++;
			}

			//-If male with breasts or female/herm with breasts > B cup:
			if (!flags[kFLAGS.HYPER_HAPPY] && (player.biggestTitSize() > 2 || (player.hasCock() && player.biggestTitSize() >= 1)) && rand(2) === 0 && changes < changeLimit)
			{
				outputText("\n\nYou cup your tits as they begin to tingle strangely.  You can actually feel them getting smaller in your hands!");
				for(x = 0; x < player.bRows(); x++)
				{
					if (player.breastRows[x].breastRating > 2 || (player.hasCock() && player.breastRows[x].breastRating >= 1))
					{
						player.breastRows[x].breastRating--;
					}
				}
				changes++;
				//(this will occur incrementally until they become flat, manly breasts for males, or until they are A or B cups for females/herms)
			}

			//Remove additional cocks
			if (player.cocks.length > 1 && rand(3) === 0 && changes < changeLimit) {
				player.removeCock(1, 1);
				outputText("\n\nYou have a strange feeling as your crotch tingles.  Opening your [armor],"
				          +" <b>you realize that one of your cocks have vanished completely!</b>");
				changes++;
			}

			//Remove additional balls/remove uniball
			if ((player.balls > 0 || player.hasStatusEffect(StatusEffects.Uniball)) && rand(3) === 0 && changes < changeLimit) {
				if (player.ballSize > 2) {
					if (player.ballSize > 5) player.ballSize -= 1 + rand(3);
					player.ballSize -= 1;
					outputText("\n\nYour scrotum slowly shrinks, settling down at a smaller size. <b>Your " + player.ballsDescriptLight() + " ");
					if (player.balls === 1 || player.hasStatusEffect(StatusEffects.Uniball)) outputText("is smaller now.</b>");
					else outputText("are smaller now.</b>");
					changes++;
				}
				else if (player.balls > 2) {
					player.balls = 2;
					//I have no idea if Uniball status effect sets balls to 1 or not so here's a just in case.
					if (player.hasStatusEffect(StatusEffects.Uniball)) player.removeStatusEffect(StatusEffects.Uniball);
					outputText("\n\nYour scrotum slowly shrinks until they seem to have reached a normal size. <b>You can feel as if your extra balls fused together, leaving you with a pair of balls.</b>");
					changes++;
				}
				else if (player.balls === 1 || player.hasStatusEffect(StatusEffects.Uniball)) {
					player.balls = 2;
					if (player.hasStatusEffect(StatusEffects.Uniball)) player.removeStatusEffect(StatusEffects.Uniball);
					outputText("\n\nYour scrotum slowly shrinks, and you feel a great pressure release in your groin. <b>Your uniball has split apart, leaving you with a pair of balls.</b>");
					changes++;
				}
			}

			//-If penis size is > 6 inches:
			if (player.hasCock())
			{
				//Find longest cock
				temp = -1;
				for(x = 0; x < player.cockTotal(); x++)
				{
					if (temp === -1 || player.cocks[x].cockLength > player.cocks[temp].cockLength) temp = x;
				}
				if (temp >= 0 && rand(2) === 0 && changes < changeLimit)
				{
					if (player.cocks[temp].cockLength > 6 && !flags[kFLAGS.HYPER_HAPPY])
					{
						outputText("\n\nA pinching sensation racks the entire length of your " + player.cockDescript(temp) + ".  Within moments, the sensation is gone, but it appears to have become smaller.");
						player.cocks[temp].cockLength--;
						if (rand(2) === 0) player.cocks[temp].cockLength--;
						if (player.cocks[temp].cockLength >= 9) player.cocks[temp].cockLength -= rand(3) + 1;
						if (player.cocks[temp].cockLength/6 >= player.cocks[temp].cockThickness)
						{
							outputText("  Luckily, it doesn’t seem to have lost its previous thickness.");
						}
						else
						{
							player.cocks[temp].cockThickness = player.cocks[temp].cockLength/6;
						}
						changes++;
					}
				}
			}
			//Cock -> Ferret cock
			if (player.hasCock() && player.cocks[0].cockType !== CockTypesEnum.FERRET && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nThe skin surrounding your penis folds, encapsulating it and turning itself into a protective sheath."
				          +" <b>You now have a ferret cock!</b>");
				player.cocks[0].cockType = CockTypesEnum.FERRET;
				changes++;
			}

			//-If the PC has quad nipples:
			if (player.averageNipplesPerBreast() > 1 && rand(4) === 0 && changes < changeLimit)
			{
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely,"
				          +" the leftover nipples migrating to the middle of your breasts. It seems like the mustelid strain on the fruit isn’t"
				          +" compatible with such an amount of them, so <b>you are left with only one nipple on each breast.</b>");
				for(x = 0; x < player.bRows(); x++)
				{
					player.breastRows[x].nipplesPerBreast = 1;
				}
				changes++;
			}
			//If the PC has gills:
			if (player.hasGills() && rand(4) === 0 && changes < changeLimit) {
				mutations.updateGills();
			}
			//Hair
			var oldHairType:Number = player.hair.type;
			var hasFerretHairColor:Boolean = ColorLists.FERRET_HAIR.indexOf(player.hair.color) !== -1;
			if ((player.hair.type !== Hair.NORMAL || !hasFerretHairColor || player.hair.length <= 0) && rand(4) === 0 && changes < changeLimit)
			{
				if (!hasFerretHairColor)
					player.hair.color = randomChoice(ColorLists.FERRET_HAIR);

				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				player.hair.type = Hair.NORMAL;

				if (player.hair.length <= 0) {
					player.hair.length = 1;
					outputText("\n\nThe familiar sensation of hair returns to your head. After looking yourself on the stream,"
					          +" you confirm that your once bald head now has normal, short [hairColor] hair.");
				} else if (oldHairType === Hair.NORMAL && !hasFerretHairColor) {
					outputText("\n\nA mild tingling on your scalp makes your check yourself on the stream. Seems like the fruit is changing your"
					          +" hair this time, turning it into [hair].");
				} else {
					switch (oldHairType) {
						case Hair.FEATHER:
							outputText("\n\nWith the taste of the fruit still lingering, you start feeling an odd itch on your scalp."
							          +" When you scratch it, you see how your feathered hair has begin to shed, downy feathers falling from your"
							          +" head until you’re left bald. It doesn’t last long, fortunately, as you feel hairs sprouting from your scalp."
							          +" Checking the changes on the nearby river, you get a glimpse of how your new [hairColor] hair begins to"
							          +" rapidly grow. <b>You now have [hair]!</b>");
							break;

						case Hair.GOO:
							player.hair.length = 1;
							outputText("\n\nAfter having gulped down the fruit last bit, a lock of gooey hair falls over your forehead. When you try"
							          +" to examine it, the bunch of goo falls to the ground and evaporates. As you tilt your head to see what"
							          +" happened, more and more patches of goo start falling from your head, disappearing on the ground with the"
							          +" same speed. Soon, your scalp is devoid of any kind of goo, albeit entirely bald.");
							outputText("\n\nNot for long, it seems, as the familiar sensation of hair returns to your head a moment later."
							          +" After looking yourself on the stream, you confirm that"
							          +" your once bald head now has normal, short [hairColor] hair.");
							break;

						/* [INTERMOD: xianxia]
						case Hair.GORGON:
							player.hair.length = 1;
							outputText("\n\nAs the fruit last juices run through your mouth, the scaled critters on your head shake wildly in pained"
							          +" displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of the sweet fruit meal"
							          +" make themselves notorious, as the writhing mess of snakes start hissing uncontrollably."
							          +" Many of them go rigid, any kind of life that they could had taken away by the root effects."
							          +" Soon, all of the snakes that made your hair are limp and lifeless.");
							outputText("\n\nTheir dead bodies are separated from you head by a scorching sensation, and start falling to the ground,"
							          +" turning to dust in a matter of seconds. Examining your head on the stream, you realize that you have"
							          +" a normal, healthy scalp, though devoid of any kind of hair.");
							outputText("\n\nThe effects don’t end here, though as the familiar sensation of hair returns to your head a moment later."
							          +" After looking yourself on the stream again, you confirm that"
							          +" <b>your once bald head now has normal, short [hairColor] hair</b>.");
							break;
						*/

						default:
							outputText("\n\nA mild tingling on your scalp makes your check yourself on the stream. Seems like the fruit is changing"
							          +" your hair this time, turning it into [hair].");
					}
				}
				changes++;
			}
			//If the PC has four eyes:
			if ((player.eyes.type === Eyes.FOUR_SPIDER_EYES || player.eyes.count > 2) && rand(3) === 0 && changes < changeLimit)
			{
				outputText("\n\nYou vision turns black, forcing you to freeze where you are as the sudden blindness put you in danger of hitting"
				          +" something dangerous. Thank Marae, it doesn’t take long to your sight to return as usual, only with a little change."
				          +" As your vision filed feels oddly changed, you check the changes in your visage, noting that the number of eyes in your"
				          +" head has dropped to the average pair! <b>You have normal human eyes again!</b>");
				player.eyes.type = Eyes.HUMAN;
				player.eyes.count = 2;
				changes++;
			}
			//Go into heat
			if (rand(3) === 0 && changes < changeLimit) {
				if (player.goIntoHeat(true)) {
						changes++;
				}
			}
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Turn ferret mask to full furface.
			if (player.face.type === Face.FERRET_MASK && player.hasFur() && player.ears.type === Ears.FERRET && player.tail.type === Tail.FERRET && player.lowerBody.type === LowerBody.FERRET && rand(4) === 0 && changes < changeLimit)
			{
				outputText("\n\nNumbness overcomes your lower face, while the rest of your head is caught by a tingling sensation."
				          +" Every muscle on your face tenses and shifts, while the bones and tissue rearrange, radically changing the shape"
				          +" of your head. You have troubles breathing as the changes reach your nose, but you manage to see as it changes into an"
				          +" animalistic muzzle. At its top, your nose acquire a triangular shape, proper of a ferret and an adorable pink color."
				          +" You jaw joins it and your teeth sharpen, reshaping in the way of belonging on a little carnivore,"
				          +" albeit without looking menacing or intimidating.");
				outputText("\n\nOnce you’re face and jaw has reshaped, fur covers the whole of your head. The soft sensation is quite pleasant."
				          +" It has a [furColor] coloration, turning into white at your muzzle, cheeks and ears. The darkened skin around your eyes"
				          +" also changes, turning into a mask of equally soft fur colored in a darker shade of [furColor]."
				          +" Well, seems like <b>you now have an animalistic, ferret face!</b>");
				player.face.type = Face.FERRET;
				changes++;
			}
			//If face is human:
			if (player.face.type === Face.HUMAN && rand(3) === 0 && changes < changeLimit)
			{
				outputText("\n\nA sudden itching begins to encompass the area around your eyes. Grunting in annoyance, you rub furiously at the"
				          +" afflicted area. Once the feeling passes, you make your way to the nearest reflective surface to see if anything"
				          +" has changed. There, your suspicions are confirmed. The [skinFurScales] around your eyes has darkened."
				          +" <b>You now have a ferret mask!</b>");
				player.face.type = Face.FERRET_MASK;
				changes++;
			}
			//If face is not ferret, has ferret ears, tail, and legs:
			if ([Face.HUMAN, Face.FERRET_MASK, Face.FERRET].indexOf(player.face.type) === -1 && rand(3) === 0 && changes < changeLimit)
			{
				outputText("\n\nYou groan uncomfortably as the bones in your [face] begin to rearrange.  You grab your head with both hands,"
				          +" rubbing at your temples in an attempt to ease the pain.  As the shifting stops, you frantically feel at your face."
				          +" The familiar feeling is unmistakable. <b>Your face is human again!</b>");
				player.face.type = Face.HUMAN;
				changes++;
			}
			//Skin
			function setFurrySkin():void
			{
				var newFurColors:Array = randomChoice(ColorLists.FERRET_FUR);
				player.skin.type = Skin.FUR;
				player.skin.adj = "";
				player.skin.desc = "fur";
				player.skin.furColor = newFurColors[0];
				player.underBody.type = UnderBody.FURRY;
				player.copySkinToUnderBody({furColor: newFurColors[1]});
				changes++;
			}
			//Fix the underBody, if the skin is already furred
			if (player.skin.type === Skin.FUR && player.underBody.type !== UnderBody.FURRY && changes < changeLimit && rand(3) === 0) {
				setFurrySkin();
				outputText("\n\nLooks, like the fruit has changed your fur colors."
				          +" <b>You’re now covered from head to toe with [furColor] fur with [underBody.furColor] fur on your underside!</b>");
			}
			//No fur, has ferret ears, tail, and legs:
			if (!player.hasFur() && player.ears.type === Ears.FERRET && player.tail.type === Tail.FERRET && player.lowerBody.type === LowerBody.FERRET && rand(4) === 0 && changes < changeLimit)
			{
				var oldSkinType:Number = player.skin.type;
				if (["latex", "rubber"].indexOf(player.skin.adj) !== -1)
					oldSkinType = -99; // Pseudo-skintype for rubbery skin
				setFurrySkin();
				switch (oldSkinType) {
					case Skin.DRAGON_SCALES:
					case Skin.FISH_SCALES:
					case Skin.LIZARD_SCALES:
						outputText("\n\nThe layer of scales covering your body feels weird for a second, almost looking like they’re moving"
						          +" on their own, and that is when you realize that they changing!");
						outputText("\n\nThe feeling is quite odd, a bit of an itching from the place where they join your skin, that quickly becomes"
						          +" more intense as their transformation advances. Then a bunch of [skinTone] scales fall from your arm."
						          +" Soon all the scales on your arm fall off, leaving behind a layer of healthy, normal, [skin]."
						          +" The process continues overs the rest of your body, and before long you are covered in a layer of [skin].");
						outputText("\n\nNot for long though, as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten for a bug, only all over your body at the same time.");
						break;

					case Skin.GOO:
						outputText("\n\nYour usually wet and gooey skin suddenly a bit dry. Thinking that maybe the reason could be the dry weather"
						          +" in the wastelands, you rush to the stream, washing your skin on the refreshing water.");
						outputText("\n\nIt has the opposite effect of the one you intended, and you watch as a layer of [skinTone] colored slime"
						          +" falls from your arm.. Alarmed, you try to put it back,but to no avail. Soon all the goo on your arm slides off,"
						          +" leaving behind a layer of healthy, normal, [skin]. The process continues over the rest of your body, and before"
						          +" you can react your body is covered in a layer of fresh new [skin], the odd sensation fading as your core is"
						          +" expelled from your now perfectly solid body.");
						outputText("\n\nThis doesn’t last long though, as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten for a bug, only all over your body at the same time.");
						break;

					case Skin.FEATHERED:
						outputText("\n\nYou start to scratch your plumage, as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten by a bug, only that it’s all over at the same time,"
						          +" and instead of coming from your skin, it originates from your feathers.");
						break;

					case Skin.WOOL:
						outputText("\n\nYou start to scratch your wooly fur, as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten by a bug, only that it’s all over at the same time,"
						          +" and instead of coming from your skin, it originates from your wool.");
						break;

					/* [INTERMOD: Revamp Dryad]
					case Skin.BARK:
						outputText("\n\nYour usually fresh and solid bark suddenly feels a bit dry. Thinking that maybe the reason could be the dry"
						          +" weather in the wastelands, you rush to the stream, washing your barked skin in the refreshing water.");
						outputText("\n\nIt has the opposite effect of the one you intended, and you watch as a layer of [skinTone] colored bark falls"
						          +" from your arm. Soon all the barked surface on your arm melts off, leaving behind a layer of healthy, normal,"
						          +" [skin] covered by a thin layer of sweet smelling resin, that it’s quickly washed off by the stream."
						          +" The process continues over the rest of your body, and before you can react your body is covered"
						          +" in a layer of fresh new [skin], the odd sensation fading.");
						outputText("\n\nNot for long however, as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten for a bug, only all over your body at the same time.");
						break;
					*/

					case -99:
						outputText("\n\nYour usually oily and rubbery skin suddenly feels a bit dry. Thinking that maybe the reason could be the dry"
						          +" weather in the wastelands, you rush to the stream, washing your skin in the refreshing water.");
						outputText("\n\nIt has the opposite effect of the one you intended, and you watch as a layer of [skinTone] colored goopy"
						          +" rubber falls from your arm. Soon all the rubber on your arm melts off, leaving behind a layer of healthy,"
						          +" normal, [skin]. The process continues over the rest of your body, and before you can react your body is covered"
						          +" in a layer of fresh new [skin], the odd sensation fading.");
						outputText("\n\nNot for long however, as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten for a bug, only all over your body at the same time.");
						break;

					case Skin.PLAIN:
					default:
						outputText("\n\nYou start to scratch your [skin], as an uncomfortable itching overcomes you. It’s quite annoying,"
						          +" like the aftermath of being bitten by a bug, only that it’s all over at the same time.");

				}
				switch (oldSkinType) {
					case Skin.FEATHERED:
						outputText("\n\nRubbing on of your arms to ease the itching, you’re somewhat alarmed at seeing some of the feathers falling,"
						          +" but are soon relieved at discovering that they’re only changing, as they leave behind a patch of [furColor] fur."
						          +" Similar changes happen over your legs, chest and back, not leaving an inch of your plumage unaffected. Fur grows"
						          +" over your body as the feathers fall, the lone patches joining and closing as the layer of plumage disappears,"
						          +" and in a matter of seconds, your entire body is covered with a lovely coat of thick fur. The soft and fluffy"
						          +" sensation is quite pleasant to the touch."
						          +"\n<b>Seems like you’re now covered from head to toe with [furColor] fur"
						          +" with [underBody.furColor] fur on your underside!</b>");
						break;

					case Skin.WOOL:
						outputText("\n\nRubbing on of your arms to ease the itching, you’re somewhat alarmed at seeing some of the wool falling,"
						          +" but are soon relieved at discovering that they’re only changing, as they leave behind a patch of [furColor] fur,"
						          +" much more shorter, but still quite fuzzy. Similar changes happen over your legs, chest and back, not leaving an"
						          +" inch of your wool unaffected. Fur grows over your body as the strands of wool fall, the lone patches joining and"
						          +" closing as the layer of wooly fur disappear, and in a matter of seconds, your entire body is covered with a"
						          +" lovely coat of standard, fuzzy fur. The soft and fluffy sensation is quite pleasant to the touch."
						          +"\n<b>Seems like you’re now covered from head to toe with [furColor] fur"
						          +" with [underBody.furColor] fur on your underside!</b>");
						break;

					default:
						outputText("\n\nSoon you realize that the sensation is coming from under your skin. After rubbing one of your arms"
						          +" in annoyance, you feel something different, and when you lay your eyes on it, you realize that a patch of fur"
						          +" is growing over your skin. Then you spot similar patches over your legs, chest and back. Fur grows over"
						          +" your body, patches joining and closing over your skin, and in a matter of seconds, your entire body is covered"
						          +" with a lovely coat of thick fur. The soft and fluffy sensation is quite pleasant to the touch."
						          +"\n<b>Seems like you’re now covered from head to toe with [furColor] fur"
						          +" with [underBody.furColor] fur on your underside!</b>");
				}
			}
			//Tail TFs!
			if (player.tail.type !== Tail.FERRET && player.ears.type === Ears.FERRET && rand(3) === 0 && changes < changeLimit)
			{
				switch (player.tail.type) {
					case Tail.NONE:
						outputText("\n\nFeeling an uncomfortable sensation on your butt, you stretch yourself, attributing it to having sat on a"
						          +" rough surface. An annoying feeling runs troughs your body, forcing you to sit down. When it migrates to your"
						          +" back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it"
						          +" properly, it seems to move on its own, following the odd feeling that now pulsates through your spine,"
						          +" and once its twisting sensations have stopped, the appendage itself has become a long, fluffy tube."
						          +" [if (hasArmor)Luckily, the transformative outburst doesn’t seem to have damaged your [armor].]");
						outputText("\n\nShortly after, the lingering effects of the fruit return, the changes now focused on your tail proper,"
						          +" which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you."
						          +" A very thick mass of soft, fluffy fur covers it in a matter of seconds. It seems that you unconsciously make it"
						          +" move excitedly or nervously when you feel the same, not unlike a ferret would do.");
						break;

					case Tail.BEE_ABDOMEN:
					case Tail.SPIDER_ABDOMEN:
						outputText("\n\nYour rounded abdomen feels oddly hot at the touch. In a matter of second, the hat withing propagates to the"
						          +" rest of your body, and you ponder for a bit if you haven’t caught a fever. Weakened from a sudden, you have to"
						          +" lean your overheated body against a nearby rock. But, as soon as it came, the heat goes away.");
						outputText("\n\nIt didn't went away alone, it seems, because when you glimpse at your backside you notice that where once"
						          +" there was a large, insectile abdomen[if (hasOvipositor) and an ovipositor], there only is a normal, human set of"
						          +" normal-looking buttcheeks, covered in [skinfurScales].");
						outputText("\n\nThen, a second later, an annoying feeling runs troughs your body, forcing you to sit down. When it migrates"
						          +" to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check"
						          +" it properly, it seems to move on its own, following the odd feeling that now pulsates through your spine,"
						          +" and once its twisting sensations have stopped, the appendage itself has become a long, fluffy tube.");
						outputText("\n\nShortly after, the lingering effects of the fruit return, the changes now focused on your tail proper,"
						          +" which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you."
						          +" A very thick mass of soft, fluffy fur covers it in a matter of seconds. It seems that you unconsciously make it"
						          +" move excitedly or nervously when you feel the same, not unlike a ferret would do.");
						break;

					default:
						if (player.tail.type === Tail.FOX && player.tail.venom > 1) {// multi-tail
							outputText("\n\nYour tails seem to move on their own, tangling together in a single mass. Before you can ever feel it"
							          +" happening, you realize that they’re merging! An odd feeling, between a mild nausea and plain dizziness,"
							          +" rushes through your body, and once that it fades, you realize that you now have a single tail.");
							outputText("\n\nThe process doesn’t stop here though, as the lingering effects of the fruit return, the changes"
							          +" now focused on your tail proper, which shakes wildly while it elongates and becomes more bushy."
							          +" Soon it has become almost as long as you. A very thick mass of soft, fluffy fur covers it in a matter of"
							          +" seconds. It seems that you unconsciously make it move excitedly or nervously when you feel the same,"
							          +" not unlike a ferret would do.");
							break;
						}

						// Other tails
						outputText("\n\nThe lingering effects of the fruit return, the changes now focused on your tail proper, which shakes wildly"
						          +" while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft,"
						          +" fluffy fur covers it in a matter of seconds. It seems that you unconsciously make it move excitedly or nervously"
						          +" when you feel the same, not unlike a ferret would do.");
				}
				outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body,"
				          +" realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch."
				          +" Anyways, <b>you have now a long, bushy, ferret tail!</b>");
				player.tail.setAllProps({type: Tail.FERRET});
				changes++;
			}
			//If legs are not ferret, has ferret ears and tail
			if (player.lowerBody.type !== LowerBody.FERRET && player.ears.type === Ears.FERRET && player.tail.type === Tail.FERRET && rand(4) === 0 && changes < changeLimit)
			{
				//-If centaur, has ferret ears and tail:
				if (player.isTaur()) {
					outputText("\n\nYou legs tremble, forcing you to lie on the ground, as they don't seems to answer you anymore."
					          +" A burning sensation in them is the last thing you remember before briefly blacking out. When it subsides"
					          +" and you finally awaken, you look at them again, only to see that you’ve left with a single set of digitigrade legs,"
					          +" and a much more humanoid backside. Soon enough, the feeling returns to your reformed legs, only to come with an"
					          +" itching sensation. A thick [if (hasFurryUnderBody)[underBody.furColor]|black-brown] coat of fur sprouts from them."
					          +" It’s soft and fluffy to the touch. Cute pink paw pads complete the transformation."
					          +" <b>Seems like you’ve gained a set of ferret paws!</b>");
				} else {
					switch (player.lowerBody.type) {
						case LowerBody.NAGA:
							outputText("\n\nA strange feeling in your tail makes you have to lay on the ground. Then, the feeling becomes stronger,"
							          +" as you feel an increasing pain in the middle of your coils. You gaze at them for a second, only to realize"
							          +" that they’re dividing! In a matter of seconds, they’ve reformed into a more traditional set of legs,"
							          +" with the peculiarity being that they’re fully digitigrade in shape. Soon, every scale on them falls off to"
							          +" leave soft [skin] behind. That doesn’t last long, because soon a thick coat of"
							          +" [if (hasFurryUnderBody)[underBody.furColor]|black-brown] fur covers them."
							          +" It feels soft and fluffy to the touch. Cute pink paw pads complete the transformation."
							          +" <b>Seems like you’ve gained a set of ferret paws!</b>");
							break;

						case LowerBody.GOO:
							outputText("\n\nYour usually fluid gooey appendage becomes strangely rigid, forcing you to stay still as you are."
							          +" Then, in front of your eyes, you see how the goo on it concentrates and shapes into the usual shape of two"
							          +" legs. Faster than you can would’ve imagined, the fluid turns into solid bones, that are instantly enveloped"
							          +" by tissues, nerves and muscles, only to be finally covered in a layer of soft, human-looking skin."
							          +" You test your re-gained feet, smiling when discovering"
							          +" that you can use them as before without major issue.");
							outputText("\n\nThen, a feeling of unease forces you to sit on a nearby rock, as you feel something within your [feet]"
							          +" is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging"
							          +" themselves. After a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads,"
							          +" ending in short black claws and covered in a thick layer of"
							          +"  fur. It feels quite soft and fluffy."
							          +" <b>You’ve gained a set of ferret paws!</b>");
							break;

						case LowerBody.DRIDER:
							outputText("\n\nYou eight spider-like legs tremble, forcing you to lie on the ground, as they doesn't seem to answer"
							          +" you anymore. A burning sensation in them is the last thing you remember before briefly blacking out."
							          +" When it subsides and you finally awaken, you look at them again, only to see that you’ve left with a single"
							          +" set of digitigrade legs. Soon enough, the feeling returns to your reformed legs, only to come with an"
							          +" itching sensation. A thick [if (hasFurryUnderBody)[underBody.furColor]|black-brown] coat of fur"
							          +" sprouts from them. It’s soft and fluffy to the touch. Cute pink paw pads complete the transformation."
							          +" <b>Seems like you’ve gained a set of ferret paws!</b>");
							break;

						case LowerBody.HUMAN:
						case LowerBody.HOOFED:
						case LowerBody.CLOVEN_HOOFED:
						case LowerBody.DEMONIC_CLAWS:
						case LowerBody.DEMONIC_HIGH_HEELS:
						default:
							outputText("\n\nA feeling of unease forces you to sit on a nearby rock, as you feel something within your [feet]"
							          +" is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging"
							          +" themselves. After a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads,"
							          +" ending in short black claws and covered in a thick layer of"
							          +" [if (hasFurryUnderBody)[underBody.furColor]|black-brown] fur. It feels quite soft and fluffy."
							          +" <b>You’ve gained a set of ferret paws!</b>");
					}
				}
				changes++;
				player.lowerBody.type = LowerBody.FERRET;
				player.lowerBody.legCount = 2;
			}
			//Arms
			if (player.arms.type !== Arms.FERRET && player.tail.type === Tail.FERRET && player.lowerBody.type === LowerBody.FERRET && rand(4) === 0 && changes < changeLimit)
			{
				outputText("\n\nWeakness overcomes your arms, and no matter what you do, you can’t muster the strength to raise or move them."
				          +" Did the fruit had some drug-like effects? Sitting on the ground, you wait for the limpness to end. As you do so,"
				          +" you realize that the bones at your hands are changing, as well as the muscles on your arms. They’re soon covered,"
				          +" from the shoulders to the tip of your digits, on a layer of soft,"
				          +" fluffy [if (hasFurryUnderBody)[underBody.furColor]|black-brown] fur. Your hands gain pink, padded paws where your palms"
				          +" were once, and your nails become short claws, not sharp enough to tear flesh, but nimble enough to make climbing and"
				          +" exploring much easier. <b>Your arms have become like those of  a ferret!</b>");
				player.arms.setType(Arms.FERRET);
				changes++;
			}
			//If ears are not ferret:
			if (player.ears.type !== Ears.FERRET && rand(4) === 0 && changes < changeLimit)
			{
				outputText("\n\nYour ears twitch under the fruit transformative effects, and your hearing is diminished for a while when they change."
				          +" As uncomfortable as it is, the process, luckily, doesn’t take too much time. The flesh on your ears shift and merges"
				          +" into a couple of small, round ones. Then, [furColor] fur sprouts over them, as they locate themselves at the sides of"
				          +" your head, ready to detect any nearby sound. At the end, you’re left with a pair of ferret ears, quite animalistic on"
				          +" their shape and looks. <b>You’ve got ferret ears!</b>");
				player.ears.type = Ears.FERRET;
				changes++;
			}
			//Remove antennae, if insectile
			if (player.hasInsectAntennae() && rand(4) === 0 && changes < changeLimit)
			{
				outputText("\n\nThe antennae parting your hair become suddenly numb, no doubt due the fruit effects, and they become thinner"
				          +" and thinner. When they’re almost hair-width, the remaining flesh on them reabsorbs itself on your head."
				          +" Seems like <b>your antennae are gone</b>.");
				player.antennae.type = Antennae.NONE;
				changes++;
			}
			//If no other effect occurred, fatigue decreases:
			if (changes === 0)
			{
				outputText("\n\nYour eyes widen.  With the consumption of the fruit, you feel much more energetic.  You’re wide awake now!");
				player.changeFatigue(-20);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}
	}
}
