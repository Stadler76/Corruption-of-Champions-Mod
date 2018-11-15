package classes.Scenes.Monsters
{
	import classes.*;
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.display.SpriteDb;
	import classes.internals.*;

	public class PriscillaScene extends BaseContent
	{
		public function PriscillaScene()
		{
		}
		/*
			PRISCILLA ENCOUNTERS
			Casts spells
			Uses potions
			Attacks with sword
			Increased tease damage
		*/
		public function goblinElderEncounter():void {
			clearOutput();
			spriteSelect(SpriteDb.s_priscilla);
			//First Time Intro
			if (flags[kFLAGS.TIMES_ENCOUNTERED_GOBLIN_ELDER] == 0)
			{
				outputText("As you take a stroll, you catch the glimpse of an imposing goblin.  Unlike most of the goblins you've seen so far, she's clad in primitive bone armor, wielding a metal sword lined with lethicite crystal, and holding a metal greatshield.  Her hair is crimson and black.  She walks over to you in a peaceful manner.");
				if (player.hasCock()) {
					if (player.isPureEnough(60)) outputText("\n\n\"<i>Would you like to fuck me?  I'll promise to teach my newborn goblins the values of pre-corruption lifestyle.</i>\"");
					else outputText("\n\n\"<i>Please don't fuck me!  You're too corrupt!</i>\"");
				}
				else {
					outputText("\n\n\"<i>You don't have anything to knock me up but I'm always up for the challenge.</i>\"");
				}
			}
			else if (player.hasVagina() && !player.hasCock() && (flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER] == 1 || flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER] == 2)) {
				startffaction();
			}
			//Repeat Intro - Cell Chambers
			else {
				outputText("As you walk, the familiar sight of a powerful goblin catches your eye.  You have encountered " + (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] > 0 ?  "Priscilla" : "the goblin elder") + " again!");
				if (player.hasCock()) {
					if (player.isPureEnough(60)) outputText("\n\n\"<i>Hello again" + (player.hasCock() ?  ", stud.  Ready to knock me up with your cum?  Or are you here to duel?" : ",") + "</i>\" she says.");
					else outputText("\n\n\"<i>Please don't fuck me!  You're too corrupt!</i>\"");
				}
				else {
					outputText("\n\n\"<i>You don't have anything to knock me up but I'm always up for the challenge,</i>\" she says.");
				}
			}
			flags[kFLAGS.TIMES_ENCOUNTERED_GOBLIN_ELDER]++;
			unlockCodexEntry("Goblins", kFLAGS.CODEX_ENTRY_GOBLINS);
			menu();
			addButton(0, "Fight", startFight);
			if (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] < 2) addButton(1, "Talk", talkToGoblinElder);
			if (player.hasVagina() && player.lust >= 33 && player.isPureEnough(60)) {
				monster = new Priscilla();
				addButton(2, "Sex Anyway", startffaction);
				if (flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER] == 3 || player.hasCock()) addButton(2, "Sex", startforeplay);
			}
			if (player.hasCock() && player.lust >= 33 && player.isPureEnough(60)) {
				monster = new Priscilla();
				if (player.cockThatFits(monster.vaginalCapacity()) >= 0) addButton(2, "Sex", startforeplay);
				else outputText("\n\n<b>There is no way you can fit your cock into her cunt!</b>");
			}
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function startFight():void {
			startCombat(new Priscilla());
			playerMenu();
		}
		
		//[LOSS SEXAHNZ]
		public function goblinElderBeatYaUp():void {
			clearOutput();
			if (doSFWloss()) return;
			var x:int;
			if (player.lust100 <= 99) outputText("You collapse, utterly beaten.  To make sure you'll be easier to handle, the victorious elder saunters up, pink arousing flames glow in her left hand.  She exposes your nether regions and throws the pink flames right into your groin!  You are unable to fight back.  \n\n");

			if (player.cockThatFits(monster.vaginalCapacity()) >= 0 && player.hasCock() && (!player.hasVagina() || rand(2) == 0)) 
			{
				x = player.cockThatFits(monster.vaginalCapacity());
				if (x < 0) x = player.smallestCockIndex();
				outputText("You’re so aroused, so horny.  Any passing thoughts of modesty are immediately discarded and forgotten, washed away under the wave of your all-consuming lust as your fingers slide home around [oneCock] and begin to play with the turgid tool.  You immediately buck from the sensation of incredible, pent-up need, nearly cumming on the spot.  Looking up, you meet the emerald-skinned woman’s eyes pleadingly.");
				outputText("\n\nThe goblin elder watches impassively for a moment, but as your need intensifies, her attitude softens while your member hardens.  \"<i>Oh, I think I’m gonna regret this, but ");
				if (player.cockTotal() == 1) outputText("that thing");
				else outputText("those things");
				outputText(" look mighty tasty.  You don’t mind if I sample just a little bit of your seed do you?</i>\" The crimson-maned beauty kneels down next to you and lets her tiny, delicate digits dance across the underside of [oneCock], drawing a lurid moan from your lips as she wonders out loud, \"<i>I don’t hear a no, " + player.mf("stud","sexy") + ".  That’s good...  I’m just going to take a little bit of cum...  just a few squirts.  Surely a ");
				if (player.tallness >= 60) outputText("big, ");
				outputText(player.mf("strapping young man","sexy breeder") + " will have enough jizz to pay for " + player.mf("his","her") + " trespass?</i>\"");
				outputText(" Those delightful, dancing fingers pirouette down to your ");
				if (player.balls > 0) outputText("[sack], giving it a gentle caress before vanishing.");
				else if (player.hasVagina()) outputText(player.vaginaDescript() + ", the tips giving your soaked mound only the barest ghost of a touch.");
				else outputText("taint, the tips giving your sensitive skin only the barest ghost of a touch.");

				outputText("\n\nShe explains, \"<i>I won’t help with that until you give me an answer.  Be honest with yourself - you don’t care about other girls at all.  You just came up here to fuck a goblin elder.  Am I right?</i>\"");

				outputText("\n\nYou try to answer ‘no’, but it trails off into a weak, ");
				if (player.femininity < 40) outputText("almost ");
				outputText("girlish moan.  The need thrumming through [eachCock] is telling you - no, demanding - that you do what she says and fuck her.  Like a beast in rut, you groan.  You look the short-but-stacked aggressor in her big, liquid blue eyes and make a decision entirely rationalized by your aching, drug-fueled needs.  Still pumping your shaft like a man possessed, you whimper, \"<i>Yes...  I...  I came to have sex with you.</i>\"");
				outputText("\n\nVeridian skin caresses you just above");
				if (player.hasSheath()) outputText(" the sheath");
				else outputText("your base");
				outputText("for a brief moment but vanishes before you can gain any satisfaction from the act.  \"<i>I’m sorry, that was too slow,</i>\" the diminutive spellcaster teases, a moment before she casts another Arouse spell towards your nether regions.  [EachCock] rises and immediately spurts a trickle of white pre-cum, unable to resist the potent spell muddling your mind, so perfectly tailored to inflame your passions past the point of reason.  You fail to notice the removal of the spent plungers, but you sure as hell notice the return of the lithe green woman’s probing caresses.  She whispers, \"<i>Now tell me how other girls don’t matter.  This was all just a ruse to get you some green love, wasn’t it?</i>\"");
				outputText("\n\nYour response is as immediate as it is enthusiastic.  You tell her exactly what she wants and then some more, panting and moaning as the elder's nimble fingers tickle every throbbing-hard inch of your over-filled fuck-tool.  It spews another rope of pre so thick and white it may as well be the real deal as you finish, begging, \"<i>Yes, I came here for your delicious, juicy cunny.  Please, fuck my cock.  I need it so bad!  I’ll do anything!</i>\"");
				outputText("\n\n\"<i>Awww, you’re squirting for me already.  I just hope there’s enough left to pay your fine.  If not, I can always cast more of these arousing spells,</i>\" muses the emerald slut.  She steps over you, the jiggly, rounded curves of her ass hanging over you for a moment before she tosses her spider-silk loincloth aside and drops her musky, squishing box straight down onto your nose and lips.  Droplets of fem-spunk roll down your cheeks as the goblin grinds her swollen mound against you, her fragrant pussy driving your neglected cock");
				if (player.cocks.length > 1) outputText("s");
				outputText(" wild with need.  Thankfully, as soon as you submit to her puffy mound and give it a lick, a pair of soft, wrinkled feet wrap around your " + player.cockDescript(x) + ", drawing out a thick flood of your pre-cum.");
				outputText("\n\nToes smear your precum around your " + player.cockHead(x) + " before the warm soles drag them down the " + num2Text(Math.round(player.cocks[x].cockLength)) + " inches of your length, basting your " + player.cockDescript(x) + " in a mixture of goblin sweat and your personal juices.  You moan in delight, your sounds of rapture muted by the puffy, soaked lips that obscure your mouth, your cock spurting helpless trails of white submissively onto her feet.  Every brush of your lips is rewarded with caresses from the goblin’s tiny toes.  Every lick sends those squeezing, cum-lubed feet sliding up and down.  Every suck on her clit causes her pace to increase.  With encouragement like that, you cannot stop yourself from attending to the goblin’s syrupy box, worshipping her womanhood like a slave before an altar of a glorious god.");
				outputText("\n\nThe short, stacked woman moves her legs to lay your cock on her left foot while the entirety of her right foot presses down on your " + player.cockDescript(x) + "’s underside, squeezing a thick flow of your pent-up jism from the cum-slit at its tip.  Her sole rocks up and down your length, milking dollop after dollop of jizz onto the goblin’s toes.  After a while, she switches her legs to let her now-soaked foot do the rest of the squeezing.  You happily squirt and squirm, dripping like a sieve but not yet achieving true release.  The goblin, having no such problem, cums noisily atop you, numerous times.  Each successive squirt of girl-fluid soaks your face more than the one before, and by the time she’s done, your " + player.hairDescript() + " is sticky with it, half-buried in a puddle of goblin-lust.  You’re so close.  So very close.  Just a little bit more...  a few more strokes.");
				outputText("\n\n\"<i>");
				if (silly()) outputText("Stop right there, criminal scum.");
				else outputText("Hold your horses.");
				outputText("</i>\" The olive emerald glances over her shoulder at you and urges, \"<i>Come on now.  Fill me up.  Let out all that spunk I’ve been making build up ");
				if (player.balls > 0) outputText("in your balls");
				else outputText("inside you");
				outputText(".  Pay your ‘fine’, and I might let you go.</i>\"");
				if (player.balls > 0) outputText(" A hand squeezes your [sack] encouragingly");
				else outputText(" Hands squeeze your [butt] encouragingly");
				outputText(" as the goblin impales herself to the hilt with a sloppy squelch.  You orgasm, cumming hard inside her.  Your back arches, your body clenches, and rope after rope of seed sprays inside the goblin’s baby-hungry womb.  Her pussy seems to drink it down, wicking the jizz away from you just as fast as you can put it out.");
				if (player.cumQ() >= 750) {
					outputText(" Even her near-supernatural fertility can’t keep up with your fantastic virility, and soon the goblin is sporting a small bump on her belly.");
					if (player.cumQ() >= 2000) outputText(" It swells to a rounded, pregnant dome by the time you finish.");
				}
				outputText(" All of your passion spends itself in the glorious climax, leaving you feeling like an empty, wasted husk.");
				outputText("\n\nStanding up with your white goo dripping from her nethers, the goblin gives you a wink and disappears around a corner, leaving you alone to slumber.");
			}
			//ii.  Lust Loss - Male - No Fit
			else if (player.biggestCockArea() > monster.vaginalCapacity() && player.hasCock() && (!player.hasVagina() || rand(2) == 0))
			{
				x = player.biggestCockIndex();
				outputText("You tear through your [armor] in a rush, anything to release [eachCock] from its hellish confinement.  You’re so aroused, so horny.  Any passing thoughts of modesty are immediately discarded and forgotten, washed away under the wave of your all-consuming lust as your fingers slide home around [oneCock] and begin to play with the turgid tool.  You immediately buck from the sensation of incredible, pent-up need, nearly cumming on the spot.  Looking up, you meet the emerald-skinned woman’s eyes pleadingly.");
				outputText("\n\nThe elder sighs and grumbles, \"<i>Another one with a fucking tree-trunk for a cock.</i>\" She begrudgingly slips out of her straps, perky, dark-green nipples popping free from their confinement to jut proudly from her chest.  \"<i>The downside of being a goblin,</i>\" explains the athletic green-skinned beauty, \'<i>is that around a dick like that...  a heaving, pulsating tower of cock-flesh like that...  I’ve just gotta TRY it.</i>\" Now nude, your captor saunters up, wide hips shaking from side to side with every step.  \"<i>Being a size-queen is suffering,</i>\" she finishes with a wry smile.");
				outputText("\n\nYou watch her tirade with confused indifference, comprehending little beyond the petite slut’s desire to mount your member.  Tracing your hands over the pulsating veins on your " + player.cockDescript(x) + ", your body continues on autopilot, masturbating hard and fast for the emerald beauty as she climbs atop you.  Her juicy gash spreads over the bulge of your urethra as the goblin sinks down atop you, her legs splaying to the sides obscenely.  She commands, \"<i>Hands off bub.  You lost to a goblin, and that means you get to be a dad, whether you want to or not.</i>\"");
				outputText("\n\nThe puffy emerald curtains drape your dick in elastic goblin pussy and brush your feverishly pumping fingers away.  Your captor lets a lewd moan slip through her lips as she begins grinding along your mammoth pole, dragging dark-hued genitalia back and forth on your massive dong.  A perky, hard little clit pops out of the top of the goblin’s glittery pussy-folds, visibly twitching in a display of supreme enjoyment.  Driven by your own insatiable desire, you shift under her, trying to slide your " + player.cockDescript(x) + " even faster through her pussy.");
				if (player.biggestCockLength() > player.tallness/2) outputText(" Your incredibly long phallus blocks your view of the sultry goblin, and you never see the blow coming.");
				outputText(" A none-too-tender swat connects with your ");
				if (player.balls > 0) outputText("[balls]");
				else outputText("cock");
				outputText(" as the goblin grunts, \"<i>Stop squirming!</i>\"");
				outputText("\n\nYou hesitantly obey, too startled by the sudden pain to risk movement again.  You’ll just have to wait until the short, stacked woman decides she’s had her fun and lets you get off.");

				outputText("\n\n\"<i>Oh, you finally figured it out?  You’re just livestock to me - just a cum-nozzle for me to play with until I tire of you and put you up in a pen.  Maybe if your cum is thick enough, I’ll take you back and chain you up with our other animals.  Of course, if I did that you’d have to pump out enough spunk to keep a few dozen matrons pregnant,</i>\" says the viridian tart in between the lurid squelches of her flexible pussy on your dick.  No...  if she takes you back, you’ll never get to do what you came here for!  She drags herself forward until she’s ");
				if (player.biggestCockLength() < player.tallness/2) outputText("sitting on your face, the " + player.cockHead(x) + " of your maleness jutting against her drooling lips.");
				else outputText("sitting on the ground ‘above’ you, your " + player.cockHead(x) + " reaching all the way up to spear her moist box, judging by what you’re feeling anyway.");

				outputText("\n\nHer soft feet clasp your dick from each side, displaying a level of flexibility you would not have expected from the girl.  The supple soles slide and caress your length.  Her toes curl around to stroke the sensitive sides of your urethral bulge.  Even the hard knobs of her heels cradle your " + player.cockDescript(x) + " underside as she masturbates you with her feet.");

				outputText("\n\nLubricated as they are by the copious vaginal drippings, the elder's feet have an easy time bringing you to the very edge of orgasm.  Every squishy, delicate step she takes brings you closer and closer, and soon you are trembling beneath her sweat and fem-spunk lubricated soles.  ");
				if (player.cumQ() >= 1000) outputText("You spurt huge dollops of pre-cum into her waiting twat thanks to your prodigious virility, though it is only a hint of things to come.  ");
				else if (player.cumQ() >= 250) outputText("You drool a steady flow of pre-cum into her waiting twat, though it’s only a hint of things to come.  ");
				outputText(" \"<i>It won’t be long now.  Yeah, I’m an elder, but I take care of myself too.  I keep these puppies nice and moisturized, just in case I need to use them on a freak-cock like yours.</i>\"");

				outputText("\n\nYou try to grunt in protest, but it’s muffled by your ");

				if (player.biggestCockLength() >= player.tallness/2) outputText("pulsating, iron-hard cock");
				else outputText("captor’s pillowy asscheeks");
				outputText(".  The goblin pulls hard with her feet, and her sloppy, stretched cunt just barely slurps in your entire " + player.cockHead(x) + ".  You shiver in delight from the tight, vise-like grip constricting your maleness, and nearly erupt from sensation when the little green minx manages to pull another inch inside herself.  She trembles and shudders, her feet suddenly going wild along your length.  The goblin’s cushy soles smear along your " + player.cockDescript(x) + " with the wild abandon of one lost to pleasure, her juices squirting out from her slit as she climaxes.  The onslaught of touches is too much for your straining member, and with a tight, hot clench, you feel your imminent release has arrived.  A fat bulge appears at the base of your shaft, coupled with an explosion of warm pleasure from within you.  It travels from your base all the way towards the tip, before disappearing into the goblin with a cunt-stretching squirt.  She moans out loud, clearly enjoying the sensation of being stuffed with cream, and the two of you sigh together while your dick finishes pumping ");
				if (player.cumQ() <= 10) outputText("dribbles");
				else if (player.cumQ() <= 100) outputText("squirts");
				else if (player.cumQ() <= 250) outputText("thick wads");
				else if (player.cumQ() <= 1750) outputText("waves of gooey spooge");
				else outputText("rivers of cum");
				outputText(" into the goblin’s box.");
				if (player.cumQ() >= 2500) outputText(" Her belly rounds up nicely under your voluminous attentions.");

				outputText("\n\nThe green girl gives your " + player.cockDescript(x) + " a few last affectionate squeezes before she disentangles herself from you.  You slump down, still feeling a little turned on, and return to masturbating.  The goblin laughs, \"<i>A few more performances like that and I just might have to keep you.</i>\" You play with yourself until you fall asleep, and even then, you dream of the feel of that silken pussy back on top of your dick.");
			}
			//iii.  Lust Loss - Female
			else {
				outputText("Defeated by your own needs, your fingers dart to your [armor], rapidly disassembling it in your hurry to expose your aching, tender puss to the goblin’s eyes.  The elder watches you with an unimpressed, bemused expression, though she remains rooted in place, her gaze locked onto you as you succumb to your lusts.  Knowing that you have an audience, you twist and contort your body to present your [chest] and [vagina] to the petite greenskin.  Glistening moisture forms on your exposed nether-lips, tempting you to slide your fingers into their slick warmth.  As if you could resist.");
				outputText("\n\nYou begin masturbating, violently and unabashedly ravishing your form, forgetting entirely about the one who put you in such a state.  Parting your slippery flesh with questing digits, you lose yourself to the pleasant, warm explosions firing through your nerves with every caress of your honeypot.  At the same time, the fingers on your free hand ");
				if (player.hasFuckableNipples()) outputText("piston in and out of your [nipple], masturbating it just as hard as the real thing.");
				else outputText("squeeze around a taut nipple, twisting and pulling on it unthinkingly.");
				outputText(" Your masturbatory reverie is interrupted sudden impacts against both your wrists.");

				outputText("\n\nLooking on in confusion, you can only stare as the goblin steps over you, straddling your prone form and easily batting away every attempt you make to touch yourself.  She carefully moves her loincloth to expose her cunny.  She doesn't even have to take her armor off.  With practiced skill, she binds your hands together with a narrow leather leash.  You don’t resist, expecting the kinky viridian bitch is planning some perverse sex game to get you both off that much harder.  She smirks down and says, \"<i>I don’t see much point in fucking a two-bit twat like yourself, but you got me horny, so by Lethice’s drippy tits, you’re gonna get me off.</i>\"");
				outputText("\n\nBefore you can mutter a protest, the goblin pivots and drops atop your face, plugging your mouth-hole with her wet gash.  Musky fem-drool slimes over your cheeks, running down to the nape of your neck where it drips on the ground.  The goblin utters a quiet, appreciative moan, rocking her hips ever so slightly to drag the bump of her clitty across your parted lips.  She doesn’t do anything for your needs at all!  You try to protest, but all that gets you is a mouth full of slime, tangy and arousing though it may be.  The silken loincloth binding your hands goes taut as you try to pull your fingers back into your aching cunt, but in your compromised position, you cannot will up the strength to overpower the tiny, dominating minx.");

				outputText("\n\n\"<i>Oh, you wanna cum too?  Then you better lick faster, slut.  You’re not getting anything until you get me off,</i>\" taunts the face-fucking box’s owner.  Determined to convince her to tend to you, you close your mouth and hide away your tongue, bargaining with the only thing you can still control.");

				outputText("\n\nAn irritated slap cracks against the [skin] of your [chest] with stinging force.  The explosion of pain sends stars through your cunt-clouded vision, but you hold fast, only giving a tiny muffle of discomfort.  Sighing, the goblin fiddles with her bandolier.  You can’t see what she’s doing, but you know she’s up to no good!  There’s a brief sting of pain in your arm, followed by a rush of ecstatic, burning euphoria.  Your [vagina] juices itself, and you moan uncontrollably.  Lust thrums through your veins.  Desire mounts to new levels.  You can’t resist this...  not anymore.  You open wide and start to lick, assaulting the lush green pussy with your tongue, anything to get her off and bring you the relief you ACHE for.");

				outputText("\n\nThere’s a momentary pain in your other arm, followed by a wave of vertigo.  In its wake, your arousal seems to double, climbing so high that your previous levels of sexual need seem insignificant by comparison.  Your [hips] lift from the ground of their own accord, the electric sensation of every air current over your engorged mons too delicious to resist.  The goblin, clearly enjoying your efforts, comments, \"<i>Oh my, are you fucking the air?  Are you seriously getting off on feeling the breeze on your bare, exposed cunt?  And you’re so wet down there!  Honey, I’m a fucking goblin, but you’d put me to shame right now.</i>\"");
				outputText("\n\nYou suck on her clit to shut her up while sliding your [butt] on the ground.  Every hump, every movement, and every pointless undulation against your phantasmal lover seems more fevered and desperate than the last.  Already, the dirt beneath you has turned into fragrant, soupy mud.  Your ass is painted brown with it, and the wet squishes it makes as you drag your bottom through the mud-puddle only serve to arouse you and your captor further.  She moans, \"<i>Want some more?  Mmm...  I don’t think you’ll be able to get off like you are now.</i>\"");
				outputText("\n\nPanting into the goblin’s green, leaky cunt, you can’t do anything to answer except to hum against her lips and trace your tongue in circles over her clit.  You’re so turned on that you feel like your sense your orgasm, lurking over a hill that you can’t quite mount.  Your desperate, obscene motions bring you pleasure, but it just isn’t enough, even with the flood of accursed goblin drugs flooding your system.");

				outputText("\n\nA pinprick on your tender, engorged nipple is the only warning you have before another wave of narcotic aphrodisiacs assault your system.  Your muscles locks as your pussy seems to come alive, practically fountaining fem-slime.  The puddle beneath you is up your shoulders, but you’re too lost in fantasies of sex and the tasty cunt atop your face to care.  The goblin’s thick, well-rounded thighs squeeze on your head as she begins panting, \"<i>Fuck yes, lick it there you hungry slut, lick my birth-hole you insignificant tongue-slut.  I ought to bring you inside our city.  I’m sure we could put you in a stall, maybe lock everything but your mouth behind a wall and make you chain-lick dozens of pregnant green cunnies until you’re living on nothing but sticky-sweet girl-cum.</i>\"");
				outputText("\n\nYour eyes roll back, not that they had anything to look at besides curvy veridian buttocks, and your tongue goes absolutely nuts, whipping back and forth through the curtains of slime that drool down into your open, moaning maw.  The goblin grinds atop you, moaning loudly as she reaches her own peak, barely caring about your pleasure.  Thankfully, with the latest injection, your [vagina] has grown so sensitive that every whisper of air over your red, swollen folds feels like an individual tongue.  You squirm, complete, irressistable need controlling your body from the waist down.  The torrent of lady-jizz that suddenly fills your mouth startles you for a moment, and then you too are cumming, your [vagina] climaxing from nothing more than faint air currents.");
				outputText("\n\nPassing out in a puddle of mixed juices, you barely notice the goblin’s departure.");
			}
			player.orgasm('Generic');
			combat.cleanupAfterCombat();
		}

		//[WIN RAEPZ]
		public function goblinElderRapeIntro():void
		{
			spriteSelect(SpriteDb.s_priscilla);
			clearOutput();
			outputText("The elder falls to her feet, smashing her titties against the confines of her armor.  She looks up at you and sniffles.");
			
			if (player.lust < 33) {
				outputText("\n\n<b>You aren't horny enough to rape her.</b>");
			}
			
			addDisabledButton(0, "Dick Fuck", "This scene requires you to have fitting cock.", "Dick Fuck");
			addDisabledButton(1, "DickTooBig", "This scene requires you to have overly large cock.", "Dick Too Big");
			addDisabledButton(2, "CorruptDick", "This scene requires you to have overly large cock and high corruption.", "Corrupt Big");
			addDisabledButton(3, "Dick In Ass", "This scene requires you to have cock and high corruption.", "Dick In Ass");
			addDisabledButton(4, "Jog Fuck", "This scene requires you to have fitting cock.", "Jog Fuck");
			addDisabledButton(5, "Breastfeed", "This scene requires you to have enough milk.", "Breastfeed");
			addDisabledButton(6, "Use Condom", "This scene requires you to have either condom or spider abdomen and fitting cock.", "Use Condom");
			addDisabledButton(7, "Pussies", "This scene requires you to have vagina.", "Pussies");
			addDisabledButton(8, "Lay Eggs", "This scene requires you to have drider ovipositor and some eggs.", "Lay Eggs");
			
			//cunt stuff
			if (player.hasVagina() && player.lust >= 33) addButton(7, "Pussies", gobboGetsRapedFem);
			//Dick stuff:
			if (player.hasCock() && player.lust >= 33) {
				//Corrupt too big scene
				if (player.cockArea(player.biggestCockIndex()) > monster.vaginalCapacity() && player.isCorruptEnough(80) || player.findPerk(PerkLib.Sadist) >= 0)
					addButton(2, "CorruptDick", rapeAGoblinCorruptTooBig);
				//Regular too big scene
				if (player.cockArea(player.biggestCockIndex()) > monster.vaginalCapacity())
					addButton(1, "DickTooBig", manRapesGoblinTooBig);
				//It fits!
				if (player.cockThatFits(monster.vaginalCapacity()) >= 0) {
					addButton(0, "Dick Fuck", gatsGoblinBoners);
					addButton(4, "Jog Fuck", gobboGetsRapedMaleFits);
				}
				//Buttsex toggle
				if (player.cockThatFits(monster.analCapacity()) >= 0 && (player.isCorruptEnough(70) || player.findPerk(PerkLib.Sadist) >= 0)) addButton(3, "Dick In Ass", gobboButtSecks);
				//Spidercondom
				if (player.tail.type == Tail.SPIDER_ABDOMEN && player.cockThatFits(monster.vaginalCapacity()) >= 0)
					addButton(6, "Web Condom", goblinCondomed, 0);
				else if (player.hasItem(useables.CONDOM) && player.cockThatFits(monster.vaginalCapacity()) >= 0)
					addButton(6, "Use Condom", goblinCondomed, 1);
			}
			if (player.canOvipositSpider()) {
				addButton(8, "Lay Eggs", laySomeDriderEggsInGobboTwat);
			}
			//Breastfeed adds an option
			if (player.lactationQ() >= 500 || player.hasStatusEffect(StatusEffects.Feeder)) addButton(5, "Breastfeed", giveGoblinAMilkMustache);
			
			addButton(14, "Leave", combat.cleanupAfterCombat);
		}
		private function giveGoblinAMilkMustache():void {
			clearOutput();
			outputText("You slowly walk up to the downed goblin, gently telling her that everything will be all right now.  She looks at you a bit incredulously and spreads her legs, obviously hoping that you will satisfy the urges that she has.  You shake your head at her and instead cup your hands under your " + player.biggestBreastSizeDescript() + " and tell her that it's feeding time.  The goblin looks at you annoyed and says, \"<i>I don't want your breasts!  I want your naughty bits!</i>\" You laugh at her and grab her arms, pulling them behind her head.\n\n");

			outputText("She struggles against your grip, trying to get something, anything inside her needy pussy while yelling \"<i>Come on " + player.mf("slut","stud") + ", you know you want to - mmph!</i>\" You cut her off by shoving her mouth onto your " + player.nippleDescript(0) + ".  She gasps involuntarily, filling her mouth with your milk.  In an instant she freezes, then slowly swallows the milk in her mouth.  She relaxes in your arms a moment later, gently suckling at your nipple.  Her old lust-filled self is gone, replaced with a pliant girl who now wants nothing but your milk.  You slowly lower your hand and start rubbing at her still-slick pussy.  In response, she puts her hand on your other " + player.nippleDescript(0) + ", playing with it and teasing you.\n\n");

			outputText("After a while, you feel the goblin fall asleep in your arms.  Even then, she still continues suckling gently on your " + player.nippleDescript(0) + ".  You smile, satisfied, and gently lift the goblin off your chest.  You pat her shoulder softly, and she stirs awake again.  She gives you a bit of a dazed look before you give her a gentle push, and she starts walking away with a vacant, drooling stare.");
			//set lust to 0, increase sensitivity slightly
			dynStats("lib", .2, "lus", -50);
			//You've now been milked, reset the timer for that
			player.addStatusValue(StatusEffects.Feeder,1,1);
			player.changeStatusValue(StatusEffects.Feeder,2,0);
			combat.cleanupAfterCombat();
		}
		private function gobboButtSecks():void
		{
			spriteSelect(SpriteDb.s_priscilla);
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = 0;
			clearOutput();
			outputText(images.showImage("goblinelder-win-male-buttsex"));
			outputText("As usual, you easily defeat another slutty goblin.  Was there any doubt you could?  Knowing what's about to happen, the goblin braces herself for the inevitable.  Her face is flushed from arousal as she licks her lips.  To goad you even further, she spreads her legs, revealing more of her sopping cunt.\n\n");
			outputText("\"<i>Fuck me, stud!</i>\" she begs.  Though defeated, she has to gall to make demands.  \"<i>Pump me full of your baby batter!</i>\" Her defeat doesn't seem to do much to silence her tongue.\n\n");
			outputText("You're insulted.  Who emerged victorious from the prior battle?  You could have left her there to wallow in a pool of her own juices if you weren't so damn horny yourself.  So what do you do?  After some silent pondering, you get a deliciously wicked idea.\n\n");
			outputText("After quickly removing your " + player.armorName + ", you tear off what little clothing the green-skinned woman is wearing.  With ease, you lift her off the ground and position her over your " + player.cockDescript(x) + ".  The little goblin whore is so enthralled with you that her body quivers from excitement.\n\n");
			outputText("With a sneer, you take the crown of your " + player.cockDescript(x) + " and press it not against her drenched pussy lips, but her asshole!\n\n");
			outputText("\"<i>Not there!</i>\" she begs, her lips trembling and eyes watering.  \"<i>I need your spunk to make my own tribe!</i>\" she explains.\n\n");
			outputText("You say nothing to the trembling woman in your grasp.  No words could describe the joy you feel from crushing her dreams.  By the elders, this world has truly corrupted you, and you love it!\n\n");
			outputText("Without any reservations, you slam the goblin whore onto your " + player.cockDescript(x) + ", virtually impaling her!  The immediate tightness of her asshole nearly drives you over the edge!  The more she squirms, the tighter her ass muscles squeeze you.  You stand frozen in ecstasy for a moment, your tongue drooping out of your mouth and eyes rolling into the back of your head.\n\n");
			outputText("Protesting, the goblin squirms more, even going as far as to beat her fists into your chest; she's so feeble at the moment that her strikes actually tickle.  Her puny assault is enough to knock you out of your carnal daze.  You grin manically as you grasp her tiny waist and hammer her!  Your " + player.cockDescript(x) + " quickly adjusts to her stretching asshole as you thrust harder and deeper!\n\n");
			outputText("\"<i>This isn't what I wanted!</i>\" she cries, \"<i>This isn't what I wanted!</i>\" If your " + player.cockDescript(x) + " expanding her ass wasn't enough, she can feel your ");
			if (player.balls > 0) outputText(player.sackDescript());
			else outputText(player.hipDescript());
			outputText(" smacking her plump rump with each thrust, as if to tease her.\n\n");
			outputText("The tight confines of the goblin's asshole prove too much for you.  Your body convulses wildly as you unload a massive load in her.  Spent, you throw the little whore onto the ground; you have no further use for her at the moment.\n\n");
			outputText("As you pick up your " + player.armorName + " and begin to get dressed, you glance at the goblin.  Her hands began to dig in her now stretched out anus, desperately trying to gather up the cum you deposited in her.  Smirking, you walk away nonchalantly, quite pleased with yourself.");
			combat.cleanupAfterCombat();
			player.orgasm('Dick');
		}

