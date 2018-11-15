package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffect;
	import classes.StatusEffects;

	/**
	 * @since April 3, 2018
	 * @author Stadler76
	 */
	public class BimboChampagne extends Consumable 
	{
		public function BimboChampagne() 
		{
			super(
				"BimboCh",
				"BimboCh",
				"a bottle of bimbo champagne",
				1,
				"A bottle of bimbo champagne. Drinking this might incur temporary bimbofication."
			);
		}

		public function applyEffect(player:Player, clearScreen:Boolean = true, intro:Boolean = true):Boolean
		{
			if (clearScreen) {
				clearOutput();
			}
			if (intro) {
				if ((player.findPerk(PerkLib.FutaFaculties) >= 0 && player.findPerk(PerkLib.FutaForm) >= 0) || (player.findPerk(PerkLib.BimboBody) >= 0 && player.findPerk(PerkLib.BimboBrains) >= 0)) {
					outputText("You could've swore the stuff worked when you saw Niamh do it to others,"
					          +" but for some reason, it had, like, no effect on you. How weird!");
				} else if (!player.hasStatusEffect(StatusEffects.BimboChampagne)) {
					outputText("You uncork the bottle and breathe in the fizzy, spicy aroma of the sparkling liquor."
					          +" Breathing deeply, you open your mouth and begin pouring the ever-effervescent fluid inside."
					          +" It's sweet and slightly gooey, and the feel of it sliding down your throat is intensely... awesome? Like, totally!");
				} else {
					outputText("You find yourself falling even further into the dense bimbo mindset."
					          +" You do feel, like, super-good and all, though!\n\nMoaning lewdly, you begin to sway your hips from side to side,"
					          +" putting on a show for anyone who might manage to see you.   You just feel so... sexy.  Too sexy to hide it."
					          +" Your body aches to show itself and feel the gaze of someone, anyone upon it. Mmmm, it makes you so wet!"
					          +" You sink your fingers into your sloppy cunt with a groan of satisfaction."
					          +" Somehow, you feel like you could fuck anyone right now!");
				}
			}
			var champagneEffect:StatusEffect = player.statusEffectByType(StatusEffects.BimboChampagne);
			if (champagneEffect !== null) {
				//player.addStatusValue(StatusEffects.BimboChampagne, 1, 4);
				champagneEffect.value1 += 4;
				dynStats("spe", -2, "lib", 1, "lus", 10);
			} else {
				champagneEffect = player.createStatusEffect(StatusEffects.BimboChampagne, 8, 0, 0, 0);
				//(Player has breasts smaller than DD-cup:
				if (player.breastRows[0].breastRating < 5) {
					outputText("\n\nYou feel this, like, totally sweet tingling in your boobies... And then your [armor] gets, like, tighter;"
					          +" wow, it seems like Niamh's booze is making your boobies grow! That's so awesome!"
					          +" You giggle and gulp down as much as you can... Aw; your boobies are <b>kinda</b> big now, but, like,"
					          +" you wanted great big bouncy sloshy boobies like Niamh has.  That'd be so hot!");
					//player.changeStatusValue(StatusEffects.BimboChampagne,2,5-player.biggestTitSize());
					champagneEffect.value2 = 5 - player.biggestTitSize();
					player.breastRows[0].breastRating = 5;
				}
				//(Player does not have vagina:
				if (!player.hasVagina()) {
					player.createVagina();
					outputText("\n\nYou can feel ");
					if (player.hasCock()) {
						outputText("the flesh under your cock[if (hasBalls = true)  and behind your [balls]]");
					} else {
						outputText("the blank expanse of flesh that is your crotch");
					}
					outputText(" start to tingle and squirm... mmm... that feels nice! There's a sensation you, like, can't describe,"
					          +" and then your crotch feels all wet... but in a good, sticky sorta way. Oh, wow!"
					          +" <b>You've, like, just grown a new virgin pussy!</b>  Awesome!");
					//player.changeStatusValue(StatusEffects.BimboChampagne, 3, 1);
					champagneEffect.value3 = 1;
				}
				//(player ass smaller than bimbo:
				if (player.butt.rating < 12) {
					outputText("\n\nYour butt jiggles deliciously - it feels like the bubbles from the drink are pushing out your plump rump,"
					          +" filling it like bagged sparkling wine!  Your bubbly booty swells and inflates until it feels as airy as your head."
					          +" Like, this is soooo plush!");
					//player.changeStatusValue(StatusEffects.BimboChampagne, 4, 12 - player.butt.rating);
					champagneEffect.value4 = 12 - player.butt.rating;
					player.butt.rating = 12;
					if (player.hips.rating < 12) {
						// A wrapper around this for later use would be great, I guess... ~Stadler76
						if (champagneEffect.dataStore === null) {
							champagneEffect.dataStore = {};
						}
						champagneEffect.dataStore['hipRatingChange'] = 12 - player.hips.rating;
						player.hips.rating = 12;
					}
				}
				dynStats("spe", -10, "lib", 1, "lus", 25);
			}
			return false;
		}

		public function removeBimboChampagne():void
		{
			var champagneEffect:StatusEffect = player.statusEffectByType(StatusEffects.BimboChampagne);
			outputText("\n<b>Whoah! Your head is clearing up, and you feel like you can think clearly for the first time in forever."
			          +" Niamh sure is packing some potent stuff!  You shake the cobwebs out of your head, glad to once again be less dense than"
			          +" a goblin with a basilisk boyfriend.</b>");
			dynStats("spe", 10, "lib", -1);
			if (champagneEffect.value2 > 0) {
				player.breastRows[0].breastRating -= champagneEffect.value2;
				outputText("  As the trecherous brew fades, your [chest] loses some of its... bimboliciousness."
				          +" Your back feels so much lighter without the extra weight dragging down on it.");
			}
			if (champagneEffect.value3 > 0) {
				outputText("  At the same time, your [vagina] slowly seals itself up, disappearing as quickly as it came.  Goodbye womanhood.");
				player.removeVagina();
			}
			if (champagneEffect.value4 > 0) {
				player.butt.rating -= champagneEffect.value4;
				outputText("  Of course, the added junk in your trunk fades too, leaving you back to having a [butt].");
			}
			// A wrapper around this for later use would be great, I guess... ~Stadler76
			if (champagneEffect.dataStore !== null && champagneEffect.dataStore.hasOwnProperty('hipRatingChange') && champagneEffect.dataStore.hipRatingChange > 0) {
				player.hips.rating -= champagneEffect.dataStore.hipRatingChange;
			}
			player.removeStatusEffect(StatusEffects.BimboChampagne);
			outputText("\n");
		}

		override public function useItem():Boolean
		{
			return applyEffect(player);
		}
	}
}
