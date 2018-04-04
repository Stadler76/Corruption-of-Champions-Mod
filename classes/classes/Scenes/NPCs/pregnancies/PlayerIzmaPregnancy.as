package classes.Scenes.NPCs.pregnancies 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.internals.GuiOutput;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by .
	 */
	public class PlayerIzmaPregnancy implements VaginalPregnancy 
	{
		private var output:GuiOutput;
		private var pregnancyProgression:PregnancyProgression;
		
		/**
		 * Create a new ... pregnancy for the player. Registers pregnancy for ... .
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerIzmaPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput)
		{
			// needed as an instance variable for refactor test code (detectVaginalBirth)
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_IZMA, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 275) {
				if (kGAMECLASS.flags[kFLAGS.IZMA_FOLLOWER_STATUS] === 1) {
					output.text("\n<b>You wake up feeling kind of nauseous.  Izma insists that you stay in bed and won't hear a word otherwise, tending to you in your sickened state.  When you finally feel better, she helps you up.  \"<i>You know, " + player.short + "... I think you might be pregnant.</i>\" Izma says, sounding very pleased at the idea. You have to admit, you do seem to have gained some weight...</b>\n");
				}
				else {
					output.text("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some fish.</b>\n");
				}
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 250) {
				output.text("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
				
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 216) {
				if (kGAMECLASS.flags[kFLAGS.IZMA_FOLLOWER_STATUS] === 1) {
					output.text("\n<b>Your stomach is undeniably swollen now, and you feel thirsty all the time. Izma is always there to bring you water, even anticipating your thirst before you recognize it yourself. She smiles all the time now, and seems to be very pleased with herself.");
				}
				else {
					output.text("\n<b>There is no question you're pregnant; your belly is getting bigger and for some reason, you feel thirsty ALL the time.");
				}
				
				output.text("</b>");
				output.text("\n");
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 180) {
				if (kGAMECLASS.flags[kFLAGS.IZMA_FOLLOWER_STATUS] === 1) {
					output.text("\n<b>There is no denying your pregnancy, and Izma is head-over-heels with your 'beautifully bountiful new body', as she puts it. She is forever finding an excuse to touch your bulging stomach, and does her best to coax you to rest against her. However, when you do sit against her, she invariably starts getting hard underneath you.</b>\n");
				}
				else {
					output.text("\n<b>There is no denying your pregnancy.  Your belly bulges and occasionally squirms as your growing offspring shifts position.</b>\n");
				}
				
				displayedUpdate = true;
			}
			if (player.pregnancyIncubation === 120) {
				if (kGAMECLASS.flags[kFLAGS.IZMA_FOLLOWER_STATUS] === 1) {
					output.text("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling. Izma is always on hand now, it seems, and she won't dream of you fetching your own food or picking up anything you've dropped. She's always dropping hints about how you should try going around naked for comfort's sake. While you are unwilling to do so, you find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n");
				}
				else {
					output.text("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling.  You find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n");
				}
				
				kGAMECLASS.dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
				
				displayedUpdate = true;
			}
			if (player.pregnancyIncubation === 72) {
				if (kGAMECLASS.flags[kFLAGS.IZMA_FOLLOWER_STATUS] === 1) {
					output.text("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in. Izma makes no secret of her pleasure and informs you that you should deliver soon.</b>\n");
				}
				else {
					output.text("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in.  The time for delivery will probably come soon.</b>\n");
				}
				
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
			pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_IZMA);
			kGAMECLASS.izmaScene.pcPopsOutASharkTot();
		}
	}
}