//[FEMSAUCE]
		private function gobboGetsRapedFem():void
		{
			spriteSelect(SpriteDb.s_priscilla);
			clearOutput();
			if (player.isTaur()) {
				outputText(images.showImage("goblinelder-win-female-taur-rapedfem"));
				outputText("You pick up the goblin, holding her tightly against your side with your arm.  You tear a piece of supple leather off of her slutty garments and use it to bind her arms behind her back, just to be sure she can't do anything.  She looks up at you, her eyes wide and frightened at the thought of being at the mercy of a much larger creature.  In spite of it all, she seems more than a little turned on, if the juices staining your flank are any indication.  You look down at her and remark, \"<i>So the little skank has a submissive streak huh?</i>\"\n\n");

				outputText("She blushes red and the flow of feminine fluid thickens as she nods.  You know she'll probably enjoy whatever sexual act you could perform with her, so you may as well surprise her.  A cruel idea forms in the back of your mind – getting revenge for her attempts to drug you.  You easily rip the pouches from her belt and pull out a few random bottles.  The goblin, understanding your intent, begins struggling to free herself, but you easily restrain the smaller woman and force the drugs into her mouth, one after the another.  When she tries to spit them out, you massage her throat, triggering her instinct to swallow.\n\n");

				outputText("By the third bottle she's given up on struggling free and is instead attempting to find some part of your body to grind against.  Her mouth is open wide and her entire face is flushed reddish-purple with desire.  You finish force-feeding her the remaining bottles and release her, catching her ankles just before she hits the ground.  The scent of her arousal and the vapors from all the drugs and aphrodisiacs give you a bit of a 'contact high', at least in the sense that your " + player.vaginaDescript(0) + " drips with feminine moisture.  Your arousal can wait.  This slut needs to be punished.\n\n");

				outputText("You flip the creature back into the crux of your arm, this time with her facing the opposite direction.  *THWACK!* Your hand smacks her nicely rounded ass.  You pull back, feeling drops of wetness thanks to her prominent pussy-lips.  The little bitch's cunt is so inflamed with need that she's practically squirting from a simple spank.  You swat her again, watching her entire body tense and feeling her fluids splatter you.  \"<i>YOU GOT ME WET, YOU CUNT!!  BAD BITCH!</i>\" you scold, slapping her even harder.\n\n");

				outputText("The goblin squeals, though in delight or pain you can't be sure.  You start spanking her harder and harder, turning her ass from green to red with the repeated abuse.  Her entire body begins convulsing and squirting, splattering your arm with her honey.  She got off on it!  Well, after that kind of show, she's going to get you off too - or else!\n\n");

				outputText("You drop her for real this time but don't give her the opportunity to stand, roughly shoving your " + player.vaginaDescript(0) + " on top of her.  She thrashes against you, too lost to her own pleasure to realize what's going on.  Her tiny fists beating weakly against your haunches feels surprisingly good, and you allow it to continue for a while until you've had enough 'foreplay' and start to roughly rub your box against her face, letting her tongue slip into your folds.\n\n");

				outputText("You can't see what she's doing but her struggling soon stops as the flavor and scent trigger her to lick.  You tremble; it feels WAY better than it should.  Perhaps some of her potions have left a residue on her lips and tongue, but you don't care.  You put even more of your considerable weight onto the little slut as your hind legs go weak from pleasure.  She reacts by sliding her hands up and pounding on your " + player.clitDescript() + ", trying to get you off of her.\n\n");

				outputText("Her efforts are rewarded as you cum on the drugged green bitch, leaving the taste of pussy on her tongue.  Her face has a strange dopey smile on it, and she looks like she's in some strange state in between consciousness and sleep.  You watch as she twitches and writhes on the ground, gasping for air and orgasming repeatedly.  While at first you're worried, the convulsions start to slow down; the little twat ought to be fine.\n\n");

				outputText("You casually dress, ignoring the pants and moans from the blissed-out goblin, and prepare to leave.  Taking one last look over your shoulder, you realize her fluids have made a puddle bigger than her.  She'll probably have a hell of a hangover when she wakes up.  You sigh and trot off, feeling a bit guilty about overdoing it.");
				combat.cleanupAfterCombat();
				player.orgasm('Vaginal');
			}
			//Goblin victory rape, female naga:
			else if (player.isNaga()) {
				outputText(images.showImage("goblinelder-win-female-naga-rapedfem"));
				outputText("You slither over to the helpless goblin, who watches you half in fear, half in curiosity.  ");
				//[Has fangs:
				if (player.face.type == Face.SNAKE_FANGS) outputText("You bare your fangs at her and the curiosity disappears.  She turns to run, but your tail is faster than she is.");
				//[No fangs: 
				else outputText("You smile at her and the fear disappears.  She's still wary though, and you make sure to grab her with your tail before she changes her mind about you.");
				outputText("\n\n");

				outputText("You wrap yourself tightly around your struggling prey, in the process removing her slutty 'clothes'.  The incapacitated goblin whimpers plaintively at you and you respond by giving her cunt a smack with your hand.  Pulling your hand away, you're surprised at how wet it is.  You wipe it dry on her face and bring your head down to her ear.\n\n");

				//[Corrupt characters:
				if (player.cor > 60) {
					outputText("You hiss something incoherent to the terrified woman, who starts to quiver in your grip.  Laughing, your fingers slide into her mouth and she begins to suck on them in an attempt to appease you.  Her tiny tongue feels wonderful; clearly she's very experienced at this.  ");
					outputText("Using your fingers, you spread open her mouth.  She's confused but can't resist as you fiddle with something beside you.  She realizes what's about to happen too late, as you pull off a number of shiny flasks from her pouches.  As punishment for trying to poison you, you start emptying bottle after bottle into her mouth, stroking her throat and forcing her to drink them down.\n\n");
				}
				//[Non-corrupt characters:
				else {
					outputText("You ask her if she's sorry for trying to poison you as your fingers slide around her face.  She nods vehemently at you, too constricted or afraid to answer.  You smile pleasantly at her and feel her body relax a little in your grip.  Your fingers slide into her mouth and she sucks on them eagerly, clearly not wanting to anger you.  Her tongue is talented and you enjoy the experience for a little bit until you decide you've toyed with her enough.\n\n");

					outputText("Opening your fingers, you open her mouth and prevent it from closing.  The confused goblin tries to see what you're doing beside her but can't.  When you bring up a handful of shiny flasks from her pouches though, her body tenses again and she whimpers at you.\n\n");

					outputText("Your pity for the creature doesn't extend quite far enough to prevent you from punishing her though, and you pick out some of the less potent looking concoctions from the bunch.  While stroking her throat gently to make sure she swallows you pour in vial after vial.\n\n");
				}
				outputText("The effects don't take long to materialize, and soon the slut is a purplish hue and desperately trying to grind against your coils.  She pants and moans in frustration as her dripping cunt can't get enough pleasure from your smooth underbelly, while you wait, enjoying the sensations.\n\n");

				outputText("You slide your tail up to her cunt and tweak her clit with the tip.  She immediately releases a gush of fluids, thoroughly coating your already slick and sticky coils in more of her cum.  You waggle your finger in front of her face to tell her off; you're not done with her yet.\n\n");

				outputText("With a smooth motion your tail slides inside her, causing her to moan in pleasure and buck her hips.  You squirm about inside, stretching her so wide you suspect she'll be gaping for quite a while.  The tip of your tail hits the end of her love canal and you're surprised to find her uterus is pulsating, trying to grip at something that's not there.  Curious, you move your tail up to the opening, which grabs you and drags you inside her womb.  You smile at the pleasure-overloaded goblin and begin stroking at the walls.  She clamps down hard on you and screams out in ecstasy as her eyes roll back into her head.\n\n");

				outputText("With no warning you pull out your entire tail, feeling a massive gush of fluids sliding out behind you.  The goblin is barely conscious, so you look around inside her pouch for something to help.  Nothing seems to look like it would help your cause though, and you're beginning to regret being so vicious, when you notice a particularly tiny flask at the very bottom.\n\n");

				outputText("You pull it out and examine it.  Not much more than a centimeter long, it's filled with a white fluid.  There's a label, but the lettering is far too small to read.  You think you can make out the word \"<i>wake</i>\", but aren't entirely sure.\n\n");

				outputText("Shrugging, you dump the contents into the goblin's mouth, little more than a drop that's quickly absorbed into her tongue.  For a moment nothing happens, then the tiny figure starts to shake violently.  Not sure what to do, you simply stay as you are, holding her tight.  The shaking stops as suddenly as it started though, and you think you might have killed her.\n\n");

				outputText("That's proven very false in a moment though, as her eyes fly open and she yells out \"<i>WHOOOOOO!</i>\".  You're startled at the sudden change in demeanor, but decide to roll with it, shoving your " + player.vaginaDescript(0) + " into the evidently very energetic little creature.\n\n");

				outputText("You hear a muffled yell of \"<i>YOU GOT IT BOSS!</i>\" as she starts licking and gently chewing at you.  The feeling is wonderful and you can't help but wonder what was in the vial, but the thought is wiped from your mind as you cum, spraying all over her.\n\n");

				outputText("You orgasm repeatedly, the goblin not tiring and the residue of the various substances you poured into her still coating her lips and tongue, making you not feel like stopping.  Eventually you grow tired, releasing the goblin from your coils.  She lands on her feet, does a pirouette, runs about the clearing for a bit (all while giggling like a madwoman), then collapses face first onto her 'clothes'.\n\n");

				outputText("Thoroughly confused about what just happened, you decide not to test fate by sticking around near the heavily drugged creature and make for camp as soon as you've grabbed your things.");
				combat.cleanupAfterCombat();
				player.orgasm('Generic');
			}
			else {
				outputText(images.showImage("goblinelder-win-female-rapedfem"));
				outputText("You pick up the goblin, sitting her onto your knee and restraining both her arms behind her back with your left hand.  You tear a piece of supple leather off of her slutty garments and use it to bind her arms there.  She looks up at you, her eyes wide and frightened at the thought of being at the mercy of a larger creature.  In spite of it all, she seems more than a little turned on, if the juices staining your knee are any indication.  You look down at her and remark, \"<i>So the little skank has a submissive streak huh?</i>\"\n\n");
				outputText("She blushes red and the flow of feminine fluid thickens as she nods.  You know she'll probably enjoy whatever sexual act you could perform with her, so you may as well surprise her.  A cruel idea forms in the back of your mind – getting revenge for her attempts to drug you.  You easily rip the pouches from her belt and pull out a few random bottles.  The goblin, understanding your intent, begins struggling to free herself, but you easily restrain the smaller woman and force the drugs into her mouth, one after the another.  When she tries to spit them out, you massage her throat, triggering her instinct to swallow.\n\n");
				outputText("By the third bottle she's given up on struggling and is instead trying to grind her cunt into your knee.  Her mouth is open wide and her entire face is flushed reddish-purple with desire.  You finish force-feeding her the remaining bottles and shove her, catching her ankles to hold her over your leg with her ass in the air.  The scent of her arousal and the vapors from all the drugs and aphrodisiacs give you a bit of a 'contact high', at least in the sense that your " + player.vaginaDescript(0) + " ");
				if (player.vaginas[0].vaginalWetness < Vagina.WETNESS_WET) outputText("grows puffy and moist");
				else if (player.vaginas[0].vaginalWetness < Vagina.WETNESS_DROOLING) outputText("drips with feminine moisture");
				else if (player.vaginas[0].vaginalWetness < Vagina.WETNESS_SLAVERING) outputText("slowly begins to soak your thighs");
				else outputText("drools with need, puddling under you");
				outputText(".  Your arousal can wait.  This slut needs to be punished.\n\n");
				outputText("*<b>THWACK</b>!* Your hand smacks her nicely rounded ass.  You pull back, feeling drops of wetness thanks to her prominent pussy-lips.  The little bitch's cunt is so inflamed with need that she's practically squirting from a simple spank.  You swat her again, watching her entire body tense and feeling her fluids splatter you.\n\n");
				outputText("\"<i>YOU GOT ME WET, YOU CUNT!!  BAD BITCH!</i>\" you scold, slapping her even harder.\n\n");
				outputText("The goblin squeals, though in delight or pain you can't be sure.  You start spanking her harder and harder, turning her ass from green to red with the repeated abuse.  Her entire body begins convulsing and squirting, splattering your arm with her honey.  She got off on it!  Well, after that kind of show, she's going to get you off too - or else!\n\n");
				outputText("You pull her off your leg and shove her face into your " + player.vaginaDescript(0) + ".  She thrashes against you, too lost to her own plessure to realize what's going on.  Forcefully you put her plump little lips on your box and grind, letting her tongue slip into your folds.  Her eyes are little white slits, her pupils rolled up out of view, but there's enough of something in there that her tongue recognizes the taste and starts licking.  You tremble; it feels WAY better than it should.  Perhaps some of her potions have left a residue on her lips and tongue, but you don't care.\n\n");
				outputText("You cum on the drugged green bitch, ");
				if (player.vaginas[0].vaginalWetness > Vagina.WETNESS_DROOLING) outputText("splattering her with your fluids");
				else if (player.vaginas[0].vaginalWetness > Vagina.WETNESS_SLICK) outputText("coating her face with the proof of your pleasure");
				else if (player.vaginas[0].vaginalWetness > Vagina.WETNESS_WET) outputText("leaving her sticky with your nether-juices");
				else outputText("leaving the taste of pussy on her tongue");
				outputText(".  ");
				if (player.biggestLactation() >= 3.5) outputText("Milk explodes from your nipples, soaking the petite slut.  ");
				else if (player.biggestLactation() > 2) outputText("Twin streams of milk soak the slut's hair, running down her face like white tears.  ");
				else if (player.biggestLactation() >= 1) outputText("Milk dribbles from your nipples, falling into the little slut's hair.  ");
				outputText("Her face has a strange dopey smile on it, and she looks like she's in some strange state in between consciousness and sleep.  You grab her by the hair and toss her on the ground, watching her body twitch and jump as her orgasm continues to rack her body.  It looks like it's starting to slow down, the little twat ought to be fine.\n\n");
				outputText("You casually dress, ignoring the pants and moans from the blissed-out goblin, and prepare to leave.  Taking one last look over your shoulder, you realize her fluids have made a puddle bigger than her.  She'll probably have a hell of a hangover when she wakes up.  You ");
				if (player.cor > 50) outputText("smirk");
				else outputText("sigh");
				outputText(" and saunter off, feeling ");
				if (player.cor < 50) outputText("a bit guilty about overdoing it.");
				else outputText("thoroughly satisfied with your revenge.");
				combat.cleanupAfterCombat();
				player.orgasm('Vaginal');
			}
		}

