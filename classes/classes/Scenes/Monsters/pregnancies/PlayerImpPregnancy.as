package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.VaginaClass;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by an Imp.
	 */
	public class PlayerImpPregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		//TODO inject player, once the new Player calls have been removed. Currently it would break on new game or load (reference changed)
		
		/**
		 * Create a new imp pregnancy for the player.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerImpPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_IMP, this);
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
				output.text("\n<b>Your belly is getting more noticeably distended.   You are probably pregnant.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 216) {
				output.text("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ");
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
				output.text("\n<b>The sudden impact of a kick from inside your womb startles you.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>Your belly is painfully distended, ");
				if (player.cor < 40) output.text("making it difficult to function.</b>");
				if (player.cor >= 40 && player.cor < 75) output.text("and you wonder how much longer you have to wait.</b>");
				if (player.cor >= 75) output.text("and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.</b>");
				output.text("\n");
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
				if (player.cor < 40) output.text("Afterwards you feel somewhat disgusted with yourself.</b>\n");
				if (player.cor >= 40 && player.cor < 75) output.text("You estimate you'll give birth in the next few days.</b>\n");
				if (player.cor >= 75) output.text("You find yourself daydreaming about birthing demons repeatedly, each time being re-impregnated by your hordes of lusty adolescent children.</b>\n");
				displayedUpdate = true;
			}
			
			return displayedUpdate;
		}
		
		public function vaginalBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			output.text(kGAMECLASS.images.showImage("birth-imp"));
			
			//Add imp birth status - used to control frequency of night imp gangbag
			if (player.hasStatusEffect(StatusEffects.BirthedImps)) {
				player.addStatusValue(StatusEffects.BirthedImps,1,1);
			}
			else {
				player.createStatusEffect(StatusEffects.BirthedImps,1,0,0,0);
			}
			
			PregnancyUtils.createVaginaIfMissing(output,player);
			output.text("A sudden gush of fluids erupts from your vagina - your water just broke.  You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.  ");
			
			if (player.cor < 50) {
				output.text("You rue the day you encountered that hateful imp.  ");
			}
			
			output.text("The pain begins to subside as your delivery continues... replaced with a building sensation of pleasure.  Arousal spikes through you as the contractions intensify, and as you feel something pass you have a tiny orgasm.\n\nYet you feel more within you, and the contractions spike again, pushing you to orgasm as you pass something else.  It repeats, over and over, nearly a dozen times you birth and orgasm.  After an eternity of procreation and pleasure, you sense your ordeal is over and collapse, unconscious.");

			if (player.vaginas[0].vaginalLooseness === VaginaClass.LOOSENESS_TIGHT) {
				player.vaginas[0].vaginalLooseness++;
			}
			
			//50% chance
			if (player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE && Utils.rand(2) === 0) {
				player.vaginas[0].vaginalLooseness++;
				output.text("\n\n<b>Your cunt is painfully stretched from the ordeal, permanently enlarged.</b>");
			}

			output.text("\n\nWhen you wake you find a large number of tiny imp tracks... and a spattering of cum on your clothes and body.  They must be born fully-formed.");
			
			if (player.averageLactation() > 0 && player.averageLactation() < 5) {
				output.text("  Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
				player.boostLactation(.5);
			}
			
			//Lactate if large && not lactating
			if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.averageLactation() === 0) {
				output.text("  As you ponder the implications, <b>you realize your breasts have been slowly lactating</b>.  You wonder how much longer it will be before they stop.");
				player.boostLactation(1);
			}
			
			player.boostLactation(.01);
			
			//Enlarge if too small for lactation
			if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
				output.text("  <b>Your breasts have grown to C-cups!</b>");
				player.growTits(1, 1, false, 3);
			}
			
			//Enlarge if really small!
			if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
				output.text("  <b>Your breasts have grown to B-cups!</b>");
				player.growTits(1, 1, false, 3);
			}
			
			if (player.vaginas[0].vaginalWetness === VaginaClass.WETNESS_DRY) {
				player.vaginas[0].vaginalWetness++;
			}
			
			player.orgasm('Vaginal');
			kGAMECLASS.dynStats("tou", -2, "spe", 2, "lib", 1, "sen", .5, "cor", 7);
			
			if (player.butt.rating < 10 && Utils.rand(2) === 0) {
				player.butt.rating++;
				output.text("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");
			}
			else if (player.hips.rating < 10) {
				player.hips.rating++;
				output.text("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
			}
			output.text("\n");
		}
	}
}
