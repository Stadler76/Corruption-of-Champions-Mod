package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.Vagina;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by an Imp.
	 */
	public class PlayerMinotaurPregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		//TODO inject player, once the new Player calls have been removed. Currently it would break on new game or load (reference changed)
		public function PlayerMinotaurPregnancy(pregnancyProgression:PregnancyProgression ,output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_MINOTAUR, this);
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
					output.text("\n<b>Your belly is painfully distended and overswollen with the offspring of some huge beast, ");
					
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
					displayedUpdate = true;
					
					output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever beast is inside your overstretched womb seems to appreciate the attention, and stops its incessant squirming.  ");
					
					if (player.cor < 40) {
						output.text("Afterwards you feel somewhat disgusted with yourself.</b>\n");
					}
					
					if (player.cor >= 40 && player.cor < 75) {
						output.text("You estimate you'll give birth in the next few days.</b>\n");
					}
					
					if (player.cor >= 75) {
						output.text("You find yourself daydreaming about birthing some huge monstrous beast, and raising it to fuck your wet pussy over and over.</b>\n");
					}
				}
				
				if (player.pregnancyIncubation === 32 || player.pregnancyIncubation === 64 || player.pregnancyIncubation === 85 || player.pregnancyIncubation === 150) {
					displayedUpdate = true;
					
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
			
			output.text(kGAMECLASS.images.showImage("birth-minotaur"));
			
			PregnancyUtils.createVaginaIfMissing(output, player);
			player.boostLactation(.01);
			
			//Main Text here
			output.text("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it bulges and shifts as another living being moves independently inside you. Instinctively, you spread your legs as you feel the creature press outward, parting your cervix.\n\nYou try to push with your vaginal muscles, but you feel the creature moving more of its own volition. Your lips part as a pair of black-furred hands grip your vulva and begin to spread them and pull. You cry out in agony as your hips are widened forcefully by the passing mass of the being exiting your womb. A bovine face appears, mercifully lacking in horns. Shoulders follow, muscles already rippling on the newborn's form. A thick barrel chest follows, narrow, masculine hips and powerful bovine legs and hooves.\n\nFinally the worst is over as the toddler-sized minotaur gets to his feet, apparently already able to stand and walk.  He clops around your legs and over to your upper body, and takes hold of one of your milk-swollen breasts. He wraps his bestial lips around your nipple and begins to suckle, relieving the pressure on the milk-swollen jug.\n\n");
			output.text("He suckles and suckles and suckles, leaving you to wonder just how much milk you were actually holding, but even as you wonder this, your eyes grow wide as the newborn minotaur begins to grow. He gains inches at a time, his horns starting to grow from his skull, his muscles rippling and thickening, his cock lengthening, his balls swelling. He reaches four feet tall, but keeps growing, soon then five feet tall, starting to resemble more and more the monster who sired him. Finally, he pulls off your breasts, and finishes his milk-inspired growth spurt at six feet tall, looking practically full grown. His one gesture of gratitude for being brought into the world is a slobbery lick at your cheek, then he turns and runs off towards the mountain, leaving you to recover from the ordeal.  You swiftly pass out.\n\n");
			
			if (player.averageLactation() > 0 && player.averageLactation() < 5) {
				output.text("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
				player.boostLactation(1);
			}
			
			player.cuntChange(120, true, true, false);
			
			if (player.vaginas[0].vaginalWetness === Vagina.WETNESS_DRY) {
				player.vaginas[0].vaginalWetness++;
			}
			
			player.orgasm('Vaginal');
			kGAMECLASS.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
			
			//Hip and butt increase
			if (player.butt.rating < 12 && Utils.rand(2) === 0) {
				player.butt.rating++;
				output.text("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");
			}
			else if (player.hips.rating < 15) {
				player.hips.rating++;
				output.text("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".");
			}
			
			player.knockUpForce(); //Clear Pregnancy
			output.text("\n");
			//326 Number of sons grown
			//327 Number of sons pending
			//328 growup countdown
			kGAMECLASS.flags[kFLAGS.MINOTAUR_SONS_PENDING]++;
			
			if (kGAMECLASS.flags[kFLAGS.MINOTAUR_SONS_GROWUP_COUNTER] === 0) {
				kGAMECLASS.flags[kFLAGS.MINOTAUR_SONS_GROWUP_COUNTER] = 150;
			}
		}
	}
}
