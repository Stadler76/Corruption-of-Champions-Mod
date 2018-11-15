package classes.Scenes.NPCs.pregnancies 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.Vagina;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by the NPC Amily.
	 */
	public class PlayerAmilyPregnancy implements VaginalPregnancy 
	{
		private var output:GuiOutput;
		
		/**
		 * Create a new Amily pregnancy for the player. Registers pregnancy for Amily.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerAmilyPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput)
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_AMILY, this);
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
				output.text("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some mixed nuts. And maybe a little cheese, too.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 280) {
				output.text("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 216) {
				output.text("\n<b>There is no question you're pregnant; your belly is already as big as that of any pregnant woman back home.");
				
				if (kGAMECLASS.flags[kFLAGS.AMILY_FOLLOWER] === 1) {
					output.text("  Amily smiles at you reassuringly. \"<i>We do have litters, dear, this is normal.</i>\"");
				}
				
				output.text("</b>");
				output.text("\n");
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 180) {
				output.text("\n<b>The sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>You feel (and look) hugely pregnant, now, but you feel content. You know the, ah, 'father' of these children loves you, and they will love you in turn.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>You jolt from the sensation of squirming inside your swollen stomach. Fortunately, it dies down quickly, but you know for a fact that you felt more than one baby kicking inside you.</b>\n");
				
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>The children kick and squirm frequently. Your bladder, stomach and lungs all feel very squished. You're glad that they'll be coming out of you soon.</b>\n");				
			}
			
			if (player.pregnancyIncubation === 32 || player.pregnancyIncubation === 64 || player.pregnancyIncubation === 85 || player.pregnancyIncubation === 150) {
				//Increase lactation!
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
					output.text("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
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
			
			player.boostLactation(.01);
			PregnancyUtils.createVaginaIfMissing(output, player);
			
			//FUCKING BIRTH SHIT HERE.
			kGAMECLASS.amilyScene.pcBirthsAmilysKidsQuestVersion();
			
			player.cuntChange(60, true, true, false);
			
			if (player.vaginas[0].vaginalWetness === Vagina.WETNESS_DRY) {
				player.vaginas[0].vaginalWetness++;
			}
			
			player.orgasm('Vaginal');
			kGAMECLASS.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
			output.text("\n");
		}
	}
}
