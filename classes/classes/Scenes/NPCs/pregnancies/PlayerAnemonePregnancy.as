package classes.Scenes.NPCs.pregnancies 
{
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.StatusEffects;
	import classes.VaginaClass;
	import classes.internals.GuiOutput;
	import classes.internals.PregnancyUtils;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by Anemone.
	 */
	public class PlayerAnemonePregnancy implements VaginalPregnancy 
	{
		private var pregnancyProgression:PregnancyProgression;
		private var output:GuiOutput;
		
		/**
		 * Create a new Anemone pregnancy for the player. Registers pregnancies for Anemone.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerAnemonePregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput)
		{
			this.pregnancyProgression = pregnancyProgression;
			this.output = output;
			
			pregnancyProgression.registerVaginalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_ANEMONE, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateVaginalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.pregnancyIncubation === 240) {
				output.text("\n<b>You feel something shifting and moving inside you.  You start to think you might be pregnant.</b>\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 210) {
				output.text("\n<b>The fluttering of sensation inside you is getting stronger and more frequent.  At times it even feels as if the inner lining of your womb is tingling.</b>\n");
				
				kGAMECLASS.dynStats("lus", (5+player.lib/20));
				displayedUpdate = true;	
			}
			
			if (player.pregnancyIncubation === 185) {
				output.text("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ");
				
				if (player.cor < 40) {
					output.text("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("Considering the possible fathers, you hope it isn't that big.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("You think dreamily about the cocks that have recently been fucking you, and hope that your offspring inherit such a divine pleasure tool.</b>");
				}
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
				
				output.text("\n");
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 154) {
				output.text("\n<b>The sudden impact of a strong movement from inside your womb startles you.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 120) {
				output.text("\n<b>Your larger, squirming belly makes your pregnancy obvious for those around you");
				
				if (player.hasVagina()) {
					output.text(" and keeps your " + player.vaginaDescript(0) + " aroused from the constant tingling in your womb");
				}
				
				output.text(".</b>\n");
				
				kGAMECLASS.dynStats("lus", (10+player.lib/20));
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 72) {
				output.text("\n<b>Your belly is noticeably distended, ");
				
				if (player.cor < 40) {
					output.text("and constantly shifts and wriggles.  What manner of beast are you bringing into the world?</b>");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("and you wonder how much longer you have to wait.</b>");
				}
				
				if (player.cor >= 75) {
					output.text("and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.</b>");
				}
				
				output.text("\n");
				
				kGAMECLASS.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", (5 + player.lib / 20));
				displayedUpdate = true;
			}
			
			if (player.pregnancyIncubation === 48) {
				output.text("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
				
				if (player.cor < 40) {
					output.text("Afterwards you feel somewhat disgusted with yourself, but horny.</b>\n");
				}
				
				if (player.cor >= 40 && player.cor < 75) {
					output.text("You estimate you'll give birth in the next few days.  You hope the birth is as erotically charged as the pregnancy has been.</b>\n");
				}
				
				if (player.cor >= 75) {
					output.text("You find yourself daydreaming  about birthing cilia-covered worms, orgasming each time their thousands of stingers brush by your clit and fill it full of sensation-enhancing drugs.</b>\n");
				}
				
				kGAMECLASS.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", (10+player.lib/20));
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
			
			pregnancyProgression.detectVaginalBirth(PregnancyStore.PREGNANCY_ANEMONE);
			output.text(kGAMECLASS.images.showImage("birth-anemone"));
			
			PregnancyUtils.createVaginaIfMissing(output, player);
			output.text("Your " + player.armorName + " feels damp around the groin and you reach down to check the area.  The  " + player.vaginaDescript(0) + " you feel is dilated and slick with unusual wetness; your water must have broken!\n\n");
			
			output.text("Hurriedly you strip off your gear and sit down with your back against a rock.  Focusing yourself, you attempt to prepare for labor; you try to remember your recent partners and worry about what kind of monstrous infant you might have to force out of your " + player.vaginaDescript(0) + ".  The first contraction comes and you push as hard as you can, to be rewarded with the feeling of something sliding out between your labia.  You attempt a few more pushes but nothing further seems forthcoming; curious, you look down at your crotch only to discover a blue stalk sticking proudly out of your vagina!\n\n");
			
			if (kGAMECLASS.flags[kGAMECLASS.flags.ANEMONE_KID] > 0) {
				output.text("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + player.clitDescript() + "!   It writhes and slips out of your pain-wracked hands, leaving them tingling.  As you lie there, stunned, it begins to inch back toward your " + player.vaginaDescript(0)+ ".  Footfalls sound next to you, and a blue hand picks up the squirming, ciliated creature.  Kid A gives you a shy smile, then turns to her barrel.  A quick splash and a filled waterskin later, she heads toward the stream, toting your grub-like offspring.");
				player.cuntChange(20,true,true,false);
				output.text("\n\nExhausted by the birth but with a burden lifted from your mind, you slip into a grateful doze.");
				player.knockUpForce(); //Clear Pregnancy
				return;
			}
			else if (player.countCocksOfType(CockTypesEnum.ANEMONE) > 0 && player.isPureEnough(25) && kGAMECLASS.flags[kGAMECLASS.flags.ANEMONE_KID] === 0) {
				output.text("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + player.clitDescript() + " makes you lock up and nearly takes away your consciousness, and with " + player.multiCockDescript() + " in the way, you can't get any leverage on the pull at all!  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + player.vaginaDescript(0)+ ".  Searching about weakly with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; shocked into sense, you look at the absurd creature.  You raise your arm to slap at it, but something stays your hand.  As if sensing your hesitation, it stands upright and holds itself at attention for inspection.  It would be easy to knock it away... and yet, the unprepossessing little thing looks so proud that you can't quite bring yourself to do so.");
				output.text("\n\nYou scoop the diminutive anemone up and look around for somewhere wet to put it.  The stream is too far, the lake doubly so; you'd never make it to either, as sick as you feel from yanking viciously on your clitoris.  Driven to last resorts, you lurch over to the water barrel in your camp and, wrenching the lid off, drop the blue stalk unceremoniously inside.  Exhausted by the shock and pain of the ordeal, you slump down beside the barrel and slip into a doze...");
				
				player.cuntChange(20,true,true,false);
				output.text("\n");
				player.createStatusEffect(StatusEffects.CampAnemoneTrigger,0,0,0,0);
				player.knockUpForce(); //Clear Pregnancy
				return;
			}
			//[(if pc has 0-9 existing cocks)
			else if (player.cockTotal() < 10) {
				output.text("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + player.clitDescript() + "!  The small anemone and you both lay there twitching, but it recovers its bearings first; through your haze of pain you watch it flexing its body, wedging the head under itself, and elevating the base.");
				
				player.cuntChange(20,true,true,false);
				
				output.text("\n\nBeset by a panic, you watch as the strange thing sets butt-end down on your pubic mound and adheres");
				//[(if cocks)
				if (player.cockTotal() > 0) {
					output.text(" below your " + player.multiCockDescriptLight());
				}
				
				output.text(". A sharp pinch lances through the nerves in your groin and sends your hands to it reflexively.  This smaller pain, coupled with the adrenaline and dopamine that have finally chased the fog from your head, is enough to pull your thoughts into focus for another attempt to remove your strange, parasitic offspring.  You shift your grip and pull a few more times, but the thing doesn't budge.  The handling of it only serves to make the stalk thicken and become stiff; gradually you notice that you're feeling the sensation of your own pulling not from the skin at the point of attachment but from the stalk itself, and this realization is accompanied by the ring of tentacles opening and pulling back to reveal the crown of a penis!  <b>You have a new anemone-penis!</b>");
				//[(dick slot 1 exists)
				if (player.cockTotal() > 0) {
					output.text("  The tentacles writhe around, rubbing against your " + player.multiCockDescriptLight());
				}
				//(doesn't exist)
				else {
					output.text("  The tentacles curl inwards, rubbing on the head of your new blue pecker");
				}
				
				player.createCock((4 + Utils.rand(3)),1.2);
				player.cocks[player.cockTotal()-1].cockType = CockTypesEnum.ANEMONE;
				output.text(" and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress " + player.sMultiCockDesc() + " sensually, leaving behind a tingling trail of vibrant pleasure");
				
				//[(if no dick1 and no balls)
				if (player.totalCocks() === 1 && player.balls === 0) {
					output.text("; you feel a pressure build below the shaft, near your asshole");
				}
				
				output.text(".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ");
				
				if (player.cumQ() < 100) {
					output.text("glob");
				}
				else if (player.cumQ() < 500) {
					output.text("squirt");
				}
				else {
					output.text("spray");
				}
				
				output.text(" of semen shoots from your new penis and lands on your ");
				
				//[(if boobs)
				if (player.biggestTitSize() >= 1) {
					output.text(player.allBreastsDescript() + " and ");
				}
				
				output.text("stomach");
				
				//[(dick1 exists)
				if (player.cockTotal() > 1) {
					output.text(", followed in short order by white squirts from " + player.sMultiCockDesc() + " remaining");
				}
				
				output.text(".  Your " + player.vaginaDescript(0) + " quivers and pulses as well, adding ");
				
				if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK) {
					output.text("a trickle");
				}
				else if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) {
					output.text("a squirt");
				}
				else {
					output.text("nearly a cupful of fluid");
				}
				
				output.text(" from your female orgasm to the puddle on the ground below your ass.\n\n");
				//(gain 1 nemo-dick, reduce lust to min)]
				player.orgasm('Vaginal');
				kGAMECLASS.dynStats("lib", 2, "sen", 5);
			}
			//[(if PC has 10 existing cocks) && no kid
			else {
				output.text("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + player.clitDescript() + " makes you lock up and nearly takes away your consciousness, robbing your pull of force.  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + player.vaginaDescript(0)+ ".  Casting about with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; renewed, you slap at it, trying to knock the little creature away.  Several weak hits land on it, and, almost as if irritated, the tentacles seize on your labia and pull the stalk back toward your crotch and thence into your pussy.  Next you feel the thing shift and flatten itself against your insides, then a pinch on your vaginal walls where the little anemone presses on them.  This can't be good.");
				player.cuntChange(20,true,true,false);
							
				//OLD TXToutput.text("The anemone writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back into your " + player.vaginaDescript(0)+ ".  As the tentacled crown brushes past your lips a venomous heat fills your crotch - you feel the thing shift and flatten itself against your insides, then a pinch on your vaginal walls where the little anemone was pressing on them.  This can't be good.\n\n");

				output.text("\n\nPush as you might, you can't get it to peek back out even the slightest bit.  What's worse, the heat isn't subsiding, as the tentacles are now lodged inside your pussy!  Prodding and pulling at your " + player.vaginaDescript(0) + " is only worsening the effect; " + player.sMultiCockDesc() + " and your clitoris harden as you attempt to retrieve your invader.  Your probes get weaker and weaker as your vagina spasms to each stroke of your insides; each time you touch the creature, the sensation is being transmitted right back to your nerves.  Eventually you push yourself to accidental orgasm; your " + player.vaginaDescript(0) + " quivers around your fingers and your " + player.multiCockDescriptLight() + " does the best ejaculation it can manage with hardly any warmup time and no direct stimulation.  Even after the orgasm ends, the tentacles continue to torment your groin.  <b>You are VERY horny with this thing inside you... though you can't reach it, maybe there's a way to crowd it out?</b>\n\n");
				//(reduce lust to min, increased minimum lust by 30 until halfway through PC's next pregnancy)]
				player.orgasm('Generic');
				kGAMECLASS.dynStats("lib", 2, "sen", 5);
				
				if (!player.hasStatusEffect(StatusEffects.AnemoneArousal)) {
					player.createStatusEffect(StatusEffects.AnemoneArousal,0,0,0,0);
				}
			}
			
			player.knockUpForce(); //Clear Pregnancy
			output.text("Exhausted by the 'birth' and the climax, you slip into a doze.\n");
		}
	}
}
