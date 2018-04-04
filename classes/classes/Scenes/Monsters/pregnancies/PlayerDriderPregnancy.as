package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.AnalPregnancy;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.internals.GuiOutput;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by a drider .
	 */
	public class PlayerDriderPregnancy implements VaginalPregnancy, AnalPregnancy
	{
		private var output:GuiOutput;
		private var pregnancyProgression:PregnancyProgression;
		
		/**
		 * Create a new drider pregnancy for the player. Registers pregnancy for drider eggs .
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerDriderPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			// needed as an instance variable for refactor test code (detectVaginalBirth)
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_DRIDER_EGGS, this);
			pregnancyProgression.registerAnalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_DRIDER_EGGS, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 399) {
				output.text("\n<b>After your session with the spider, you feel much... fuller.  There is no outward change on your body as far as you can see but your womb feels slightly tingly whenever you move.  Hopefully it's nothing to be alarmed about.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 275) {
				output.text("\n<b>Your belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 250) {
				output.text("\n<b>Your belly looks a little pudgy");
				
				if (player.thickness > 60 && player.tone < 40) {
					output.text(" even for you");
				}
				
				output.text(", maybe you should cut back on all the food you've been consuming lately?</b>\n");
				
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 216) {
				output.text("\n<b>Your belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 180) {
				output.text(kGAMECLASS.images.showImage("spidermorph-male-loss-vag"));
				output.text("\n<b>A hot flush works its way through you, and visions of aroused ");
				output.text("driders ");
				output.text("quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and mated with over and over, violated by a pack of horny males, each hoping to father your next brood.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?</b>\n");
				
				kGAMECLASS.dynStats("lib", 1, "sen", 1, "lus", 20);
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.");
				
				if (player.cor < 50) {
					output.text("  You shudder and shake your head, wondering why you're thinking such unusual things.");
				}
				
				output.text("</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 32 || player.pregnancyIncubation === 64 || player.pregnancyIncubation === 85 || player.pregnancyIncubation === 150) {
				//Increase lactation!
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
					output.text("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
					player.boostLactation(.5);
					
					displayedUpdate = true;
				}
				
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
					output.text("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
					player.boostLactation(.5);
					
					displayedUpdate = true;
				}
				
				//Lactate if large && not lactating
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() === 0) {
					output.text("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
					player.boostLactation(1);
					
					displayedUpdate = true;
				}
				
				//Enlarge if too small for lactation
				if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
					output.text("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
					player.growTits(1, 1, false, 3);
					
					displayedUpdate = true;
				}
				
				//Enlarge if really small!
				if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
					output.text("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
					player.growTits(1, 1, false, 3);
					
					displayedUpdate = true;
				}
			}
			
			return displayedUpdate;
		}
		
		/**
		 * @inheritDoc
		 */
		public function vaginalBirth():void 
		{
			pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_DRIDER_EGGS);
			kGAMECLASS.swamp.corruptedDriderScene.driderPregVagBirth();
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAnalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.buttPregnancyIncubation === 199) {
				output.text("\n<b>After your session with the drider, you feel so nice and... full.  There is no outward change on your body, aside from the egg-packed bulge of your belly, but your " + player.assholeDescript() + " tingles slightly and leaks green goop from time to time. Hopefully it's nothing to be alarmed about.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 180) {
				output.text(kGAMECLASS.images.showImage("cDrider-loss-butt"));
				output.text("\n<b>A hot flush works its way through you, and visions of aroused driders quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and packed completely full of eggs, stuffing your belly completely with burgeoning spheres of love.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?</b>\n");
				
				kGAMECLASS.dynStats("lib", 1, "sen", 1, "lus", 20);
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 120) {
				output.text("\n<b>Your belly is bulging from the size of the eggs growing inside you and gurgling just about any time you walk.  Green goo runs down your " + player.legs() + " frequently, drooling out of your pregnant asshole.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 72) {
				output.text("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.");
				output.text("</b>\n");
				
				displayedUpdate = true;
			}
			
			return displayedUpdate;
		}
		
		/**
		 * @inheritDoc
		 */
		public function analBirth():void 
		{
			kGAMECLASS.swamp.corruptedDriderScene.birthSpiderEggsFromAnusITSBLEEDINGYAYYYYY();
			
			pregnancyProgression.detectAnalBirth(PregnancyStore.PREGNANCY_DRIDER_EGGS);
		}
	}
}
