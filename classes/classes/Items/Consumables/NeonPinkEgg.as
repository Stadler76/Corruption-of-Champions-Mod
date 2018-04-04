package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.PregnancyStore;

	/**
	 * @since March 30, 2018
	 * @author Stadler76
	 */
	public class NeonPinkEgg extends Consumable 
	{
		private var pregnantChange:Boolean;

		public function NeonPinkEgg(_pregnantChange:Boolean = false) 
		{
			pregnantChange = _pregnantChange;

			super(
				"NPnkEgg",
				"NPnkEgg",
				"a neon pink egg",
				ConsumableLib.DEFAULT_VALUE,
				"This is an oblong egg with an unnatural neon pink coloration." +
				" It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky."
			);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "neonPinkEgg";
			mutations.initTransformation([2, 2]);
			//If this is a pregnancy change, only 1 change per proc.
			if (pregnantChange) changeLimit = 1;
			else clearOutput();
			//If not pregnancy, mention eating it.
			if (!pregnantChange) outputText("You eat the neon pink egg, and to your delight it tastes sweet, like candy.  In seconds you've gobbled down the entire thing, and you lick your fingers clean before you realize you ate the shell – and it still tasted like candy.");
			//If pregnancy, warning!
			if (pregnantChange) {
				outputText("\n<b>Your egg-stuffed ");
				if (player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
					outputText("womb ");
					if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("and ");
				}
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("backdoor ");
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY && player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) outputText("rumble");
				else outputText("rumbles");
				outputText(" oddly, and you have a hunch that something's about to change</b>.");
			}
			//STATS CHANGURYUUUUU
			//Boost speed (max 80!)
			if (changes < changeLimit && rand(3) === 0 && player.spe100 < 80) {
				if (player.spe100 < 30) outputText("\n\nTingles run through your muscles, and your next few movements seem unexpectedly fast.  The egg somehow made you faster!");
				else if (player.spe100 < 50) outputText("\n\nYou feel tingles running through your body, and after a moment, it's clear that you're getting faster.");
				else if (player.spe100 < 65) outputText("\n\nThe tight, ready feeling you've grown accustomed to seems to intensify, and you know in the back of your mind that you've become even faster.");
				else outputText("\n\nSomething changes in your physique, and you grunt, chopping an arm through the air experimentally.  You seem to move even faster than before, confirming your suspicions.");
				if (player.spe100 < 35) dynStats("spe", 1);
				dynStats("spe", 1);
			}
			//Boost libido
			if (changes < changeLimit && rand(5) === 0) {
				dynStats("lib", 1, "lus", (5 + player.lib / 7));
				if (player.lib100 < 30) dynStats("lib", 1);
				if (player.lib100 < 40) dynStats("lib", 1);
				if (player.lib100 < 60) dynStats("lib", 1);
				//Lower ones are gender specific for some reason
				if (player.lib100 < 60) {
					//(Cunts or assholes!
					if (!player.hasCock() || (player.gender == 3 && rand(2) === 0)) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 60) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 90) outputText("You pant a little and wonder where the nearest fertile male is.");
							else outputText("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your " + player.assholeOrPussy() + ", and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (player.hasCock()) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) === 0) outputText("female hare until she's immobilized by all her eggs");
							else outputText("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							outputText(". ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 50) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 75) outputText("You pant a little and wonder where the nearest fertile female is.");
							else outputText("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to " + player.sMultiCockDesc() + ", and you groan from how tight and hard it feels.  The desire to squeeze it, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (player.lib100 < 80) {
					outputText("\n\nYou fan your neck and start to pant as your " + player.skin.tone + " skin begins to flush red with heat");
					if (!player.hasPlainSkin()) outputText(" through your " + player.skin.desc);
					outputText(".  ");
					if (player.gender == 1) outputText("Compression tightens down on " + player.sMultiCockDesc() + " as it strains against your " + player.armorName + ".  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (player.gender == 0) outputText("Sexual hunger seems to gnaw at your " + player.assholeDescript() + ", demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (player.gender == 2) outputText("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else outputText("Steamy moisture and tight compression war for your awareness in your groin as " + player.sMultiCockDesc() + " starts to strain against your " + player.armorName + ".  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					outputText("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (player.cor < 33) outputText("You sigh, trying not to give in completely.");
					else if (player.cor < 66) outputText("You pant and groan, not sure how long you'll even want to resist.");
					else {
						outputText("You smile and wonder if you can ");
						if (player.lib100 < 100) outputText("get your libido even higher.");
						else outputText("find someone to fuck right now.");
					}
				}
			}
			//BIG sensitivity gains to 60.
			if (player.sens100 < 60 && changes < changeLimit && rand(3) === 0) {
				outputText("\n\n");
				//(low)
				if (rand(3) !== 2) {
					outputText("The feeling of small breezes blowing over your " + player.skin.desc + " gets a little bit stronger.  How strange.  You pinch yourself and nearly jump when it hurts a tad more than you'd think. You've gotten more sensitive!");
					dynStats("sen", 5);
				}
				//(BIG boost 1/3 chance)
				else {
					dynStats("sen", 15);
					outputText("Every movement of your body seems to bring heightened waves of sensation that make you woozy.  Your " + player.armorName + " rubs your " + player.nippleDescript(0) + "s deliciously");
					if (player.hasFuckableNipples()) {
						outputText(", sticking to the ");
						if (player.biggestLactation() > 2) outputText("milk-leaking nipple-twats");
						else outputText("slippery nipple-twats");
					}
					else if (player.biggestLactation() > 2) outputText(", sliding over the milk-leaking teats with ease");
					else outputText(" catching on each of the hard nubs repeatedly");
					outputText(".  Meanwhile, your crotch... your crotch is filled with such heavenly sensations from ");
					if (player.gender == 1) {
						outputText(player.sMultiCockDesc() + " and your ");
						if (player.balls > 0) outputText(player.ballsDescriptLight());
						else outputText(player.assholeDescript());
					}
					else if (player.gender == 2) outputText("your " + player.vaginaDescript(0) + " and " + player.clitDescript());
					else if (player.gender == 3) {
						outputText(player.sMultiCockDesc() + ", ");
						if (player.balls > 0) outputText(player.ballsDescriptLight() + ", ");
						outputText(player.vaginaDescript(0) + ", and " + player.clitDescript());
					}
					//oh god genderless
					else outputText("you " + player.assholeDescript());
					outputText(" that you have to stay stock-still to keep yourself from falling down and masturbating on the spot.  Thankfully the orgy of tactile bliss fades after a minute, but you still feel way more sensitive than your previous norm.  This will take some getting used to!");
				}
			}
			//Makes girls very girl(90), guys somewhat girly (61).
			if (changes < changeLimit && rand(2) === 0) {
				var buffer:String = "";
				if (player.gender < 2) buffer += player.modFem(61, 4);
				else buffer += player.modFem(90, 4);
				if (buffer !== "") {
					outputText(buffer);
					changes++;
				}
			}

			//De-wettification of cunt (down to 3?)!
			if (player.wetness() > 3 && changes < changeLimit && rand(3) === 0) {
				//Just to be safe
				if (player.hasVagina()) {
					outputText("\n\nThe constant flow of fluids that sluice from your " + player.vaginaDescript(0) + " slow down, leaving you feeling a bit less like a sexual slip-'n-slide.");
					player.vaginas[0].vaginalWetness--;
					changes++;
				}
			}
			//Fertility boost!
			if (changes < changeLimit && rand(4) === 0 && player.fertility < 50 && player.hasVagina()) {
				player.fertility += 2 + rand(5);
				changes++;
				outputText("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you know your body is just aching to be pregnant and give birth.");
			}
			//-VAGs
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) {
				mutations.restoreNeck(tfSource);
			}
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) {
				mutations.restoreRearBody(tfSource);
			}
			//Ovi perk loss
			if (rand(4) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			if (player.hasVagina() && player.findPerk(PerkLib.BunnyEggs) < 0 && changes < changeLimit && rand(4) === 0 && player.bunnyScore() > 3) {
				outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n\n");
				outputText("(<b>Perk Gained: Bunny Eggs</b>)");
				player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
				changes++;
			}
			//Shrink Balls!
			if (player.balls > 0 && player.ballSize > 5 && rand(3) === 0 && changes < changeLimit) {
				if (player.ballSize < 10) {
					outputText("\n\nRelief washes through your groin as your " + player.ballsDescript() + " lose about an inch of their diameter.");
					player.ballSize--;
				}
				else if (player.ballSize < 25) {
					outputText("\n\nRelief washes through your groin as your " + player.ballsDescript() + " lose a few inches of their diameter.  Wow, it feels so much easier to move!");
					player.ballSize -= (2 + rand(3));
				}
				else {
					outputText("\n\nRelief washes through your groin as your " + player.ballsDescript() + " lose at least six inches of diameter.  Wow, it feels SOOOO much easier to move!");
					player.ballSize -= (6 + rand(3));
				}
				changes++;
			}
			//Get rid of extra balls
			if (player.balls > 2 && changes < changeLimit && rand(3) === 0) {
				changes++;
				outputText("\n\nThere's a tightening in your " + player.sackDescript() + " that only gets higher and higher until you're doubled over and wheezing.  When it passes, you reach down and discover that <b>two of your testicles are gone.</b>");
				player.balls -= 2;
			}
			//Boost cum production
			if ((player.balls > 0 || player.hasCock()) && player.cumQ() < 3000 && rand(3) === 0 && changeLimit > 1) {
				changes++;
				player.cumMultiplier += 3 + rand(7);
				if (player.cumQ() >= 250) dynStats("lus", 3);
				if (player.cumQ() >= 750) dynStats("lus", 4);
				if (player.cumQ() >= 2000) dynStats("lus", 5);
				//Balls
				if (player.balls > 0) {
					//(Small cum quantity) < 50
					if (player.cumQ() < 50) outputText("\n\nA twinge of discomfort runs through your " + player.ballsDescriptLight() + ", but quickly vanishes.  You heft your orbs but they haven't changed in size – they just feel a little bit denser.");
					//(medium cum quantity) < 250
					else if (player.cumQ() < 250) {
						outputText("\n\nA ripple of discomfort runs through your " + player.ballsDescriptLight() + ", but it fades into a pleasant tingling.  You reach down to heft the orbs experimentally but they don't seem any larger.");
						if (player.hasCock()) outputText("  In the process, you brush " + player.sMultiCockDesc() + " and discover a bead of pre leaking at the tip.");
					}
					//(large cum quantity) < 750
					else if (player.cumQ() < 750) {
						outputText("\n\nA strong contraction passes through your " + player.sackDescript() + ", almost painful in its intensity.  ");
						if (player.hasCock()) outputText(player.sMultiCockDesc() + " leaks and dribbles pre-cum down your " + player.legs() + " as your body's cum production kicks up even higher.");
						else outputText("You wince, feeling pent up and yet unable to release.  You really wish you had a cock right about now.");
					}
					//(XL cum quantity) < 2000
					else if (player.cumQ() < 2000) {
						outputText("\n\nAn orgasmic contraction wracks your " + player.ballsDescriptLight() + ", shivering through the potent orbs and passing as quickly as it came.  ");
						if (player.hasCock()) outputText("A thick trail of slime leaks from " + player.sMultiCockDesc() + " down your " + player.leg() + ", pooling below you.");
						else outputText("You grunt, feeling terribly pent-up and needing to release.  Maybe you should get a penis to go with these balls...");
						outputText("  It's quite obvious that your cum production has gone up again.");
					}
					//(XXL cum quantity)
					else {
						outputText("\n\nA body-wrenching contraction thrums through your " + player.ballsDescriptLight() + ", bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  ");
						if (player.hasCock()) outputText("pre-cum explodes from " + player.sMultiCockDesc() + ", running down your " + player.leg() + " and splattering into puddles that would shame the orgasms of lesser " + player.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
						else outputText("You pant and groan but the pleasure just turns to pain.  You're so backed up – if only you had some way to vent all your seed!");
					}
				}
				//NO BALLZ (guaranteed cock tho)
				else {
					//(Small cum quantity) < 50
					if (player.cumQ() < 50) outputText("\n\nA twinge of discomfort runs through your body, but passes before you have any chance to figure out exactly what it did.");
					//(Medium cum quantity) < 250)
					else if (player.cumQ() < 250) outputText("\n\nA ripple of discomfort runs through your body, but it fades into a pleasant tingling that rushes down to " + player.sMultiCockDesc() + ".  You reach down to heft yourself experimentally and smile when you see pre-beading from your maleness.  Your cum production has increased!");
					//(large cum quantity) < 750
					else if (player.cumQ() < 750) outputText("\n\nA strong contraction passes through your body, almost painful in its intensity.  " + player.SMultiCockDesc() + " leaks and dribbles pre-cum down your " + player.legs() + " as your body's cum production kicks up even higher!  Wow, it feels kind of... good.");
					//(XL cum quantity) < 2000
					else if (player.cumQ() < 2000) outputText("\n\nAn orgasmic contraction wracks your abdomen, shivering through your midsection and down towards your groin.  A thick trail of slime leaks from " + player.sMultiCockDesc() + "  and trails down your " + player.leg() + ", pooling below you.  It's quite obvious that your body is producing even more cum now.");
					//(XXL cum quantity)
					else outputText("\n\nA body-wrenching contraction thrums through your gut, bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  pre-cum explodes from " + player.sMultiCockDesc() + ", running down your " + player.legs() + " and splattering into puddles that would shame the orgasms of lesser " + player.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
				}
			}
			//Bunny feet! - requirez earz
			if (player.lowerBody.type !== LowerBody.BUNNY && changes < changeLimit && rand(5) === 0 && player.ears.type == Ears.BUNNY) {
				//Taurs
				if (player.isTaur()) outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of fur-covered rabbit feet</b>!");
				//Non-taurs
				else {
					outputText("\n\nNumbness envelops your " + player.legs() + " as they pull tighter and tighter.  You overbalance and drop on your " + player.assDescript());
					if (player.tail.type > Tail.NONE) outputText(", nearly smashing your tail flat");
					else outputText(" hard enough to sting");
					outputText(" while the change works its way through you.  Once it finishes, <b>you discover that you now have fuzzy bunny feet and legs</b>!");
				}
				changes++;
				player.lowerBody.type = LowerBody.BUNNY;
				player.lowerBody.legCount = 2;
			}
			//BUN FACE!  REQUIREZ EARZ
			if (player.ears.type == Ears.BUNNY && player.face.type !== Face.BUNNY && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\n");
				changes++;
				//Human(ish) face
				if (player.face.type == Face.HUMAN || player.face.type == Face.SHARK_TEETH) outputText("You catch your nose twitching on its own at the bottom of your vision, but as soon as you focus on it, it stops.  A moment later, some of your teeth tingle and brush past your lips, exposing a white pair of buckteeth!  <b>Your face has taken on some rabbit-like characteristics!</b>");
				//Crazy furry TF shit
				else outputText("You grunt as your " + player.faceDescript() + " twists and reforms.  Even your teeth ache as their positions are rearranged to match some new, undetermined order.  When the process finishes, <b>you're left with a perfectly human looking face, save for your constantly twitching nose and prominent buck-teeth.</b>");
				player.face.type = Face.BUNNY;
			}
			//DAH BUNBUN EARZ - requires poofbutt!
			if (player.ears.type !== Ears.BUNNY && changes < changeLimit && rand(3) === 0 && player.tail.type == Tail.RABBIT) {
				outputText("\n\nYour ears twitch and curl in on themselves, sliding around on the flesh of your head.  They grow warmer and warmer before they finally settle on the top of your head and unfurl into long, fluffy bunny-ears.  <b>You now have a pair of bunny ears.</b>");
				player.ears.type = Ears.BUNNY;
				changes++;
			}
			//DAH BUNBUNTAILZ
			if (player.tail.type !== Tail.RABBIT && rand(2) === 0 && changes < changeLimit) {
				if (player.tail.type > Tail.NONE) outputText("\n\nYour tail burns as it shrinks, pulling tighter and tighter to your backside until it's the barest hint of a stub.  At once, white, poofy fur explodes out from it.  <b>You've got a white bunny-tail!  It even twitches when you aren't thinking about it.</b>");
				else outputText("\n\nA burning pressure builds at your spine before dissipating in a rush of relief. You reach back and discover a small, fleshy tail that's rapidly growing long, poofy fur.  <b>You have a rabbit tail!</b>");
				player.tail.type = Tail.RABBIT;
				changes++;
			}
			// Remove gills
			if (rand(4) === 0 && player.hasGills() && changes < changeLimit) {
				mutations.updateGills();
			}
			//Bunny Breeder Perk?
			//FAILSAAAAFE
			if (changes == 0) {
				if (player.lib100 < 100) changes++;
				dynStats("lib", 1, "lus", (5 + player.lib / 7));
				if (player.lib100 < 30) dynStats("lib", 1);
				if (player.lib100 < 40) dynStats("lib", 1);
				if (player.lib100 < 60) dynStats("lib", 1);
				//Lower ones are gender specific for some reason
				if (player.lib100 < 60) {
					//(Cunts or assholes!
					if (!player.hasCock() || (player.gender == 3 && rand(2) === 0)) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 60) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 90) outputText("You pant a little and wonder where the nearest fertile male is.");
							else outputText("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your " + player.assholeOrPussy() + ", and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (player.hasCock()) {
						if (player.lib100 < 30) {
							outputText("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) === 0) outputText("female hare until she's immobilized by all her eggs");
							else outputText("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							outputText(". ");
							if (player.cor < 25) outputText("You're repulsed by such shameful thoughts.");
							else if (player.cor < 50) outputText("You worry that this place is really getting to you.");
							else if (player.cor < 75) outputText("You pant a little and wonder where the nearest fertile female is.");
							else outputText("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else outputText("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to " + player.sMultiCockDesc() + ", and you groan from how tight and hard it feels.  The desire to have it squeezed, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (player.lib100 < 80) {
					outputText("\n\nYou fan your neck and start to pant as your " + player.skin.tone + " skin begins to flush red with heat");
					if (!player.hasPlainSkin()) outputText(" through your " + player.skin.desc);
					outputText(".  ");
					if (player.gender == 1) outputText("Compression tightens down on " + player.sMultiCockDesc() + " as it strains against your " + player.armorName + ".  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (player.gender == 0) outputText("Sexual hunger seems to gnaw at your " + player.assholeDescript() + ", demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (player.gender == 2) outputText("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else outputText("Steamy moisture and tight compression war for your awareness in your groin as " + player.sMultiCockDesc() + " starts to strain against your " + player.armorName + ".  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					outputText("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (player.cor < 33) outputText("You sigh, trying not to give in completely.");
					else if (player.cor < 66) outputText("You pant and groan, not sure how long you'll even want to resist.");
					else {
						outputText("You smile and wonder if you can ");
						if (player.lib100 < 100) outputText("get your libido even higher.");
						else outputText("find someone to fuck right now.");
					}
				}
			}
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;

			return false;
		}
	}
}
