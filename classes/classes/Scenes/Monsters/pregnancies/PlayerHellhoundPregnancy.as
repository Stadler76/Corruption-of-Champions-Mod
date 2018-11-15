package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.Vagina;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by an Hellhound.
	 */
	public class PlayerHellhoundPregnancy implements VaginalPregnancy 
	{
		private var output:GuiOutput;
		private var pregnancyProgression:PregnancyProgression;
		
		/**
		 * Create a new Hellhound pregnancy for the player. Registers pregnancy for Hellhound.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerHellhoundPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput)
		{
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_HELL_HOUND, this);
		}
		
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 290) {
				output.text("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 240) {
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
				
				output.text("\n");
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				displayedUpdate = true;				
			}
			
			if (player.pregnancyIncubation === 180) {
				output.text("\n<b>There is a strange heat within your belly, it makes you a little tired.</b>\n");
				kGAMECLASS.dynStats("tou", -1);
				displayedUpdate = true;				
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  With each day you can feel the heat within you growing.</b>\n");
				displayedUpdate = true;
				kGAMECLASS.dynStats("tou", -1);
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>The heat within doesn't drain you as much as it used to, instead giving you an odd strength.</b>");
				output.text("\n");
				kGAMECLASS.dynStats("str", 1,"tou", 1);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You can feel two large lumps pushing against your womb together ");
				
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
				kGAMECLASS.dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
				displayedUpdate = true;
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
		
		public function vaginalBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_HELL_HOUND);
			
			output.text("\nYou are suddenly awoken by the heat inside your womb suddenly flaring up rather intensely.  It gives you a sudden charge of energy and you feel a strong need to stand up.  You can feel the two heads moving inside of you and you know that a hellhound will soon be born.  Guided by your instincts, you spread your legs and squat down, but wonder how exactly you are going to pass a creature with two heads?\n");
			PregnancyUtils.createVaginaIfMissing(output, player);
			output.text("Hearing a hiss, you look down to see drops of water hitting the ground and instantly turning to steam.  There is unnatural heat filling you, it's hot enough to boil water; but thanks to the creature inside you, you're barely feeling a thing!  More energy fills you and you begin to push down on the child within in earnest.  The process is painful, but satisfying; you feel like you could push out a mountain with the energy you have right now.  Within a minute, you can feel the heads emerge.  The heads are quickly followed by the rest of the body and you catch your hellhound child in your hands and lift it up to look at it.\n\n");
			output.text("You can see the distinctive dog heads are wrapped around each other and yipping softly; a hint of flame can sometimes be seen inside their mouths.  Its cute paws are waving in the air looking for purchase, but the rest of its body looks entirely human except for the double dicks, and it even has your skin color.  Its mouths are aching for nutrition, and you realize that your breasts are filled with what this pup needs and pull it to your chest.  Each head quickly finds a nipple and begins to suckle.  Having finished the birthing, you contentedly sit back down and bask in the feeling of giving milk to your child, or is it children?\n\n");
			output.text("You sit there in a state of euphoria for some time.  It's not until the child in front of you starts to become uncomfortably hot and heavy, that you are brought back to reality.  You look down to see that the hellhound pup has grown to three times its original size and even sprouted the distinctive layer of tough black fur.  The beast is licking contentedly at your breasts instead of sucking.  It was the now-full flames in its mouth that had broken your reverie, but before you get a real grasp of what had happened, the hellhound pulls away from you and gives you a few quick happy barks before turning around and running off into the wilds, dropping down onto four legs just before disappearing from view.  You feel the unnatural strength you gained during the birth fade away, and you fall into a deep contented sleep.\n\n");
			
			player.boostLactation(.01);
			
			//Main Text here
			if (player.averageLactation() > 0 && player.averageLactation() < 5) {
				output.text("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.  ");
				player.boostLactation(.5);
			}
			
			player.cuntChange(60, true);
			
			if (player.vaginas[0].vaginalWetness === Vagina.WETNESS_DRY) {
				player.vaginas[0].vaginalWetness++;
			}
			
			player.orgasm('Vaginal');
			kGAMECLASS.dynStats("str", -1, "tou", -1, "spe", 2, "lib", 1, "sen", .5);
			
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