//Corrupt too big fuck
		private function rapeAGoblinCorruptTooBig():void
		{
			var x:Number = player.biggestCockIndex();
			clearOutput();
			spriteSelect(SpriteDb.s_priscilla);
			outputText(images.showImage("goblinelder-win-male-corruptedfuck"));
			outputText("You begin to remove your " + player.armorName + ", looking down on your helpless would-be-attacker and soon-to-be victim while licking your lips hungrily.  Your " + player.multiCockDescriptLight());
			if (player.cockTotal() == 1) outputText(" is");
			else outputText(" are all");
			outputText(" far more aware of the situation than she is as you stoop down and strip her of every scrap of her admittedly sparse clothing.  While you look her over, ");
			if (player.cockTotal() > 1) outputText("one of your " + player.multiCockDescriptLight() + " comes to rest on top of her and the fact that it's ");
			else outputText("your " + player.cockDescript(x) + " comes to rest on top of her and the fact that it's ");
			if (player.cocks[0].cockLength < 20) outputText("about as long as her entire torso");
			else outputText("bigger than she is");
			outputText(" gives you a wicked idea.\n\n");

			outputText("You have a seat, legs wide, on the ground and hold the little goblin whore with her relatively tiny slit resting at the tip of your " + player.cockDescript(x) + ".  Finally out of her stupor a look of extreme conflict crosses her face as her need for cock and cum goes to war with her survival instincts.  On the brink of defeat, those instinct suddenly regroup and beat back her lust once she feels the pain of just the " + player.cockHead(x) + " of your " + player.cockDescript(x) + " starting to stretch out her " + monster.vaginaDescript() + ".  She does all she can to resist, but with the way you're holding this is little more than flailing wildly and pushing against your " + player.cockDescript(x) + " with her feet, practically climbing it like the tree trunk it must look like from her perspective.\n\n");
			outputText("Both of you dripping with sweat from your respective exertions, you slowly begin to realize the combination of her furious struggling and the tightness of her " + monster.vaginaDescript() + " is going to keep you from the penetration you were so looking forward to.  However, as you begin to consider finishing off in her throat, a darkness stirs and another idea crosses your mind.\n\n");
			outputText("The goblin relaxes a little when she feels you no longer pressing her down onto your " + player.cockDescript(x) + ".  She absolutely thrills when you bring her tiny pussy to your lips and begin to have at it.  Your tongue plays around both on the inside and outside of her " + monster.vaginaDescript() + " until you coax her little nub out from hiding.  You wrap your lips around it and begin putting your corruption to task.  As you drive the goblin slut closer and closer to orgasm, working over her clit with an expertise rarely found outside of the infernal ranks, bolts of corrupt energies travel from your tongue, through her clit, and deep into her core.  As she cums, screaming, you pull off of her, admiring the outward signs of your demonic handiwork.  What before was an average sized love button has swollen five times its size into a proud, engorged clit...  and that's not the only thing you enlarged.\n\n");

			outputText("You reposition your fucktoy so that now she's facing away from you and again bring your " + player.cockDescript(x) + " into contact with her " + monster.vaginaDescript() + ".  Again she struggles, but after her orgasm she doesn't have the strength to put up a decent fight; all her resistance does is arouse you further, now that she's fighting the inevitable.  You begin to press her down onto yourself.\n\n");

			outputText("\"<i>Too much...</i>\" she says, weakly.  The tip of the head pops in.\n\n");
			outputText("\"<i>You'll kill me...</i>\" she pleads.  The rest of the head follows.\n\n");
			outputText("\"<i>Stop...</i>\" she begs.  The shaft starts to sink in.\n\n");
			outputText("\"<i>Don't...</i>\" More enters her small body.\n\n");
			outputText("\"<i>Please...</i>\" She fills to capacity.\n\n");
			outputText("\"<i>Please...</i>\" And beyond.\n\n");
			outputText("\"<i>...  Fuck me.</i>\"\n\n");
			outputText("You ram home the rest of your " + player.cockDescript(x) + " left outside of your newly christened dick jockey.  It's enough to orgasm the bitch, and you haven't even gotten started.  You ");
			if (player.cocks[0].cockLength < 20) outputText("can feel the massive bulge in her midsection");
			else outputText("stretch her so much that you can see the bulge even from this angle");
			outputText(" and it drives your lust even higher.  You withdraw more cock from the hole than your cum starved slut has body, causing her eyes to roll into the back of her head as her " + monster.vaginaDescript() + " clamps down on you and she cums again.  Every time you pull out or hammer home brings her off to the point that by the time you've both gotten down on all fours, rutting like a pair of wild animals, she can only lie there, practically foaming at the wide open mouth");
			if (player.biggestTitSize() >= 1) {
				outputText(", her head resting between your " + player.breastDescript(0));
				if (player.biggestLactation() >= 1) {
					outputText(" as your " + player.nippleDescript(0) + " ");
					if (player.biggestLactation() < 2) outputText("occasionally drip milky tears onto her face");
					if (player.biggestLactation() < 3) outputText("weep streams of milk onto her features");
					else outputText("plaster her with gouts of fluid");
				}
			}
			outputText(".  Her hair is matted with");
			if (player.biggestLactation() >= 1) outputText(" milk and");
			outputText(" the sweat of the both of you, and the only sound she makes is an occasional gurgle of ecstasy every few orgasms.\n\n");
			outputText("\"<i>Alright, whore.  You wanted my babies?  Here.  They.  CUM!</i>\" you yell.  However, ");
			if (player.hasVagina()) {
				outputText("while your " + player.vaginaDescript(0) + " ");
				if (player.vaginas[0].vaginalWetness <= Vagina.WETNESS_SLICK) outputText("juices ");
				else if (player.vaginas[0].vaginalWetness <= Vagina.WETNESS_DROOLING) outputText("floods ");
				else outputText("explodes ");
				if (player.cockTotal() > 1) outputText("and the rest of your " + player.multiCockDescriptLight() + " drench her, ");
			}
			else if (player.cockTotal() > 1) {
				outputText("while your other " + Appearance.cockNoun(CockTypesEnum.HUMAN));
				if (player.cockTotal() > 2) outputText(" drench her, ");
				else outputText(" drenches her, ");
			}
			outputText("the bitch is too tight!  Like a natural cock-ring!  ");
			if (player.balls >= 2) outputText("Your " + player.ballsDescriptLight() + " are trying but, h");
			else outputText("H");
			outputText("er spasming " + monster.vaginaDescript() + " is clamping down so hard on your " + player.cockDescript(x) + " that it can't release.\n\n");
			outputText("The moment passes and you're left unsatisfied.  This only serves to piss you off as your cum receptacle fails in its one duty.  You, however, are undaunted.  In fact you redouble your efforts.  If this size queen slut wants to deny you your pay off while getting off herself, well, you'll just have to cum her into oblivion the next go-round.\n\n");
			outputText("For what seems like hours you almost literally screw the brains out of her little green head, working yourself back up to the brink.  You consider pulling out this time, but decide against it.  At least two loads worth at once; it'll work, and the bitch has it coming.\n\n");
			outputText("\"<i>Let's.  Try.  This.  AGAIN!</i>\" you shout, pulling the two of you back into a sitting position and arching both of your backs.\n\n");
			outputText("Your " + player.cockDescript(x) + " is pressed so firmly against her skin that you can see the cum working its way up and out of your shaft and bloating your goblin toy with only the first shot.  ");
			if (player.cockTotal() > 2) outputText("Your remaining " + player.multiCockDescriptLight() + " blast geysers into the air, coating you both in your spunk.  ");
			if (player.cockTotal() == 2) outputText("Your remaining penis blasts geysers into the air, coating you both with spunk.  ");
			outputText("The same tightness that prevented your cumming the first time now ensures that none of the copious amount of seed you blast into her escapes until you pull out.  It's a good thing your corruption was so effective, as she is beginning to look pregnant enough to hold a beach ball.\n\n");
			outputText("Finally you blow your last wad into this latest piece of ass, shoving her off of your " + player.cockDescript(x) + " and letting her fall to the ground.  The impact sends torrents of cum sluicing out of her.\n\n");
			outputText("You stand and prepare to leave, looking down at the goblin slut you just finished with.\n\n");
			outputText("\"<i>I hope my daughters are a better fuck than their bitch mother,</i>\" you say.  \"<i>Tell'em to find me if they want to get split like a log too.</i>\"");
			outputText("\n\nShe absolutely will.");
			player.orgasm('Dick');
			dynStats("cor", 1);
			combat.cleanupAfterCombat();
		}

