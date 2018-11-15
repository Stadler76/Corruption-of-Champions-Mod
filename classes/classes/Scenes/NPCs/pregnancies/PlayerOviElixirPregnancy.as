package classes.Scenes.NPCs.pregnancies 
{
	import classes.CoC_Settings;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.ArmorLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.StatusEffects;
	import classes.Vagina;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by OviElixir.
	 */
	public class PlayerOviElixirPregnancy implements VaginalPregnancy
	{
		private var output:GuiOutput;
		
		/**
		 * Create a new OviElixir pregnancy for the player. Registers pregnancy for OviElixir.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerOviElixirPregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			return !vaginaCheck()
		}
		
		private function vaginaCheck():Boolean {
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			if (player.vaginas.length === 0) {
				player.removeStatusEffect(StatusEffects.Eggs);
				
				output.text("\n<b>Your pregnant belly suddenly begins shrinking, until it disappears.</b>\n");
				
				player.knockUpForce(); //Clear Pregnancy
				
				return false;
			}
			
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function vaginalBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			if (!vaginaCheck()) {
				return;
			}
			
			var oviMaxOverdoseGainedOviPerk:Boolean = false;
			
			if (!player.hasPerk(PerkLib.Oviposition) && kGAMECLASS.flags[kFLAGS.OVIMAX_OVERDOSE] > 0 && Utils.rand(3) < kGAMECLASS.flags[kFLAGS.OVIMAX_OVERDOSE]) {
				output.text("You instantly feel your body seize up and you know something is wrong."
						  +" [if (hasWeapon)You let go of your [weapon] before your|Your] legs completely give out from under you and"
						  +" a high pitched, death curdle escapes your lips as you fall to your knees. Clutching your stomach,"
						  +" you bury your face into the ground, your screaming turning into a violent high pitched wail."
						  +" Deep inside your uterus you feel a shuddering, inhuman change as your womb violently and painfully,"
						  +" shifts and warps around your unfertilized eggs, becoming a more accommodating, cavernous home for them."
						  +" Your wails quieted down and became a mess of heaving sighs and groans. Your eyes weakly register as your belly"
						  +" trembles with a vengeance, and you realize there is still more to come.\n\n");
				
				if (player.armor !== ArmorLib.NOTHING) {
					output.text("Realizing you're about to give birth, you rip off your [armor] before it can be ruined by what's coming.\n\n");
				}
				
				oviMaxOverdoseGainedOviPerk = true;
			}
			
			kGAMECLASS.flags[kFLAGS.OVIMAX_OVERDOSE] = 0;
			
			//Small egg scenes
			if (player.statusEffectv2(StatusEffects.Eggs) === 0) {
				//light quantity
				if (player.statusEffectv3(StatusEffects.Eggs) < 10) {
					output.text("You are interrupted as you find yourself overtaken by an uncontrollable urge to undress and squat.   You berate yourself for giving in to the urge for a moment before feeling something shift.  You hear the splash of fluid on the ground and look down to see a thick greenish fluid puddling underneath you.  There is no time to ponder this development as a rounded object passes down your birth canal, spreading your feminine lips apart and forcing a blush to your cheeks.  It plops into the puddle with a splash, and you find yourself feeling visibly delighted to be laying such healthy eggs.   Another egg works its way down and you realize the process is turning you on more and more.   In total you lay ");
					output.text(eggDescript()); 
					output.text(", driving yourself to the very edge of orgasm.");
					
					kGAMECLASS.dynStats("lus=", player.maxLust(), "scale", false);
				}
				//High quantity
				else {
					output.text("A strange desire overwhelms your sensibilities, forcing you to shed your " + player.armorName + " and drop to your hands and knees.   You manage to roll over and prop yourself up against a smooth rock, looking down over your pregnant-looking belly as green fluids leak from you, soaking into the ground.   A powerful contraction rips through you and your legs spread instinctively, opening your " + player.vaginaDescript(0) + " to better deposit your precious cargo.   You see the rounded surface of an egg peek through your lips, mottled with strange colors.   You push hard and it drops free with an abrupt violent motion.  The friction and slimy fluids begin to arouse you, flooding your groin with heat as you feel the second egg pushing down.  It slips free with greater ease than the first, arousing you further as you bleat out a moan from the unexpected pleasure.  Before it stops rolling on the ground, you feel the next egg sliding down your slime-slicked passage, rubbing you perfectly as it slides free.  You lose count of the eggs and begin to masturbate, ");
					
					if (player.getClitLength() > 5) {
						output.text("jerking on your huge clitty as if it were a cock, moaning and panting as each egg slides free of your diminishing belly.  You lubricate it with a mix of your juices and the slime until ");
					}
					
					if (player.getClitLength() > 2 && player.getClitLength() <= 5) {
						output.text("playing with your over-large clit as if it were a small cock, moaning and panting as the eggs slide free of your diminishing belly.  You spread the slime and cunt juice over it as you tease and stroke until ");
					}
					
					if (player.getClitLength() <= 2) {
						output.text("pulling your folds wide and playing with your clit as another egg pops free from your diminishing belly.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself until "); 
					}
					
					output.text("you quiver in orgasm, popping out the last of your eggs as your body twitches nervelessly on the ground.   In total you lay " + eggDescript() + ".");
					player.orgasm('Vaginal');
					
					kGAMECLASS.dynStats("scale", false);
				}
			}
			//Large egg scene
			else {
				output.text("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your " + player.armorName + " before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ");
				
				if (player.vaginas[0].vaginalLooseness < Vagina.LOOSENESS_LOOSE) {
					output.text("stretching your tight cunt painfully, the lips opening wide ");
				}
				
				if (player.vaginas[0].vaginalLooseness >= Vagina.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness <= Vagina.LOOSENESS_GAPING_WIDE) {
					output.text("temporarily stretching your cunt-lips wide-open ");
				}
				
				if (player.vaginas[0].vaginalLooseness > Vagina.LOOSENESS_GAPING_WIDE) {
					output.text("parting your already gaping lips wide ");
				}
				
				output.text("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ");
				
				if (player.getClitLength() > 5) {
					output.text("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ");
				}
				
				if (player.getClitLength() > 2 && player.getClitLength() <= 5) {
					output.text("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ");
				}
				
				if (player.getClitLength() <= 2) {
					output.text("your " + player.vaginaDescript(0) + " by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ");
				}
				
				output.text("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ");
				
				if (player.statusEffectv3(StatusEffects.Eggs) >= 11) {
					output.text("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your " + player.vaginaDescript(0) + " as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ");
				}
				
				output.text("\n\nYou gaze down at the mess, counting " + eggDescript() + ".");
				player.orgasm('Vaginal');
				
				kGAMECLASS.dynStats("scale", false);
			}
			
			if (oviMaxOverdoseGainedOviPerk) {
				output.text("\n\n(<b>Perk Gained: Oviposition</b>)");
				player.createPerk(PerkLib.Oviposition, 0, 0, 0, 0);
			}
			
			output.text("\n\n<b>You feel compelled to leave the eggs behind, ");
			
			if (player.hasStatusEffect(StatusEffects.AteEgg)) {
				output.text("but you remember the effects of the last one you ate.\n</b>");
			}
			else {
				output.text("but your body's intuition reminds you they shouldn't be fertile, and your belly rumbles with barely contained hunger.\n</b>");
			}
			
			player.cuntChange(20, true);
			player.createStatusEffect(StatusEffects.LootEgg,0,0,0,0);
			
			player.knockUpForce(); //Clear Pregnancy
		}
		
		public function eggDescript(plural:Boolean = true):String
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			
			var descript:String = "";
			if (player.hasStatusEffect(StatusEffects.Eggs)) {
				descript += Utils.num2Text(player.statusEffectv3(StatusEffects.Eggs)) + " ";
				
				//size descriptor
				if (player.statusEffectv2(StatusEffects.Eggs) === 1) {
					descript += "large ";
				}
				/*color descriptor
				0 - brown - ass expansion
				1 - purple - hip expansion
				2 - blue - vaginal removal and/or growth of existing maleness
				3 - pink - dick removal and/or fertility increase.
				4 - white - breast growth.  If lactating increases lactation.
				5 - rubbery black - 
				*/
				if (player.statusEffectv1(StatusEffects.Eggs) === 0) {
					descript += "brown ";
				}
				
				if (player.statusEffectv1(StatusEffects.Eggs) === 1) {
					descript += "purple ";
				}
				
				if (player.statusEffectv1(StatusEffects.Eggs) === 2) {
					descript += "blue ";
				}
				
				if (player.statusEffectv1(StatusEffects.Eggs) === 3) {
					descript += "pink ";
				}
				
				if (player.statusEffectv1(StatusEffects.Eggs) === 4) {
					descript += "white ";
				}
				
				if (player.statusEffectv1(StatusEffects.Eggs) === 5) {
					descript += "rubbery black ";
				}
				
				//EGGS
				if (plural) {
					descript += "eggs";
				} else {
					descript += "egg";
				}
				
				return descript;
			}
			
			CoC_Settings.error("");
			
			return "EGG ERRORZ";
		}
	}
}
