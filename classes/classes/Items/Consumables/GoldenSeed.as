package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;

	/**
	 * @since March 26, 2018
	 * @author Stadler76
	 */
	public class GoldenSeed extends Consumable 
	{
		public static const STANDARD:int = 0;
		public static const ENHANCED:int = 1;

		private var type:int;

		public function GoldenSeed(_type:int) 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			type = _type;

			switch (type) {
				case STANDARD:
					id = "GldSeed";
					shortName = "GoldenSeed";
					longName = "a golden seed";
					description = "This seed looks and smells absolutely delicious. Though it has an unusual color,"
					             +" the harpies prize these nuts as delicious treats. Eating one might induce some physical transformations.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case ENHANCED:
					id = "MagSeed";
					shortName = "MagSeed";
					longName = "a magically-enhanced golden seed";
					description = "This seed glows with power.  It's been enhanced by Lumi to unlock its full potential,"
					             +" allowing it to transform you more easily.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "goldenSeed";
			if (player.hasPerk(PerkLib.HarpyWomb)) tfSource += "-HarpyWomb";
			var temp:int;
			//'type' refers to the variety of seed.
			//0 == standard.
			//1 == enhanced - increase change limit and no pre-reqs for TF
			mutations.initTransformation([2, 2], type === ENHANCED ? 3 : 1);
			//Generic eating text:
			clearOutput();
			outputText("You pop the nut into your mouth, chewing the delicious treat and swallowing it quickly.  No wonder harpies love these things so much!");
			//****************
			//Stats:
			//****************
			//-Speed increase to 100.
			if (player.spe100 < 100 && rand(3) === 0) {
				if (player.spe100 >= 75) outputText("\n\nA familiar chill runs down your spine. Your muscles feel like well oiled machinery, ready to snap into action with lightning speed.");
				else outputText("\n\nA chill runs through your spine, leaving you feeling like your reflexes are quicker and your body faster.");
				//Speed gains diminish as it rises.
				if (player.spe100 < 40) dynStats("spe", .5);
				if (player.spe100 < 75) dynStats("spe", .5);
				dynStats("spe", .5);
			}
			//-Toughness decrease to 50
			if (player.tou100 > 50 && rand(3) === 0 && changes < changeLimit) {
				if (rand(2) === 0) outputText("\n\nA nice, slow warmth rolls from your gut out to your limbs, flowing through them before dissipating entirely. As it leaves, you note that your body feels softer and less resilient.");
				else outputText("\n\nYou feel somewhat lighter, but consequently more fragile.  Perhaps your bones have changed to be more harpy-like in structure?");
				dynStats("tou", -1);
			}
			//antianemone corollary:
			if (changes < changeLimit && player.hair.type == 4 && rand(2) === 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nAs you down the seed, your head begins to feel heavier.  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels soft and fluffy, almost feathery; you watch as it dissolves into many thin, feathery strands.  <b>Your hair is now like that of a harpy!</b>");
				player.hair.type = Hair.FEATHER;
				changes++;
			}
			//-Strength increase to 70
			if (player.str100 < 70 && rand(3) === 0 && changes < changeLimit) {
				//(low str)
				if (player.str100 < 40) outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
				//(hi str – 50+)
				else outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				//Faster until 40 str.
				if (player.str100 < 40) dynStats("str", .5);
				dynStats("str", .5);
			}
			//-Libido increase to 90
			if ((player.lib100 < 90 || rand(3) === 0) && rand(3) === 0 && changes < changeLimit) {
				if (player.lib100 < 90) dynStats("lib", 1);
				//(sub 40 lib)
				if (player.lib100 < 40) {
					outputText("\n\nA passing flush colors your " + player.faceDescript() + " for a second as you daydream about sex. You blink it away, realizing the item seems to have affected your libido.");
					if (player.hasVagina()) outputText(" The moistness of your " + player.vaginaDescript() + " seems to agree.");
					else if (player.hasCock()) outputText(" The hardness of " + player.sMultiCockDesc() + " seems to agree.");
					dynStats("lus", 5);
				}
				//(sub 75 lib)
				else if (player.lib100 < 75) outputText("\n\nHeat, blessed heat, works through you from head to groin, leaving you to shudder and fantasize about the sex you could be having right now.\n\n");
				//(hi lib)
				else if (player.lib100 < 90) outputText("\n\nSexual need courses through you, flushing your skin with a reddish hue while you pant and daydream of the wondrous sex you should be having right now.\n\n");
				//(90+)
				else outputText("\n\nYou groan, something about the seed rubbing your libido in just the right way to make you horny. Panting heavily, you sigh and fantasize about the sex you could be having.\n\n");
				//(fork to fantasy)
				if (player.lib100 >= 40) {
					dynStats("lus", (player.lib / 5 + 10));
					//(herm – either or!)
					//Cocks!
					if (player.hasCock() && (player.gender !== 3 || rand(2) === 0)) {
						//(male 1)
						if (rand(2) === 0) {
							outputText("In your fantasy you're winging through the sky, " + player.sMultiCockDesc() + " already hard and drizzling with male moisture while you circle an attractive harpy's nest. Her plumage is as blue as the sky, her eyes the shining teal of the sea, and legs splayed in a way that shows you how ready she is to be bred. You fold your wings and dive, wind whipping through your " + player.hairDescript() + " as she grows larger and larger. With a hard, body-slapping impact you land on top of her, plunging your hard, ready maleness into her hungry box. ");
							if (player.cockTotal() > 1) {
								outputText("The extra penis");
								if (player.cockTotal() > 2) outputText("es rub ");
								else outputText("rubs ");
								outputText("the skin over her taut, empty belly, drooling your need atop her.  ");
								outputText("You jolt from the vision unexpectedly, finding your " + player.sMultiCockDesc() + " is as hard as it was in the dream. The inside of your " + player.armorName + " is quite messy from all the pre-cum you've drooled. Perhaps you can find a harpy nearby to lie with.");
							}
						}
						//(male 2)
						else {
							outputText("In your fantasy you're lying back in the nest your harem built for you, stroking your dick and watching the sexy bird-girl spread her thighs to deposit another egg onto the pile. The lewd moans do nothing to sate your need, and you beckon for another submissive harpy to approach. She does, her thick thighs swaying to show her understanding of your needs. The bird-woman crawls into your lap, sinking down atop your shaft to snuggle it with her molten heat. She begins kissing you, smearing your mouth with her drugged lipstick until you release the first of many loads. You sigh, riding the bliss, secure in the knowledge that this 'wife' won't let up until she's gravid with another egg. Then it'll be her sister-wife's turn. The tightness of " + player.sMultiCockDesc() + " inside your " + player.armorName + " rouses you from the dream, reminding you that you're just standing there, leaking your need into your gear.");
						}
					}
					//Cunts!
					else if (player.hasVagina()) {
						//(female 1)
						if (rand(2) === 0) {
							outputText("In your fantasy you're a happy harpy mother, your womb stretched by the sizable egg it contains. The surging hormones in your body arouse you again, and you turn to the father of your children, planting a wet kiss on his slobbering, lipstick-gilt cock. The poor adventurer writhes, hips pumping futilely in the air. He's been much more agreeable since you started keeping his cock coated with your kisses. You mount the needy boy, fantasizing about that first time when you found him near the portal, in the ruins of your old camp. The feeling of your stiff nipples ");
							if (player.hasFuckableNipples()) outputText("and pussy leaking over ");
							else if (player.biggestLactation() >= 1.5) outputText("dripping milk inside ");
							else outputText("rubbing inside ");
							outputText("your " + player.armorName + " shocks you from the dream, leaving you with nothing but the moistness of your loins for company. Maybe next year you'll find the mate of your dreams?");
						}
						//(female 2)
						else {
							outputText("In your fantasy you're sprawled on your back, thick thighs splayed wide while you're taken by a virile male. The poor stud was wandering the desert all alone, following some map, but soon you had his bright red rod sliding between your butt-cheeks, the pointed tip releasing runnels of submission to lubricate your loins. You let him mount your pussy before you grabbed him with your powerful thighs and took off. He panicked at first, but the extra blood flow just made him bigger. He soon forgot his fear and focused on the primal needs of all males – mating with a gorgeous harpy. You look back at him and wink, feeling his knot build inside you. Your aching, tender " + player.nippleDescript(0) + "s pull you out of the fantasy as they rub inside your " + player.armorName + ". Maybe once your quest is over you'll be able to find a shy, fertile male to mold into the perfect cum-pump.");
						}
					}
				}
			}
			//****************
			//   Sexual:
			//****************
			//-Grow a cunt (guaranteed if no gender)
			if (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) === 0)) {
				changes++;
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your " + player.ballsDescriptLight() + ", but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your " + player.sackDescript() + ", and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your " + player.multiCockDescriptLight() + ". You pull your manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your " + player.armorName + " to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.setClitLength(.25);
				dynStats("sen", 10);
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) === 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				mutations.removeExtraBreastRow(tfSource);
			}
			//-Shrink tits if above DDs.
			//Cannot happen at same time as row removal
			else if (changes < changeLimit && player.breastRows.length == 1 && rand(3) === 0 && player.breastRows[0].breastRating >= 7 && !flags[kFLAGS.HYPER_HAPPY])
			{
				changes++;
				//(Use standard breast shrinking mechanism if breasts are under 'h')
				if (player.breastRows[0].breastRating < 19)
				{
					player.shrinkTits();
				}
				//(H+)
				else {
					player.breastRows[0].breastRating -= (4 + rand(4));
					outputText("\n\nYour chest pinches tight, wobbling dangerously for a second before the huge swell of your bust begins to shrink into itself. The weighty mounds jiggle slightly as they shed cup sizes like old, discarded coats, not stopping until they're " + player.breastCup(0) + "s.");
				}
			}
			//-Grow tits to a B-cup if below.
			if (changes < changeLimit && player.breastRows[0].breastRating < 2 && rand(3) === 0) {
				changes++;
				outputText("\n\nYour chest starts to tingle, the " + player.skin.desc + " warming under your " + player.armorName + ". Reaching inside to feel the tender flesh, you're quite surprised when it puffs into your fingers, growing larger and larger until it settles into a pair of B-cup breasts.");
				if (player.breastRows[0].breastRating < 1) outputText("  <b>You have breasts now!</b>");
				player.breastRows[0].breastRating = 2;
			}
			//Change cock if you have a penis.
			if (changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.AVIAN) < player.cockTotal() && rand(type === ENHANCED ? 4 : 10) === 0 ) { //2.5x chance if magic seed.
				changes++;
				outputText("\n\nYou feel a strange tingling sensation in your cock as erection forms. You " + player.clothedOrNakedLower("open up your " + player.armorName + " and", "") + " look down to see " + (player.cockTotal() == 1 ? "your cock" : "one of your cocks") + " shifting! By the time the transformation's complete, you notice it's tapered, red, and ends in a tip. When you're not aroused, your cock rests nicely in a newly-formed sheath. <b>You now have an avian penis!</b>");
				for (var i:int = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType !== CockTypesEnum.AVIAN) {
						player.cocks[i].cockType = CockTypesEnum.AVIAN;
						break;
					}
				}
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) mutations.restoreRearBody(tfSource);
			//Ovi perk
			if (rand(5) === 0) mutations.updateOvipositionPerk(tfSource);
			//****************
			//General Appearance:
			//****************
			//-Femininity to 85
			if (player.femininity < 85 && changes < changeLimit && rand(3) === 0) {
				changes++;
				outputText(player.modFem(85, 3 + rand(5)));
			}
			//-Skin color change – tan, olive, dark, light
			if ((player.skin.tone !== "tan" && player.skin.tone !== "olive" && player.skin.tone !== "dark" && player.skin.tone !== "light") && changes < changeLimit && rand(5) === 0) {
				changes++;
				outputText("\n\nIt takes a while for you to notice, but <b>");
				if (player.hasFur()) outputText("the skin under your " + player.hair.color + " " + player.skin.desc);
				else outputText("your " + player.skin.desc);
				outputText(" has changed to become ");
				temp = rand(4);
				if (temp == 0) player.skin.tone = "tan";
				else if (temp == 1) player.skin.tone = "olive";
				else if (temp == 2) player.skin.tone = "dark";
				else if (temp == 3) player.skin.tone = "light";
				outputText(player.skin.tone + " colored.</b>");
				player.arms.updateClaws(player.arms.claws.type);
			}
			//-Grow hips out if narrow.
			if (player.hips.rating < 10 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening " + player.hipDescript() + ". The change is subtle, but they're definitely broader.");
				player.hips.rating++;
				changes++;
			}
			//-Narrow hips if crazy wide
			if (player.hips.rating >= 15 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYour gait shifts inward, your " + player.hipDescript() + " narrowing significantly. They remain quite thick, but they're not as absurdly wide as before.");
				player.hips.rating--;
				changes++;
			}
			//-Big booty
			if (player.butt.rating < 8 && changes < changeLimit && rand(3) === 0) {
				player.butt.rating++;
				changes++;
				outputText("\n\nA slight jiggle works through your rear, but instead of stopping it starts again. You can actually feel your " + player.armorName + " being filled out by the growing cheeks. When it stops, you find yourself the proud owner of a " + player.buttDescript() + ".");
			}
			//-Narrow booty if crazy huge.
			if (player.butt.rating >= 14 && changes < changeLimit && rand(4) === 0) {
				changes++;
				player.butt.rating--;
				outputText("\n\nA feeling of tightness starts in your " + player.buttDescript() + ", increasing gradually. The sensation grows and grows, but as it does your center of balance shifts. You reach back to feel yourself, and sure enough your massive booty is shrinking into a more manageable size.");
			}
			//-Body thickness to 25ish
			if (player.thickness > 25 && changes < changeLimit && rand(3) === 0) {
				outputText(player.modThickness(25, 3 + rand(4)));
				changes++;
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
			//****************
			//Harpy Appearance:
			//****************
			//-Harpy legs
			if (player.lowerBody.type !== LowerBody.HARPY && changes < changeLimit && (type === ENHANCED || player.tail.type == Tail.HARPY) && rand(4) === 0) {
				//(biped/taur)
				if (!player.isGoo()) outputText("\n\nYour " + player.legs() + " creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your " + player.feet() + " have changed.  ");
				//goo
				else outputText("\n\nYour gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet!  ");
				player.lowerBody.type = LowerBody.HARPY;
				player.lowerBody.legCount = 2;
				changes++;
				//(cont)
				outputText("While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in " + player.hair.color + " feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>");
			}
			//-Feathery Tail
			if (player.tail.type !== Tail.HARPY && changes < changeLimit && (type === ENHANCED || player.wings.type == Wings.FEATHERED_LARGE) && rand(4) === 0) {
				//(tail)
				if (player.tail.type > Tail.NONE) outputText("\n\nYour tail shortens, folding into the crack of your " + player.buttDescript() + " before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>");
				//(no tail)
				else outputText("\n\nA tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your " + player.skin.desc + " in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>");
				player.tail.type = Tail.HARPY;
				changes++;
			}
			//-Propah Wings
			if (player.wings.type == Wings.NONE && changes < changeLimit && (type === ENHANCED || player.arms.type == Arms.HARPY) && rand(4) === 0) {
				outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your " + player.skin.desc + ". It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your " + player.armorName + ". Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and");
				player.wings.setProps({
					type: Wings.FEATHERED_LARGE,
					color: player.hasFur() ? player.skin.furColor : player.hair.color
				});
				outputText(" <b>you're able to curve the new growths far enough around to behold your brand new, " + player.wings.color + " wings.</b>");
				changes++;
			}
			//-Remove old wings
			if (([Wings.NONE, Wings.FEATHERED_LARGE].indexOf(player.wings.type) == -1 || player.rearBody.type == RearBody.SHARK_FIN) && changes < changeLimit && rand(4) === 0) {
				if (player.rearBody.type == RearBody.SHARK_FIN) {
					outputText("\n\nSensation fades from your large fin slowly but surely, leaving it a dried out husk that breaks off to fall on the"
					          +" ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
					player.rearBody.restore();
				} else {
					outputText("\n\nSensation fades from your [wings] slowly but surely, leaving them dried out husks that break off to fall on the"
					          +" ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
				}
				player.wings.restore();
				changes++;
			}
			//-Feathery Arms
			if (player.arms.type !== Arms.HARPY && changes < changeLimit && (type === ENHANCED || player.hair.type === Hair.FEATHER) && rand(4) === 0) {
				outputText("\n\nYou smile impishly as you lick the last bits of the nut from your teeth, but when you go to wipe your mouth, instead of the usual texture of your " + player.skin.desc + " on your lips, you feel feathers! You look on in horror while more of the avian plumage sprouts from your " + player.skin.desc + ", covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
				changes++;
				player.arms.setType(Arms.HARPY);
			}
			//-Feathery Hair
			if (player.hair.type !== Hair.FEATHER && changes < changeLimit && (type === ENHANCED || player.face.type == Face.HUMAN) && rand(4) === 0) {
				outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a harpy!");
				player.hair.type = Hair.FEATHER;
				changes++;
			}
			//-Human face
			if (player.face.type !== Face.HUMAN && changes < changeLimit && (type === ENHANCED || (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN)) && rand(4) === 0) {
				outputText("\n\nSudden agony sweeps over your " + player.faceDescript() + ", your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face.");
				player.face.type = Face.HUMAN;
				changes++;
			}
			//-Gain human ears (keep elf ears)
			if ((player.ears.type !== Ears.HUMAN && player.ears.type !== Ears.ELFIN) && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
				player.ears.type = Ears.HUMAN;
				changes++;
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) mutations.updateGills();
			//SPECIAL:
			//Harpy Womb – All eggs are automatically upgraded to large, requires legs + tail to be harpy.
			if (player.findPerk(PerkLib.HarpyWomb) < 0 && player.lowerBody.type == LowerBody.HARPY && player.tail.type == Tail.HARPY && rand(4) === 0 && changes < changeLimit) {
				player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
				outputText("\n\nThere's a rumbling in your womb, signifying that some strange change has taken place in your most feminine area. No doubt something in it has changed to be more like a harpy. (<b>You've gained the Harpy Womb perk! All the eggs you lay will always be large so long as you have harpy legs and a harpy tail.</b>)");
				changes++;
			}
			if (changes < changeLimit && rand(4) === 0 && ((player.ass.analWetness > 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) || player.ass.analWetness > 1)) {
				outputText("\n\nYou feel a tightening up in your colon and your [asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				player.ass.analWetness--;
				if (player.ass.analLooseness > 1) player.ass.analLooseness--;
				changes++;
			}
			//Nipples Turn Back:
			if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) === 0) {
				mutations.removeBlackNipples(tfSource);
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) === 0 && player.vaginaType() == 5 && player.hasVagina()) {
				outputText("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your vagina and find that it has turned back to its natural flesh colour.");
				player.vaginaType(0);
				changes++;
			}
			if (changes == 0) outputText("\n\nAside from being a tasty treat, it doesn't seem to do anything to you this time.");
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
