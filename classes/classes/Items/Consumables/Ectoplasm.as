package classes.Items.Consumables 
{
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	
	/**
	 * Ghost transformative item.
	 */
	public class Ectoplasm extends Consumable 
	{
		public function Ectoplasm() 
		{
			super("EctoPls","EctoPls", "a bottle of ectoplasm", ConsumableLib.DEFAULT_VALUE, "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "ectoplasm";
			player.slimeFeed();
			clearOutput();
			outputText("You grimace and uncork the bottle, doing your best to ignore the unearthly smell drifting up to your nostrils. Steeling yourself, you raise the container to your lips and chug the contents, shivering at the feel of the stuff sliding down your throat.  Its taste, at least, is unexpectedly pleasant.  Almost tastes like oranges.");
			changes = 0;
			changeLimit = 1;
			if (rand(2) === 0) changeLimit++;
			if (rand(3) === 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Effect script 1:  (higher intelligence)
			if (player.inte100 < 100 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nYou groan softly as your head begins pounding something fierce.  Wincing in pain, you massage your temples as the throbbing continues, and soon, the pain begins to fade; in its place comes a strange sense of sureness and wit.");
				dynStats("int", 1);
				if (player.inte100 < 50) dynStats("int", 1);
				changes++;
			}
			//Effect script 2:  (lower sensitivity)
			if (player.sens100 >= 20 && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\nWoah, what the... you pinch your " + player.skinFurScales() + " to confirm your suspicions; the ghostly snack has definitely lowered your sensitivity.");
				dynStats("sen", -2);
				if (player.sens100 >= 75) dynStats("sen", -2);
				changes++;
			}
			//Effect script 3:  (higher libido)
			if (player.lib100 < 100 && rand(3) === 0 && changes < changeLimit) {
				//([if libido >49]
				if (player.lib100 < 50) outputText("\n\nIdly, you drop a hand to your crotch as");
				else outputText("\n\nWith a substantial amount of effort, you resist the urge to stroke yourself as");
				outputText(" a trace amount of the ghost girl's lust is transferred into you.  How horny IS she, you have to wonder...");
				dynStats("lib", 1);
				if (player.lib100 < 50) dynStats("lib", 1);
				changes++;
			}
			//Effect script a:  (human wang)
			if (player.hasCock() && changes < changeLimit) {
				if (rand(3) === 0 && player.cocks[0].cockType !== CockTypesEnum.HUMAN) {
					outputText("\n\nA strange tingling begins behind your " + player.cockDescript(0) + ", slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your " + player.armorName + " to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, <b>leaving you with a completely human penis.</b>");
					player.cocks[0].cockType = CockTypesEnum.HUMAN;
					changes++;
				}
			}
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Appearnace Change
			//Hair
			if (rand(4) === 0 && changes < changeLimit && player.hairType !== 2) {
				outputText("\n\nA sensation of weightlessness assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming lighter in your grasp, before you can hardly tell you're holding anything.  Plucking a strand, you hold it up before you, surprised to see... it's completely transparent!  You have transparent hair!");
				player.hairType = 2;
				changes++;
			}
			//Skin
			if (rand(4) === 0 && changes < changeLimit && (player.skinTone !== "sable" && player.skinTone !== "white")) {
				if (rand(2) === 0) {
					outputText("\n\nA warmth begins in your belly, slowly spreading through your torso and appendages. The heat builds, becoming uncomfortable, then painful, then nearly unbearable. Your eyes unfocus from the pain, and by the time the burning sensation fades, you can already tell something's changed. You raise a hand, staring at the milky-white flesh. Your eyes are drawn to the veins in the back of your hand, darkening to a jet black as you watch. <b>You have white skin, with black veins!</b>");
					player.skinTone = "white";
					player.skinAdj = "milky";
					player.skinDesc = "skin";
					player.skinType = SKIN_TYPE_PLAIN;
				}
				else {
					outputText("\n\nA warmth begins in your belly, slowly spreading through your torso and appendages. The heat builds, becoming uncomfortable, then painful, then nearly unbearable. Your eyes unfocus from the pain, and by the time the burning sensation fades, you can already tell something's changed. You raise a hand, staring at the sable flesh. Your eyes are drawn to the veins in the back of your hand, brightening to an ashen tone as you watch.  <b>You have black skin, with white veins!</b>");
					player.skinTone = "sable";
					player.skinAdj = "ashen";
					player.skinDesc = "skin";
					player.skinType = SKIN_TYPE_PLAIN;
				}
				player.underBody.restore();
				mutations.updateClaws(player.clawType);
				changes++;
			}
			//Legs
			if (changes < changeLimit && player.findPerk(PerkLib.Incorporeality) < 0 && (player.skinTone === "white" || player.skinTone === "sable") && player.hairType === 2) {
				//(ghost-legs!  Absolutely no problem with regular encounters, though! [if you somehow got this with a centaur it'd probably do nothing cuz you're not supposed to be a centaur with ectoplasm ya dingus])
				outputText("\n\nAn otherworldly sensation begins in your belly, working its way to your " + player.hipDescript() + ". Before you can react, your " + player.legs() + " begin to tingle, and you fall on your rump as a large shudder runs through them. As you watch, your lower body shimmers, becoming ethereal, wisps rising from the newly ghost-like " + player.legs() + ". You manage to rise, surprised to find your new, ghostly form to be as sturdy as its former corporeal version. Suddenly, like a dam breaking, fleeting visions and images flow into your head, never lasting long enough for you to concentrate on one. You don't even realize it, but your arms fly up to your head, grasping your temples as you groan in pain. As fast as the mental bombardment came, it disappears, leaving you with a surprising sense of spiritual superiority.  <b>You have ghost legs!</b>\n\n");
				outputText("<b>(Gained Perk:  Incorporeality</b>)");
				player.createPerk(PerkLib.Incorporeality, 0, 0, 0, 0);
			}
			//Effect Script 8: 100% chance of healing
			if (changes === 0) {
				outputText("You feel strangely refreshed, as if you just gobbled down a bottle of sunshine.  A smile graces your lips as vitality fills you.  ");
				game.HPChange(player.level * 5 + 10, true);
				changes++;
			}
			//Incorporeality Perk Text:  You seem to have inherited some of the spiritual powers of the residents of the afterlife!  While you wouldn't consider doing it for long due to its instability, you can temporarily become incorporeal for the sake of taking over enemies and giving them a taste of ghostly libido.

			//Sample possession text (>79 int, perhaps?):  With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.
			//Failure:  With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.
			player.refillHunger(20);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			
			return false;
		}
	}
}
