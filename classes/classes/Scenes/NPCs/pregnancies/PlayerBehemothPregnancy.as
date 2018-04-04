package classes.Scenes.NPCs.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by Behemoth.
	 */
	public class PlayerBehemothPregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		/**
		 * Create a new Behemoth pregnancy for the player. Registers pregnancy for Behemoth.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerBehemothPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_BEHEMOTH, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 1152) {
				output.text("<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.  However, you have a feel that it's going to be a very long pregnancy.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 864) {
				output.text("<b>Your distended belly has grown noticeably, but you still have a long way to go.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 576) {
				output.text("<b>Your belly has yet to betray the sheer size of your expected offspring, but it's certainly making an attempt.  At this rate, you'll need to visit the father more just to keep your strength up.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 288) {
				output.text("<b>Your belly can't grow much larger than it already is; you hope you'll give birth soon.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 1024 || player.pregnancyIncubation === 768 || player.pregnancyIncubation === 512 || player.pregnancyIncubation === 256) {
				//Increase lactation!
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
					output.text("\nYour breasts feel swollen with all the extra milk they're accumulating.  You hope it'll be enough for the coming birth.\n");
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
			
			if (kGAMECLASS.prison.prisonLetter.deliverChildWhileInPrison()) {
				return;
			}
			
			PregnancyUtils.createVaginaIfMissing(output, player);
			kGAMECLASS.volcanicCrag.behemothScene.giveBirthToBehemoth();
			
			if (player.hips.rating < 10) {
				player.hips.rating++;
				output.text("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
			}
			
			output.text("\n");
		}
	}
}