//(TOO BIG – pin the bitch to the ground with your cock, coat it in her potions, and make her lick it clean, then blow your load in her mouth, possible cum inflation.)
		private function manRapesGoblinTooBig():void
		{
			clearOutput();
			outputText(images.showImage("goblinelder-win-male-corruptedbj"));
			var x:Number = player.biggestCockIndex();
			spriteSelect(SpriteDb.s_priscilla);
			outputText("You whip out your stiffening maleness, revealing its ");
			if (player.cockArea(x) < 80) outputText("nearly ");
			outputText(" absurd size to your victim.  The goblin-girl's eyes grow to the size of dinner plates in shock as she takes in the view.  Knowing you'll try regardless of the size-mismatch, she removes her spider-silk loincloth, spreads her legs and settles herself more comfortably on the ground.\n\n");
			outputText("You ");
			if (player.cor < 50) outputText("shrug and guess you may as well try since she's ready");
			else outputText("grin, happy to try and stretch her around yourself");
			outputText(".  The ");
			if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flare");
			else outputText("head");
			outputText(" of your " + player.cockDescript(x) + " visibly pulses in excitement as you brush it against her already-slick folds.  She squirms under you, clearly enjoying the feeling of you pushing against her opening.  With painful slowness, you begin pushing forward, feeling her body stretch around your ");
			if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flare");
			else outputText("crown");
			outputText(", but after a moment or two of progress the tiny passage will stretch no more, and you're sure you can't force any more in without hurting her.\n\n");
			outputText("Disgruntled with the tease, you pull out and slide it onto her torso, pinning her underneath your " + player.cockDescript(x) + " and smearing her face and body with her juices.  Her tits squish down enough that her erect little purple nipples barely poke out on each side.  The little slut looks relieved and more than a little turned on.  She licks her lips and speaks happily, \"<i>Thanks hun, I think you would have torn me in half!  Don't worry, I'm more than happy to get soaked with your cum,</i>\" as she wraps her arms and legs around you");
			if (player.hasKnot(0)) outputText(" hooking the heels of her feet just behind your knot");
			outputText(".\n\n");
			outputText("\"<i>She's good at this,</i>\" you muse as she begins grinding underneath you, using her legs to piston her entire body up and down your length, her arms and hands rubbing and caressing you with surprising passion.  The feeling is intense – these goblins know how to please a ");
			if (player.gender == 3) outputText("herm");
			else outputText("man");
			outputText(", that's for sure!  You start dripping with excitement, soaking the goblin's face with an errant drop.  Her smile only broadens when she blinks it away.  A trail of warm wetness licks its way up your tip as the goblin greedily begins to devour your pre, going so far as to lick it from your urethra.  Your " + player.hipDescript() + " twitch, lifting her off the ground as she clings to your member.\n\n");
			outputText("You'd never think such an act would be so enjoyable, but it's just too good.  You lose control, blasting a load of hot seed over the goblin's face.  She sputters and tries to wipe the spunk from her eyes when your next blast hits her square in the forehead, unbalancing the sprightly woman.  She thumps down hard on the ground after losing her grip on your spasming " + player.cockDescript(x) + ".  You step back, dick bobbling in the air as your orgasm finishes, ");
			if (player.cumQ() < 75) outputText("splattering her a few more times with potent seed.  ");
			else if (player.cumQ() < 250) outputText("painting her with a thick layer of seed.  ");
			else outputText("soaking her and leaving her in a thick puddle of seed.  ");
			outputText("The green slut seems to handle it pretty well, even going so far as to scoop up your spunk and rub it into her cunt as she masturbates.  She licks her lips as she watches you redress, a sultry smile on her cum-painted face, \"<i>You tasted as good as I thought stud!  Maybe shrink that bad-boy down and come visit me for a better visit next time ok?  Hopefully by then all this baby batter I'm cramming into my box will give me a nice belly for you to rub!</i>\"\n\n");
			outputText("You shake your head and leave, somewhat drained and relieved by the experience.");
			player.orgasm('Dick');
			combat.cleanupAfterCombat();
		}

//[DUDEGASM]
		private function gobboGetsRapedMaleFits():void
		{
			spriteSelect(SpriteDb.s_priscilla);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.biggestCockIndex();
			clearOutput();
			outputText(images.showImage("goblinelder-win-male-getridden"));
			//(FITS( barley) – Get ridden)
			if (player.cockArea(x) > monster.vaginalCapacity() * .8) {
				outputText("You pick up the defeated goblin, looking her over.  She crosses her arms across her chest pitifully and asks, \"<i>What now?</i>\" with her eyes darting down when she thinks you won't notice.  A grimace temporarily crossing her face at the size of your " + player.cockDescript(x) + ".  You get the idea of giving her more cock than she can handle, remove her spider-silk loincloth, and lower her down towards your " + player.cockDescript(x) + ".  The tip slips between her moist and folds, stretching her and taking some of her weight off your arms.  She winces slightly, wrapping her legs as far around your " + player.hipDescript() + " as possible.\n\n");
				outputText("You start walking, letting your movements work with gravity, allowing you to penetrate her with little difficulty.  Those puffy wet walls clench you tightly as she slides down, ");
				if (player.cocks[0].cockType == CockTypesEnum.DEMON) outputText("rubbing painfully against your demonic nubs");
				else if (player.hasKnot(0)) outputText("stretching painfully around your knot");
				else if (player.cocks[0].cockType == CockTypesEnum.HORSE || player.cocks[0].cockType.Index > 3) outputText("feeling painfully tight around you");
				outputText(".  With each and every step she slides down further, stretching her to capacity, until she sits almost completely impaled on you, grabbing your ");
				if (player.biggestTitSize() >= 1) outputText(player.allBreastsDescript());
				else outputText("torso");
				outputText(" to help support herself.  A steady pulse of motion massages you in time with the green girl's breathing.  You realize just how much of her body must be devoted to accommodating monstrous members, no wonder goblins are so fragile in a fight!\n\n");
				outputText("She pants happily, her tongue rolling free from her mouth as she comments, \"<i>So full.  .  .</i>\" Still wincing from the monster inside her she begins to cheer you on, \"<i>oooh go-ah-faster!  I wanna bounce!</i>\"\n\n");
				outputText("It's all the encouragement you need, and you break into a run, feeling her lithe form bounce on your " + player.cockDescript(x) + ", drawing out a cacophony of cries ranging from happy wails and moans to slight yelps of pain.  Her tiny fists dig into your ");
				if (player.biggestTitSize() >= 1) outputText("tits");
				else outputText("skin");
				outputText(" as she hangs on, clenching and smashing her ample tits against you.  You run hard, feeling her bounce and wriggle as her cunt and rapid breathing squeezing and milking you like you never before.  You're sure if you could feel like this every time you took a jog, you'd be in great shape.\n\n");
				outputText("\"<i>Ooh fuck stud, bounce me!  Yeah just like that,</i>\" she moans, \"<i>Are you gonna cum?  Omigod please cum, I need you to fill me up just like this!</i>\"\n\n");
				outputText("The familiar tightness of a coming orgasm grows in your groin, tightening as you near release.  You pick up the pace, full out sprinting, letting the girl bounce and jiggle as she clings to you, supported entirely by your " + player.cockDescript(x) + ".  ");
				if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " tighten, releasing the seed of your orgasm.  ");
				outputText("The howl of a powerful orgasm fills your ears as your cumming sets off the little green cock-sleeve.  One of her hands lets go, and starts rubbing her belly while she kisses and licks your belly-button.");
				if (player.cumQ() >= 100) outputText(" Your enhanced body easily stuffs her full of cream, pudging her belly out slightly, your seed staying embedded in her womb with nowhere to escape, her cunt plugged tightly with your " + player.cockDescript(x) + ".");
				if (player.cumQ() >= 500) outputText(" The orgasm is so potent that by the time you wind down, she looks to be sporting a pregnancy the size of a medicine ball.  Your cum is trapped inside her, unable to find any gap between her walls and your " + player.cockDescript(x) + ".");
				else if (player.cumQ() >= 250) outputText(" The orgasm is so potent that by the time you wind down, she looks heavily pregnant.  Your cum is unable to find any gap between her walls and your " + player.cockDescript(x) + ".");
				outputText("\n\n");
				outputText("You pant and stop, pulling the stuffed goblin off you and setting her on the ground, smiling in satisfaction as your cum ");
				if (player.cumQ() >= 250) outputText("pours out in a river");
				else outputText("leaks");
				outputText(" from her now-gaping twat.  She rubs her belly and blows you a kiss, still trying to catch her breath.  You smirk and begin redressing.  Once finished, you start walking away, but she calls out one last time to you, \"<i>MMMmm I hope you don't mind if I find you again.  I need more of your baby batter so I can give you lots of beautiful sluts to fuck!</i>\"\n\n");
				if (player.cor > 50) outputText("Chuckling");
				else outputText("Shuddering");
				outputText(", you make your way back to camp, satisfied.");
			}
			//(FITS – Get ridden)
			else {
				outputText("You pick up the defeated goblin, looking her over.  She crosses her arms across her chest pitifully and asks, \"<i>What now?</i>\" with her eyes darting down when she thinks you won't notice.  You muse to yourself 'great minds think alike', remove her spider-silk loincloth, and lower her down towards your " + player.cockDescript(x) + ".  The tip slips between her moist and parted folds, brushing against her entrance and taking some of her weight for you.  She goes cross-eyed and smiles happily, wrapping her legs as far around your " + player.hipDescript() + " as possible.\n\n");
				outputText("You start walking, letting the movements work with gravity to allow you to effortlessly penetrate her.  Those puffy wet walls clench you tightly as she slides down ");
				if (player.cocks[0].cockType == CockTypesEnum.DEMON) outputText("rubbing perfectly against your demonic nubs");
				else if (player.hasKnot(0)) outputText("stretching tightly around your knot");
				else if (player.cocks[0].cockType == CockTypesEnum.HORSE || player.cocks[0].cockType.Index > 3) outputText("feeling absolutely perfect around you");
				outputText(".  With each and every step you take, she slides down further, until she sits fully impaled on you, grabbing your ");
				if (player.biggestTitSize() >= 1) outputText(player.allBreastsDescript());
				else outputText("torso");
				outputText(" to help support herself.  A steady pulse of motion massages you in time with the green girl's breathing, making you realize just how much of her body must be devoted to accommodating monstrous members.\n\n");
				outputText("She pants happily, her tongue rolling free from her mouth as she cheers you on, \"<i>oooh go-ah-faster!  I wanna bounce!</i>\"\n\n");
				outputText("It's all the encouragement you need, and you break into a run, feeling her lithe form bounce on your " + player.cockDescript(x) + ", drawing out a cacophony of happy wails and moans.  Her tiny fists dig into your ");
				if (player.biggestTitSize() >= 1) outputText("tits");
				else outputText("skin");
				outputText(" as she hangs on, clenching and smashing her ample tits against you.  You run hard, feeling her bounce and wriggle as her cunt and rapid breathing begin squeezing and milking you like never before.  You're sure if you could feel like this every time you took a jog, you'd be in great shape.\n\n");
				outputText("\"<i>Ooh fuck stud, bounce me!  Yeah just like that,</i>\" she moans, \"<i>Are you gonna cum?  Omigod please cum, I need you to fill me like this!</i>\"\n\n");
				outputText("The familiar tightness of a coming orgasm grows in your groin, tightening as you near release.  You pick the pace, full out sprinting, letting the girl bounce and jiggle as she clings to you, supported entirely by your " + player.cockDescript(x) + ".  ");
				if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " tighten, releasing the seed of your orgasm.  ");
				outputText("The howl of a powerful orgasm fills your ears as your cumming sets off the little green cock-sleeve.  One of her hands lets go, and starts rubbing her belly while she kisses and licks your belly-button.");
				if (player.cumQ() >= 250) {
					outputText(" Your enhanced body easily stuffs her full of cream, pudging her belly out slightly and dripping down your ");
					if (player.balls > 0) outputText(player.ballsDescriptLight());
					else outputText("legs");
					outputText(".");
				}
				if (player.cumQ() >= 500) outputText(" The orgasm is so potent that by the time you wind down, she looks heavily pregnant and your cum squirts out of any gap it can find between her walls and your " + player.cockDescript(x) + ".");
				outputText("\n\n");
				outputText("You pant and stop, pulling the stuffed goblin off you and setting her on the ground, smiling in satisfaction as your cum ");
				if (player.cumQ() >= 250) outputText("pours out in a river");
				else outputText("leaks");
				outputText(" from her now-gaping twat.  She rubs her belly and blows you a kiss, still trying to catch her breath.  You smirk and begin redressing.  Once finished, you start walking away, but she calls out one last time to you, \"<i>Ummm I hope you don't mind if I find you again.  I need more of your baby batter so I can give you lots of beautiful sluts to fuck!</i>\"\n\n");
				if (player.cor > 50) outputText("Chuckling");
				else outputText("Shuddering");
				outputText(", you make your way back to camp, satisfied.");
			}
			combat.cleanupAfterCombat();
			player.orgasm('Dick');
		}


