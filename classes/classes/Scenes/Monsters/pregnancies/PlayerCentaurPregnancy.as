package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Player;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.Vagina;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	import classes.PregnancyStore;

	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by an centaur or the NPC Kelt.
	 */
	public class PlayerCentaurPregnancy implements VaginalPregnancy {
		private var output:GuiOutput;
		private var pregnancyProgression:PregnancyProgression;

		/**
		 * Create a new centaur pregnancy for the player. Registers pregnancies for centaurs and Kelt.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerCentaurPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) {
			// needed as an instance variable for refactor test code (detectVaginalBirth)
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_CENTAUR, this);
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_KELT, this);
		}

		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
				//TODO remove this once new Player calls have been removed
				var player:Player = kGAMECLASS.player;
				var displayedUpdate:Boolean = false;

				if (player.pregnancyIncubation === 350) {
					output.text("\n<b>You realize your belly has gotten bigger. Maybe you should cut back on all the strange food.</b>\n");
					displayedUpdate = true;
				}
				
				if (player.pregnancyIncubation === 280) {
					output.text("\n<b>Your belly is getting more noticeably distended. You are probably pregnant.</b>\n");
					displayedUpdate = true;	
				}
				
				if (player.pregnancyIncubation === 216) {
					output.text("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  Somehow, you don't feel worried. Only content.</b>\n");
					kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
					displayedUpdate = true;				
				}
				
				if (player.pregnancyIncubation === 180) {
					output.text("\n<b>The pregnancy is moving much faster than you expected. It's already as big as the belly of any pregnant woman back home.  However, a feeling of warm satisfaction fills you.</b>\n");
					displayedUpdate = true;				
				}
				
				if (player.pregnancyIncubation === 120) {
					output.text("\n<b>Your belly is painfully distended and overswollen with the offspring of some huge beast, making it difficult to function.</b>\n");
					kGAMECLASS.dynStats("spe", -1, "lib", .5, "sen", .5, "lus", 4);
					displayedUpdate = true;
				}
				
				if (player.pregnancyIncubation === 72) {
					output.text("\n<b>Your stomach is easily the size of a beach ball, and still growing ever further. Strangely, you don't feel hindered. In fact, you feel like running...</b>\n");
					kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 4);
					displayedUpdate = true;
				}
				
				if (player.pregnancyIncubation === 48) {
					output.text("\n<b>It seems impossible for your pregnant belly to grow any larger, but you are at your happiest yet, satisfied that somehow, you are fulfilling your role. It feels right to be pregnant, and you can't wait to get knocked up again afterwards.</b>\n");
					displayedUpdate = true;
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
						output.text("<b>\nYou realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
						player.boostLactation(1);
					}
					
					//Enlarge if too small for lactation
					if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
						output.text("<b>\nYour breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
						player.growTits(1, 1, false, 3);
					}
					
					//Enlarge if really small!
					if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
						output.text("<b>\nYour breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
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

				pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_CENTAUR);
				
				output.text("\nYou blink, feeling a sudden ache of need radiating from your massive stomach. You can't even get off the ground, it is so heavy... you simply lie on your side, panting with desire, as the convulsions start. New life moves beneath your stomach, ready to be born, and it is time to do your part.\n");
				
				PregnancyUtils.createVaginaIfMissing(output, player);
				
				//Main Text here
				player.boostLactation(.01);
				output.text("Perhaps strangely, there is no pain, just a steady, rhythmic compulsion that directs you to breathe steadily and spread your legs as wide as possible. You hardly have to push at all, as the child - no, your child, begins pressing against the walls of your womb, searching for escape. It finds it, and begins the arduous task of squeezing through your cervix, making you gasp with barely concealed pleasure.  It doesn't even hurt; there's only a dull little whisper of happiness followed by a tide of satisfaction.\n\n");
				output.text("The head comes first, and your first thought is relief as you see the face of a small, elfin child.  She's slick with afterbirth and pushing her way free. But the greater part is to come.  She pulls her body free, easily twice as large as her human torso. Soft downy fur with long, spindly legs and a bristly tail... she is a centaur! You help as best as you can, proud of your achievement, but are too exhausted by the ordeal. Your newfound daughter does most of the work.\n\n");
				output.text("She cannot stand, at first, and stumbles over her own shaky legs in a cute, innocent way. She appears to be a six-year old girl, stuck on top of the body of a young foal, and your heart goes out to her involuntarily. She manages to stand at last, wobbling uncertainly, and moves immediately towards your prone form. Knowing her needs, you reveal a breast to her, and she nickers affectionately before latching on, drinking hungrily from your heavily lactating teat.\n\n");
				output.text("She drinks endlessly, and seems more alive and stronger with every gulp. Hours pass in quiet, motherly bliss as she drains your breastmilk first from one breast, then the other. Her little stomach bulges slightly, but she does not stop, and you do not want her to. Even with the strange, soothing effect of the pregnancy wearing off, you feel nothing but affection for this child.\n\n");
				output.text("By the time she is finished, the centaur girl is obviously stronger, able to stand and move about on her own. She explores her new body, jumping and prancing happily, while you lay back and watch, too exhausted to join her. Suddenly, though, her ears perk up, as she looks towards the horizon urgently. She hesitates just long enough to plant a sweet kiss on your cheek, then dashes off, smiling broadly. Exhausted, you are unable to follow... but that comforting sensation returns.  Somehow, you sense she will be all right.");
				
				if (player.averageLactation() > 0 && player.averageLactation() < 5) {
					output.text("  Your " + player.allBreastsDescript() + " won't seem to stop dribbling milk, lactating more heavily than before.");
					player.boostLactation(.5);
				}
				
				output.text("  ");
				player.cuntChange(100, true);
				
				if (player.vaginas[0].vaginalWetness === Vagina.WETNESS_DRY) {
					player.vaginas[0].vaginalWetness++;
				}
				
				player.orgasm('Vaginal');
				kGAMECLASS.dynStats("str", -1, "tou", -4, "spe", 2, "lib", 1, "sen", .5);
				
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
				
				player.knockUpForce(); //Clear Pregnancy
				output.text("\n");
		}
	}
}
