package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	/**
	 * Nuts for berries.
	 */
	public class TrailMix extends Consumable 
	{
		private static const ITEM_VALUE:int = 20;
		public function TrailMix() 
		{
			super("TrailMx", "Trail Mix", "a pack of trail mix", ITEM_VALUE, "This mix of nuts, dried fruits and berries is lightweight, easy to store and very nutritious.");
		}
		
		override public function useItem():Boolean
		{
			outputText("You eat the trail mix. You got energy boost from it!");
			player.refillHunger(30);
			player.changeFatigue(-20);
			player.HPChange(Math.round(player.maxHP() * 0.1), true);
			
			return false;
		}
	}
}