//Spider goblin condom
		private function goblinCondomed(mode:Number = 0):void
		{
			spriteSelect(SpriteDb.s_priscilla);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			clearOutput();
			outputText(images.showImage("goblinelder-win-male-goblincondomed"));
			outputText("Defeated, the goblin girl's knees give out and she sinks backward, lying on her back with her emerald ankles suspended above her head.  \"<i>Use me,</i>\" she begs, \"<i>humiliate, degrade, and debase me!  Just, whatever you do, fill me!</i>\" As you strip off your " + player.armorName + ", she removes her loincloth and spreads her legs as wide as she can, the wanton girl presenting her drooling pussy to you, puffy green lips already dripping with beads of anxious sweat and eager lubrication.  She wiggles in the dirt, gripping her plump rear with both hands and lifting her ass into the air for you, hopefully.  You can practically feel the heat pouring off the small slut's cum-hungry cunt, her breeding-fever leaving her eyes glassy and unfocused.  Standing over her, it's clear that the only things she's even aware of are the pulsing pussy between her legs and your burgeoning erection.\n\n");

			outputText("Impatiently, she thrusts her legs out and hooks her toes around your lower body, trying to pull you closer while still keeping her needy hole accessible.  Her olive feet clench around your flesh, her soles firm and muscular on your " + player.skinFurScales() + " as she slides up and down the outsides of your " + player.hipDescript() + ".  Dragging her heels across your thighs, the goblin pushes her feet together on either side of your " + player.cockDescript(x) + ", the balls of her jade skin pressing against ");
			if (player.balls > 0) outputText("your throbbing sack");
			else outputText("the base of your shaft");
			outputText(" while her digits curl around your member like thick fingers .  Stroking you slowly at first, the lime-hued girl picks up her tempo and alternates to the soft embrace of the silken skin between her instep and her calf, using the firmness of her ankles to massage your dick to full-mast.  Quivering between her feet, blobs of pre-cum begin to leak from your tip, nearly transparent globules rolling down your glans.  The goblin uses her big toes to gather up the warm fluid reverently, letting it flow between each digit gleefully before spreading it back onto your shaft with firm caresses, kneading the seedless ejaculate into your flesh like oil, her feet glistening like sea-green beryl with your fluid.\n\n");

			outputText("By now, a widening lake of over-stimulated honey has pooled under the lascivious girl.  Moaning lewdly, her fingers still digging into her ass cheeks, you realize the goblin is cumming just from giving you a footjob.  She needs your dick so badly that it's almost pathetic and a wicked idea crosses your mind.  Taking hold of her pre-cum slick feet, you run your fingers along her ejaculate-softened skin, tickling and rubbing her soles until the girl squeals in ecstasy, clenching her eyes shut as her panting desire becomes too much for her to keep her hands away from her cunt any longer.  With a warm splash of overflowing honey, she digs the fingers of her right hand into her verdant slit, her left hand rubbing her jade clit in widening circles so quickly the vibrations jiggle her butt in the mud she's made of the forest floor.  While she's distracted, ");
			if (mode == 0) { //Web condom (spinnerets)
				outputText("you work your spinnerets, the delicate organ weaving a long, thin sheath of finely meshed spider silk, taking care to leave the sticky strands between the inert layers of the flexible condom.  Sliding it over your " + player.cockDescript(x) + ", you marvel at how light it is!  You can even feel the wind's breeze through the silken covering.");
			}
			else { //Latex condom (item)
				player.destroyItems(useables.CONDOM, 1);
				outputText("you tear open the packet and slide the latex condom over your " + player.cockDescript(x) + ", marveling at how transparent and shiny it is.  You don't think the goblin will be able to notice that until it's too late!");
			}
			outputText(" Time to give the goblin what she asked for, if not what she wanted.\n\n");
			
			outputText("Still holding her wriggling feet, you bend down and pull her legs apart as far as you can, muscles stretching almost wider and wider as her inner thighs clench against the tugging.  The added pressure along with her own frantic jilling crests the girl into another orgasm, this time her gushing lube squirting upwards in crystal streams of depraved lust that patter against your abdomen warmly.  Her arms fall at her sides, palms up and fingers twitching, clearing the path for your " + player.cockDescript(x) + " to the quivering green pussy she has so kindly prepared for you.  Pushing against her engorged lips, you find she's so wet that you practically slip right in, her climax-racked muscles spasming irregularly as you fill her with your stiff manhood.  \"<i>Oh yesss, you finally found your cock</i>\" she pants, drool bubbling in her mouth.  \"<i>Pump me like you hate me, you fucker</i>\" she demands and you haul her upward by the ankles, pulling her further onto your pulsing dick, her dribbling cunny sucking at your shaft as her deep green inner folds part before your thrusting length.  \"<i>I'm not a glass doll, you pussy, just fucking jam it in!</i>\" she screams, fingers clawing at the ground as she bucks upward to get more of you inside her.\n\n");

			outputText("The mouthy bitch apparently forgot who lost the fight, it seems, so you decide to remind her.  Using her legs like a lever, you twist her around on your dick, spinning her 180 degrees, leaving her lying on her tits, her ass jutting up as you slam your cock the rest of the way into the olive-skinned nympho.  She grunts and starts to say something else, but you push forward and grind her face into the mud before she can get it out, her mouth filling with her own lubrication-soaked dirt with an ecstatic gurgle.  Her legs fight against your grip, jerking this way and that, her slick feet nearly slipping out of your hands.  You grit your teeth and begin screwing her slavering twat as hard as you can, eager to tame the thrashing cunt of a girl.  Slamming her sweat-soaked thighs against your " + player.hipDescript() + ", your thrusts become almost savage, bringing a deep flush to her backside as you slap her snatch against your groin, the secret condom working perfectly, as thin as skin on your " + player.cockDescript(x) + ".\n\n");

			outputText("Squirming right-side up, covered in sweat and mud, the emerald girl's face screws into an expression of confusion as she pokes at the bulge of her abdomen.  \"<i>What...  that doesn't feel right,</i>\" she mumbles, pushing at her skin with both hands.  Checking her cunny with a long, middle finger, she pulls it out clean, devoid of the ivory cream she expected.  \"<i>The fuck?  A condom?</i>\" she screeches.  \"<i>You bastard!</i>\" Pushing at her belly with increasingly frantic motions, her mouth gapes when the seed-loaded balloon bounces right back, still intact.  \"<i>Why won't it burst?</i>\" she demands.  ");
			if (mode == 0) {
				outputText("You politely inform her that spider silk is terribly strong and oh so sticky.  Reaching her fingers into her slit, she tries to pull it out and gasps at the feeling of her inner walls being pulled by the clinging webbing.  Despite her best effort, the silk bubble stays right where you left it, snugly glued in place by your binding webbing.  You laugh and wish her luck trying to get it out as you gather your clothes and walk away.  So full of cum and yet unable to get any of it into her womb, the goblin girl moans helplessly, fingering herself in desperation, as if her orgasm could dislodge the treasure you've left inside of her.");
			}
			else {
				outputText("You politely inform her that latex is strong and effective at preventing pregnancy.  You laugh and wish her luck trying to get it out as you gather your clothes and walk away.  So full of cum and yet unable to get any of it into her womb, the goblin girl moans helplessly, fingering herself in desperation, as if her orgasm could dislodge the treasure you've left inside of her.");				
			}

			player.orgasm('Dick');
			combat.cleanupAfterCombat();
		}

