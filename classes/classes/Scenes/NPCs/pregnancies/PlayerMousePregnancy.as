package classes.Scenes.NPCs.pregnancies 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.PerkLib;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.Vagina;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by an mouse or the NPC Jojo.
	 */
	public class PlayerMousePregnancy implements VaginalPregnancy 
	{
		private var output:GuiOutput;
		private var pregnancyProgression:PregnancyProgression;
		
		/**
		 * Create a new mouse pregnancy for the player. Registers pregnancies for mice and Jojo.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerMousePregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput)
		{
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_MOUSE, this);
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_JOJO, this);
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
				
				if (kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) { //Bimbo Jojo, stage 1
					output.text("\nJoy notices you examining your belly and strolls over, playfully poking it with her finger. \"<i>Somebody's getting chubby; maybe you and I need to have a little more fun-fun to help you work off those calories, hmm?" + kGAMECLASS.joyScene.joyHasCockText(" Or maybe I'm just feeding you too much...") + "</i>\" She teases" + kGAMECLASS.joyScene.joyHasCockText(", patting her " + kGAMECLASS.joyScene.joyCockDescript()) + ".\n");
				}
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 280) {
				output.text("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
				
				if (kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType === PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 2
					output.text("\nA pair of arms suddenly wrap themselves around you, stroking your belly. \"<i>Like, don't worry, [name]; I love you even if you are getting fat. Actually... this little pot belly of yours is, like, kinda sexy, y'know?</i>\" Joy declares.\n");
					output.text("\nYou roll your eyes at Joy's teasing but appreciate her support all the same.\n");
				}
				
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 216) {
				if (kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType === PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 3
					output.text("\n<b>You have no doubt that you're pregnant now,</b> and from your recent urges to eat cheese and nuts, as well as the lusty thoughts that roam your head, you can already imagine who the father is...\n");
					output.text("\nJoy shakes her head. \"<i>Wow, you just keep getting, like, fatter and fatter, don't you, [name]? S'funny, though... I never thought of myself as, like, a chubby chaser before, but that belly of yours really gets me, y'know, hot 'n' bothered.</i>\" She comments.\n");
					output.text("\nYou sigh, almost laughing... sometimes Joy's inability to see the obvious is cute, sometimes it's just funny and sometimes both. You tell her to quit being silly, it's quite obvious by now that you're pregnant and she's the father, by the way.\n");
					output.text("\nJoy stares at you, silent and dumbfounded. Moments of silence pass by... you wonder if maybe you've broken her. Then, suddenly. \"<i>Yahoo!</i>\" She screams, and performs a backflip, dancing around with both arms pumping in the air before suddenly rushing towards you and throwing your arms around you, barely remembering to be gentle to avoid squishing your vulnerable belly. \"<i>I'm gonna be a daddy-mommy!</i>\" She shouts in glee.\n");
					output.text("\nJoy's erm... joy... is infectious and you find yourself smiling at her happy reaction.\n");
					
					if (kGAMECLASS.flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 70 && !kGAMECLASS.camp.marbleFollower()) {
						output.text("\nThen her face falls in realisation. \"<i>Crap! I gotta get that nursery built, like, now!</i>\" She yells. She gives your belly a loud, wet kiss, then runs off into the scrub, muttering to herself about what she needs to get.\n");
						kGAMECLASS.flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 69;
					}
				}
				else {
					output.text("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ");
					
					if (kGAMECLASS.flags[kFLAGS.JOJO_STATUS] > 0) {
						if (player.cor < 40) {
							output.text("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
						}
						
						if (player.cor >= 40 && player.cor < 75) {
							output.text("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
						}
						
						if (player.cor >= 75) {
							output.text("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
						}
					}
					else {
						output.text("</b>");
					}
				}
				
				output.text("\n");
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 180) {
				if (kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType === PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 4
					output.text("\nIf there was ever any doubt you were carrying only one child before, it has long been forgotten. <b>Your belly is bigger than any woman's back in your village, and the children within are seemingly restless! They kick you all the time; it is clear they inherited Joy's energy, but it's starting to get bothersome.</b> You sigh as you take a seat to rest a bit as the babies inside you kick.\n");
					output.text("\nThis would, of course, be less tiresome if you didn't have to lug around a third mouse as well... A smooch on your belly signals Joy's arrival into the scene.\n");
					output.text("\nThe bimbo mouse smiles up at you, rubbing her cheek against your gravid midriff. \"<i>Aw... how are Joyjoy's little ones today? Are you being good to your mommy?</i>\" She coos.\n");
					output.text("\nYou tell her they've been very active lately, you barely get a moment's rest as they keep kicking inside your belly.\n");
					output.text("\nShe frowns and then stares at your belly. \"<i>Naughty little babies! Stop kicking mommy! You wouldn't be kicking like this inside mommy Joy's tummy, now would you?</i>\" She states, unconcerned about the fact she is trying to chastise her unborn offspring.\n");
					output.text("\nYou chuckle at the bimbo mouse's antics. Somehow the whole scene is uplifting, and you feel a bit less tired by your pregnancy.\n");
					
					if (kGAMECLASS.flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] === 69 && !kGAMECLASS.camp.marbleFollower()) {
						output.text("\nThe mouse turns to walk away, but stops before doing so and looks at you. \"<i>Oh, right! I, like, totally forgot; the nursery's all done now. Our little babies will have a cosy nest to play in when they finally, y'know, come out.</i>\" She states, full of pride at her achievements - both knocking you up and getting a nursery done.\n");
						kGAMECLASS.flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 70;
					}
				}
				else {
					output.text("\n<b>The sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.</b>\n");
				}
				
				displayedUpdate = true;
			}
			if (player.pregnancyIncubation === 120) {
				if (kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType === PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 5
					output.text("\nYou're mildly annoyed at your squirming tummy, it seems your children have taken a liking to scurrying about inside you. The other mildly annoying thing, is Joy's attachment to your huge pregnant belly. It would seem that the bimbo mouse is as eager to see the children as the children inside you are eager to come out and play.\n");
					output.text("\n\"<i>Like, [name], when are the babies gonna come out and play? I wanna hold my cute little squeakies already!</i>\" Joy pouts, stamping her foot in irritation at the wait for you to give birth.\n");
					output.text("\nYou tell her that she'll just have to wait, you want them out too. It's getting heavy.\n");
					output.text("\nJoy pouts, \"<i>But I want them to come out now!</i>\" She whines, then she heaves a heavy sigh. \"<i>Alright, I guess it'll be, like, worth the wait...</i>\" She looks at your " + player.breastDescript(0) + " and develops a sly expression. \"<i>Like... some nice creamy milk would make me feel better...</i>\" She wheedles.\n");
					output.text("\n");
					
					if (player.findPerk(PerkLib.Feeder) >= 0) {
						output.text("You grin at Joy's idea, but you can't simply mash her against your breasts and nurse her without some teasing first.");
					}
					
					output.text("You tell Joy that she can have some, but she has to ask nicely, like a good girl.\n");
					output.text("\nThe bimbo mouse presses her hands together and gives you a winning smile, eyes wide with an uncharacteristic innocence. \"<i>Like, [name], will you please let your little Joyjoy suck on your " + player.breastDescript(0) + " and drink all the yummy mommy-milk she can hold? Puh-lease?</i>\" She begs.\n");
					output.text("\nYou expose your breasts and open your arms in invitation.\n");
					output.text("\nJoy squeaks in glee and rushes into your embrace, rubbing her " + (kGAMECLASS.jojoScene.pregnancy.isPregnant ? "swollen " : "") + "belly against your baby-filled stomach and nuzzling your player.breastDescript excitedly. She wastes no time in slurping on your nipplesdescript until they are painfully erect, then sucks the closest one into her mouth and starts suckling as if her life depends on it.\n");
					output.text("\nBy the time Joy's had her fill, your babies have calmed down a little. It seems like being close to Joy might have actually helped calm the little mice down. Joy yawns and nuzzles your " + player.breastDescript(0) + ".\n");
					output.text("\n\"<i>Mmm... Sooo good.</i>\" Joy murmurs, then burps softly. \"<i>I feel, like, so sleepy now...</i>\" She mumbles, yawning hugely, then reluctantly she pushes herself off of you and starts stumbling away in the direction of her bed" + (player.lactationQ() >= 750 || player.findPerk(PerkLib.Feeder) >= 0 ? ", her belly audibly sloshing from all the milk you let her stuff herself with" : "") + ".\n");
					output.text("\nYou sigh, glad to finally have a moment to rest.\n");
				}
				else {
					output.text("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n");
				}
				
				displayedUpdate = true;
			}
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>Your belly is painfully distended and overswollen with wriggling offspring, ");
				
				if (player.cor < 40) {
					output.text("making it difficult to function.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("and you wonder how much longer you have to wait.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>");
				}
				
				output.text("\n");
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever is inside your overstretched womb seems to appreciate the attention and stops its incessant squirming.  ");
				
				if (player.cor < 40) {
					output.text("Afterwards you feel somewhat disgusted with yourself.</b>\n");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("You estimate you'll give birth in the next few days.</b>\n");
				}
				
				if (player.cor >= 75) {
					output.text("You find yourself daydreaming about birthing hundreds of little babies, and lounging around while they nurse non-stop on your increasingly sensitive breasts.</b>\n");				
				}
			}
			
			if (player.pregnancyIncubation === 32 || player.pregnancyIncubation === 64 || player.pregnancyIncubation === 85 || player.pregnancyIncubation === 150) {
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
			
			pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_MOUSE);
			player.boostLactation(.01);
			
			output.text("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n");
			PregnancyUtils.createVaginaIfMissing(output, player);

			//Main Text here
			if (player.pregnancyType === PregnancyStore.PREGNANCY_JOJO && (kGAMECLASS.flags[kFLAGS.JOJO_STATUS] < 0 || kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) && !kGAMECLASS.prison.inPrison) {
				if (kGAMECLASS.flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
					kGAMECLASS.joyScene.playerGivesBirthToJoyBabies();
					return;
				}
				else {
					kGAMECLASS.jojoScene.giveBirthToPureJojoBabies();
				}
			}
			else {
				output.text("Pain shoots through you as they pull open your cervix forcefully. You grip the ground and pant and push as the pains of labor overwhelm you. You feel your hips being forceably widened by the collective mass of the creatures moving down your birth canal. You spread your legs wide, laying your head back with groans and cries of agony as little white figures begin to emerge from between the lips of your abused pussy. Large innocent eyes, even larger ears, cute little muzzles, long slender pink tails all appear as the figures emerge. Each could be no larger than six inches tall, but they seem as active and curious as if they were already developed children. \n\n");
				output.text("Two emerge, then four, eight... you lose track. They swarm your body, scrambling for your chest, and take turns suckling at your nipples. Milk does their bodies good, making them grow rapidly, defining their genders as the girls grow cute little breasts and get broader hips and the boys develop their little mouse cocks and feel their balls swell. Each stops suckling when they reach two feet tall, and once every last one of them has departed your sore, abused cunt and drunk their fill of your milk, they give you a few grateful nuzzles, then run off towards the forest, leaving you alone to recover.\n");
			}
			
			if (player.averageLactation() > 0 && player.averageLactation() < 5) {
				output.text("Your [chest] won't seem to stop dribbling milk, lactating more heavily than before.");
				player.boostLactation(.5);
			}
			
			player.cuntChange(60, true,true,false);
			
			if (player.vaginas[0].vaginalWetness === Vagina.WETNESS_DRY) {
				player.vaginas[0].vaginalWetness++;
			}
			
			player.orgasm('Vaginal');
			kGAMECLASS.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
			
			//Butt increase
			if (player.butt.rating < 14 && Utils.rand(2) === 0) {
				if (player.butt.rating < 10) {
					player.butt.rating++;
					output.text("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");				
				}
				//Big butts grow slower!
				else if (player.butt.rating < 14 && Utils.rand(2) === 0) {
					player.butt.rating++;
					output.text("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");
				}
			}
			
			output.text("\n");
		}
	}
}
