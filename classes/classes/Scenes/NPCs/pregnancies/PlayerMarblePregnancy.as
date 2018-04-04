package classes.Scenes.NPCs.pregnancies
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by Marble.
	 */
	public class PlayerMarblePregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		public function PlayerMarblePregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput)
		{
			this.output = output;
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_MARBLE, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 336) {
				output.text("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 280) {
				output.text("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 216) {
				output.text("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ");
				
				if (player.cor < 40) {
					output.text("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
				}
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				output.text("\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 180) {
				output.text("\n<b>The sudden impact of a kick from inside your distended womb startles you.  Moments later it happens again, making you gasp and stagger.  Whatever is growing inside you is strong.</b>\n");
				displayedUpdate = true;				
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>Your belly is distended and overswollen with your offspring, ");
				
				if (player.cor < 40) {
					output.text("making it difficult to function.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("and you wonder how much longer you have to wait.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("and you're eager to give birth, so you can get fill your womb with a new charge.</b>");
				}
				
				output.text("\n");
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever child is inside your overstretched womb seems to appreciate the attention, and stops its incessant squirming.\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 32  || player.pregnancyIncubation === 150) {
				//Increase lactation!
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
					output.text("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
					player.boostLactation(.5);
				}
				
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
					output.text("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
					player.boostLactation(.5);
				}
				
				//Lactate if large && not lactating
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() === 0) {
					output.text("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
					player.boostLactation(1);
				}
				
				//Enlarge if too small for lactation
				if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
					output.text("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
					player.growTits(1, 1, false, 3);
				}
				
				//Enlarge if really small!
				if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
					output.text("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
					player.growTits(1, 1, false, 3);
				}
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 85) {
				//A small scene for very late in the pregnancy, its breast growth for the little cowgirl.  This scene should be a few days before birth, so the milk doesn't stop before the cowgirl is born.
				output.text("\n<b>Your belly has become heavily pregnant; at the same time, ");
				
				//If (PC has flat breasts) 
				if (player.biggestTitSize() <= 0) {
					output.text("your chest has begun to feel a bit odd.  Your run your hands over it to find that your breasts have grown to around C-cups at some point when you weren't paying attention!  ");
					player.breastRows[0].breastRating = 3;
				}
				else if (player.biggestTitSize() <= 1 && player.mf("m", "f") === "f") {
					output.text("your breasts feel oddly tight in your top.  You put a hand to them and are startled when you find that they've grown to C-cups!  ");
					player.breastRows[0].breastRating = 3;
				}
				else if (player.biggestTitSize() <= 10) {
					output.text("your breasts feel oddly full.  You grab them with your hands, and after a moment you're able to determine that they've grown about a cup in size.  ");
					player.breastRows[0].breastRating++;
				}
				else {
					output.text("your breasts feel a bit odd.  You put a hand on your chest and start touching them.  ");
				}
				
				if (player.biggestLactation() < 1) {
					output.text("You gasp slightly in surprise and realize that you've started lactating.");
					player.boostLactation(player.breastRows.length);
				} 
				else {
					output.text("A few drips of milk spill out of your breasts, as expected.  Though, it occurs to you that there is more milk coming out than before.");
					player.boostLactation(player.breastRows.length * .25);
				}
				
				output.text("</b>\n");
			}
			
			return displayedUpdate;
		}
		
		/**
		 * @inheritDoc
		 */
		public function vaginalBirth():void
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			output.text(kGAMECLASS.images.showImage("birth-cowgirl"));
			if (kGAMECLASS.prison.prisonLetter.deliverChildWhileInPrison()) {
				return;
			}
			
			player.boostLactation(.01);
			PregnancyUtils.createVaginaIfMissing(output, player);
			
			//If you like terrible outcomes
			if (kGAMECLASS.flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 100) {
				output.text("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble doesn't seem to be around right now, so you can do nothing but push.\n\n");

				output.text("You push and heave with all your might, little else going through your mind. You somehow register when the head comes out, and soon the shoulders along with the rest of the body follow.  You lean back and pant for a while before feeling a pair of hands grab a hold of you. They slowly and clumsily feel up your body before finding your " + player.chestDesc() + " and a mouth quickly closes down on a " + player.nippleDescript(0) + ".  You sigh softly, and drift off to sleep.");
				player.cuntChange(20,true,true,false);
				
				output.text("\n\nEventually you feel a hand on your face, and open your eyes to see Marble looking down at you.  \"<i>Sweetie, are you all right?  Why aren't you pregnant anymore?  Where is our child?</i>\" You stand up and look around.  There is no sign of the baby you were carrying; the child seems to have left after finishing its drink. You never even got to see its face...\n\n");
				
				output.text("Marble seems to understand what happened, but is really disappointed with you, \"<i>Sweetie, why couldn't you wait until after I'd finished the nursery...?</i>\"");
				//Increase PC's hips as per normal, add to birth counter
			}
			else {

				output.text("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble rushes over and sees that it's time for you to give birth, so she picks you up and supports you as you continue pushing the child out of your now-gaping " + player.vaginaDescript(0) + ".");
				//50% chance of it being a boy if Marble has been purified
				if (kGAMECLASS.flags[kFLAGS.MARBLE_PURIFIED] > 0 && Utils.rand(2) === 0)
				//it's a boy!
				{
					output.text("\n\nFor the next few minutes, you can’t do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It’s a son of mine!</i>\" she tells you, but you can barely hear her due to the focus you’re putting into the task of bringing this child out.");
					output.text("\n\nYou give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you’ve pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small bull boy cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a boy that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when he came out.");
					output.text("\n\nShe helps you stand up and gives you the little boy to suckle for yourself.");
					output.text("\n\nYou put the child to your breast and let him drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It’s a really good feeling, isn’t it?</i>\"  You can’t help but nod in agreement.  After a minute the little boy has had enough and you put him into the nursery.");
				
					output.text("The little boy is already starting to look like he is a few years old; he’s trotting around on his little hoofs.");
					
					//Increase the size of the PC’s hips, as per normal for pregnancies, increase birth counter
					if (player.hips.rating < 10) {
						player.hips.rating++;
						output.text("After the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
					}
					
					//has Marble had male kids before?
					if (kGAMECLASS.flags[kFLAGS.MARBLE_BOYS] === 0)
					{
						output.text("You notice that Marble seems to be deep in thought, and you ask her what is wrong.  She starts after a moment and says, \"<i>Oh sweetie, no, it's nothing really.  I just never thought that I'd actually be able to father a son is all.  The thought never occurred to me.</i>\"");
					}
					//Add to marble-kids:
					kGAMECLASS.flags[kFLAGS.MARBLE_KIDS]++;
					kGAMECLASS.flags[kFLAGS.MARBLE_BOYS]++; //increase the number of male kids with Marble
				}
				else // end of new content
				//it's a girl!
				{
					player.cuntChange(20,true,true,false);
					output.text("\n\nFor the next few minutes, you can't do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It's a daughter of mine!</i>\" she tells you, but you can barely hear her due to the focus you're putting into the task of bringing this child out.\n\n");
					output.text("You give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you've pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small cowgirl cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a girl that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when she came out.\n\n");
					output.text("She helps you stand up and gives you the little girl to suckle for yourself.  ");
					
					if (player.statusEffectv4(StatusEffects.Marble) >= 20) {
						output.text("As the child contentedly drinks from your " + player.nippleDescript(0) + ", Marble tells you, \"<i>Sweetie, somehow I know that our kids won't have to worry about the addictive milk.  It will only make them healthy and strong.</i>\"  You nod at her and put the child into the nursery.  ");
					} 
					else {
						output.text("You put the child to your breast and let her drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It's a really good feeling, isn't it?</i>\"  You can't help but nod in agreement.  After a minute the little girl has had enough and you put her into the nursery.\n\n");
					}
					
					output.text("The little girl is already starting to look like she is a few years old; she's trotting around on her little hooves.");
					//Add to marble-kids:
					kGAMECLASS.flags[kFLAGS.MARBLE_KIDS]++;
				}
				
				//Increase the size of the PC's hips, as per normal for pregnancies, increase birth counter
				if (player.hips.rating < 10) {
					player.hips.rating++;
					output.text("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
				}
			}
			
			output.text("\n");
		}
	}
}
