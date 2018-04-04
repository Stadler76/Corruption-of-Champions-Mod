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
	 * Contains pregnancy progression and birth scenes for a Player impregnated by Minerva.
	 */
	public class PlayerMinervaPregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		/**
		 * Create a new Minerva pregnancy for the player. Registers pregnancy for Minerva.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerMinervaPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_MINERVA, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 216) {
				output.text("<b>You realize your belly has gotten slightly larger.  You could go for some peaches around now.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 144) {
				output.text("<b>Your belly is distended with pregnancy. You wish you could spend all day bathing.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("<b>Your belly has grown enough for it to be twins.  Well, you <em>did</em> want to restore sirens to the world.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 24) {
				output.text("<b>Your belly is as big as it can get.  Your unborn children shuffle relentlessly, calming only when you try singing lullabys.</b>");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 144 || player.pregnancyIncubation === 72 || player.pregnancyIncubation === 85 || player.pregnancyIncubation === 150) {
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
			
			if (kGAMECLASS.prison.prisonLetter.deliverChildWhileInPrison()) {
				return;
			}
			
			PregnancyUtils.createVaginaIfMissing(output, player);
			kGAMECLASS.highMountains.minervaScene.minervaPurification.playerGivesBirth();
			
			if (player.hips.rating < 10) {
				player.hips.rating++;
				output.text("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
			}
			
			output.text("\n");
		}
	}
}
