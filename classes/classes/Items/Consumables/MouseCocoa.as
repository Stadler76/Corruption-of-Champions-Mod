package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.PregnancyStore;
	import classes.StatusEffects;
	
	//special attack - bite?
	//tooth length counter starts when you get teef, mouse bite gets more powerful over time as teeth grow in
	//hit
	//You sink your prominent incisors deep into your foe.  They're not as sharp as a predator's, but even a mouse bites when threatened, and you punch quite a large hole.
	//miss
	//You attempt to turn and bite your foe, but " + monster.pronoun1 + " pulls back deftly and your jaws close on empty air.

	//perk - fuck if i know
	//maybe some pregnancy-accelerating thing
	
	/**
	 * Mouse transformative item.
	 */
	public class MouseCocoa extends Consumable 
	{
		public function MouseCocoa() 
		{
			super("MouseCo","MouseCo", "a handful of mouse cocoa", ConsumableLib.DEFAULT_VALUE, "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "mouseCocoa";
			var temp:int = 0;
			
			clearOutput();
			changes = 0;
			changeLimit = 1;
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//use:
			outputText("You pop several of the beans in your mouth and suck; they immediately reward you by giving up an oily, chocolatey flavor with a hint of bitterness.  For several minutes you ");
			if (!player.isTaur()) outputText("sit and ");
			outputText("enjoy the taste.");

			//stat changes:
			//lose height + gain speed (42" height floor, no speed ceiling but no speed changes without height change)
			if (player.tallness >= 45 && changes < changeLimit && rand(3) === 0) {
				//not horse
				if (!player.isTaur()) outputText("\n\nYou tap your [feet] idly against the rock you sit upon as you enjoy the treat; it takes several minutes before you realize you don't reach as far down as you did when you sat down!  In shock, you jerk upright and leap off, nearly falling forward as your body moves more responsively than before!  Experimentally, you move in place as you look down at your now-closer [feet]; the sensation of a more compact agility stays with you.");
				//horse
				else outputText("\n\nYou trot idly in place as you eat, moving quicker and quicker as you become increasingly bored; on one step, the ground sneaks up on you and you hit it sharply, expecting a few more inches before contact!  Looking down, you notice better resolution than before - you can make out the dirt a bit more clearly.  It looks like you just shed some height, but... you're feeling too jittery to care.  You just want to run around.");
				dynStats("spe", 1);
				player.tallness--;
				if (player.tallness > 60) player.tallness--;
				if (player.tallness > 70) player.tallness--;
				if (player.tallness > 80) player.tallness--;
				if (player.tallness > 90) player.tallness -= 2;
				if (player.tallness > 100) player.tallness -= 2;
				changes++;
			}
			//lose tough
			if (player.tou100 > 50 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYou feel a bit less sturdy, both physically and mentally.  In fact, you'd prefer to have somewhere to hide for the time being, until your confidence returns.  The next few minutes are passed in a mousey funk - even afterward, you can't quite regain the same sense of invincibility you had before.");
				//[removed:1.4.10]//changes++;
				dynStats("tou", -1);
				if (player.tou100 >= 75) dynStats("tou", -1);
				if (player.tou100 >= 90) dynStats("tou", -1);
			}

			//SEXYYYYYYYYYYY
			//vag-anal capacity up for non-goo (available after PC < 5 ft; capacity ceiling reasonable but not horse-like or gooey)
			if (player.tallness < 60 && (player.analCapacity() < 100 || (player.vaginalCapacity() < 100 && player.hasVagina())) && changes < changeLimit && rand(3) === 0) {
				outputText("\n\nYour ");
				if (player.vaginalCapacity() < 100 && player.hasVagina()) outputText("[vagina]");
				else outputText("[asshole]");
				outputText(" itches, and you shyly try to scratch it, looking around to see if you're watched.  ");
				if (player.isTaur()) outputText("Backing up to a likely rock, you rub your hindquarters against it, only to be surprised when you feel your hole part smoothly against the surface, wider than you're used to!");
				else outputText("Slipping a hand in your [armor], you rub vigorously; your hole opens more easily and your fingers poke in farther than you're used to!");
				outputText("  It feels unusual - not bad, really, but definitely weird.  You can see how it would come in handy, now that you're smaller than most prospective partners, but... shaking your head, you ");
				if (player.isTaur()) outputText("back away from your erstwhile sedimentary lover");
				else outputText("pull your hand back out");
				outputText(".");
				//adds some lust
				dynStats("lus", 10 + player.sens / 5);
				if (player.vaginalCapacity() < 100 && player.hasVagina()) {
					if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				}
				else {
					if (!player.hasStatusEffect(StatusEffects.BonusACapacity)) player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 5);
				}
				changes++;
			}
			//fem fertility up and heat (suppress if pregnant)
			//not already in heat (add heat and lust)
			if (player.statusEffectv2(StatusEffects.Heat) < 30 && rand(2) === 0 && changes < changeLimit) {

        var intensified:Boolean = player.inHeat;
        if (player.goIntoHeat(false)) {
          if (intensified) {
  					outputText("\n\nYour womb feels achingly empty, and your temperature shoots up.  Try as you might, you can't stop fantasizing about being filled with semen, drenched inside and out with it, enough to make a baker's dozen offspring.  ");
  					//[(no mino cum in inventory)]
  					if (!player.hasItem(consumables.MINOCUM)) {
  						outputText("<b>Your heat has intensified as much as your fertility has increased, which is a considerable amount!</b>");
  					}
  					else if (player.lust < player.maxLust() || player.isTaur()) outputText("You even pull out a bottle of minotaur jism and spend several minutes considering the feasibility of pouring it directly in your [vagina], but regain your senses as you're unsealing the cap, setting it aside.  <b>Still, your heat is more intense than ever and your increasingly-fertile body is practically begging for dick - it'll be hard to resist any that come near!</b>");
  					//(mino cum in inventory and non-horse, 100 lust)
  					else {
  						outputText("Desperately horny, you pull out your bottle of minotaur jism and break the seal in two shakes, then lie down with your hips elevated and upend it over your greedy vagina.  The gooey seed pours into you, and you orgasm fitfully, shaking and failing to hold the bottle in place as it coats your labia.  <b>As a hazy doze infiltrates your mind, you pray the pregnancy takes and dream of the sons you'll bear with your increasingly fertile body... you're going to go insane if you don't get a baby in you</b>.");
  						//(consumes item, increment addiction/output addict message, small chance of mino preg, reduce lust)]");
  						player.minoCumAddiction(5);
						player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR, 175);
						var consumables:ConsumableLib = game.consumables;
  						player.consumeItem(consumables.MINOCUM);
  					}
          }
          else {
  					outputText("\n\nYour insides feel... roomy.  Accommodating, even.  You could probably carry a whole litter of little [name]s right now.  Filled with a sudden flush of desire, you look around furtively for any fertile males.  With a shake of your head, you try to clear your thoughts, but daydreams of being stuffed with seed creep right back in - it looks like your body is intent on probing the limits of your new fertility.  <b>You're in heat, and pregnable in several senses of the word!</b>");
            
            // Also make a permanent nudge.
  					player.fertility++;
          }
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
			//bodypart changes:
			//gain ears
			if (player.earType !== EARS_MOUSE && changes < changeLimit && rand(4) === 0) {
				outputText("\n\nYour ears ");
				if (player.earType === EARS_HORSE || player.earType === EARS_COW || player.earType === EARS_DOG || player.earType === EARS_BUNNY || player.earType === EARS_KANGAROO) outputText("shrink suddenly");
				else outputText("pull away from your head");
				outputText(", like they're being pinched, and you can distinctly feel the auricles taking a rounded shape through the pain.  Reaching up to try and massage away their stings, <b>you're not terribly surprised when you find a pair of fuzzy mouse's ears poking through your " + player.hairDescript() + ".</b>");
				player.earType = EARS_MOUSE;
				changes++;
			}
			//gain tail
			//from no tail
			if (player.earType === EARS_MOUSE && player.tailType !== TAIL_TYPE_MOUSE && changes < changeLimit && rand(4) === 0) {
				//from other tail
				if (player.tailType > TAIL_TYPE_NONE) {
					outputText("\n\nYour tail clenches and itches simultaneously, leaving you wondering whether to cry out or try to scratch it.  The question is soon answered as the pain takes the forefront; looking backward is a horrible strain, but when you manage it, you can see your old appendage ");
					if (player.tailType === TAIL_TYPE_HORSE) outputText("elongating");
					else outputText("compressing");
					outputText(" into a long, thin line.  With a shudder, it begins to shed until it's completely, starkly nude.  <b>Your new mouse tail looks a bit peaked.</b>");
				}
				else outputText("\n\nA small nub pokes from your backside, and you turn to look at it.  When you do, your neck aches as if whiplashed, and you groan as your spine shifts smoothly downward like a rope being pulled, growing new vertebra behind it and expanding the nub into a naked, thin, tapered shape.  <b>Rubbing at your sore neck, you stare at your new mouse tail.</b>");
				player.tailType = TAIL_TYPE_MOUSE;
				changes++;
			}
			//get teeth - from human, bunny, coonmask, or other humanoid teeth faces
			if (player.earType === EARS_MOUSE && (player.faceType === FACE_HUMAN || player.faceType === FACE_SHARK_TEETH || player.faceType === FACE_BUNNY || player.faceType === FACE_SPIDER_FANGS || player.faceType === FACE_RACCOON_MASK) && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYour teeth grind on their own, and you feel a strange, insistent pressure just under your nose.  As you open your mouth and run your tongue along them, you can feel ");
				if (player.faceType !== FACE_HUMAN) outputText("the sharp teeth receding and ");
				outputText("your incisors lengthening.  It's not long before they're twice as long as their neighbors and the obvious growth stops, but the pressure doesn't go away completely.  <b>Well, you now have mouse incisors and your face aches a tiny bit - wonder if they're going to keep growing?</b>");
				player.faceType = FACE_BUCKTEETH;
				changes++;
			}
			//get mouse muzzle from mouse teeth or other muzzle
			if (player.hasFur() && player.faceType !== FACE_MOUSE && (player.faceType !== FACE_HUMAN || player.faceType !== FACE_SHARK_TEETH || player.faceType !== FACE_BUNNY || player.faceType !== FACE_SPIDER_FANGS || player.faceType !== FACE_RACCOON_MASK) && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nA wave of light-headedness hits you, and you black out.  In your unconsciousness, you dream of chewing - food, wood, cloth, paper, leather, even metal... whatever you can fit in your mouth, even if it doesn't taste like anything much.  For several minutes you just chew and chew your way through a parade of ordinary objects, savoring the texture of each one against your teeth, until finally you awaken.  Your teeth work, feeling longer and more prominent than before, and you hunt up your reflection.  <b>Your face has shifted to resemble a mouse's, down to the whiskers!</b>");
				player.faceType = FACE_MOUSE;
				changes++;
			}
			//get fur
			if ((!player.hasFur() || (player.hasFur() && (player.furColor !== "brown" && player.furColor !== "white"))) && changes < changeLimit && rand(4) === 0) {
				//from skinscales
				if (!player.hasFur()) {
					outputText("\n\nYour " + player.skinFurScales() + " itch");
					if (!player.hasPlainSkin()) outputText("es");
					outputText(" all over");
					if (player.tailType > TAIL_TYPE_NONE) outputText(", except on your tail");
					outputText(".  Alarmed and suspicious, you tuck in your hands, trying to will yourself not to scratch, but it doesn't make much difference.  Tufts of ");
					temp = rand(10);
					if (temp < 8) {
						outputText("brown");
						player.furColor = "brown";
					}
					else {
						outputText("white");
						player.furColor = "white";
					}
					outputText(" fur begin to force through your skin");
					if (player.hasScales()) outputText(", pushing your scales out with little pinches");
					outputText(", resolving the problem for you.  <b>You now have fur.</b>");
				}
				//from other color fur
				else {
					outputText("\n\nYour fur stands on end, as if trying to leap from your body - which it does next.  You watch, dumb with shock, as your covering deserts you, but it's quickly replaced with another layer of ");
					temp = rand(10);
					if (temp < 8) {
						outputText("brown");
						player.furColor = "brown";
					}
					else {
						outputText("white");
						player.furColor = "white";
					}
					outputText(" fuzz coming in behind it that soon grows to full-fledged fur.");
				}
				player.skinAdj = "";
				player.skinDesc = "fur";
				player.skinType = SKIN_TYPE_FUR;
				player.underBody.restore(); // Restore the underbody for now
				changes++;
			}
			player.refillHunger(10);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}
	}
}
