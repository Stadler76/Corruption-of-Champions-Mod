package classes.Scenes.Monsters.pregnancies 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Mutations;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.AnalPregnancy;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.StatusEffects;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by a bunny.
	 */
	public class PlayerBunnyPregnancy implements VaginalPregnancy, AnalPregnancy
	{
		private var pregnancyProgression:PregnancyProgression;
		private var output:GuiOutput;
		private var mutations:Mutations;
		
		/**
		 * Create a new bunny pregnancy for the player. Registers pregnancy for bunnies.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerBunnyPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput, mutations:Mutations)
		{
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			this.mutations = mutations;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_BUNNY, this);
			pregnancyProgression.registerAnalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_BUNNY, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 800) {
				output.text("\nYour womb gurgles strangely.\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 785) {
				//output.text("\n<b>An unexpected change occurs, no doubt brought on by the bunny's eggs inside you!</b>");
				kGAMECLASS.consumables.NPEPREG.useItem();
				output.text("\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 776) {
				output.text("\nYour womb feels full and bloated.\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 765) {
				//output.text("\n<b>An unexpected change occurs, no doubt brought on by the bunny's eggs inside you!</b>");
				kGAMECLASS.consumables.NPEPREG.useItem();
				output.text("\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation <= 745 && player.pregnancyIncubation > 400) {
				output.text("\n<b>After dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your womb have dissolved.</b>\n");
				displayedUpdate = true;
				player.knockUpForce(); //Clear Pregnancy
			}
			
			//BREAK - REAL PREGNANCY BELOW THIS:
			if (player.pregnancyIncubation === 198) {
				output.text("\n<b>You realize your belly has gotten slightly larger.  Maybe there's some truth to what the bunny-girl said.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 178) {
				output.text("\n<b>Your belly is getting more noticeably distended.   You are probably pregnant.</b>\n");
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 156) {
				output.text("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ");
				
				if (player.cor < 40) {
					output.text("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("You find yourself wondering what giving birth to bunny-girls is like.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("You dreamily wonder if you could find a bunny willing to put more than two eggs inside you at once.</b>");
				}
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				output.text("\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 140) {
				output.text("\n<b>The sudden impact of a kick from inside your womb startles you, and it's immediately followed by a second on the other side.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>Your belly is painfully distended, ");
				
				if (player.cor < 40) {
					output.text("making it difficult to function.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("and you wonder how much longer you have to wait.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("and you're eager to give birth so you'll be able to get pregnant again.</b>");
				}
				
				output.text("\n");
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
				
				if (player.cor < 40) {
					output.text("Afterwards you feel somewhat disgusted with yourself.</b>\n");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("You estimate you'll give birth in the next few days.</b>\n");
				}
				
				if (player.cor >= 75) {
					output.text("You find yourself daydreaming about birthing bunnies repeatedly, each time being re-impregnated with dozens of eggs from your lusty adolescent children.</b>\n");
				}
				
				displayedUpdate = true;
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
			
			pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_BUNNY);
			
			output.text(kGAMECLASS.images.showImage("birth-bunny"));
			PregnancyUtils.createVaginaIfMissing(output, player);
			
			output.text("A dangerous rumble comes from your womb, signaling that it's time to birth your body's cargo at last.  Your " + player.legs() + " wobble unsteadily as your strength ebbs with every gush that erupts  from your now-broken water until you collapse on your " + player.buttDescript() + ", grunting and groaning.  At first it goes slow – there's just a few small contractions that are more strange than anything else, rippling down your " + player.vaginaDescript(0) + " and squirting out more of your pregnancy's fluid.  All too soon the tempo kicks up, and you feel something starting to stretch you wider and wider.\n\n");
			
			output.text("You heave and push, instinctively driven to flex muscles you didn't even know you had to speed the super human labor you've entered into.  ");
			
			if (player.vaginalCapacity() < 60) {
				output.text("It hurts a little as your cervix starts to stretch wide");
			}
			else {
				output.text("It actually feels kind of nice as your cervix is stretched wide");
			}
			
			output.text(", but somehow your body accommodates the forced dilation without too much discomfort.  It's soon forgotten as you feel your " + player.vaginaDescript(0) + " pushed into a large sphere, stretched around the inhuman form of your child as it squirms and writhes inside you on its path to freedom.  You grunt and flex, watching with disbelief as a tiny, rabbit-eared form slides from your slick canal into the grass, the process leaving your " + player.chestDesc() + " heaving with unexpected pleasure.\n\n");
			
			output.text("The whole process starts over again – there's another one!  By now your well-stretched pussy is oozing both the birthing fluids and your own lubricants, and the second bunny-child slides down to bump into its sibling with ease.  You shake and shudder, groaning and spasming as you nearly cum from the stimulation, but in the end you're left panting and horny.  The two bunnies look like miniature people except for their ears, tails, and fuzzy legs.  Your children lick themselves clean before hopping up onto your " + player.chestDesc() + " and suckling your nipples for a while");
			
			if (player.lactationQ() > 500) {
				output.text(", growing fat from all the milk");
			}
			
			output.text(".  At last they finish, and with one last nuzzle, your strange bunny-children go hopping off, doubtless to find more of their own kind.\n\n");
			
			output.text("You sink into restful unconsciousness, marveling at how stretchy and sensitive your " + player.vaginaDescript(0) + " feels now.");
			
			player.cuntChange(60,true,true,false);
			player.boostLactation(.01);
			//Boost capacity
			if (player.vaginalCapacity() < 300) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) {
					player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
				}
				
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 10);
			}
			
			player.orgasm('Vaginal');
			kGAMECLASS.dynStats("lib", 1, "sen", 10, "cor", -2);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAnalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.buttPregnancyIncubation === 800) {
				output.text("\nYour gut gurgles strangely.\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 785) {
				kGAMECLASS.consumables.NPEPREG.useItem();
				output.text("\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 776) {
				output.text("\nYour gut feels full and bloated.\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 765) {
				kGAMECLASS.consumables.NPEPREG.useItem();
				output.text("\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 745) {
				output.text("\n<b>After dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your ass have dissolved.</b>\n");
				
				displayedUpdate = true;
				
				player.buttKnockUpForce();
			}
			
			return displayedUpdate;
		}
		
		/**
		 * @inheritDoc
		 */
		public function analBirth():void 
		{
			// there is no bunny anal birth, see PlayerBunnyPregnancy#updateAnalPregnancy()
		}
	}
}
