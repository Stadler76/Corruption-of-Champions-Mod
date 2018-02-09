package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	
	/**
	 * Holiday festive item that might give you antlers.
	 */
	public class WinterPudding extends Consumable 
	{
		
		public function WinterPudding() 
		{
			super("W.Pddng", "W.Pudding", "a slice of winter pudding", 35, "A slice of delicious Winter Pudding. It smells delicious. \n\nNote: Eating this might cause antlers to grow from your head.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "winterPudding";
			changes = 0;
			changeLimit = 2;
			outputText("You stuff the stodgy pudding down your mouth, the taste of brandy cream sauce and bitter black treacle sugar combining in your mouth.  You can tell by its thick spongy texture that it's far from good for you, so its exclusivity is more than likely for the best.");
			player.refillHunger(30);
			if (player.thickness < 100 || player.tone > 0) {
				//outputText("\n\nYou feel your waist protrude slightly.  Did you just put on a little weight?  It sure looks like it.");
				outputText(player.modTone(0,2));
				outputText(player.modThickness(100,2));
			}
			outputText("\n\nYou lick your lips clean, savoring the taste of the Winter Pudding.  You feel kinda antsy...");
			//[Decrease player tone by 5, Increase Lust by 20, Destroy item.]
			dynStats("lus", (10+player.lib/10), "scale", false);
			
			//[Optional, give the player antlers! (30% chance) Show this description if the player doesn't have horns already.]
			if (player.horns.value == 0 && rand(2) === 0) {
				outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree.  Investigating the exotic additions sprouting from your head, the situation becomes clear.  <b>You've grown antlers!</b>");
				//[Player horn type changed to Antlers.]
				player.horns.type = Horns.ANTLERS;
				player.horns.value = 4 + rand(12);
				changes++;
			}
			//[Show this description instead if the player already had horns when the transformation occurred.] 
			else if (player.horns.value > 0 && player.horns.type !== Horns.ANTLERS && rand(2) === 0) {
				outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else.  Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained antlers!</b>");
				//[Player horn type changed to Antlers.]
				player.horns.type = Horns.ANTLERS;
				player.horns.value = 4 + rand(12);
				changes++;
			}
			if (rand(5) === 0) mutations.updateOvipositionPerk(tfSource); // I doubt, that winterPudding will ever be affected, but well ... just in case
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
		
	}

}