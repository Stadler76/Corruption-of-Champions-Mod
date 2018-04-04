package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;

	/**
	 * @since March 26, 2018
	 * @author Stadler76
	 */
	public class KangaFruit extends Consumable 
	{
		public static const STANDARD:int = 0;
		public static const ENHANCED:int = 1;

		private var type:int;

		public function KangaFruit(_type:int) 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			type = _type;

			switch (type) {
				case STANDARD:
					id = "KangaFt";
					shortName = "KangaFruit";
					longName = "a piece of kanga fruit";
					description = "A yellow, fibrous, tubular pod. A split in the end reveals many lumpy, small seeds inside."
					             +" The smell of mild fermentation wafts from them.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case ENHANCED:
					id = "MghtyVg";
					shortName = "MghtyVg";
					longName = "a mightily enhanced piece of kanga fruit";
					description = "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside."
					             +" The smell of mild fermentation wafts from them. It glows slightly from Lumi's enhancements.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "kangaFruit";
			mutations.initTransformation([2, 2], type === ENHANCED ? 3 : 1);
			clearOutput();
			outputText("You squeeze the pod around the middle, forcing the end open.  Scooping out a handful of the yeasty-smelling seeds, you shovel them in your mouth.  Blech!  Tastes like soggy burnt bread... and yet, you find yourself going for another handful...");
			//Used as a holding variable for biggest dicks and the like
			var biggestCock:Number;
			//****************
			//General Effects:
			//****************
			//-Int less than 10
			if (player.inte < 10 && !player.hasPerk(PerkLib.TransformationResistance)) {
				if (player.inte < 8 && player.kangaScore() >= 5) {
					outputText("\n\nWhile you gnaw on the fibrous fruit, your already vacant mind continues to empty, leaving nothing behind but the motion of your jaw as you slowly chew and swallow your favorite food.  Swallow.  Chew.  Swallow.  You don't even notice your posture worsening or your arms shortening.  Without a single thought, you start to hunch over but keep munching on the food in your paws as if were the most normal thing in the world.  Teeth sink into one of your fingers, leaving you to yelp in pain.  With the last of your senses, you look at your throbbing paw to notice you've run out of kanga fruit!");
					outputText("\n\nStill hungry and licking your lips in anticipation, you sniff in deep lungfuls of air.  There's more of that wonderful fruit nearby!  You bound off in search of it on your incredibly muscular legs, their shape becoming more and more feral with every hop.  Now guided completely by instinct, you find a few stalks that grow from the ground.  Your belly rumbles, reminding you of your hunger, as you begin to dig into the kanga fruits...");
					outputText("\n\nLosing more of what little remains of yourself, your body is now entirely that of a feral kangaroo and your mind has devolved to match it.  After you finish the handful of fruits you found, you move on in search for more of the tasty treats.  Though you pass by your camp later on, there's no memory, no recognition, just a slight feeling of comfort and familiarity.  There's no food here so you hop away.");
					//[GAME OVER]
					getGame().gameOver();
					return false;
				}
				outputText("\n\nWhile chewing, your mind becomes more and more tranquil.  You find it hard to even remember your mission, let alone your name.  <b>Maybe more kanga fruits will help?</b>");
			}
			//-Speed to 70
			if (player.spe100 < 70 && rand(3) === 0) {
				//2 points up if below 40!
				if (player.spe100 < 40) dynStats("spe", 1);
				dynStats("spe", 1);
				outputText("\n\nYour legs fill with energy as you eat the kanga fruit.  You feel like you could set a long-jump record!  You give a few experimental bounds, both standing and running, with your newfound vigor.  Your stride seems longer too; you even catch a bit of air as you push off with every powerful step.");
			}
			//-Int to 10
			if (player.inte > 2 && rand(3) === 0 && changes < changeLimit) {
				//Gain dumb (smart!)
				if (player.inte > 30) outputText("\n\nYou feel... antsy. You momentarily forget your other concerns as you look around you, trying to decide which direction you'd be most likely to find more food in.  You're about to set out on the search when your mind refocuses and you realize you already have some stored at camp.");
				//gain dumb (30-10 int):
				else if (player.inte > 10) outputText("\n\nYour mind wanders as you eat; you think of what it would be like to run forever, bounding across the wastes of Mareth in the simple joy of movement.  You bring the kanga fruit to your mouth one last time, only to realize there's nothing edible left on it.  The thought brings you back to yourself with a start.");
				//gain dumb (10-1 int):
				else outputText("\n\nYou lose track of everything as you eat, staring at the bugs crawling across the ground.  After a while you notice the dull taste of saliva in your mouth and realize you've been sitting there, chewing the same mouthful for five minutes.  You vacantly swallow and take another bite, then go back to staring at the ground.  Was there anything else to do today?");
				dynStats("int", -1);
			}
			//****************
			//Appearance Effects:
			//****************
			//-Hip widening funtimes
			if (changes < changeLimit && rand(4) === 0 && player.hips.rating < 40) {
				outputText("\n\nYou weeble and wobble as your hipbones broaden noticeably, but somehow you don't fall down.  Actually, you feel a bit MORE stable on your new widened stance, if anything.");
				player.hips.rating++;
				changes++;
			}
			//-Restore arms to become human arms again
			if (rand(4) === 0) mutations.restoreArms(tfSource);
			//-Remove feathery hair
			mutations.removeFeatheryHair();
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
			//Sexual:
			//****************
			//-Shrink balls down to reasonable size (3?)
			if (player.ballSize >= 4 && changes < changeLimit && rand(2) === 0) {
				player.ballSize--;
				player.cumMultiplier++;
				outputText("\n\nYour " + player.sackDescript() + " pulls tight against your groin, vibrating slightly as it changes.  Once it finishes, you give your " + player.ballsDescriptLight() + " a gentle squeeze and discover they've shrunk.  Even with the reduced volume, they feel just as heavy.");
				changes++;
			}
			//-Shorten clits to reasonable size
			if (player.hasVagina() && player.getClitLength() >= 4 && changes < changeLimit && rand(5) === 0) {
				outputText("\n\nPainful pricks work through your " + player.clitDescript() + ", all the way into its swollen clitoral sheath.  Gods, it feels afire with pain!  Agony runs up and down its length, and by the time the pain finally fades, the feminine organ has lost half its size.");
				player.setClitLength(player.getClitLength() / 2);
				changes++;
			}
			//Find biggest dick!
			biggestCock = player.biggestCockIndex();
			//-Shrink dicks down to 8\" max.
			if (player.hasCock()) {
				if (player.cocks[biggestCock].cockLength >= 16 && changes < changeLimit && rand(5) === 0) {
					outputText("\n\nA roiling inferno of heat blazes in your " + player.cockDescript(biggestCock) + ", doubling you over in the dirt.  You rock back and forth while tears run unchecked down your cheeks.  Once the pain subsides and you're able to move again, you find the poor member has lost nearly half its size.");
					player.cocks[biggestCock].cockLength /= 2;
					player.cocks[biggestCock].cockThickness /= 1.5;
					if (player.cocks[biggestCock].cockThickness * 6 > player.cocks[biggestCock].cockLength) player.cocks[biggestCock].cockThickness -= .2;
					if (player.cocks[biggestCock].cockThickness * 8 > player.cocks[biggestCock].cockLength) player.cocks[biggestCock].cockThickness -= .2;
					if (player.cocks[biggestCock].cockThickness < .5) player.cocks[biggestCock].cockThickness = .5;
					changes++;
				}
				//COCK TF!
				if (player.countCocksOfType(CockTypesEnum.KANGAROO) < player.cockTotal() && (type === ENHANCED && rand(2) === 0) && changes < changeLimit) {
					outputText("\n\nYou feel a sharp pinch at the end of your penis and whip down your clothes to check.  Before your eyes, the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into ");
					if (player.hasSheath()) outputText("your sheath");
					else outputText("a sheath that forms at the base of it");
					outputText(".  <b>You now have a kangaroo-penis!</b>");
					var cockIdx:int = 0;
					//Find first non-roocock!
					while (cockIdx < player.cockTotal()) {
						if (player.cocks[cockIdx].cockType !== CockTypesEnum.KANGAROO) {
							player.cocks[cockIdx].cockType = CockTypesEnum.KANGAROO;
							player.cocks[cockIdx].knotMultiplier = 1;
							break;
						}
						cockIdx++;
					}
					changes++;
				}
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) {
				mutations.restoreNeck(tfSource);
			}
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) {
				mutations.restoreRearBody(tfSource);
			}
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//****************
			//Big Kanga Morphs
			//type 1 ignores normal restrictions
			//****************
			//-Face (Req: Fur + Feet)
			if (player.face.type !== Face.KANGAROO && ((player.hasFur() && player.lowerBody.type == LowerBody.KANGAROO) || type === ENHANCED) && changes < changeLimit && rand(4) === 0) {
				//gain roo face from human/naga/shark/bun:
				if (player.face.type == Face.HUMAN || player.face.type == Face.SNAKE_FANGS || player.face.type == Face.SHARK_TEETH || player.face.type == Face.BUNNY) outputText("\n\nThe base of your nose suddenly hurts, as though someone were pinching and pulling at it.  As you shut your eyes against the pain and bring your hands to your face, you can feel your nose and palate shifting and elongating.  This continues for about twenty seconds as you stand there, quaking.  When the pain subsides, you run your hands all over your face; what you feel is a long muzzle sticking out, whiskered at the end and with a cleft lip under a pair of flat nostrils.  You open your eyes and receive confirmation. <b>You now have a kangaroo face!  Crikey!</b>");
				//gain roo face from other snout:
				else outputText("\n\nYour nose tingles. As you focus your eyes toward the end of it, it twitches and shifts into a muzzle similar to a stretched-out rabbit's, complete with harelip and whiskers.  <b>You now have a kangaroo face!</b>");
				changes++;
				player.face.type = Face.KANGAROO;
			}
			//-Fur (Req: Footsies)
			if (!player.hasFur() && (player.lowerBody.type == LowerBody.KANGAROO || type === ENHANCED) && changes < changeLimit && rand(4) === 0) {
				changes++;
				outputText("\n\nYour " + player.skin.desc + " itches terribly all over and you try cartoonishly to scratch everywhere at once.  ");
				player.skin.type = Skin.FUR;
				player.skin.desc = "fur";
				player.skin.furColor = "brown";
				player.underBody.restore(); // Restore the underbody for now
				outputText("As you pull your hands in, you notice " + player.skin.furColor + " fur growing on the backs of them.  All over your body the scene is repeated, covering you in the stuff.  <b>You now have fur!</b>");
			}
			//-Roo footsies (Req: Tail)
			if (player.lowerBody.type !== LowerBody.KANGAROO && (type === ENHANCED || player.tail.type == Tail.KANGAROO) && changes < changeLimit && rand(4) === 0) {
				//gain roo feet from centaur:
				if (player.isTaur()) outputText("\n\nYour backlegs suddenly wobble and collapse, causing you to pitch over onto your side.  Try as you might, you can't get them to stop spasming so you can stand back up; you thrash your hooves wildly as a pins-and-needles sensation overtakes your lower body.  A dull throbbing along your spine makes you moan in agony; it's as though someone had set an entire bookshelf on your shoulders and your spine were being compressed far beyond its limit.  After a minute of pain, the pressure evaporates and you look down at your legs.  Not only are your backlegs gone, but your forelegs have taken on a dogleg shape, with extremely long feet bearing a prominent middle toe!  You set about rubbing the feeling back into your legs and trying to move the new feet.  <b>You now have kangaroo legs!</b>");
				//gain roo feet from naga:
				else if (player.lowerBody.type == LowerBody.NAGA) outputText("\n\nYour tail quivers, then shakes violently, planting you on your face.  As you try to bend around to look at it, you can just see the tip shrinking out of your field of vision from the corner of your eye.  The scaly skin below your waist tightens intolerably, then splits; you wriggle out of it, only to find yourself with a pair of long legs instead!  A bit of hair starts to grow in as you stand up unsteadily on your new, elongated feet.  <b>You now have kangaroo legs!</b>  Now, what are you going to do with a giant shed snakeskin?");
				//gain roo feet from slime:
				else if (player.lowerBody.type == LowerBody.GOO) outputText("\n\nYour mounds of goo shrink and part involuntarily, exposing your crotch.  Modesty overwhelms you and you try to pull them together, but the shrinkage is continuing faster than you can shift your gooey body around.  Before long you've run out of goo to move, and your lower body now ends in a pair of slippery digitigrade legs with long narrow feet.  They dry in the air and a bit of fur begins to sprout as you look for something to cover up with.  <b>You now have kangaroo legs!</b> You sigh.  Guess this means it's back to wearing underpants again.");
				//gain roo feet from human/bee/demon/paw/lizard:
				else outputText("\n\nYour feet begin to crack and shift as the metatarsal bones lengthen.  Your knees buckle from the pain of your bones rearranging themselves, and you fall over.  After fifteen seconds of what feels like your feet being racked, the sensation stops.  You look down at your legs; they've taken a roughly dog-leg shape, but they have extremely long feet with a prominent middle toe!  As you stand up you find that you're equally comfortable standing flat on your feet as you are on the balls of them!  <b>You now have kangaroo legs!</b>");
				player.lowerBody.type = LowerBody.KANGAROO;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//-Roo tail (Req: Ears)
			if (player.tail.type !== Tail.KANGAROO && changes < changeLimit && rand(4) === 0 && (type === ENHANCED || player.ears.type == Ears.KANGAROO)) {
				//gain roo tail:
				if (player.tail.type == Tail.NONE) outputText("\n\nA painful pressure in your lower body causes you to stand straight and lock up.  At first you think it might be gas.  No... something is growing at the end of your tailbone.  As you hold stock still so as not to exacerbate the pain, something thick pushes out from the rear of your garments.  The pain subsides and you crane your neck around to look; a long, tapered tail is now attached to your butt and a thin coat of fur is already growing in!  <b>You now have a kangaroo tail!</b>");
				//gain roo tail from bee tail:
				else if (player.tail.type == Tail.SPIDER_ABDOMEN || player.tail.type == Tail.BEE_ABDOMEN) {
					outputText("\n\nYour chitinous backside shakes and cracks once you finish eating.  Peering at it as best you can, it appears as though the fuzz is falling out in clumps and the chitin is flaking off.  As convulsions begin to wrack your body and force you to collapse, the ");
					if (player.tail.type == Tail.BEE_ABDOMEN) outputText("hollow stinger drops out of the end, taking the venom organ with it.");
					else outputText("spinnerets drop out of the end, taking the last of your webbing with it.");
					outputText("  By the time you're back to yourself, the insectile carapace has fallen off completely, leaving you with a long, thick, fleshy tail in place of your proud, insectile abdomen.  <b>You now have a kangaroo tail!</b>  You wipe the errant spittle from your mouth as you idly bob your new tail about.");
				}
				//gain roo tail from other tail:
				else {
					outputText("\n\nYour tail twitches as you eat.  It begins to feel fat and swollen, and you try to look at your own butt as best you can.  What you see matches what you feel as your tail thickens and stretches out into a long cone shape.  <b>You now have a kangaroo tail!</b>");
				}
				player.tail.type = Tail.KANGAROO;
				changes++;
			}
			//-Roo ears
			if (player.ears.type !== Ears.KANGAROO && changes < changeLimit && rand(4) === 0) {
				//Bunbun ears get special texts!
				if (player.ears.type == Ears.BUNNY) outputText("\n\nYour ears stiffen and shift to the sides!  You reach up and find them pointed outwards instead of up and down; they feel a bit wider now as well.  As you touch them, you can feel them swiveling in place in response to nearby sounds.  <b>You now have a pair of kangaroo ears!</b>");
				//Everybody else?  Yeah lazy.
				else outputText("\n\nYour ears twist painfully as though being yanked upwards and you clap your hands to your head.  Feeling them out, you discover them growing!  They stretch upwards, reaching past your fingertips, and then the tugging stops.  You cautiously feel along their lengths; they're long and stiff, but pointed outwards now, and they swivel around as you listen.  <b>You now have a pair of kangaroo ears!</b>");
				changes++;
				player.ears.type = Ears.KANGAROO;
			}
			//UBEROOOO
			//kangaroo perk: - any liquid or food intake will accelerate a pregnancy, but it will not progress otherwise
			if (player.findPerk(PerkLib.Diapause) < 0 && player.kangaScore() > 4 && rand(4) === 0 && changes < changeLimit && player.hasVagina()) {
				//Perk name and description:
				player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
				outputText("\n\nYour womb rumbles as something inside it changes.\n<b>(You have gained the Diapause perk.  Pregnancies will not progress when fluid intake is scarce, and will progress much faster when it isn't.)</b>");
				changes++;
				//trigger effect: Your body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}
			if (changes == 0) {
				outputText("\n\nIt did not seem to have any effects, but you do feel better rested.");
				player.changeFatigue(-40);
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
