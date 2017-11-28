package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	/**
	 * Honey based alcoholic beverage.
	 */
	public class GodMead extends Consumable 
	{
		
		public function GodMead() 
		{
			super("GodMead","GodMead", "a pint of god's mead", ConsumableLib.DEFAULT_VALUE,"A horn of potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.");
		}

		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			outputText("You take a hearty swig of mead, savoring the honeyed taste on your tongue.  Emboldened by the first drink, you chug the remainder of the horn's contents in no time flat.  You wipe your lips, satisfied, and let off a small belch as you toss the empty horn aside.  ");

			//Libido: No desc., always increases.
			//Corruption: No desc., always decreases.
			dynStats("lib", 1, "cor", -1);
			//Health/HP(Large increase; always occurs):
			outputText("\n\nYou feel suddenly invigorated by the potent beverage, like you could take on a whole horde of barbarians or giants and come out victorious! ");
			game.HPChange(Math.round(player.maxHP() * .33), true);
			if (rand(3) === 0) {
				outputText("\n\nThe alcohol fills your limbs with vigor, making you feel like you could take on the world with just your fists!");
				if (game.silly()) outputText("  Maybe you should run around shirtless, drink, and fight!  Saxton Hale would be proud.");
				dynStats("str", 1);
			}
			//Tough:
			else {
				outputText("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
				dynStats("tou", 1);
			}
			//Grow Beard [ONLY if PC has a masculine face & a dick.)( -- Why? Bearded ladies are also a fetish [That's just nasty.] (I want a lady beard)): A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. You now sport a fine [player.HairColor] beard!
			if (rand(6) === 0 && player.beard.length < 4) {
				if (player.beard.length <= 0) outputText("A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. <b>You now sport a fine " + player.hair.color + " beard!</b>");
				else outputText("\n\nA sudden tingling runs along your chin. You stroke your beard proudly as it slowly grows in length and lustre.");
				player.beard.length += 0.5;
			}
			//Grow hair: Your scalp is beset by pins and needles as your hair grows out, stopping after it reaches [medium/long] length.}
			player.refillHunger(20);
			
			return false;
		}
	}
}
