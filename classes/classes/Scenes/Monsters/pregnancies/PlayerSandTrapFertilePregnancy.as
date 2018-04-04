package classes.Scenes.Monsters.pregnancies 
{
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.AnalPregnancy;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.internals.GuiOutput;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by sandtrap.
	 */
	public class PlayerSandTrapFertilePregnancy implements AnalPregnancy
	{
		private var pregnancyProgression:PregnancyProgression;
		private var output:GuiOutput;
		
		/**
		 * Create a new sandtrap pregnancy for the player. Registers pregnancy for sandtrap.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerSandTrapFertilePregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			this.pregnancyProgression = pregnancyProgression;
			
			pregnancyProgression.registerAnalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_SANDTRAP_FERTILE, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAnalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.buttPregnancyIncubation === 36) {
				//(Eggs take 2-3 days to lay)
				output.text("<b>\nYour bowels make a strange gurgling noise and shift uneasily.  You feel ");
				output.text(" bloated and full; the sensation isn't entirely unpleasant.");
				output.text("</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 20) {
				//end eggpreg here if unfertilized
				output.text("\nSomething oily drips from your sphincter, staining the ground.  You suppose you should feel worried about this, but the overriding emotion which simmers in your gut is one of sensual, yielding calm.  The pressure in your bowels which has been building over the last few days feels right somehow, and the fact that your back passage is dribbling lubricant makes you incredibly, perversely hot.  As you stand there and savor the wet, soothing sensation a fantasy pushes itself into your mind, one of being on your hands and knees and letting any number of beings use your ass, of being bred over and over by beautiful, irrepressible insect creatures.  With some effort you suppress these alien emotions and carry on, trying to ignore the oil which occasionally beads out of your " + player.assholeDescript() + " and stains your [armor].\n");
				
				kGAMECLASS.dynStats("int", -.5, "lus", 500);
				
				displayedUpdate = true;
			}
			
			return displayedUpdate;
		}
		
		/**
		 * @inheritDoc
		 */
		public function analBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			kGAMECLASS.desert.sandTrapScene.birfSandTarps();
			if (player.butt.rating < 17) {
				if (player.butt.rating < 13) {
					//Guaranteed increase up to level 10
					player.butt.rating++;
					output.text("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.\n");
				} else if (Utils.rand(2) === 0) {
					//Big butts only increase 50% of the time.
					player.butt.rating++;
					output.text("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.\n");
				}
			}
			
			displayedUpdate = true;
			
			pregnancyProgression.detectAnalBirth(PregnancyStore.PREGNANCY_SANDTRAP_FERTILE);
		}
	}
}
