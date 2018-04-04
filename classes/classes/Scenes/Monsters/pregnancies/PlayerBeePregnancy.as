package classes.Scenes.Monsters.pregnancies 
{
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.Scenes.AnalPregnancy;
	import classes.Scenes.PregnancyProgression;
	import classes.Scenes.VaginalPregnancy;
	import classes.internals.GuiOutput;
	import classes.internals.Utils;
	
	/**
	 * Contains pregnancy progression and birth scenes for a Player impregnated by bee.
	 */
	public class PlayerBeePregnancy implements AnalPregnancy
	{
		private var pregnancyProgression:PregnancyProgression;
		private var output:GuiOutput;
		
		/**
		 * Create a new bee pregnancy for the player. Registers pregnancy for bee.
		 * @param	pregnancyProgression instance used for registering pregnancy scenes
		 * @param	output instance for gui output
		 */
		public function PlayerBeePregnancy(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
		{
			this.output = output;
			this.pregnancyProgression = pregnancyProgression;
			
			pregnancyProgression.registerAnalPregnancyScene(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.PREGNANCY_BEE_EGGS, this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAnalPregnancy():Boolean 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			if (player.buttPregnancyIncubation === 36) {
				output.text("<b>\nYou feel bloated, your bowels shifting uncomfortably from time to time.</b>\n");
				
				displayedUpdate = true;
			}
			
			if (player.buttPregnancyIncubation === 20) {
				output.text("<b>\nA honey-scented fluid drips from your rectum.</b>  At first it worries you, but as the smell fills the air around you, you realize anything with such a beautiful scent must be good.  ");
				
				if (player.cockTotal() > 0) {
					output.text("The aroma seems to permeate your very being, slowly congregating in your ");
				}
				
				if (player.cockTotal() === 1) {
					output.text(player.cockDescript(0));
					
					if (player.countCocksOfType(CockTypesEnum.HORSE) === 1) {
						output.text(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your " + player.cockDescript(0) + " is twitching and dripping, the flare swollen and purple.  ");
					}
					
					if (player.dogCocks() === 1) {
						output.text(", each inhalation making it thicker, harder, and firmer.  You suck in huge lungfuls of air, desperate for more, until your " + player.cockDescript(0) + " is twitching and dripping, its knot swollen to the max.  ");
					}
					
					if (player.countCocksOfType(CockTypesEnum.HUMAN) === 1) {
						output.text(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your " + player.cockDescript(0) + " is twitching and dripping, the head swollen and purple.  ");
					}
					
					//FAILSAFE FOR NEW COCKS
					if (player.countCocksOfType(CockTypesEnum.HUMAN) === 0 && player.dogCocks() === 0 && player.countCocksOfType(CockTypesEnum.HORSE) === 0) {
						output.text(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air until your " + player.cockDescript(0) + " is twitching and dripping.  ");
					}
				}
				
				if (player.cockTotal() > 1) {
					output.text("groin.  Your " + player.multiCockDescriptLight() + " fill and grow with every lungful of the stuff you breathe in.  You suck in great lungfuls of the tainted air, desperate for more, your cocks twitching and dripping with need.  ");
				}
				
				output.text("You smile knowing you couldn't stop from masturbating if you wanted to.\n");
				
				kGAMECLASS.dynStats("int", -.5, "lus", 500);
				
				displayedUpdate = true;
			}
			
			return displayedUpdate;
		}
		
		/**
		 * @inheritDoc
		 */
		public function analBirth():void 
		{
			//TODO remove this once new Player calls have been removed
			var player:Player = kGAMECLASS.player;
			var displayedUpdate:Boolean = false;
			
			output.text("\n");
			
			output.text(kGAMECLASS.images.showImage("birth-beegirl"));
			
			output.text("There is a sudden gush of honey-colored fluids from your ass.  Before panic can set in, a wonderful scent overtakes you, making everything ok.  ");
			
			if (player.cockTotal() > 0) {
				output.text("The muzzy feeling that fills your head seems to seep downwards, making your equipment hard and tight.  ");
			}
			
			if (player.vaginas.length > 0) {
				output.text("Your " + player.vaginaDescript(0) + " becomes engorged and sensitive.  ");
			}
			
			output.text("Your hand darts down to the amber, scooping up a handful of the sticky stuff.  You wonder what your hand is doing as it brings it up to your mouth, which instinctively opens.  You shudder in revulsion as you swallow the sweet-tasting stuff, your mind briefly wondering why it would do that.  The stuff seems to radiate warmth, quickly pushing those nagging thoughts away as you scoop up more.\n\n");
			output.text("A sudden slip from below surprises you; a white sphere escapes from your anus along with another squirt of honey.  Your drugged brain tries to understand what's happening, but it gives up, your hands idly slathering honey over your loins.  The next orb pops out moments later, forcing a startled moan from your mouth.  That felt GOOD.  You begin masturbating to the thought of laying more eggs... yes, that's what those are.  You nearly cum as egg number three squeezes out.  ");
			
			if (player.averageLactation() >= 1 && player.biggestTitSize() > 2) {
				output.text("Seeking even greater sensation, your hands gather the honey and massage it into your " + player.breastDescript(0) + ", slowly working up to your nipples.  Milk immediately begins pouring out from the attention, flooding your chest with warmth.  ");
			}
			
			output.text("Each egg seems to come out closer on the heels of the one before, and each time your conscious mind loses more of its ability to do anything but masturbate and wallow in honey.\n\n");
			output.text("Some time later, your mind begins to return, brought to wakefulness by an incredibly loud buzzing...  You sit up and see a pile of dozens of eggs resting in a puddle of sticky honey.  Most are empty, but a few have hundreds of honey-bees emptying from them, joining the massive swarms above you.  ");
			
			if (player.cor < 35) {
				output.text("You are disgusted, but glad you were not stung during the ordeal.  You stagger away and find a brook to wash out your mouth with.");
			}
			
			if (player.cor >= 35 && player.cor < 65) {
				output.text("You are amazed you could lay so many eggs, and while the act was strange there was something definitely arousing about it.");
			}
			
			if (player.cor >= 65 && player.cor < 90) {
				output.text("You stretch languidly, noting that most of the drugged honey is gone.  Maybe you can find the Bee again and remember to bottle it next time.");
			}
			
			if (player.cor >= 90) {
				output.text("You lick your lips, savoring the honeyed residue on them as you admire your thousands of children.  If only every night could be like this...\n");
			}
			
			player.orgasm('Anal');
			
			kGAMECLASS.dynStats("int", 1, "lib", 4, "sen", 3);
			
			if (player.buttChange(20, true)) {
				output.text("\n");
			}
			
			if (player.butt.rating < 17) {
				if (player.butt.rating < 13) {
					//Guaranteed increase up to level 10
					player.butt.rating++;
					
					output.text("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");
				} else if (Utils.rand(2) === 0) {
					//Big butts only increase 50% of the time.
					player.butt.rating++;
					
					output.text("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.");
				}
			}
			
			output.text("\n");
			
			displayedUpdate = true;
			
			pregnancyProgression.detectAnalBirth(PregnancyStore.PREGNANCY_BEE_EGGS);
		}
	}
}