//REQUIRES: AT LEAST ONE DICK AND A COPY OF ATLAS SHRUGGED - MUST NOT BE MONSTROUSLY HUGE
		private function gatsGoblinBoners():void
		{
			clearOutput();
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = player.smallestCockIndex();
			outputText(images.showImage("goblinelder-win-male-goblinboners"));
			if (kGAMECLASS.inCombat) {
				outputText("The goblin lies strewn across the ground upon her stomach, exhausted from the battle.  Her plump legs are unintentionally spread open while her ass pokes up into the air, giving you a clear view of her wet pussy as she tries to get herself off.  It seems as if the green-skinned slut has already forgotten about you - too many fruitless encounters might've caused her to give up hope on finding a virile specimen to pump her full of cum.\n\n");

				outputText("Luckily for her, you have every intention of changing that.\n\n");
				
				outputText("You begin to fondle your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" as you walk towards the unsuspecting goblin girl, taking in the sight of her perfectly round cheeks as they jiggle against her hurried movements, her soft thighs clenched against the eager hand between them.  Bending down, you quickly grab the goblin's ample hips, causing the girl to squeak in surprise as she turns around to catch the sight of your erect length");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".\n\n");

				outputText("\"<i>W-woah!  Hey stud, whaddya think you're doing back there?</i>\" she yelps, more surprised than scared at your sudden appearance.  Instead of answering, you decide to grab your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" and slap ");
				if (player.cockTotal() == 1) outputText("it");
				else outputText("them");
				outputText(" against the bare flesh of her ass, whilst your victim anxiously awaits your next move.  You take your time massaging the goblin's slutty ass with your bare hands before sliding your " + player.cockDescript(x) + " in between her soft cheeks.  Your horny victim appears impatient, attempting to grind against you as she spreads her moist lips open, enthusiastic that she's found someone willing to mate with her.  You slap her ass firmly as you quicken your thrusting - seconds before finally plunging ");
				if (player.cockTotal() == 1) outputText("your dick inside of the panting whore, pushing her forwards violently as you enter her tight snatch");
				else if (player.cockTotal() == 2) outputText("both of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole");
				else {
					outputText("two of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole - your other cock");
					if (player.cockTotal() >= 4) outputText("s");
					outputText(" remaining sandwiched in between her asscheeks");
				}
				outputText(".\n\n");

				outputText("You roughly pound against the goblin girl, maintaining a firm grip on her hips while she squeals with delight.  The sound of your groin slapping against her echoes throughout the area, followed by your grunting and the goblin's moans of ecstasy.  Your victim struggles to lift herself up by her arms, only to collapse back down from the feeling of you invading her insides.\n\n");

				outputText("Eventually you begin to feel yourself coming to a climax, your movements getting faster and faster as you build up to your release.  The goblin below you has already lost herself to the pleasure of your " + player.cockDescript(x) + ", her eyes rolled upwards and her tongue drooling out of her mouth while her slutty face rubs against the ground you're currently pounding her on.  With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance");
				if (player.cockTotal() == 2) outputText("s");
				outputText(".  You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed.\n\n");

				outputText("You pick yourself back up, jerking yourself slowly as cum dribbles from your " + player.cockDescript(x) + " onto the collapsed body of the goblin.  It'll be awhile before she comes back to consciousness, but you're certain she'll have a better appreciation for sex when she does.");
			}
			else { //Initiated from [Fuck Her] when meeting her.
				outputText("You tell the goblin that you're here to fuck.  Her ears perk up in excitement.  She removes her spider-silk loincloth, exposing her cooter, and jiggles her ass-cheeks as if she's inviting you.  She doesn't even bother removing her armor but that doesn't matter to you.  " + player.clothedOrNakedLower("You open up your [armorname]" + ((player.armor.name != "nothing" && player.lowerGarment.name != "nothing") ?  " and [lowergarment]" : "") + ", revealing your [cocks].", "") + " ");
				
				outputText("You begin to fondle your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" as you walk towards the goblin girl, taking in the sight of her perfectly round cheeks as they jiggle against her movements, her soft thighs clenched against the eager hand between them.  Bending down, you grab the goblin's ample hips, causing the girl to squeak in excitement as she turns around to catch the sight of your erect length");
				if (player.cockTotal() > 1) outputText("s");
				outputText(".\n\n");

				outputText("\"<i>W-woah!  Hey stud, fuck me already!</i>\" she yelps, more surprised than excited at your sudden appearance.  Instead of answering, you decide to grab your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" and slap ");
				if (player.cockTotal() == 1) outputText("it");
				else outputText("them");
				outputText(" against the bare flesh of her ass, whilst your victim anxiously awaits your next move.  You take your time massaging the goblin's slutty ass with your bare hands before sliding your " + player.cockDescript(x) + " in between her soft cheeks.  Your horny partner appears impatient, attempting to grind against you as she spreads her moist lips open, enthusiastic that she's found someone willing to mate with her.  You slap her ass firmly as you quicken your thrusting - seconds before finally plunging ");
				if (player.cockTotal() == 1) outputText("your dick inside of the panting whore, pushing her forwards violently as you enter her tight snatch");
				else if (player.cockTotal() == 2) outputText("both of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole");
				else {
					outputText("two of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole - your other cock");
					if (player.cockTotal() >= 4) outputText("s");
					outputText(" remaining sandwiched in between her asscheeks");
				}
				outputText(".\n\n");

				outputText("You pound against the goblin elder, maintaining a firm grip on her hips while she squeals with delight.  The sound of your groin slapping against her echoes throughout the area, followed by your grunting and the goblin's moans of ecstasy.  Your sex-partner struggles to lift herself up by her arms, only to collapse back down from the feeling of you invading her insides.\n\n");

				outputText("Eventually you begin to feel yourself coming to a climax, your movements getting faster and faster as you build up to your release.  The goblin below you has already lost herself to the pleasure of your " + player.cockDescript(x) + ", her eyes rolled upwards and her tongue drooling out of her mouth while her slutty face rubs against the ground you're currently pounding her on.  With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance");
				if (player.cockTotal() == 2) outputText("s");
				outputText(".  You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed.\n\n");

				outputText("You pick yourself back up, jerking yourself slowly as cum dribbles from your " + player.cockDescript(x) + " onto the collapsed body of the goblin.  The goblin gets up, wobbling from the ordeal.  \"<i>Thanks for the seed, stud!  I'll have new goblins to teach,</i>\" she says.");

			}

			player.orgasm('Dick');
			combat.cleanupAfterCombat();
		}

		private function laySomeDriderEggsInGobboTwat():void
		{
			clearOutput();
			outputText(images.showImage("goblinelder-win-drider-egged"));
			//Play standard goblin victory text
			outputText("The pitiful struggling of the little green-skinned creature as she tries to scramble away from you gives you a rather generous view of her drooling box.  While you feel yourself ");
			if (player.hasCock()) outputText("harden");
			else if (player.hasVagina()) outputText("moisten");
			else outputText("twitch");
			outputText(" slightly, you can't help but register the growing weight of your spider half.  Looking down at the goblin again, you decide that maybe you can both get something...  <i>similar</i> to what you want.");

			outputText("\n\nYou quickly undress and skitter over to the sniffling slut, reaching down to pull her up and turning her to face you as you do.  Looping one arm under her armpits, you prod at her soft stomach with your free hand, inquiring about the state of her children.");

			//[if (femininity > 50)
			if (player.femininity > 50) outputText("\n\n\"<i>W-what?  You- I haven't got any, you stupid bitch!  This your idea of fun, jackass?  Kicking people when they're down?!</i>\"");
			//[if (femininity < 51) 
			else outputText("\n\n\"<i>W-what?  You- I haven't got any, you stupid bastard!  This your idea of fun, jackass?  Kicking people when they're down?!</i>\"");
			outputText(" She lashes out with her feet, but there's no strength behind it, and her pout deepens as tears begin to gather at the corners of her eyes.");

			outputText("\n\n\"<i>Lemme go, lemme go!</i>\" She squirms around, and you slip your other hand under her arm to help restrain her.  You hold her out further from you as you begin to curl your spider abdomen underneath yourself.  Already, you can see your egg-chute poking free of your carapace, twitching in time with your heartbeat, drooling green lube all over your undercarriage.");

			outputText("\n\nYour goblin plaything has fallen silent, staring at the thickening rod between your many legs.");

			outputText("\n\n\"<i>What?  What is that?  What's it for?</i>\" Her nervous tone does nothing to conceal the interest sliding down her thighs.  You pull her closer, holding her just above your ovipositor, and kiss her on her forehead, promising her all the children she could ever dream of.  Her conflicted smile and heavy panting makes your heart beat just a little faster, and any reply is cut off as you impale the purpled-haired woman on your slippery shaft.");

			outputText("\n\nStifled gasps and grunts escape her lips as you work her up and down like a living sex toy, stuffing as much of yourself into as you can.  A deep blush spreads across your goblin whore's face; one of her hands twists and pulls at her nipple as she bites down on her lip while her free hand massages excitedly at the bulge you make with every thrust.  Your carapace is slick with a mixture of her juices and the slow leak of your arachnid egg lube.");

			outputText("\n\nYou finally bottom out, working the green cum-sleeve all the way down as you feel your thickness brush against her cervix.  You slide your hands out from under her arms and reposition them on her shoulders, pinning her in place for what's about to come.  Her stomach pushes out slightly when the first wave of lube forces its way inside her and she gasps in bliss, rubbing her hands across her 'pregnancy'.  Your own smile grows wider as you feel your bottom half clench and shiver, as the first of many eggs forces its way up your ovipositor.");

			outputText("\n\nYou feel its slow path up into the goblin, your egg-tube flaring out around it, until it stops just short of her womb's entrance.  She looks up from her stomach, her wide-eyed stare meeting yours for only a second before a powerful spasm forces the egg past her clenched cervix.  The miniature whore convulses, her eyes rolling back, tongue lolling as she cums hard, a torrent of girlcum spraying across your chitin.");
			if (player.hasCock()) {
				outputText(" Your own orgasm is just as strong, [eachCock] spraying powerfully across your torso");
				if (player.hasVagina()) outputText("and y");
			}
			else if (player.hasVagina()) outputText(" Y");
			if (player.hasVagina()) outputText("our [vagina] clenching in time with hers as your copious fluids drench your spider half.");

			outputText("\n\nThen the next egg rolls forward, and the next, and the next...");

			outputText("\n\nYou keep her pinned against your body as you fill her up, one orb at a time, each sphere bloating her stretched stomach a little further, until she's so full you can feel your eggs through the taut skin of her belly.  The goblin is nearly unconscious, insensibly gurgling as the pleasure of her instant pregnancy numbs her mind.  You pull her off with a loud wet plop, her twitching snatch leaking an unending stream of her own clear fluids as well as a sticky string of your green egg-mucus.");

			outputText("\n\nLaying her down in the shade, you put your clothes back on, glad to be free of the extra weight and ready to continue your adventure.");
			player.dumpEggs();
			player.orgasm('Ovi');
			combat.cleanupAfterCombat();
		}

		private function talkToGoblinElder():void {
			clearOutput();
			outputText("You ask the goblin if she wouldn't mind talking.  ");
			if (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] == 0) {
				outputText("What is she anyway?  How is she unusual from the other goblins?  Of all the goblins you've seen, she isn't as sexually inclined.");
				outputText("\n\n\"<i>Of course.  My name is Priscilla and I've travelled a lot and I have slain a lot of imps, hellhounds, and minotaurs.  The demons must pay for the damage caused to my race and I worked hard to keep my mind off constant sexual desires.  I gave birth to hundreds of goblins but I keep my boobs normal with Reducto.  I still have unfinished business,</i>\" she says.");
				outputText("\n\nWhat are her current goals then?");
				outputText("\n\n\"<i>I'm seeking out someone who's not corrupt so I can give birth to less-tainted goblin.  My tribe is isolated from the corrupted Goblin societies and I tried to brew a purifying potion but to no avail" + (flags[kFLAGS.LETHICE_DEFEATED] > 0 ?  ".  I did hear the news that you have defeated Lethice.  You're my saviour and I'll be forever grateful at you for causing a major blow against the demons" : "") + ",</i>\" the goblin says.");
			}
			else if (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] == 1) {
				outputText("Where did she originally came from?  How did she escape corruption?");
				outputText("\n\n\"<i>I came from the old goblin city.  Before the demons came, we were the technological leaders.  When the demons came, they offer us a treaty guaranteeing the peace and safety.  But they lied and they corrupted the water supply.  I knew there was something wrong with the water supply so I escaped and hid in the Deepwoods, where no demons would find me.</i>\"");
			}
			outputText("\n\nYou thank the goblin for telling you and wave her off.");
			flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
		}

		private function startffaction():void {
			clearOutput();
			if (flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER] == 0) {
				outputText("You smile seductively and ask aloud if Priscilla wouldn’t mind keeping you company even without a dick.  Priscilla’s ear twitches at this, but to your surprise she frowns, and waits a moment before responding.\n\n");
				outputText("\"<i>I’m sure you don’t get told ‘no’ often, but I don’t fuck just for the fun of it.</i>\"  Priscilla started.  \"<i>Everything I do is to restore my people, so if you don’t have a penis, you’re just wasting my time.</i>\"\n\n");
				outputText("You start to protest, but Priscilla had already started walking away-you try to think about what she said, but you find yourself glued the sway of her thighs in that tight spider-silk loincloth-you’re parched, and not from a lack of water.  But unless you have a dick, she’s not interested.  Maybe you should just forget about her?  ");
				menu();
				addButton(0, "Yes", camp.returnToCampUseOneHour);
				addButton(1, "No", flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER]++);
			}
			else if (flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER] == 1) {
				outputText("As you walk, exploring for new places and potential opponents, you see Priscilla, and she doesn’t look too good.  Her sword is embedded into the skull of a recently deceased imp overlord, and her bone armor is strewn everywhere in pieces.  As for Priscilla herself, she’s not beaten up too bad, but she’s leaning up against a stump, spasming violently and moaning lewdly as she squeezes her breasts.  Looking back towards the imp, you see in his hands were a vial dripping a pink liquid, and a succubi whip.  It’s obvious now what the imp tried to do, and Priscilla is suffering from that attack.  What do you do?  ");
				menu();
				addButton(0, "Check", checkonher);
				addButton(1, "Leave", leaveher);
			}
			else if (flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER] == 2) {
				outputText("\"<i>Hey you...</i>\"  Priscilla says awkwardly.  You smile and walk towards her.  She looks at the ground, a bit embarrassed.  \"<i>The other day you saw me at a weak moment, and I wasn’t myself.  I drove you away when you tried to help me, and I’m...s...s...I was a fucking bitch.</i>\" Priscilla finally says.  You mention it’s no problem, and that you’re happy to help out a friend.  Hearing that word brings Priscilla to look into your eyes again.\n\n");
				outputText("\"<i>Friend?  I don’t think I’ve had a friend since the demons attacked.</i>\"  Priscilla says.  \"<i>And...me and my girlfriends, we used to get into all kinds of... fun.  Priscilla says, the way she says it, with the slight grin on her face and blush on her cheeks, give you an idea of what kind of fun she and her goblin girls were into.  And I do owe you for the (lust reducing item) So...friend, ready for some fun?</i>\" You eagerly nod.  ");
				doNext(scissorscene);
			}
		}

		private function checkonher():void {
			clearOutput();
			outputText("You walk out of where you were hidden.  Priscilla didn’t even notice you until you cleared your throat while in front of her.  Before you could ask what you could do to help, Priscilla started an angry verbal assault: \"<i>Damn you you’re worst than vultures!  What, now that I’m weak and horny you think you can take advantage of me?  Get out of here dyke!</i>\"  She yells at you with all of her strength as she covers her breasts, and tries to stifle her gasps as even covering her melons made her almost cum.\n\n");
			outputText("How rude.  You only had best intentions for the goblin elder but screw that now.  You could just leave her to stew in her wet sticky bitterness.  A dark thought then enters your head-she is in no shape to fight back, you could teach her a lesson in respecting others.  Or better yet, its obvious she has you on her mind, which is why she on the defensive when she’s her most horny.  Why not give her a show?  "); 
			outputText("But then again she looks awful, and is only trying to protect herself the only way she knows how...  \n\n");
			if (player.hasItem(consumables.PURHONY, 1) || player.hasItem(consumables.P_PEARL, 1) || player.hasItem(consumables.PPHILTR, 1)) outputText("and you just happen to have the right item.  Should you give it to her?  ");
			menu();
			if (player.hasItem(consumables.PURHONY, 1) || player.hasItem(consumables.P_PEARL, 1) || player.hasItem(consumables.PPHILTR, 1)) addButton(0, "Help", helpher);
			else addDisabledButton(0, "Help", "This requires a special Item.", "Help");
			addButton(1, "Seduce", seduceher);
			addButton(2, "Rape", gobboGetsRapedFem);
			addButton(4, "Leave", leaveher2);
		}
		
		private function helpher():void {
			clearOutput();
			flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER]++;
			outputText("You take out your vial, and hold it out in front of Priscilla, she glances at it, then at you.\n\n");
			outputText("\"<i>You think I need your charity!</i>\"  Priscilla whispers, beads of sweat forming on her forehead.  \"<i>Who the hell do you think I am, you bitch?!</i>\"  It’s obvious she won’t listen to reason, but you’re not going to force the issue-you place the (lust reducing item) on the ground slowly, back up a meter, and walk away towards camp.  Before you left the area completely you look behind you.  Priscilla as well as the (lust reducing item) is gone.  ");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function leaveher():void {
			clearOutput();
			outputText("Hey, she’s a big girl, this can’t be the first time she got drugged, she’ll be fine.  Pushing Priscilla out of your mind, you head back to camp ");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function leaveher2():void {
			clearOutput();
			outputText("Without even a backwards glance, you step away from Priscilla and head back to camp, ignoring the choking sobs as you left the clearing.  ");
			doNext(camp.returnToCampUseOneHour);
		}

		private function seduceher():void {
			clearOutput();
			outputText("\"<i>No, I’m not going anywhere.</i>\" You say with a smile, as you strip out of your " + player.armorName + ", as slowly and shamelessly as possible, starting off with the top, jiggling your " + player.breastDescript(0) + " from side to side.  Priscilla pretended she didn’t care, but her eyes reflected the lust as she honed in on your " + player.nippleDescript(0) + " and started to lap up some spittle from her wide open mouth.\n\n");
			outputText("\"<i>S-stop!</i>\"  Priscilla moans, trying to reach for her weapon, or a means to escape, but you just continued.  Next was your bottoms.  As you discarded that portion of your " + player.armorName + " you squat right in front of Priscilla, giving her a full view of your pink, bare, pussy.  As you raised a hand towards Priscilla, she gasped as she unconsciously started to squeeze her breasts again.  No!  Don’t touch me, or Marae help me- but her words died as she saw you take the index finger of that hand, and thrust it along with your middle finger, into your happy hole.  You moan sensually, and slowly thrust your fingers farther and deeper, a wave of arousal wafts the air.  Priscilla is fidgeting now, the hem of her loincloth she’s ready to throw away.  You decide now is the time for the coup de grâce:\n\n");
			outputText("You stop playing with yourself and you turn around, showing your " + player.assDescript() + " to Priscilla, whose breath quickens, and a bright green flush enters her cheeks, and she breaks out in a cold sweat.  You lift your " + player.assDescript() + " into the air, and start shaking it up down and around in front of Priscilla, the smell of your arousal wafting through thunderous intense clapping is all she notices.  As you start bouncing faster, you look behind yourself, enjoying the sight of Priscilla’s walls finally breaking, as she tears off her spider-silk loincloth and throws it aside, and plunges two of her fingers right into her slop hungry vagina, exalting a crushing wail of her defeat, but she no longer cares, as with an inhuman pace, she attacks her clit and vagina, rubbing them for dear life.  You bounce faster and faster, wiggling your perfect " + player.assDescript() + " for Priscilla, who has finally reached the throes of passion.\n\n");
			outputText("With a cry, Priscilla arches her back as she cums, a tangy sour flow of juices squirts out of her pussy, all over your back and ass.  You blush at the thought of another woman cumming on you, and realize your mets haven’t been made yet.  You turn around expecting Priscilla to fly into your arms, but you see she has passed out.  Like a ditz You’re remember that Priscilla was drugged, and now that she came, she’s not going to be receptive.  Accepting your defeat this time, you walk back to camp, but not before placing Priscilla’s sword within reach of her.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}

		private function scissorscene():void {
			clearOutput();
			flags[kFLAGS.GOBLIN_ELDER_RELATION_COUNTER]++;
			outputText("Eagerly, Priscilla went towards her supplies, rummages through her bag, and throws you a vial.  Inside was a purple highly viscous liquid.  \"<i>Rub it on your pussy.</i>\"  Priscilla said, walking back towards you.  The liquid was cold told to the touch, especially when you massaged it on your vagina.  You pass the vial back to Pricilla, who sat down and applied to liquid to herself.  As you watched Priscila, you felt a heat slowly coming from your nether region.  You bit your lip as the heat started to burn, and could literally feel all your blood moving towards your pussy, until it’s engorged and puffy-It didn’t hurt, but you definitely wished for the burning to extinguish.\n\n");
			outputText("\"<i>Alright, I’m ready.</i>\"  Priscilla moans, watching you with a smile.  \"<i>You feel that heat?  Don’t worry baby, that’s supposed to happen.  Now come here, there’s only way to make it stop.</i>\"  Priscilla opens her legs and waits on you.  You quickly move on to Priscilla, putting one of your legs under Priscilla’s and the other above Priscilla’s legs, and the two of you lean back, to now that you are both pussy to pussy.  Priscilla reaches a hand towards you - you grab hers, and when you do so, Priscilla pulls you towards her so that with a clap, your swollen pussies smack into each other.\n\n");
			outputText("It felt like electricity shooting through you.  You gasp in shock, in contrast to Priscilla’s sweet moans, and the two of you slam each other again and again.  First it was slow, but you and Priscilla go faster and faster, until All is heard is pussy clapping and feminine squeals of joys as you slide and gyrate between each other.  It was so hot.  The burning, the heat was intense.  You mash against each other, shuddering as you and Priscilla bump and clap, your asses and tittiess jiggling with sweat.  ");
			if (player.hasCock()) outputText("Your " + player.cockDescript(0) + " flops noisily on you and Priscilla, smearing and shooting pre everywhere.  ");
			outputText("In desperation Priscilla takes her other hand and grabs your outstretched hand, and jerks you hard enough that you are now looking at each other face to face, panting in each others face, inching closer and closer.  Priscilla breaks first, thrusting her tongue into your mouth, at which you happily accommodate.  You suck on her tongue, the sour smell of her pussy and sour taste of her mouth was everyone in your senses.  Your pussies have long stop bumping into each other, and it seemed as you two were conjoined by the crotch, as all that was happening was grinding.\n\n");
			outputText("\"<i>I'm going to cum, fucking bitch I'm gonna cum!</i>\"  Priscilla grunts, as she breaks the kiss and pulls into your neck, kissing it.  Unable to stop the heat, you grab Priscilla body from her ass and push her into your twat.  She bites into your neck as she starts thrusting into you as if she had a cock and was getting ready to give you a sloppy finish.  You fall back, gasping and grunting, with Priscilla, now slave to lust, on top of you, bashing your pussy like crazy, her face twisting into an uncontrollable whore.  You can barely move as you took the assault as you screamed, your pussy contracting and shaking as you squirted all over Priscilla's sopping pussy, who herself can no longer hold back.  Grabbing your breasts to prop herself");
			if (player.hasCock()) outputText("and your " + player.cockDescript(0) + " jerking you as hard as she could");
			outputText(", she thrust into you one last time, before with a shriek her fluids gushed all over your pussy and onto the ground.  You moan under Priscilla, the burning finally put out by her fire-fighting.  Priscilla holds the position arching above you shaking slowly for what felt like an eternity before looking at you with a smile on your face.\n\n");
			outputText("\"<i>Almost as good as cock, right?</i>\"  Priscilla said.  You're only response was pulling Priscilla into a passionate kiss, before the two of you cuddled on the ground, enjoying the closeness and warmth between you two.  After almost an hour, the two of you got up and got dressed and left, but not before kissing each other fully one last time, and promising to meet up again real soon.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}

		private function startforeplay():void {
			clearOutput();
			if (player.hasCock() && player.hasVagina()) {
				if (flags[kFLAGS.GOBLIN_ELDER_FOREPLAY_COUNTER] == 0) {
					outputText("\"<i>I thought we understood each other.</i>\" Priscilla pouts.  \"<i>I need daughters, I need to restore Goblins to their rightful place!  Pussy eating doesn’t help me one bit!</i>\" She starts to walk away, but You remind her ");
					if (flags[kFLAGS.TIMES_ENCOUNTERED_GOBLIN_ELDER] <= 2) outputText("that dicks like yours are scarce these days");
					else outputText(" though that swallowing all of your spunk and taking it in the ass doesn’t help her people either");
					outputText(", which causes her to stop in her tracks.  Grabbing her by the waist and turning her around you tell her that if she does a good job lezzing out, you’ll be forever grateful.  She sighs at this, but a sly grin grows on her face as you start detailing a vision of you paying your gratefulness by breeding her another 100 daughters, and she’s game.  ");
					flags[kFLAGS.GOBLIN_ELDER_FOREPLAY_COUNTER]++;
				}
				else {
					outputText("You tell Priscilla you’re here to lez out.  A big, wide grin grows on her face as she starts to shed out of her spider silk loincloth and bone armor, watching you intently as you strip off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands dart towards her breasts, kneading them slowly as you walk towards her, fondling your " + player.cockDescript(0) + " at the sight of her exotic body.  You lick your lips at the sight of the goblin, and ");
					if (player.tallness >= 60) outputText("kneel down and scoop Priscilla into your arms for a kiss.  ");
					else outputText("pull Priscilla into a kiss.  "); 
					outputText("She thrusts her sour tasting tongue into your mouth as soon as your lips touched, and one of her hands reach towards your breasts, and the other, to your pussy.  You moan as her fingers plunge into you making a sloppy sound.  You break the kiss and start kissing on Priscilla’s neck slowly, and while she paws at your tits, and finger-fuck your pussy, you grip her side with one of your hands, and with your other hand you reach towards her firm but jiggable butt, and you take your middle finger and prod her asshole, before going inside.  Her hole was springy and stretched to accommodate you, and you felt your knees shake as Priscilla cried out, sounding almost orgasmic, as wave a pleasure came over her.  her hands grabbing your " + player.cockDescript(0) + " and started rubbing you as rough as you're treating her hole.\n\n");
					outputText("\"<i>Yes finger my ass!</i>\"  Priscilla squeals as she simutanously jerks and fingerfuck you.  You find the dual attack too much and you start shooting out your spunk, spraying Priscilla on her thighs, her shaved pussy mound, her stomach, and breasts.  You ignored Priscilla's look of disappointment however, you told her cock wasn’t on the menu today after all.\n\n");
					outputText("\"<i>Yeah...we're definitely focusing on vag today.</i>\"  Priscilla muttered, as she brought a bit of your spooge to her lips, a smile appears as she moans at the taste.  ");
					if (player.cumQ() >= 750) outputText("\"<i>Think you can help me out stud?</i>\"  Getting on your knees, you start lapping up your cum, trying not to swallow too much, cleaning Priscilla's body from wherever she was stained.  The taste of the minotaur and imp blood she stains herself with was sweet, tangy, yet bitter, in contrast with her oily, sour skin.  She moaned as she dined on your seed trapped in her breasts, as your tongue slurped and glided up and down her body, fighting every urge to locate all of your work between her legs.  When you were finished, you pulled Priscilla into another kiss, depositing the remaining amounts of your sticky cream that you didn't swallow as you cleaned Priscilla.  \"<i>Thank you.</i>\"  Priscilla said, licking her lips and savoring the taste.\n\n");
					outputText("Placing her hands on your now softened " + player.cockDescript(0) + " as she looked up at you.  \"<i>Now let’s get down to business.</i>\"  Her hands move from your " + player.cockDescript(0) + " to your sides.  \"<i>I’m following your lead on this one.  How do you want me?</i>\"  ");
				}
				menu();
				addButton(0, "Scissor", scissorscene);
				addButton(1, "3some", unleashthekraken);
				addButton(2, "Wrestle", wrestle);
				addButton(3, "Pri.  Dom.", priscilladom);
			}
			if (player.hasCock()) {
				if (flags[kFLAGS.GOBLIN_ELDER_FOREPLAY_COUNTER] == 0) {
					outputText("You tell Priscilla you’re here to fuck.  A big, wide grin grows on her face as she starts to shed out of her spider silk loincloth and bone armor, watching you intently as you strip off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands dart towards her breasts, kneading them slowly as you walk towards her, fondling your " + player.cockDescript(0) + " at the sight of her exotic body.  Her ears perk up in excitement as she sees your " + player.cockDescript(0) + ", now completely hardened, reach its fully erect size of " + num2Text(Math.round(player.cocks[0].cockLength)) + ".  Priscilla starts to seductively sway her body towards you, her ample hips and round ass cheeks jiggling slightly, as her fingers thread from her breasts to her soft thighs.\n\n");
					if (player.tallness >= 60) outputText("You kneel down and scoop Priscilla into your arms for a kiss");
					else outputText("You pull Priscilla into a kiss"); 
					outputText(", halfway expecting her to instantly swoon, but as soon as your lips touch, you find her foreign tongue swimming in your mouth; A sour taste overcomes your senses.  You suppress a moan as her tongue glides along your own, her hands grabbing your " + player.cockDescript(0) + " firmly as one of your hands grabs a firm breast (so soft!), and the other, reaching towards the small of Priscilla’s back before gripping the cheeks of her soft ass (so firm!).  Feeling your hands invade her skin, Priscilla breaks the kiss and leans in towards your neck, placing butterfly kisses as she traced your collarbone with her lips, fervently jerking your " + player.cockDescript(0) + " upon her shaved yellow green mound, daring you to soak her blood-stained body with your fresh seed.  You squeeze Priscilla’s peach bottom even harder and attack her nipple, pinching and pulling it hard enough to elicit a sharp gasp from the goblin.  With a chuckle, Priscilla pushes away from you, breaking your hold on her thighs, and before you could even react, she shoves you onto ground quite easily (so strong!).  \n\n");
					outputText("\"<i>Naughty boy...</i>\"  Priscilla purrs, placing her hands on your knees with an ardent gleam in her eye, and a slight drool slithering away from her bottom lip.  \"<i>No more foreplay – it’s fuck time.</i>\"  She puts up a tough front as if she’s dominating you, but even now she awaits on you to take charge – how do you want her?");
					flags[kFLAGS.GOBLIN_ELDER_FOREPLAY_COUNTER]++;
				}
				else {
					outputText("You tell Priscilla there’s a thick, creamy load with her name on it, and her spider silk loincloth had already been discarded onto the ground.  She didn’t even take off the rest of her armor as she sat down, spread her legs, and started fingering her pussy and squeezing her breasts.  As you walked towards her fully free from your " + player.armorName + ", you stroke your " + player.cockDescript(0) + " to her, finding amusement as Priscilla starts rubbing her wet slit at breakneck speed as she watches your " + player.cockDescript(0) + " harden, her gasps quickening and her skin blushing a bright shade of green as a bit of pre-cum oozes out of your rod.  By the time you’re fully erect she howls loudly as she arches her back, squirting her juices all over the ground.  The sour fragrance is in the air again.\n\n");
					outputText("You pick Priscilla up gently and doesn’t bother lifting her off the ground before you pull her in for a forceful kiss, shoving your tongue into her mouth, and it’s almost a test of wills once again.  As before, the intoxicating, seemingly drugged taste of her tongue fights and swims with yours; you literally tear Priscilla’s bone armor off of her as you grab a breast and her ass, gripping and pinching to stay in control of this \"<i>battle.</i>\" Priscilla’s hands roam towards your own nipples in response and twists and squeezes them with a level of strength that definitely would leave you bruised.  When you yelp, you release Priscilla, who continues her attack by pushing you to ground, quite easily once again.\n\n");
					showStatDown('tou');
					player.tou -= 1;
					outputText("\"<i>Alright stud, no more games, I have places to go, demons to kill...</i>\"  Priscilla starts, placing her hands on your knees with a fierce stare in her eye, and a ravenous smile on her lips.  \"<i>...Champions to fuck, babies to make.</i>\"  Of course, as a goblin, she has a one-track mind, but you know Priscilla - procreation is necessary, but she likes your seed in other places too - how are you going to give it to her?  ");
				}
				menu();
				addButton(0, "Pussy", pussyfuck);
				addButton(1, "Ass", assfuck);
				addButton(2, "Mouth", mouthfuck);
			}
			if (player.hasVagina()) {
				if (flags[kFLAGS.GOBLIN_ELDER_FOREPLAY_COUNTER] == 0) {
					outputText("You tell Priscilla you’re here for some cunt.  She smiles a toothy grin as she starts to shed out of her spidersilk loincloth and bone armor, watching you intently as you stripped off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands went towards her breasts, kneading them slowly as you walked towards her.  You licked your lips at the sight of the goblin, and ");
					if (player.tallness >= 60) outputText("kneel down and scoop Priscilla into your arms for a kiss.  ");
					else outputText("pull Priscilla into a kiss.  ");
					outputText("She thrusts her sour-tasting tongue into your mouth as soon as your lips touched, and one of her hands reach towards your breasts, and the other, to your pussy.  You moan as her fingers plunge into you making a sloppy sound.  You breaks the kiss and start kissing on Priscilla’s neck slowly, and while she paws at your tits, and finger-fuck your pussy, you grip her side with one of your hands, and with your other hand you reach towards her firm but jiggable butt, and you take your middle finger and prod her asshole, before going inside.  Her hole was springy and stretched to accommodate you, and you felt your knees shake as Priscilla cried out, sounding almost orgasmic, as wave a pleasure came over her-then with her cavity muscles, she pushes your finger out with a grunt.\n\n");
					outputText("\"<i>You bitch...</i>\"  Priscilla moans, and the two of you french kiss once again.  The sour taste of her tongue and lips drown you, and you find yourself so dazed you didn’t realize that the goblin has stopped playing with your pussy, until you find Priscilla’s stained fingers in front of your lips.  You suckle dreamily, enjoying your taste, while Priscilla goes towards your " + player.breastDescript(0) + " biting into them gently, and kissing the " + player.nippleDescript(0) + ".  You gasp out loud as Priscilla starts becoming rougher with your breasts, squeezing and pushing them together, and slurping and biting them as well.  You start to feel your orgasm building.  With a grunt you pull away from Priscilla, gasping out loud at how quickly you almost came.  Priscilla smiles a small smile, and places her hands on her hips.\n\n");
					outputText("\"<i>Alright babe, let’s get down.  How do you want to do it?  We can scissor, that’s one thing I got all 120+ of my daughters addicted to so they won’t roam looking for cock, and there’s probably a tentacle beast we could ambush for a threesome.  What sounds good?</i>\"\n\n");
					outputText("You mention the obvious one: Priscilla’s lips on your nethers, but she only laughs.  \"<i>If you’d like, we can wrestle for dominance.  The loser must do whatever the winner wants: You want me to dine on your gash?  that’s the only way to do it.</i>\"  You raise an eyebrow, not remotely surprised at Priscilla intention to keep from eating your tuna, but you are intrigued at the challenge.\n\n");
					outputText("\"<i>So...how do you want to handle this?</i>\"  ");
					flags[kFLAGS.GOBLIN_ELDER_FOREPLAY_COUNTER]++;
				}
				else {
					outputText("You tell Priscilla you’re here for her.  She smiles a toothy grin as she starts to shed out of her spidersilk loincloth and bone armor, watching you intently as you stripped off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands went towards her breasts, kneading them slowly as you walked towards her.  You licked your lips at the sight of the goblin, and ");
					if (player.tallness >= 60) outputText("kneel down and scoop Priscilla into your arms for a kiss.  ");
					else outputText("pull Priscilla into a kiss.  ");
					outputText("She thrusts her tongue into your mouth as soon as your lips touched, and one of her hands reach towards your breasts, and the other, to your pussy.  You moan as her fingers plunge into you making a sloppy sound.  You breaks the kiss and start kissing on Priscilla’s neck slowly, and while she paws at your tits, and finger-fuck your pussy, you grip her side with one of your hands, and with your other hand you reach towards her firm but jiggable butt, slapping her as Priscilla cried out, sounding almost orgasmic.\n\n");
					outputText("\"<i>Yes, spank me harder!  I’ve been a naughty girl!</i>\"  Priscilla moans, and the two of you french kiss once again as you continued your swat assault The sour taste of her tongue and lips drown you, and you find yourself so dazed you didn’t realize that the goblin has stopped playing with your pussy, until you find Priscilla’s stained fingers in front of your lips.  You suckle dreamily, enjoying your taste, while Priscilla goes towards your " + player.breastDescript(0) + " biting into them gently, and kissing the " + player.nippleDescript(0) + ".  You gasp out loud as Priscilla starts becoming rougher with yout breasts, squeezing and pushing them together, and slurping and biting them as well.  You start to feel your orgasm building.  Priscilla stops, and pushes you away-your finger jerks out of Priscilla’s booty with a ‘pop’ You sit back up with a smile, so ready to get a taste of this goblin whore.\n\n");
					outputText("\"<i>Alright slut you want some of my babymaker right?  Lay on back so I can give you all of it in one go.</i>\"  Sounds tempting, you point out, but you mention maybe you’d like to sit on her face");
					if (!flags[kFLAGS.GOBLIN_ELDER_WRESTLE_COUNTER] == 0) outputText(" this time");
					outputText(".  \"<i>Well you know the toll, friend.</i>\"  Priscilla said with a grin.  \"<i>Of course, we can scissor, or we can find some poor sap and make him our bitch?  Whatever you want babe.</i>\"\n\n");
					outputText("How are you going to spend time with Priscilla today?  ");
				}
				menu();
				addButton(0, "Scissor", scissorscene);
				addButton(1, "3some", unleashthekraken);
				addButton(2, "Wrestle", wrestle);
				addButton(3, "Pri.  Dom.", priscilladom);
			}
		}

		private function unleashthekraken():void {
			clearOutput();
			outputText("Priscilla goes towards her armor and supplies and pulls out what looked like to be a flesh colored penis shaped whistle.  Before you can ask what it was for, she blew on it, and then grabbed you by the hands, and pulled you behind a rock formation.  Not even half a minute went by before a loud roar was heard, and a tentacle beast was in the clearing.\n\n");
			outputText("\"<i>Attack!</i>\"  Priscilla shouted as she rushed the beast.  Momentarily surprised, you jumped out from behind the rock and before the tentacle beast could even react, you and Priscilla deck the tentacle monster as hard as you both could.  It wails, dazed.  Taking your hand, Priscilla guides you to sit on the beast, whose body looked like a giant shrub.  As you sit on it, grimacing as what felt like a twig was poking your inner thigh, Priscilla kicked the tentacle beast, waking it up.  She then moves to you, straddling you on your lap.  The tentacle beast stirs, notices two nubile, and powerful females on top of him, and doesn’t take long to figure out what he’s there for.\n\n");
			outputText("\"<i>There we go~...</i>\"  Priscilla says as a tentacle slides from under you, and pulls through you and Priscilla’s legs.  You shudder as the tentacle slides past your crotch, and moan along with Priscilla as it starts thrusting through your thighs slow and rough.\n\n");
			if (flags[kFLAGS.GOBLIN_ELDER_BEAST_COUNTER] == 0) {
				outputText("You ask if the beast can be trusted as you feel a tentacle going through your hands and arms, binding.  \"<i>If it tries to go overboard with us, it will die. And it knows that.</i>\"  Priscilla laughs, allowing the beast to do the same to her.  ");
			}	
			else outputText("You ask Priscilla how she learned to call the beasts as you feel a tentacle going through your hands and arms, binding.  \"<i>Goblin sex hunters.</i>\" Priscilla said as the beast bound her as well.  \"<i>4 of them at a time would gather around, blow a beast whistle, and rape whatever comes.</i>\"  "); 
			outputText("You both are becoming bound, but still you two bounce and slide along the tentacle between the two of you, your juices slicking the beast.  You almost feel ready to cum, but the beast stops, and pulls you both into the air suspending you bound between one tentacle.\n\n");
			if (flags[kFLAGS.GOBLIN_ELDER_BEAST_COUNTER] == 0) {
				outputText("\"<i>Get Ready to rock!</i>\"  Priscilla says gleefully.  Before you can ask what she means, two of the beasts tentacle, one for each of you, springs forwards into your wet pussies.  ");
			flags[kFLAGS.GOBLIN_ELDER_BEAST_COUNTER]++;
			}
			else outputText("\"<i>Yes!  Here it comes!</i>\"  Priscilla yells, a look of mania in her eyes.  You close your eyes, anticipating the tentacles, coming for you and for Priscilla.  ");
			outputText("You suppress a scream as the beast pushes itself deep into your caverns as far as it could, kissing your cervix, before jettisoning out of your entrance, and busting into your hole again and again.  ");
			if (player.hasCock()) outputText("your " + player.cockDescript(0) + " instantly goes erect, the pain was excruciating, but exciting.  ");
			outputText("\n\n\"<i>Yes!  Yes!</i>\"  Priscilla screams, going wild as her tentacle was sliding in and out of her, and thrust deeper and rougher in side of her.  You could easily see her stomach distend to take the tentacle, it bulged out through her as if she was bubblegum being blown into.  You try to hang on, and then, you felt a painful swat, on your ass!  You scream out, taking note of the tentacle’s fourth tentacle, swiping at you, then at Priscilla.  Tears started streaming freely from your eyes, but yet, the tentacles plowing you, as well as Priscilla’s ecstatic roar, started to really turn you on, as pain turned to pleasure.  Just when you couldn’t take it anymore, the swatting tentacle stopped spanking you and Priscilla, and thrust itself into your " + player.assholeDescript() + " just when your pussy was fully stuffed.  You couldn’t even cry out in pain, just whimper as your body spasms, ");
			if (player.hasCock()) outputText("your " + player.cockDescript(0) + " starts cumming everywhere, shooting your nut on to the tentacles and all over Priscilla’s face, "); 
			outputText("being overtaken by the orgasm.  \"<i>Me next!  Me next!</i>\"  Priscilla cries watching you take the the tentacles crazy assault on your holes pushing deep and hard inside of you.  Oddly enough it did not cum, after you finally went limp, exhausted, the beasts’ tentacles pulled out of you, and started ravishing Priscilla.  You dimly watched as Priscilla received both tentacle in her ass, and and all three tore threw her in breakneck speed.\n\n");
			outputText("\"<i>Right there!  Right there!  Yes!  Yes!</i>\"  Priscilla squealed, as she and the tentacle beast fulfilled their innermost desires.  Priscilla, to have her walls broken down and gangbanged with no way to fight back, and the tentacle beast, letting loose all of its frustration on the goblin who summoned it here.  It wasn’t much longer as with a cry, Priscilla screamed an orgasmic pitch, and her pussy juices squirted everywhere, on the tentacles, on the beast, on you... Still struggling to stay awake, the tentacle beast dropped you and Priscilla to the ground gently, and pulled out of the babbling Priscilla, and all four tentacles pointed out at you both before the tentacle beast did finally cum.  What felt like loads and loads of cream coated you and Priscilla both, caking you in sticky love.\n\n");
			outputText("You awake an hour later.  Both Priscilla and the Tentacle Beast are gone.  Still aching from before, you gather your gear and head to camp.  ");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function wrestle():void {
			clearOutput();
			if (flags[kFLAGS.GOBLIN_ELDER_WRESTLE_COUNTER] == 0) {
				outputText("You and Priscilla grab a stick from a tree, and create a circle with a 5 meter diameter.  You chuckle at what you’re doing, without clothes even, but with Priscilla the two of you form the circle and get in, being on the edges.both of you widen your stance and circle around each other, before charging at each other with great speed.  ");
			}
			else {
				outputText("As the two of you form the circle again, You say that this time, Priscilla will be the one eating your juicy cunt.\n\n");
				outputText("\"<i>Sure Babe, sure.</i>\"  Priscilla laughs,.  The two of you get into your set circle and wrestling stances.  The two of you watch each other for any tells, unmoving and silent.  It’s not until you hear a twig snap, probably a squirrel, that the two you charge at each other.  ");
			}
			doNext(wrestle2);
		}

		private function wrestle2():void {
			clearOutput();
			flags[kFLAGS.GOBLIN_ELDER_WRESTLE_COUNTER]++;
			outputText("You and Priscilla arm lock, then after a bit of pushing and pulling between you two, you pull her into a headlock.  She grunts as you squeeze her head between your underarms, at which you pull her over your body, flipping her over.  You let her go and she falls on to the ground with an ‘oomph’ but she rolls away from and charges.  You throw a punch at Priscilla’s, but Priscilla ducks under the strike and chains into a tackle.  You are astounded at Priscilla’s raw power when you barely withstood the blow, but then your astonishment went to horror as Priscilla picked you up by your lower body and suplexed you, falling back.\n\n");
			outputText("You roll off the ground, and when Priscilla jumped at you headbutted her in the face.  As she reeled from the strike you dashed towards Priscilla to take her down to the ground, but as if she had wings on her feet, Priscilla jumped incredible hight and ejected her feet into your face.  You jerked back, face smarting, and slightly dazed.  The goblin waited for you to recover, smugly.  You shake your head in frustration, and the two of you circled each other again.\n\n");
			outputText("You charged Priscilla again, but she was ready for.  She rolled under your attempt to grab her and with her unbelievable strength hooks you in the side.  You bow over pained, allowing Priscilla to grab you by your head in an armlock, and fall back, driving your head into the ground.  Before you could recover from (as your friend back home called it) the Death Drop Takedown, Priscilla jumps on your back like a crazed monkey, tearing out your hair, and clawing on your back, you scream out in pain, and you fall backwards, attempting to get her off you.  She jumps off your back before you land ");
			if ((player.str + player.tou + player.spe + player.inte/2 + rand(50)) > 230) {
				outputText("<b>but you are faster.</b> Before she lands you grab her by the sides and push her to the ground, head down and ass up.  Priscilla wheeze, and gasp, clearly exhausted.\n\n");
				outputText("\"<i>Grrr...</i>\"  Priscilla grunted, pushing back on you, but you held firm.  Priscilla tried pulling you towards her, and then pushing you away, but you still you were steadfast.  She then tried to break away from you.  With a smile, you shake your head, still holding on to her.  What the hell?  Priscilla shouted, before trying to kick at your ankles, but she couldn’t move.  It was then You set up your final attack.  Grabbing her by the arms, you spin her in the air like a rag doll, before hoisting her into the air, and while she was still processing what was happening, you easily tossed her and sent her flying.  With a scream she flew into the air and hit the ground outside the wrestling circle with a thud.  She bounced once, and tumbled on the ground before stopping, and just laid where she landed looking like a crumpled heap.  After a minute She groaned out in pain, as she slowly got herself up.  You inquired if she was alright.  ");
				outputText("\"<i>Shut up!</i>\"  She said while you laughed.  You walk towards her and waited until she got back her breath.  When she recomposed herself, you pointed at the ground, still smiling.  \"<i>Next time...</i>\"  Priscilla mumbled.  ");
				doNext(dompriscilla);
			}
			else {
				outputText(".  You try to grab her, <b>but you’re too slow.</b> Priscilla and you arm lock.  You wheeze and gasp, clearly exhausted.\n\n");
				outputText("\"<i>I’m going to be honest babe.</i>\"  Priscilla said.  \"<i>I expected better-far better.</i>\"  You exclaim that the both of you are still evenly matched, all you received was a chuckle for your trouble.  It was then Priscilla broke out of your grip and grabbed your arm, and wrenched you to the ground.  With all of your strength you swing your twisted arm wildly, throwing Priscilla who rolled to the ground, but then barrelled back at you, forcing you to the ground with a tackle, and before you could fight back, Priscilla twisted her entire body around your arm, and started twisting back hard, just enough to make you slam your other hand on the ground, crying in pain.  Priscilla relents, leaving you for a moment to breathe.  You pull yourself up to your feet, holding your arm, and gasping large breaths of air, but as the Priscilla steps over to you, hands on her hips with an evil grin on her face, it dawns on you you have no idea what it means to be truly short of breath-not yet.  ");
				doNext(priscilladom);
			}
		}

		private function dompriscilla():void {
			clearOutput();
			outputText("Priscilla lays on the ground, looking slightly more demure than usual.  You blow a kiss to the submissive goblin, before standing over her head.  You slowly guide your self down, squatting your love box in front of Priscilla’s face.  ");
			if (player.hasCock()) outputText("you start pulling on " + player.cockDescript(0) + " slowly, getting it hard."); 
			outputText("\n\nPriscilla’s hand start to rub your butt and your sides, pulling you closer towards her face as you spread her thighs.  Priscilla parts your entrance with her tongue, licking them slowly and flicking your clitoris.  You exhale loudly, grabbing your breasts and squeezing them in response to Priscilla’s ministrations.  Your pussy starts to queeze on Priscilla’s face as her tongue swirls inside of you.  You spasm at the feeling, and you hold back, trying to stave off an orgasm.\n\n");
			outputText("\"<i>MMMMmmmm!</i>\"  Priscilla moans, dining on your snatch.  You laugh to yourself thinking about for someone who doesn’t like pussy, she sure loves the taste.  You grind and rub on Priscilla’s face.  She licks and sucks, moving faster and faster as she slurps on your juices as you quiver and gyrate.  You smush Priscilla’s face as hard as you could.  Eventually with a scream you paint Priscilla’s with your juices.  Shaking all over her.  You slowly pull up over her.  Priscilla has a wide smile on her face, as if your pussy juices were a new ale she’s drunk on.  ");
			if (player.hasCock()) outputText("kneeling down you slowly push your " + player.cockDescript(0) + " in front of Priscilla’s face, who immediately opens her mouth, ready for meat any time-however with a chuckle, you pull away.  ");
			outputText("You chuckle to yourself as you grab your things, watching as an annoyed Priscilla get hers.  \n\n");
			outputText("\"<i>I’ll be the one to take you down next time.</i>\"  Priscilla said as she walks away with a wave.  \"<i>Just you wait!</i>\"  You head back to camp, thinking of the next time you’ll get to dominate Priscilla again.");
			doNext(camp.returnToCampUseOneHour);
		}

		private function priscilladom():void {
			clearOutput();
			outputText("Being ordered to lay on the ground, you do as you’re told.  Priscilla smirks as she stands above your head, before she pivots and drops on top of your face.  All you could see was green delectable cheeks, and a drippy wet pussy smush on your nose and then on your lips.  you stick your tongue out at the folds, licking them clean before darting your tongue into her sugar walls, taking her sweaty dirty pussy in full.  Priscilla utters a loud, moan, as she rocking her hips, grinding her clitoris along your lips.  Tastes definitely like pickle: You open your mouth as wide as you could and started to swirl and your tongue in the crevices of Priscilla’s greedy hole.  Gasps and squirms are your rewards as you dine on your meal, you grasp Priscilla along the arches of her sides and thrust upward.  ");
			if (player.hasCock()) outputText("Your " + player.cockDescript(0) + " twirls around, aching for contact, but whether Priscilla didn’t care, or didn’t want you to enjoy this (too late), she didn’t touch you.  ");
			outputText("Yeah, you love being my bottom bitch, don’t you?  Priscilla moans between gasps.  All you could answer with was a \"<i>mmph!</i>\" and dive in further.  Eventually Priscilla started grinding faster and faster on your face, more bestial groans coming out of her, before finally releasing a flow of tangy snatch cream, almost drowning you.  You quickly start gulping, quite unable to shake the goblin off as she’s crossed her legs under you and is holding on.  Priscilla squeals and shakes above you.  Priscilla slowly gets up, allowing you to breathet, but then you grow silent as she looks at you, blushing furiously as she bites her bottom lip with a serious look.  Stick your tongue in here.  Priscilla murmurs as she spreads her cheeks and her butthole open and comes back down, aligning your lips to her back door.  You obediently prod her asshole, before going all the way in, as well as grabbing her breasts.  ");
			if (player.hasCock()) outputText("At this, your cock becomes fully erect, the clean but lewd taste of her asshole exciting you.  ");
			outputText("\"<i>Yes!  Oh Marae Yes!</i>\"  Priscilla shouts, riding your face as she starts rubbing her clit furiously.  One of your hands grab her sides and while still holding one of her breasts and start pushing your tongue in farther, her caverns squeezed and gripped you , but in response you fought back, going wild in her taint.  As you kneaded her breasts roughly until she finally exploded in a cry, jumping off your tongue and falling onto your stomach, squirting juices on your chest.  You watch, satisfied as her asshole quivers, slowly opening and closing in pleasure.  ");
			outputText("When she recomposes herself, Priscilla gets up, not giving you a second glance.  \"<i>Thanks babe, you’re a doll.</i>\"  Priscilla says happily, going towards her armor and weapons.  \"<i>I do hope we can do this again.</i>\"  Before she puts on her loincloth, you get up quite dissatisfied, inquiring about your needs.  Priscilla just laughs.  \"<i>Sorry honey, maybe next time.  Claim dominance over me and you get to call the shots.</i>\"  You watch as the goblin elder blows you a kiss and walks away smugly.  You tell yourself you’ll get her next time as you head back to camp ");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function pussyfuck():void {
			clearOutput();
			outputText("Grabbing your shaft, you sit up and point a finger at Priscilla in a beckoning motion, jerking your manhood slowly.  \"<i>Let’s try to put a bun in that oven.</i>\"\n\n");
			outputText("In an instant, Priscilla was all over your " + player.cockDescript(0) + ", kissing your glans with sloppy, wet kisses and gripping your " + player.ballsDescriptLight() + " roughly, causing you to elicit a muffled moan.  She danced her lips down your shaft, going down slowly towards your abused fruits, at which she nuzzles against, caringly, sniffing them as one would an intoxicating flower.  You watch her closely as she goes back up to your " + player.cockDescript(0) + " - your eyes meet once she’s stood up.\n\n");
			outputText("\"<i>I’m so wet for you.  See for yourself.</i>\"  You take one of your free hands and reach towards Priscilla’s crevice, and you shudder at how slick her womanhood is.  You easily plunge your fingers into her hole as Priscilla arches her back, sighing sensually amidst the squelching sounds of her sex.  You take your sloppy fingers and bring them to her gaping mouth, and as you watch her greedily lick the taste and inhale the scent of her sour arousal, you guide her muff box to your " + player.cockDescript(0) + ".\n\n");
			outputText("She doesn’t even hesitate, falling on your spear like a pro, garnering a sweet moan from your lips, and a gasp from hers.  Her pussy was so warm and unbelievably tight you almost want to release your cum into her womb right now, but you took ahold of her sides, and with a grunt, pulled her down towards your base as you started thrusting upwards.  In response Priscilla matches you slamming down, her body quivering as she does so.\n\n");
			outputText("\"<i>Yes!  Fuck me.  Fuck me pregnant!</i>\"  Priscilla coos between gasps, seesawing up and down your shaft, a smile on her lips, as your hands went towards gripping her by her waist.  For added stability, she rests her hands on your shoulders, and in the throes of passion the two of you start colliding into each other faster and faster.\n\n");
			outputText("As Priscilla bounces on your " + player.cockDescript(0) + ", You eagerly move one of your hands towards her clitoris, and started to flick her clitoris with a finger, causing Priscilla to erupt in a cry.  As she leans back away from you, you pepper her neck and breasts with kisses, and with your other hand, you slap your the goblin’s ass repeatedly, causing her to squeak and cry out your name, begging you to keep going.  Her pussy starts tightening and churning on your " + player.cockDescript(0) + ", demanding your cream, but you press on further, mashing her bean as the parted lips of her flower devoured your " + player.cockDescript(0) + " with no resistance.\n\n");
			outputText("You start moving faster, and you force yourself into Priscilla further, your " + player.ballsDescriptLight() + " slapping on the bottom of her ass with each jerk.  Priscilla’s sour fragrance spread everywhere with each squeal that came from her lips.  You pull yourself to her left breast, and then her right, slurping on her lethicite pierced nipples, the taste of the red minotaur blood exciting your loins, and igniting your spirit.  Breed me!  Fucking breed me you bastard!  Priscilla roars as she starts to cum her head off, her body shaking violently, and the sour scent of her pussy overpowering your senses..  Each slam into her pussy causes the goblin to cry out, every smash on her clit overpowering her will, and each nom on her nipples causing her to shiver.  You’ve started to feel your seed coming, and with one last thrust, you take Priscilla’s left breast into your mouth, biting deep and hard.  With a shriek, Priscilla arched her back and convulsed intensely, her pussy squeezing your cock good and tight, begging for the hot sticky load she always wanted.  It is then you feel you can no longer contain your juice.  Still biting Priscilla’s nipple, your eyes lose focus, as you feel your " + player.cockDescript(0) + " enlarging as your semen shot out into Priscilla’s greedy womb.\n\n");
			outputText("\"<i>Ah!  Oh yes breed me!</i>\"  Priscilla cried out, grasping your head closer into her breast.  \"<i>I’m going to be a mommy!</i>\" She starts swiveling on your dick, her pussy felt like an endless motion of contracting, and strangling more of your life creating liquid into her.  ");
			if (player.cumQ() >= 750) outputText("Amidst your nipple suckling, you watched as Priscilla’s stomach started to slowly inflate as if she already was pregnant, and you felt a large gush of your flow squeeze itself out of Priscilla’s pussy onto your balls.");
			outputText("Priscilla holds you onto her until the flow of semen finally stops.  You let go of Priscilla breasts-red with bite marks-dazed, yet satisfied.  You lay back on the ground, unable to move.\n\n");
			outputText("\"<i>Mmmm...</i>\" Priscilla moaned as she stood up above you, and walked towards her armor, loincloth, and weapons.  ");
			if (player.cumQ() >= 750) outputText("\"<i>You’re such an amazing breeder baby!  Maybe so good, I shouldn’t let you go...</i>\"");
			else outputText("\"<i>Stay safe out there stud.  I’m going to need more of that sticky cream later.  Find me again okay?</i>\"");
			outputText("She gives you a devious look, the glance made you gulp and almost reach for your " + player.weaponName + " ... \"<i>Whenever you’re done being champion, me and my daughters would love a permanent home stud to keep us company.  Non stop sex for the rest of your life - don’t say no now - Just think about it.</i>\" She blows you a kiss, and walks away.  With a small smile on your face, you sleepily head back to camp for rest.\n\n");
			player.orgasm('Dick');
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function assfuck():void {
			clearOutput();
			outputText("Priscilla huffs at your request for butt fun, but goes towards her supplies, rummages through her bag, and throws you a vial-lubricant.  \"<i>Babies aren’t made like this you know.</i>\"  She calls out, but the slight blush on her cheeks tells you that even so, she won’t mind the fun that will be had.\n\n");
			outputText("Priscilla gets on all fours, slowly swaying her body invitingly: her toned ass has a delicious jiggle to it that makes your rod stiffen so hard it hurts.  You kneel behind her, watching with an intense gaze as Priscilla spread her green cheeks and asshole open.  With the lube Priscilla gave you, you coat your first two fingers and slowly thrust your fingers inside of her asshole, eliciting a sharp gasp from her.\n\n");
			outputText("\"<i>Your fingers are so cold!</i>\"  Priscilla whispers, taken in by this foreign and taboo pleasure.  You chuckle at her shaking and quivering, and with an evil thought, started lubricating the rest of your hand.  You force a third finger in, followed by a fourth, and finally your thumb.  Priscilla grit her teeth as you had your whole fist pumping in and out the rim , faster and faster until with a cry Priscilla collapses onto the ground, a puddle of her freshly squeezed pussy juice spread all over the ground.  You slip your fingers out of Priscilla’s now dilated asshole.  It just can’t quite close fully, meaning it's ready for service.\n\n");
			outputText("\"<i>Wait, wait!</i>\"  Priscilla slurred, dazed, and laying on her stomach with her gaping hole winking at you like a slut, but you take your " + num2Text(Math.round(player.cocks[0].cockLength)) + " hard cock and push it in past her rim.  Her eyes widen larger than the size of dinner plates as you grab her by the waist and thrust deep and hard!  Priscilla’s mouth opens to exclaim \"<i>G-gah!</i>\"  As her body spasms, as you pull her onto and off your throbbing " + player.cockDescript(0) + ", using her as a living clocksleeve");
			if (player.cocks[0].cockLength > 14) outputText("Slamming her into your meat, you took delight not only in her tightness, but at how her stomach bulged out when forced to take your cock.  ");
			outputText("A large moan escapes your lips, as your " + player.cockDescript(0) + " started to throb, painfully inside Priscilla.  You felt yourself unconsciously thrusting upwards, as your eyes rolled into the back of your head, the feeling of this goblin’s tight sweaty lube stained asshole leaving you unable to think coherently, except you needed to push farther, push deeper inside, until finally, the wave of pleasure overwhelms you.\n\n");
			outputText("A shrieking cry comes out from you as well as Priscilla, you feel your baby batter jettisoning out past Priscilla’s sphincter.  \"<i>Yes Champion, yes!  Paint my shitter white!</i>\"  Priscilla greedily shouts, eyes rolled up to the back of her head and mouth wide open and slobbering.  You grunt and moan as you hold the goblin in place, as each wave and ml of your semen left your body-you never felt so alive anywhere else, pumping cum into this goblin whore’s back door, but all good things must come to an end.  You pull your " + player.cockDescript(0) + " out of Priscilla, you shudder in pleasure, and a big grin appears on your face as ");
			if (player.cumQ() >= 750) outputText("a pure white flow of your baby jism shamelessly torrents out of Priscilla’s gaping brown star, a hole which doesn’t look like it’s going to fully close any time soon.");
			else outputText("a thin trail of your man milk leaks subtly out of Priscilla’s quivering but closing asshole.  ");
			outputText("Priscilla for her credit is still conscious, but other than the goofy look on her face, and murmurings of her asshole being pregnant, she wasn’t all there for the moment.  Utterly satisfied, you blow Priscilla a kiss, and head towards your camp.\n\n");
			player.orgasm('Dick');
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function mouthfuck():void {
			clearOutput();
			outputText("Grabbing your shaft, you sit up and point a finger at Priscilla in a come beckon motion, jerking your manhood slowly.  \"<i>Come over here and taste this sausage.</i>\" You chuckle immaturely at your joke, but you almost yelp at how quickly Priscilla was kneeling in front of your cock, a flash of desire in her eyes, made you a bit uneasy.\n\n");
			outputText("Grasping your " + player.ballsDescriptLight() + " firmly, Priscilla slowly went towards the base of your shaft, and with the edge of her tongue, deftly licked and tasted you from your glans to the bottom of your member’s road, moaning in pleasure as she did so, as if just tasting your organ gave her the greatest orgasm.  She looked utterly enraptured, licking her lips as she stared at your member.  You’ve never seen anyone stare at you with such a hunger before, not even the shark girls.\n\n");
			if (player.cocks[0].cockLength > 14) outputText("\"<i>So much meat...And it’s all mine!</i>\"  ");
			else outputText("\"<i>Oh, this is going to be a treat.</i>\"  "); 
			outputText("Priscilla whispered, as she grasped your " + player.cockDescript(0) + " and placed her lips to the head of your " + player.cockDescript(0) + " There was no attempt at foreplay.  Without even an ‘itadakimasu’ Priscilla had already downed half of your cock, causing you to yelp painfully as going down, her teeth awkwardly nipped your penis’ opening, though a wave of pleasure washed over you as Priscilla’s throat started to squeeze your " + player.cockDescript(0) + " like a vice, begging for your cum.\n\n");
			outputText("You start to moan as you look into your lovers eyes, enthralled by how several " + num2Text(Math.round(player.cocks[0].cockLength)) + " of your meat has already disappeared into her throat.  You shudder at the feeling of your precum already leaving your shaft, and almost feel ready to release early as you can feel the tightening of Priscilla's throat, as each dollop of pre causes her to spasm with need, begging for a taste.  Priscilla looks to be in utter bliss as one of her hands wrapped around your shaft, her other hand, went towards her slicken womanhood, and her head started struggling towards your crotch, using your pre as a lubricant.  Just when you thought you were going to explode, Priscilla’s throat slackened, as she slowly pulled her self off of your cock\n\n");
			outputText("\"<i>Oh I can’t believe this is all mine!  My girls will be so jealous!</i>\"  Priscilla moaned, as her lips went towards your balls, slurping and sucking on them like they were sugary jawbreakers, as her hands jerked, squeezed and milked your shaft as much as it was truly worth.  You bit your bottom lip in anguished pleasure as a slight masochistic streak developed within you as the constant edging of your cock and " + player.ballsDescriptLight() + " made you want to honestly die in a puddle of liquid bliss.  And then, almost as if you displeased her, Priscilla released your cock and grabbed your balls, wringing them taut and squeezing them to death.  You yelp and look at her in fear, and you see the whore grin an evil, evil grin: \"<i>Such a naughty dick must have the tastiest throat glue, right?  Don’t even hold back, Fill my throat with your gooey seed Champion!</i>\"  Visions of the utterly insatiable, utterly greedy Tamani entered your mind as without a another word Priscilla went facedown in your crotch, taking all of your " + player.cockDescript(0) + " with one gulp.\n\n");
			outputText("Priscilla’s tits jiggle and sway as she slams her head down to your base.  A moan escapes you as Priscilla looks into your eyes, and you felt ready to melt nut something was keeping you to hang on.  As you find yourself enthralled by Priscilla’s mouth pussy, you feel your need to cum rising.  You mutter Priscilla’s name, which only spurs her faster.  Through out all this, Priscilla never broke eye contact, mesmerizing you with the lust in her eyes, and the warmth of her tongue.  Slowly she releases your squeezed genitals, and she reaches towards her own.  Amidst her gagging and slurping, you can hear her shlicking her pussy while she goes \"<i>no hands</i>\" as your head doctor, going up and down again on your " + player.cockDescript(0) + ", her eyes rolling up into the back of her head in delight.\n\n");
			outputText("It was then that you lost control, utterly giving in to your better, this goblin elder.  \"<i>Oh Priscilla!</i>\" you cry out sensually, and you start thrusting up, matching her downward slams.  Priscilla started bobbing her head faster and closer on your " + player.cockDescript(0) + ", frigging her pussy fast and rough as her inhuman goblin whore throat starts unconsciously milking your cock.  No longer able to hold back, you use the last of your failing strength to grasp her head to push Priscillia down to the base of your cock.  You let out a howling scream as you arched your back and started to attack Priscilla's throat with three short thrusts, before you feel your seed, jetting out through your cock.  Priscilla's eyes rolled into the back of her head as she screamed into your cock, spasming violently as her pussy sprayed her hand and the parched dirt with her sour womanly flavor and scent.\n\n");
			outputText("You feel Priscilla’s hands on your balls again, making them slippery with her juices as she massaged your of your batter out of your shaft in tandem with her sweet lock jaw skills.  You cry out again as you even felt a three fingers reach into your bunghole, jabbing your prostate clumsily to claim even more of your nut - it works.  You groan outward in pain, as you feel the dregs of your semen finally leave your body, to be vacuumed into Priscilla’s mouth.  You weakly watch as she chews your load as she wipes her hands off on to the ground, and did nothing, as after she swallowed, she went up to you, and placed a sloppy, wet, semen tasted kiss on your lips, giving you a taste of her meal.  You moan weakly, so exhausted, that you find you’re unable to even stay awake.\n\n");
			outputText("You wake up an hour later, dazed, but satisfied.  Fantasies of you and Priscilla engage your mind as you gather your things, count to make sure none of your gems are missing, and walk back to camp.  ");
			player.orgasm('Dick');
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
