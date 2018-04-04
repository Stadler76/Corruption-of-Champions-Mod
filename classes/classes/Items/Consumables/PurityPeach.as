package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	public class PurityPeach extends Consumable 
	{
		private static const ITEM_VALUE:int = 10;
		
		public function PurityPeach() 
		{
			super("PurPeac", "PurPeac", "a pure peach", ITEM_VALUE, "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You bite into the sweet, juicy peach, feeling a sensation of energy sweeping through your limbs and your mind.  You feel revitalized, refreshed, and somehow cleansed.  ");
			player.changeFatigue(-15);
			player.HPChange(Math.round(player.maxHP() * 0.25), true);
			player.refillHunger(25);	
			
			return false;
		}
	}
}