package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	/**
	 * @since March 26, 2018
	 * @author Stadler76
	 */
	public class PeppermintWhite extends Consumable 
	{
		public function PeppermintWhite() 
		{
			super(
				"PeppWht",
				"PeppWht",
				"a vial of peppermint white",
				120,
				"This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays. How odd."
			);
		}

		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You pull the cork off the gift from the mysterious stranger. The scent of alluring mint fills your nose once again."
			          +" You bring the head of the bottle to your lips and tip it back, the creamy white fluid hits your tongue and slips down your"
			          +" throat. The liquid is surprisingly refreshing, the creamy mint flavor clings to your tongue and mouth,"
			          +" and makes your breath feel cool as you exhale over your lips.  You can feel the liquid drip down to your stomach"
			          +" and fill you with a pleasant warmth and holiday cheer.\n\n");
			//Recovers health and fatigue, adds five to max health, and one to libido.*/
			player.HPChange(player.maxHP(), true);
			player.changeFatigue( -100);
			return false;
		}
	}
}
