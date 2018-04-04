package classes.Items.Consumables 
{
	import classes.Appearance;
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	import classes.lists.BreastCup;
	import classes.lists.Gender;

	/**
	 * @since  26.05.2017
	 * @author Stadler76
	 */
	public class TonOTrice extends Consumable
	{
		
		public function TonOTrice() 
		{
			super(
				"ToTrice",
				"Ton o' Trice",
				"a ton o' trice",
				ConsumableLib.DEFAULT_VALUE,
				"It’s a small bottle of thick turquoise liquid labelled ‘Ton o’ Trice’. The label shows an avian creature with a thick reptilian"+
				" tail and bright coloured plumage playfully flying around the text."
			);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "TonOTrice";
			var i:int;
			player.slimeFeed();
			mutations.initTransformation([2, 2, 3, 4]);

			clearOutput();
			credits.authorText = "MissBlackthorne";
			outputText("You drink the slimy concoction, grimacing as it reaches your tongue. At first you’re shocked you don’t gag but once you taste"
			          +" the mixture you realise it's not so bad, almost having a hint of almond behind that thick texture.");

			if (player.spe < player.ngPlus(100) && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYou stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation,"
				          +" you adjust. You’re certain that you can run faster now.");
				//+3 spe if less than 50
				if (player.spe < player.ngPlus(50)) dynStats("spe", 1);
				//+2 spe if less than 75
				if (player.spe < player.ngPlus(75)) dynStats("spe", 1);
				//+1 if above 75.
				dynStats("spe", 1);
			}

			if (player.tou > player.ngPlus(80) && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou feel yourself become a little more delicate, as though you can’t handle quite so strong hits anymore. Then again,"
				          +" who needs to withstand a blow when you can just move with the speed of the wind and dodge it?");
				dynStats("tou", -1);

			}

			//-Reduces sensitivity.
			if (player.sens > 20 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nThe sensation of prickly pins and needles moves over your body, leaving your senses a little dulled in its wake.");
				dynStats("sen", -1);
			}

			//Raises libido greatly to 50, then somewhat to 75, then slowly to 100.
			if (player.lib < 100 && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA knot of fire in your gut doubles you over but passes after a few moments. As you straighten you can feel the heat"
				          +" seeping into you, ");
				//(DICK)
				if (player.cocks.length > 0 && (player.gender != Gender.HERM || rand(2) == 0)) {
					outputText("filling [if (cocks > 1)each of] your [cocks] with the desire to breed. You get a bit hornier when you realize your"
					          +" sex-drive has gotten a boost.");
				}
				//(COOCH)
				else if (player.hasVagina()) {
					outputText("puddling in your [vagina]. An instinctive desire to mate and lay eggs spreads through you, increasing your lust and"
					          +" boosting your sex-drive.");
				}
				//(TARDS)
				else {
					outputText("puddling in your featureless crotch for a split-second before it slides into your [ass].  You want to be fucked,"
					          +" filled, and perhaps even gain a proper gender again.  Through the lust you realize your sex-drive has been"
					          +" permanently increased.");
				}
				//+3 lib if less than 50
				if (player.lib < 50) dynStats("lib", 1);
				//+2 lib if less than 75
				if (player.lib < 75) dynStats("lib", 1);
				//+1 if above 75.
				dynStats("lib", 1);
			}

			//Sexual changes

			//-Lactation stoppage.
			if (player.biggestLactation() >= 1 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\n[if (totalNipples == 2)Both of your|All of your many] nipples relax. It's a strange feeling, and you pull back your"
				          +" top to touch one. It feels fine, though there doesn't seem to be any milk leaking out.  You give it a squeeze and marvel"
				          +" when nothing [if (hasNippleCunts)but sexual fluid] escapes it. <b>You are no longer lactating.</b> That makes sense,"
				          +" only mammals lactate!  Smiling, you muse at how much time this will save you when cleaning your gear.");
				if (player.findPerk(PerkLib.Feeder) >= 0 || player.hasStatusEffect(StatusEffects.Feeder)) {
					outputText("\n\n(<b>Feeder perk lost!</b>)");
					player.removePerk(PerkLib.Feeder);
					player.removeStatusEffect(StatusEffects.Feeder);
				}
				changes++;
				//Loop through and reset lactation
				for (i = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].lactationMultiplier = 0;
				}
			}

			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA chill runs over your [allBreasts] and vanishes. You stick a hand under your [armor] and discover that your extra"
				          +" nipples are missing! You're down to just one per [if (biggestTitSize < 1)'breast'|breast].");
				changes++;
				//Loop through and reset nipples
				for (i = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].nipplesPerBreast = 1;
				}
			}

			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) == 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				mutations.removeExtraBreastRow(tfSource);
			}

			//-Butt > 5 - decrease butt size
			if (player.butt.rating > 5 && changes < changeLimit && rand(4) == 0) {
				changes++;
				player.butt.rating--;
				outputText("\n\nA feeling of tightness starts in your [butt], increasing gradually. The sensation grows and grows, but as it does"
				          +" your center of balance shifts. You reach back to feel yourself, and sure enough your [butt] is shrinking into a"
				          +" more manageable size.");
			}

			if (player.isFemaleOrHerm()) {
				//Breasts > D cup - Decrease breast size by up to 3 cups
				if (player.isFemaleOrHerm() && player.biggestTitSize() > BreastCup.D && changes < changeLimit && rand(3) == 0) {
					for (i = 0; i < player.breastRows.length; i++) {
						if (player.breastRows[i].breastRating > BreastCup.D)
							player.breastRows[i].breastRating -= 1 + rand(3);
					}
					outputText("\n\nYour breasts feel tight[if (hasArmor), your [armor] feeling looser around your chest]. You watch in shock as your"
					          +" breast flesh rapidly diminishes, shrinking into your chest. They finally stop when they reach [breastcup] size."
					          +" You feel a little lighter.");
					dynStats("spe", 1);
					changes++;
				}

				//Breasts < B cup - Increase breast size by 1 cup
				if (player.isFemaleOrHerm() && player.smallestTitSize() < BreastCup.B && changes < changeLimit && rand(3) == 0) {
					for (i = 0; i < player.breastRows.length; i++) {
						if (player.breastRows[i].breastRating < BreastCup.B)
							player.breastRows[i].breastRating++;
					}
					outputText("\n\nYour breasts feel constrained and painful against your top as they grow larger by the moment, finally stopping as"
					          +" they reach [breastcup] size. You rub the tender orbs as you get used to your larger breast flesh.");
					dynStats("lib", 1);
					changes++;
				}

				//Hips > 12 - decrease hip size by 1-3 sizes
				if (player.hips.rating > 12 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully. Your hips have narrowed.");
					player.hips.rating -= 1 + rand(3);
					changes++;
				}

				//Hips < 6 - increase hip size by 1-3 sizes
				if (player.hips.rating < 6 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hips.rating += 1 + rand(3);
					changes++;
				}

				if (player.nippleLength > 1 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nWith a sudden pinch your [nipples] get smaller and smaller,"
					          +" stopping when they are roughly half their previous size");
					player.nippleLength /= 2;
				}

				if (player.hasVagina() && player.vaginas[0].vaginalWetness < 3 && changes < changeLimit && rand(4) == 0) {
					outputText("\n\nYour [cunt]'s internal walls feel a tingly wave of strange tightness which then transitions into a long"
					          +" stretching sensation, like you were made of putty. Experimentally, you slip a couple of fingers inside to find"
					          +" you've become looser and more pliable, ready to take those monster cocks. Or better yet, to lay eggs.");
					player.vaginas[0].vaginalWetness++
					changes++;
				}

				//Increase tone (up to 65)
				if (player.tone < 65 && rand(3) == 0) {
					outputText(player.modTone(65, 2));
				}

				//Decrease thickness (down to 35)
				if (player.thickness > 35 && rand(3) == 0) {
					outputText(player.modThickness(35, 5));
				}

				if (rand(5) == 0 && player.cockatriceScore() > 3) {
					mutations.updateOvipositionPerk(tfSource); // does all the magic, nuff said!
				}
			}

			if (player.isMale()) {
				//Breasts > B cup - decrease by 1 cup size
				if (player.biggestTitSize() > BreastCup.B && changes < changeLimit && rand(3) == 0) {
					for (i = 0; i < player.breastRows.length; i++) {
						if (player.breastRows[i].breastRating > BreastCup.B)
							player.breastRows[i].breastRating--;
					}
					outputText("\n\nYour breasts feel tight[if (hasArmor), your [armor] feeling looser around your chest]. You watch in shock as your"
					          +" breast flesh rapidly diminishes, shrinking into your chest. They finally stop when they reach [breastcup] size."
					          +" You feel a little lighter.");
					dynStats("spe", 1);
					changes++;
				}

				if (player.nippleLength > 1 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nWith a sudden pinch your [nipples] get smaller and smaller,"
					          +" stopping when they are roughly half their previous size");
					player.nippleLength /= 2;
				}

				//Hips > 10 - decrease hip size by 1-3 sizes
				if (player.hips.rating > 10 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully. Your hips have narrowed.");
					player.hips.rating -= 1 + rand(3);
					changes++;
				}

				//Hips < 2 - increase hip size by 1-3 sizes
				if (player.hips.rating < 2 && changes < changeLimit && rand(3) == 0) {
					outputText("\n\nYou stumble as you feel the bones in your hips grinding, expanding your hips noticeably.");
					player.hips.rating += 1 + rand(3);
					changes++;
				}

				//Increase tone (up to 70)
				if (player.tone < 70 && rand(3) == 0) {
					outputText(player.modTone(65, 2));
				}

				//Decrease thickness (down to 35)
				if (player.thickness > 35 && rand(3) == 0) {
					outputText(player.modThickness(35, 5));
				}
			}

			if (player.isMaleOrHerm()) {
				//Cock < 6 inches - increase by 1-2 inches
				if (player.shortestCockLength() < 6 && rand(3) == 0 && changes < changeLimit) {
					var increment:Number = player.increaseCock(player.shortestCockIndex(), 1 + rand(2));
					outputText("Your [if (cocks > 1)shortest] cock fills to its normal size, but doesn’t just stop there. Your cock feels incredibly"
					          +" tight as a few more inches of length seem to pour out from your crotch."
					          +" Your cock has gained "+ increment + " inches.");
					changes++;
				}

				//Shrink oversized cocks
				if (player.biggestCockLength() > 16 && rand(3) == 0 && changes < changeLimit) {
					var idx:int = player.biggestCockIndex();
						outputText("\n\nYou feel a tightness in your groin like someone tugging on your shaft from behind you. Once the sensation"
						          +" fades you check [if (hasLowerGarment)inside your [lowergarment]|your [multicock]] and see that your"
						          +" [if (cocks > 1)largest] [cock] has shrunk to a slightly shorter length.");
					player.cocks[idx].cockLength -= (rand(10) + 5) / 10;
					if (player.cocks[idx].cockThickness > 3) {
						outputText(" Your " + player.cockDescript(idx) + " definitely got a bit thinner as well.");
						player.cocks[idx].cockThickness -= (rand(4) + 1) / 10;
					}
					changes++;
				}

				//Cock thickness <2 - Increase cock thickness
				if (player.smallestCockArea() < 10 && rand(3) == 0 && changes < changeLimit) {
					outputText("[if (cocks > 1) One of your cocks|Your cock] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm"
					          +" your suspicions. It is definitely thicker.");
					player.cocks[player.thinnestCockIndex()].thickenCock(1.5);
					changes++;
				}
			}

			//-Lizard dick - first one
			if (player.countCocksOfType(CockTypesEnum.LIZARD) == 0 && player.cockTotal() > 0 && changes < changeLimit && rand(4) == 0) {
				//Find the first non-lizzy dick
				for (i = 0; i < player.cocks.length; i++) {
					//Stop loopahn when dick be found
					if (player.cocks[i].cockType !== CockTypesEnum.LIZARD) break;
				}
				outputText("\n\nA slow tingle warms your groin.  Before it can progress any further, you yank back your [armor] to investigate."
				          +"  Your " + player.cockDescript(i) + " is changing!  It ripples loosely from [if (hasSheath)sheath|base] to tip,"
				          +" undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue."
				          +"  Your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " resolves itself into a bulbous form, with a slightly pointed tip."
				          +"  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners,"
				          +" but the perverse, alien pecker ");
				if (player.cor < 33) outputText("horrifies you.");
				else if (player.cor < 66) outputText("is a little strange for your tastes.");
				else {
					outputText("looks like it might be more fun to receive than use on others.  ");
					if (player.hasVagina()) outputText("Maybe you could find someone else with one to ride?");
					else outputText("Maybe you should test it out on someone and ask them exactly how it feels?");
				}
				outputText("  <b>You now have a bulbous, lizard-like cock.</b>");
				//Actually xform it nau
				if (player.hasSheath()) {
					player.cocks[i].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath())
						outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your "
						          + player.cockDescript(i) + "'s lower portions.  After a few moments"
						          +" <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[i].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}
			//(CHANGE OTHER DICK)
			//Requires 1 lizard cock, multiple cocks
			if (player.cockTotal() > 1 && player.countCocksOfType(CockTypesEnum.LIZARD) > 0 && player.cockTotal() > player.countCocksOfType(CockTypesEnum.LIZARD) && rand(4) == 0 && changes < changeLimit) {
				outputText("\n\nA familiar tingle starts in your crotch, and before you can miss the show, you pull open your [armor]."
				          +"  As if operating on a cue, ");
				for (i = 0; i < player.cocks.length; i++) {
					//Stop loopahn when dick be found
					if (player.cocks[i].cockType !== CockTypesEnum.LIZARD) break;
				}
				if (player.cockTotal() == 2) outputText("your other dick");
				else outputText("another one of your dicks");
				outputText(" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating"
				          +" pleasurable feelings back to you as the transformation progresses.  ");
				if (player.cumQ() < 50) outputText("pre-cum oozes from the tip");
				else if (player.cumQ() < 700) outputText("Thick pre-cum rains from the tip");
				else outputText("A wave of pre-cum splatters on the ground");
				outputText(" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>");
				//(REMOVE SHEATH IF NECESSARY)
				if (player.hasSheath()) {
					player.cocks[i].cockType = CockTypesEnum.LIZARD;
					if (!player.hasSheath())
						outputText("\n\nYour sheath tightens and starts to smooth out, revealing ever greater amounts of your "
						          + player.cockDescript(i) + "'s lower portions.  After a few moments"
						          +" <b>your groin is no longer so animalistic – the sheath is gone.</b>");
				}
				else player.cocks[i].cockType = CockTypesEnum.LIZARD;
				changes++;
				dynStats("lib", 3, "lus", 10);
			}

			//--Worms leave if 100% lizard dicks?
			//Require mammals?
			if (player.countCocksOfType(CockTypesEnum.LIZARD) == player.cockTotal() && changes < changeLimit && player.hasStatusEffect(StatusEffects.Infested)) {
				outputText("\n\nLike rats from a sinking ship, worms escape from your body in a steady stream.  Surprisingly, the sensation is"
				          +" remarkably pleasant, similar to the pleasure of sexual release in a way.  Though they seem inexhaustible, the tiny,"
				          +" cum-slimed invertebrates slow to a trickle.  The larger worm-kin inside you stirs as if disturbed from a nap, coming"
				          +" loose from whatever moorings it had attached itself to in the interior of your form.  It slowly works its way up your"
				          +" urethra, stretching to an almost painful degree with every lurching motion. Your dick bloats out around the base,"
				          +" stretched like the ovipositor on a bee-girl in order to handle the parasitic creature,"
				          +" but thankfully, the ordeal is a brief one.");
				if (player.balls > 1)
					outputText("  The remaining " + num2Text(player.balls - 1) + " slither out the pre-stretched holes with ease,"
					          +" though the last one hangs from your tip for a moment before dropping to the ground.");
				outputText("  The white creature joins its kin on the ground and slowly slithers away.  Perhaps they prefer mammals? In any event,"
				          +" <b>you are no longer infected with worms</b>.");
				player.removeStatusEffect(StatusEffects.Infested);
				changes++;
			}

			//Increase height up to 5ft 7in.
			if (player.tallness < 67 && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nYou shift uncomfortably as you realize you feel off balance."
				          +" Gazing down, you realize you have grown SLIGHTLY taller.");
				player.tallness += rand(3) + 1;
				changes++;
			}

			//Decrease height down to a maximum of 6ft 8in.
			if (player.tallness > 80 && changes < changeLimit && rand(5) == 0) {
				outputText("\n\nYour skin crawls, making you close your eyes and shiver. When you open them again the world seems... different."
				          +" After a bit of investigation, you realize you've become shorter!");
				player.tallness -= rand(3) + 1;
				changes++;
			}

			//Physical changes:
			//Removes other antennae
			if (player.hasNonCockatriceAntennae() && rand(3) == 0 && changes < changeLimit) {
				mutations.removeAntennae();
			}
			//Gain antennae like feathers
			if (player.antennae.type == Antennae.NONE && player.face.type == Face.COCKATRICE && player.ears.type == Ears.COCKATRICE && rand(3) == 0 && changes < changeLimit) {
				// Other antennae types are handled above! (Stadler76)
				outputText("\n\nYour forehead suddenly itches, making you run your fingers through your hairline as you try to scratch. Under your"
				          +" roving fingertips you feel your pores stretch as the shaft of one of your feathers gets thicker and sturdier. A sudden"
				          +" pressure builds and then fades, making you groan as you hold your head tight. You tentatively run your fingers over the"
				          +" two spots where the feeling originated, only to feel the body of a long, soft and extravagant quill like feather on each"
				          +" side. While sturdy enough to support themselves these " + player.hair.color + " feathers flop daintily as you move."
				          +" They seem to move with your eyebrows, helping convey your expressions.");
				outputText("\n<b>You’ve got antennae like eyebrow feathers!</b>");
				player.antennae.type = Antennae.COCKATRICE;
				changes++;
			}
			//Removes horns
			if (changes < changeLimit && (player.horns.type != Horns.NONE || player.horns.value != 0) && rand(5) == 0) {
				outputText("\n\nYour ");
				if (player.horns.type == Horns.UNICORN || player.horns.type == Horns.RHINO) outputText("horn");
				else outputText("horns");
				outputText(" crumble, falling apart in large chunks until they flake away to nothing.");
				player.horns.value = 0;
				player.horns.type = Horns.NONE;
				changes++;
			}

			//Face TF
			if (player.face.type != Face.COCKATRICE && player.arms.type == Arms.COCKATRICE && player.lowerBody.type == LowerBody.COCKATRICE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour head is suddenly wracked with pain. You throw back your head and scream in agony as you feel your skull’s"
				          +" structure shifting, reforming into something... different. Your lower face elongates, your nose and lips fusing into the"
				          +" new upper half of your mouth while your jaw soon catches it up as they both harden. Your larger upper lip curves over"
				          +" your lower, ending in a pointed tip as it changes colour to a shade of yellow. Small feathers rapidly sprout from your"
				          +" skin, covering it in " + (player.hasCockatriceSkin() ? player.skin.furColor : player.hair.color) + " feathers. Once your face"
				          +" stops it’s rapid transformation you run your hands over your face. You have a beak like muzzle,"
				          +" though instead of sharp edges, the lips are firm and rubbery, allowing you the same amount of facial expression as"
				          +" before while being solid enough to crack open seeds and nuts like that of a bird.");
				outputText("\n<b>You have a cockatrice face!</b>");
				player.face.type = Face.COCKATRICE;
				changes++;
			}
			//Hair TF
			if (player.hair.type != Hair.FEATHER && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your"
				          +" hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated"
				          +" to the sight of downy fluff trailing from your [claws]. A realization dawns on you - <b>you have feathers for hair,"
				          +" just like a harpy!</b>");
				player.hair.type = Hair.FEATHER;
				changes++;
			}
			//Eye TF
			if (player.eyes.type != Eyes.COCKATRICE && player.face.type == Face.COCKATRICE && player.underBody.type == UnderBody.COCKATRICE && player.ears.type == Ears.COCKATRICE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nYour eyes suddenly burn, tears streaming down your cheeks. Your irises grow, taking up your entire eye as a spiderweb"
				          +" of light blue crawls across your now vibrant blue eyes, looking like lightning strikes. Your pupils rapidly grow to"
				          +" match, elongating into slit like shapes, similar to that of a feline. When your eyes stop watering you finally get a"
				          +" look at yourself. Your eyes are now the same as that of the cockatrice you met in the mountains! Your excitement over"
				          +" this causes your pupils to widen into large circles, giving you a cute and excited look. Seems you won’t be able to have"
				          +" much of a poker face anymore.");
				outputText("\n<b>You now have cockatrice eyes!</b>");
				player.eyes.type = Eyes.COCKATRICE;
				player.eyes.count = 2;
			}
			//Lizard tongue TF
			if (player.tongue.type != Tongue.LIZARD && player.face.type == Face.COCKATRICE && changes < changeLimit && rand(3) == 0) {
				mutations.gainLizardTongue();
			}
			//Ears TF
			if (player.ears.type != Ears.COCKATRICE && player.face.type == Face.COCKATRICE && changes < changeLimit && rand(3) == 0) {
				outputText("\n\nA prickling sensation suddenly fills your ears; unpleasant, but hardly painful. It grows and grows until you can't"
				          +" stand it any more, and reach up to scratch at them. To your surprise, you find them melting away like overheated"
				          +" candles. You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion."
				          +" Then, all of a sudden, hearing returns to you.  Gratefully investigating, you find you now have a pair of avian"
				          +" ear-holes, one on either side of your head. A sudden pain strikes your temples, and you feel long feathers sprout from"
				          +" the side you your head, the longest being vertical while the 3 shorter ones come out at a 1 o'clock, 2 o'clock and"
				          +" 3 o'clock angle. With a little patience, you begin to adjust these feathers just like ears to aid your hearing.");
				outputText("\n<b>You now have cockatrice ears!</b>");
				player.ears.type = Ears.COCKATRICE;
				changes++;
			}
			//Arm TF
			if (player.arms.type != Arms.COCKATRICE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed"
				          +" pins and needles. You scratch yourself, hoping for relief; but soon notice lumps forming under the skin as your lower"
				          +" arm begins to shed. A coat of " + (player.hasCockatriceSkin() ? player.skin.furColor : player.hair.color) + " feathers sprouts"
				          +" from your skin, covering your upper arm and shoulder entirely, ending at your elbow in a fluffy cuff."
				          +" A few long feathers decorate your elbows like vestigial wings. Your lower arm however as grown a layer thick leathery"
				          +" scales and dangerous looking talons tip your fingers. As suddenly as the itching came it fades, leaving you to marvel"
				          +" over your new arms.");
				outputText("\n<b>You now have cockatrice arms!</b>");
				player.arms.setType(Arms.COCKATRICE, Claws.COCKATRICE);
				changes++;
			}
			//Neck loss, if not cockatrice neck
			if (player.neck.type != Neck.COCKATRICE && changes < changeLimit && rand(4) == 0)
				mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.rearBody.type != RearBody.NONE && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Body TF
			if (!player.hasCockatriceSkin() && player.face.type == Face.COCKATRICE && changes < changeLimit && rand(3) == 0) {
				mutations.restoreNeck(tfSource + "-forceRestoreNeck");
				var colorChoice:Array = mutations.newCockatriceColors();
				outputText("\n\nYour body feels hot and your skin feels tight, making you fall to your knees in a bout of lightheadedness."
				          +" You kneel there panting as the pressure increases, sweat dripping from your brow. You don’t know how long you can take"
				          +" this and soon you drift into unconsciousness.");
				outputText("\nWhen you awaken you check yourself to see what has changed now that the overwhelming pressure has left your body."
				          +" The first thing you notice is feathers, lots and lots of feathers that now cover your body in a downy layer."
				          +" Around your neck a ruff of soft fluffy feathers has formed like that of an exotic bird. As you look down to your [chest]"
				          +" you see that from your chest to your groin you are covered in a layer of " + colorChoice[2] + " scales.");
				outputText("\n<b>Your body is now covered in scales and feathers!</b>");

				player.skin.setAllProps({
					type:     Skin.LIZARD_SCALES,
					furColor: colorChoice[0], // Primary feather color
					tone:     colorChoice[2],
					desc:     "scales"
				});
				player.underBody.setAllProps({
					type: UnderBody.COCKATRICE,
					skin: {
						type:     Skin.FEATHERED,
						furColor: colorChoice[1], // Secondary feather color
						tone:     colorChoice[2],
						desc:     "feathers"
					}
				});
				player.neck.setAllProps({
					type: Neck.COCKATRICE,
					color: colorChoice[1]
				});
				changes++;
			}
			//Neck TF, if not already TFed from Body TF above
			if (player.neck.type != Neck.COCKATRICE && player.hasCockatriceSkin() && player.face.type == Face.COCKATRICE && changes < changeLimit && rand(3) == 0) {
				mutations.restoreNeck(tfSource);
				outputText("\n\nYour neck starts to tingle and [secondary furcolor] feathers begin to grow out of it one after another until a ruff"
				          +" of soft fluffy feathers has formed like that of an exotic bird.");
				outputText("\n<b>You now have a cockatrice neck!</b>");
				player.neck.setAllProps({
					type: Neck.COCKATRICE,
					color: colorChoice[1]
				});
				changes++;
			}
			//Leg TF
			if (player.lowerBody.type != LowerBody.COCKATRICE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nYou scream in agony as you feel the bones in your feet suddenly break and restructure themselves,"
				          +" becoming digitigrade. These strange new legs have three-toed, clawed feet, complete with a small vestigial claw-toe on"
				          +" the back for added grip, yet from hip to knee are covered with a layer of "
				          + (player.hasCockatriceSkin() ? player.skin.furColor : player.hair.color) + " feathers that end in a cuff.");
				outputText("\n<b>You have cockatrice legs!</b>");
				player.lowerBody.type = LowerBody.COCKATRICE;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//Tail TF
			if (player.tail.type != Tail.COCKATRICE && changes < changeLimit && rand(4) == 0) {
				outputText("\n\nA sudden dull, throbbing pain in your [butt] forces your hands to it; you can feel an ominous lump over your tail"
				          +" bone, swelling bigger and bigger with every heartbeat.  All of a sudden, it seems to explode, jutting out and around"
				          +" until it hovers near your ankles. The skin beneath your fingers is covered in feathers but terminates about an inch"
				          +" later in a 'v'shape, giving way to " + player.skin.tone + " scales.");
				outputText("\n<b>You now have a cockatrice tail!</b>");
				player.tail.type = Tail.COCKATRICE;
				player.tail.recharge = 5;
				player.tail.venom = 0;
				changes++;
			}
			//Wings TF
			if (player.wings.type != Wings.FEATHERED_LARGE && player.arms.type == Arms.COCKATRICE && changes < changeLimit && rand(4) == 0) {
				outputText("\n");
				if (player.wings.type != Wings.NONE) {
					outputText("\nSensation fades from your [wings] slowly but surely, leaving them dried out husks that break off to fall on the"
					          +" ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
				}
				player.wings.setProps({
					type:  Wings.FEATHERED_LARGE,
					color: player.isFluffy() || player.hasCockatriceSkin() ? player.skin.furColor : player.hair.color
				});
				outputText("\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your skin. It hurts, oh gods does"
				          +" it hurt, but you can’t get a good angle to feel at the source of your agony. A loud crack splits the air, and then your"
				          +" body is forcing a pair of narrow limbs through a gap in your comfortable clothes. Blood pumps through the new"
				          +" appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn’t know"
				          +" you had, and <b>you’re able to curve the new growths far enough around to behold your brand new, "
				          + player.wings.color + " wings</b>.");
				changes++;
			}

			//FAILSAFE CHANGE
			if (changes == 0) {
				outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				player.HPChange(50, true);
				dynStats("lus", 3);
			}

			player.refillHunger(20);
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
