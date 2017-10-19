package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Antlion? transformative item.
	 */
	public class TrapOil extends Consumable 
	{
		public function TrapOil() 
		{
			super("TrapOil","TrapOil", "a vial of trap oil", ConsumableLib.DEFAULT_VALUE, "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "trapOil";
			var temp:int = 0;
			
			clearOutput();
			changes = 0;
			changeLimit = 1;
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			outputText("You pour some of the oil onto your hands and ");
			if (player.cor < 30) outputText("hesitantly ");
			else if (player.cor > 70) outputText("eagerly ");
			outputText("rub it into your arms and chest.  The substance is warm, coating and ever so slightly numbing; it quickly sinks into your skin, leaving you feeling smooth and sleek.");

			//Speed Increase:
			if (player.spe100 < 100 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel fleet and lighter on your toes; you sense you could dodge, dart or skip away from anything.");
				dynStats("spe", 1);
				changes++;
			}
			//Strength Loss:
			else if (player.str100 > 40 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nA sense of helplessness settles upon you as your limbs lose mass, leaving you feeling weaker and punier.");
				dynStats("str", -1);
				changes++;
			}
			//Sensitivity Increase:
			if (player.sens100 < 70 && player.hasCock() && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nA light breeze brushes over you and your skin tingles.  You have become more sensitive to physical sensation.");
				dynStats("sen", 5);
				changes++;
			}
			//Libido Increase:
			if (player.lib100 < 70 && player.hasVagina() && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel your blood quicken and rise, and a desire to... hunt builds within you.");
				dynStats("lib", 2);
				if (player.lib100 < 30) dynStats("lib", 2);
				changes++;
			}
			//Body Mass Loss:
			if (player.thickness > 40 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel an odd tightening sensation in your midriff, as if you were becoming narrower and lither.  You frown downwards, and then turn your arms around, examining them closely.  Is it just you or have you lost weight?");
				player.modThickness(40, 3);
				changes++;
			}

			//Thigh Loss: (towards “girly”)
			if (player.hipRating >= 10 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou touch your thighs speculatively.  It's not just your imagination; you've lost a bit of weight around your waist.");
				player.hipRating--;
				if (player.hipRating > 15) player.hipRating -= 2 + rand(3);
				changes++;
			}
			//Thigh Gain: (towards “girly”)
			if (player.hipRating < 6 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou touch your thighs speculatively.  You think you may have gained a little weight around your waist.");
				player.hipRating++;
				changes++;
			}
			//Breast Loss: (towards A cup)
			if (player.biggestTitSize() > 1 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou gasp as you feel a compressing sensation in your chest and around your [fullChest].  The feeling quickly fades however, leaving you feeling like you have lost a considerable amount of weight from your upper body.");
				temp = 0;
				while (temp < player.bRows()) {
					if (player.breastRows[temp].breastRating > 70) player.breastRows[temp].breastRating -= rand(3) + 15;
					else if (player.breastRows[temp].breastRating > 50) player.breastRows[temp].breastRating -= rand(3) + 10;
					else if (player.breastRows[temp].breastRating > 30) player.breastRows[temp].breastRating -= rand(3) + 7;
					else if (player.breastRows[temp].breastRating > 15) player.breastRows[temp].breastRating -= rand(3) + 4;
					else player.breastRows[temp].breastRating -= 2 + rand(2);
					if (player.breastRows[temp].breastRating < 1) player.breastRows[temp].breastRating = 1;
					temp++;
				}
				changes++;
			}
			//Breast Gain: (towards A cup)
			if (player.biggestTitSize() < 1 || player.breastRows[0].breastRating < 1 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel a vague swelling sensation in your [fullChest], and you frown downwards.  You seem to have gained a little weight on your chest.  Not enough to stand out, but- you cup yourself carefully- certainly giving you the faintest suggestion of boobs.");
				player.breastRows[0].breastRating = 1;
				if (player.bRows() > 1) {
					temp = 1;
					while (temp < player.bRows()) {
						if (player.breastRows[temp].breastRating < 1) player.breastRows[temp].breastRating = 1;
						temp++;
					}
				}
				changes++;
			}
			//Penis Reduction towards 3.5 Inches:
			if (player.longestCockLength() >= 3.5 && player.hasCock() && rand(2) === 0 && changes < changeLimit) {
				outputText("\n\nYou flinch and gasp as your " + player.multiCockDescriptLight() + " suddenly become");
				if (player.cockTotal() === 1) outputText("s");
				outputText(" incredibly sensitive and retract into your body.  Anxiously you pull down your underclothes to examine your nether regions.  To your relief ");
				if (player.cockTotal() === 1) outputText("it is");
				else outputText("they are");
				outputText(" still present, and as you touch ");
				if (player.cockTotal() === 1) outputText("it");
				else outputText("them");
				outputText(", the sensitivity fades, however - a blush comes to your cheeks - ");
				if (player.cockTotal() === 1) outputText("it seems");
				else outputText("they seem");
				outputText(" to have become smaller.");
				temp = 0;
				while (temp < player.cockTotal()) {
					if (player.cocks[temp].cockLength >= 3.5) {
						//Shrink said cock
						if (player.cocks[temp].cockLength < 6 && player.cocks[temp].cockLength >= 2.9) {
							player.cocks[temp].cockLength -= .5;
							if (player.cocks[temp].cockThickness * 6 > player.cocks[temp].cockLength) player.cocks[temp].cockThickness -= .2;
							if (player.cocks[temp].cockThickness * 8 > player.cocks[temp].cockLength) player.cocks[temp].cockThickness -= .2;
							if (player.cocks[temp].cockThickness < .5) player.cocks[temp].cockThickness = .5;
						}
						player.cocks[temp].cockLength -= 0.5;
						player.increaseCock(temp, Math.round(player.cocks[temp].cockLength * 0.33) * -1);
					}
					temp++;
				}
				changes++;
			}
			//Testicle Reduction:
			if (player.balls > 0 && player.hasCock() && (player.ballSize > 1 || !player.hasStatusEffect(StatusEffects.Uniball)) && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou feel a delicate tightening sensation around your [balls].  The sensation upon this most sensitive part of your anatomy isn't painful, but the feeling of your balls getting smaller is intense enough that you stifle anything more than a sharp intake of breath only with difficulty.");
				player.ballSize--;
				if (player.ballSize > 8) player.ballSize--;
				if (player.ballSize > 10) player.ballSize--;
				if (player.ballSize > 12) player.ballSize--;
				if (player.ballSize > 15) player.ballSize--;
				if (player.ballSize > 20) player.ballSize--;
				//Testicle Reduction final:
				if (player.ballSize < 1 && !player.hasStatusEffect(StatusEffects.Uniball)) {
					outputText("  You whimper as once again, your balls tighten and shrink.  Your eyes widen when you feel the gentle weight of your testicles pushing against the top of your [hips], and a few hesitant swings of your rear confirm what you can feel - you've tightened your balls up so much they no longer hang beneath your " + player.multiCockDescriptLight() + ", but press perkily upwards.  Heat ringing your ears, you explore your new sack with a careful hand.  You are deeply grateful you apparently haven't reversed puberty, but you discover that though you still have " + num2Text(player.balls) + ", your balls now look and feel like one: one cute, tight little sissy parcel, its warm, insistent pressure upwards upon the joining of your thighs a never-ending reminder of it.");
					//[Note: Balls description should no longer say “swings heavily beneath”.  For simplicity's sake sex scenes should continue to assume two balls]
					player.ballSize = 1;
					player.createStatusEffect(StatusEffects.Uniball, 0, 0, 0, 0);
				}
				else if (player.ballSize < 1) player.ballSize = 1;
				changes++;
			}
			//Anal Wetness Increase:
			if (player.ass.analWetness < 5 && rand(4) === 0 && changes < changeLimit) {
				if (player.ass.analWetness < 4) outputText("\n\nYour eyes widen in shock as you feel oily moisture bead out of your [asshole].  Your asshole has become wetter and more pliable.");
				//Anal Wetness Increase Final (always loose):
				else outputText("\n\nYou moan as clear, odorless oil dribbles out of your [asshole], this time in enough quantity to stain your [armor].  Your back passage feels incredibly sensitive, wet and accommodating.  Your ass is ready to be plowed by anything, and always will be.");
				player.ass.analWetness++;
				//buttChange(30,false,false,false);
				if (player.ass.analLooseness < 3) player.ass.analLooseness++;
				changes++;
				dynStats("sen", 2);
			}
			//Fertility Decrease:
			if (player.hasVagina() && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nThe vague numbness in your skin sinks slowly downwards, and you put a hand on your lower stomach as the sensation centers itself there.  ");
				dynStats("sen", -2);
				//High fertility:
				if (player.fertility >= 30) outputText("It feels like your overcharged reproductive organs have simmered down a bit.");
				//Average fertility:
				else if (player.fertility >= 5) outputText("You feel like you have dried up a bit inside; you are left feeling oddly tranquil.");
				//[Low/No fertility:
				else {
					outputText("Although the numbness makes you feel serene, the trap oil has no effect upon your ");
					if (player.fertility > 0) outputText("mostly ");
					outputText("sterile system.");
					//[Low/No fertility + Trap/Corruption  >70:
					if (player.isCorruptEnough(70)) outputText("  For some reason the fact that you cannot function as nature intended makes you feel helpless and submissive.  Perhaps the only way to be a useful creature now is to find a dominant, fertile being willing to plow you full of eggs? You shake the alien, yet oddly alluring thought away.");
				}
				player.fertility -= 1 + rand(3);
				if (player.fertility < 4) player.fertility = 4;
				changes++;
			}
			//Male Effects
			if (player.gender === 1) {
				//Femininity Increase Final (max femininity allowed increased by +10):
				if (rand(4) === 0 && changes < changeLimit) {
					if (player.femininity < 70 && player.femininity >= 60) {
						outputText("\n\nYou laugh as you feel your features once again soften, before stopping abruptly.  Your laugh sounded more like a girly giggle than anything else.  Feeling slightly more sober, you touch the soft flesh of your face prospectively.  The trap oil has changed you profoundly, making your innate maleness... difficult to discern, to say the least.  You suspect you could make yourself look even more like a girl now if you wanted to.");
						if (player.findPerk(PerkLib.Androgyny) < 0) {
							player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
							outputText("\n\n(<b>Perk Gained: Androgyny</b>)");
						}
						player.femininity += 10;
						if (player.femininity > 70) player.femininity = 70;
						changes++;
					}
					//Femininity Increase:
					else {
						outputText("\n\nYour face softens as your features become more feminine.");
						player.femininity += 10;
						changes++;
					}
				}
				//Muscle tone reduction:
				if (player.tone > 20 && rand(4) === 0 && changes < changeLimit) {
					outputText("\n\nYou sink a finger into your arm inquiringly.  You seem to have lost some of your muscle definition, leaving you looking softer.");
					player.tone -= 10;
					changes++;
				}
			}
			//Female Effects
			else if (player.gender === 2) {
				//Masculinity Increase:
				if (player.femininity > 30 && rand(4) === 0 && changes < changeLimit) {
					player.femininity -= 10;
					if (player.femininity < 30) {
						player.femininity = 30;
						//Masculinity Increase Final (max masculinity allowed increased by +10):
						outputText("\n\nYou laugh as you feel your features once again soften, before stopping abruptly.  Your laugh sounded more like a boyish crow than anything else.  Feeling slightly more sober, you touch the defined lines of your face prospectively.  The trap oil has changed you profoundly, making your innate femaleness... difficult to discern, to say the least.  You suspect you could make yourself look even more like a boy now if you wanted to.");
						if (player.findPerk(PerkLib.Androgyny) < 0) {
							player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
							outputText("\n\n(<b>Perk Gained: Androgyny</b>)");
						}
					}
					else {
						outputText("\n\nYour face becomes more set and defined as your features turn more masculine.");
					}
					changes++;
				}
				//Muscle tone gain:
				if (player.tone < 80 && rand(4) === 0 && changes < changeLimit) {
					outputText("\n\nYou flex your arm in interest.  Although you have become thinner, your muscles seem to have become more defined.");
					player.tone += 10;
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
			//Nipples Turn Black:
			if (!player.hasStatusEffect(StatusEffects.BlackNipples) && rand(6) === 0 && changes < changeLimit) {
				outputText("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [nipples].  They have turned an onyx black!");
				player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
				changes++;
			}
			//Remove odd eyes
			if ((player.eyeType === EYES_FOUR_SPIDER_EYES || player.eyeType == EYES_SPIDER) && rand(2) === 0 && changes < changeLimit) {
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow. <b>Your arachnid eyes are gone! You have normal, humanoid eyes again.</b>");
				player.eyeType = EYES_HUMAN;
				player.eyeCount = 2;
				changes++;
			}
			//PC Trap Effects
			if (player.eyeType !== EYES_BLACK_EYES_SAND_TRAP && rand(4) === 0 && changes < changeLimit) {
				player.eyeType = EYES_BLACK_EYES_SAND_TRAP;
				//Eyes Turn Black:
				outputText("\n\nYou blink, and then blink again.  It feels like something is irritating your eyes.  Panic sets in as black suddenly blooms in the corner of your left eye and then your right, as if drops of ink were falling into them.  You calm yourself down with the thought that rubbing at your eyes will certainly make whatever is happening to them worse; through force of will you hold your hands behind your back and wait for the strange affliction to run its course.  The strange inky substance pools over your entire vision before slowly fading, thankfully taking the irritation with it.  As soon as it goes you stride quickly over to the stream and stare at your reflection.  <b>Your pupils, your irises, your entire eye has turned a liquid black</b>, leaving you looking vaguely like the many half insect creatures which inhabit these lands.  You find you are merely grateful the change apparently hasn't affected your vision.");
				changes++;
			}
			//Vagina Turns Black:
			if (player.hasVagina() && player.vaginaType() !== 5 && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYour [vagina] feels... odd.  You undo your clothes and gingerly inspect your nether regions.  The tender pink color of your sex has disappeared, replaced with smooth, marble blackness starting at your lips and working inwards.");
				//(Wet:
				if (player.wetness() >= 3) outputText("  Your natural lubrication makes it gleam invitingly.");
				//(Corruption <50:
				if (player.cor < 50) outputText("  After a few cautious touches you decide it doesn't feel any different- it does certainly look odd, though.");
				else outputText("  After a few cautious touches you decide it doesn't feel any different - the sheer bizarreness of it is a big turn on though, and you feel it beginning to shine with anticipation at the thought of using it.");
				outputText("  <b>Your vagina is now ebony in color.</b>");
				dynStats("sen", 2, "lus", 10);
				player.vaginaType(5);
				changes++;
			}
			//Dragonfly Wings:
			if (player.wingType !== WING_TYPE_GIANT_DRAGONFLY && rand(4) === 0 && changes < changeLimit) {
				outputText("\n\nYou scream and fall to your knees as incredible pain snags at your shoulders, as if needle like hooks were being sunk into your flesh just below your shoulder blades.  After about five seconds of white hot, keening agony it is with almost sexual relief that something splits out of your upper back.  You clench the dirt as you slide what feel like giant leaves of paper into the open air.  Eventually the sensation passes and you groggily get to your feet.  You can barely believe what you can see by craning your neck behind you - <b>you've grown a set of four giant dragonfly wings</b>, thinner, longer and more pointed than the ones you've seen upon the forest bee girls, but no less diaphanous and beautiful.  You cautiously flex the new muscle groups in your shoulder blades and gasp as your new wings whirr and lift you several inches off the ground.  What fun this is going to be!");
				//Wings Fall Out: You feel a sharp pinching sensation in your shoulders and you cringe slightly.  Your former dragonfly wings make soft, papery sounds as they fall into the dirt behind you.
				changes++;
				player.wingType = WING_TYPE_GIANT_DRAGONFLY;
			}
			if (changes === 0) {
				outputText("\n\nWell... that didn't amount to much.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}
	}
}